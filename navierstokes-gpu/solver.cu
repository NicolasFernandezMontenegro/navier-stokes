#include <assert.h>
#include <cmath>
#include "indices.h"
#include "solver.h"

#include "cuda.h"
#include "helper_cuda.h"

#define IX(x, y) (rb_idx((x), (y), (n + 2)))
#define IX_FLAT(x, y) ((x) + (n + 2) * (y))
#define SWAP(x0, x)      \
    {                    \
        float* tmp = x0; \
        x0 = x;          \
        x = tmp;         \
    }

typedef enum { NONE = 0,
               VERTICAL = 1,
               HORIZONTAL = 2 } boundary;
typedef enum { RED,
               BLACK } grid_color;

// globales
cudaStream_t stream_red;
cudaStream_t stream_black;

__global__ static void add_source_kernell(unsigned int n, float* x, const float* s, float dt)
{
    uint i = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned int size = (n + 2) * (n + 2);
    if (i < size){
         x[i] += dt * s[i];
    }
}

static void add_source(unsigned int n, float* x, const float* s, float dt)
{
    unsigned int size = (n + 2) * (n + 2);
    dim3 block(128);
    dim3 grid(div_ceil(size, block.x));

    add_source_kernell<<<grid, block>>>(n, x, s, dt);
    checkCudaCall(cudaGetLastError()); 
}

__global__ static void set_bnd_kernell(unsigned int n, boundary b, float* x)
{
    uint i = blockIdx.x * blockDim.x + threadIdx.x;
    if (0 < i && i <= n){
        x[IX(0, i)] = b == VERTICAL ? -x[IX(1, i)] : x[IX(1, i)];
        x[IX(n + 1, i)] = b == VERTICAL ? -x[IX(n, i)] : x[IX(n, i)];
        x[IX(i, 0)] = b == HORIZONTAL ? -x[IX(i, 1)] : x[IX(i, 1)];
        x[IX(i, n + 1)] = b == HORIZONTAL ? -x[IX(i, n)] : x[IX(i, n)];
    }
    __syncthreads();
    if (i == 0){
        x[IX(0, 0)] = 0.5f * (x[IX(1, 0)] + x[IX(0, 1)]);
        x[IX(0, n + 1)] = 0.5f * (x[IX(1, n + 1)] + x[IX(0, n)]);
        x[IX(n + 1, 0)] = 0.5f * (x[IX(n, 0)] + x[IX(n + 1, 1)]);
        x[IX(n + 1, n + 1)] = 0.5f * (x[IX(n, n + 1)] + x[IX(n + 1, n)]);
    }
}

static void set_bnd(unsigned int n, boundary b, float* x)
{
    dim3 block(128);
    dim3 grid(div_ceil(n-2, block.x));

    set_bnd_kernell<<<grid, block>>>(n, b, x);
    checkCudaCall(cudaGetLastError());
}

__global__ static void lin_solve_rb_step_kernell(grid_color color,
                              unsigned int n,
                              unsigned int width,
                              float a,
                              float c,
                              const float* __restrict__ same0,
                              const float* __restrict__ neigh,
                              float* __restrict__ same)
{
    uint x = blockIdx.x * blockDim.x + threadIdx.x;
    uint y = blockIdx.y * blockDim.y + threadIdx.y + 1;

    if ((y <= n) && (x < n/2)){
        int parity = ((y + 1 + (color == BLACK)) % 2);
        int index = idx(x + parity, y, width);
        int shift = 1 - 2 * parity;
        same[index] = (same0[index] + a * (neigh[index - width] 
                                        + neigh[index] 
                                        + neigh[index + shift] 
                                        + neigh[index + width])) / c;
    }
}

static void lin_solve(unsigned int n, boundary b,
                      float* __restrict__ x,
                      const float* __restrict__ x0,
                      float a, float c)
{   
    unsigned int color_size = (n + 2) * ((n + 2) / 2);
    const float* red0 = x0;
    const float* blk0 = x0 + color_size;
    float* red = x;
    float* blk = x + color_size;
    unsigned int width = (n + 2) / 2;

    dim3 block(16, 8);
    dim3 grid(div_ceil(n-2, block.x), div_ceil(n-2, block.y));

    for (unsigned int k = 0; k < 20; ++k) {
        lin_solve_rb_step_kernell<<<grid, block, 0, stream_red>>>(RED, n, width, a, c, red0, blk, red);
        checkCudaCall(cudaGetLastError());
        lin_solve_rb_step_kernell<<<grid, block, 0, stream_black>>>(BLACK, n, width, a, c, blk0, red, blk);
        checkCudaCall(cudaGetLastError());

        // Sincronizar ambos streams
        checkCudaCall(cudaStreamSynchronize(stream_red));
        checkCudaCall(cudaStreamSynchronize(stream_black));

        set_bnd(n, b, x);
    }
}

static void diffuse(unsigned int n, boundary b, float* x, const float* x0, float diff, float dt)
{
    float a = dt * diff * n * n;
    lin_solve(n, b, x, x0, a, 1 + 4 * a);
}


__global__ static void advect_rb_step_kernell(grid_color color,
                          unsigned int n,
                          float* __restrict__ d,
                          const float* __restrict__ d0,
                          const float* __restrict__ u,
                          const float* __restrict__ v,
                          float dt)
    {
    unsigned int width = (n + 2) / 2;
    unsigned int j = blockIdx.y * blockDim.y + threadIdx.y + 1;
    unsigned int i = blockIdx.x * blockDim.x + threadIdx.x + 1;

    if (i <= n/2 && j <= n){
        unsigned int is_odd = (color) ? 1 - (j % 2) : (j % 2);
        int x_idx = i - is_odd;

        int index = idx(x_idx, j, width);

        float dt0 = dt * n;
        float x = (2 * i - is_odd) - dt0 * u[index];
        float y = j - dt0 * v[index];
        x = fmaxf(0.5f, fminf(x, n + 0.5f));
        y = fmaxf(0.5f, fminf(y, n + 0.5f));

        int i0 = (int)x;
        int i1 = i0 + 1;
        int j0 = (int)y;
        int j1 = j0 + 1;

        float s1 = x - i0;
        float s0 = 1.0f - s1;
        float t1 = y - j0;
        float t0 = 1.0f - t1;

        d[index] =
            s0 * (t0 * d0[IX(i0, j0)] + t1 * d0[IX(i0, j1)]) +
            s1 * (t0 * d0[IX(i1, j0)] + t1 * d0[IX(i1, j1)]);
    }   
}  

static void advect(unsigned int n, boundary b,
                       float* __restrict__ d,
                       const float* __restrict__ d0,
                       const float* __restrict__ u,
                       const float* __restrict__ v,
                       float dt)
    {

        unsigned int color_size = (n + 2) * ((n + 2) / 2);
        float* __restrict__ d_Red = d;
        float* __restrict__ d_Blk = d + color_size;
        const float* __restrict__ u_Red = u;
        const float* __restrict__ u_Blk = u + color_size;
        const float* __restrict__ v_Red = v;
        const float* __restrict__ v_Blk = v + color_size;

        dim3 block(16, 8);
        dim3 grid(div_ceil(n-2, block.x), div_ceil(n-2, block.y));

        advect_rb_step_kernell<<<grid, block, 0, stream_black>>>(RED, n, d_Red, d0, u_Red, v_Red, dt);
        checkCudaCall(cudaGetLastError());
        advect_rb_step_kernell<<<grid, block, 0, stream_red>>>(BLACK, n, d_Blk, d0, u_Blk, v_Blk, dt);
        checkCudaCall(cudaGetLastError());

        // Sincronizar ambos streams
        checkCudaCall(cudaStreamSynchronize(stream_red));
        checkCudaCall(cudaStreamSynchronize(stream_black));
        
        set_bnd(n, b, d);
    }

__global__ static void project_rb_step_1_kernell(grid_color color,
                                  unsigned int n,
                                  float* __restrict__ u,
                                  float* __restrict__ v,
                                  float* __restrict__ div,
                                  float* __restrict__ p)
    {
        uint x = blockIdx.x * blockDim.x + threadIdx.x;
        uint y = blockIdx.y * blockDim.y + threadIdx.y + 1;

        unsigned int width = (n + 2) / 2;
        if ((y <= n) && (x < n/2)){
            int parity = ((y + 1 + (color == BLACK)) % 2);
            int index = idx(x + parity, y, width);
            int shift = 1 - 2 * parity;

            float dudx = shift * (u[index + shift] - u[index]);
            float dvdy = v[index + width] - v[index - width];

            div[index] = -0.5 * (dudx + dvdy) / n;
            p[index] = 0;
        }
    }

__global__ static void project_rb_step_2_kernell(grid_color color,
                                  unsigned int n,
                                  float* __restrict__ p,
                                  float* __restrict__ u,
                                  float* __restrict__ v)
    {
        uint x = blockIdx.x * blockDim.x + threadIdx.x;
        uint y = blockIdx.y * blockDim.y + threadIdx.y + 1;

        unsigned int width = (n + 2) / 2;
        if ((y <= n) && (x < n/2)){
            int parity = ((y + 1 + (color == BLACK)) % 2);
            int index = idx(x + parity, y, width);
            int shift = 1 - 2 * parity;

            u[index] -= 0.5 * n * (shift * (p[index + shift] - p[index]));
            v[index] -= 0.5 * n * (p[index + width] - p[index - width]);
        }
    }

    static void project(unsigned int n, float* __restrict__ u, float* __restrict__ v, float* __restrict__ p, float* __restrict__ div)
    {  
        
        unsigned int color_size = (n + 2) * ((n + 2) / 2);
        float* red_u = u;
        float* blk_u = u + color_size;
        float* red_v = v;
        float* blk_v = v + color_size;
        float* red_p = p;
        float* blk_p = p + color_size;
        float* red_div = div;
        float* blk_div = div + color_size;

        dim3 block(16, 8);
        dim3 grid(div_ceil(n-2, block.x), div_ceil(n-2, block.y));

        project_rb_step_1_kernell<<<grid, block, 0, stream_red>>>(RED, n, blk_u, blk_v, red_div, red_p);
        project_rb_step_1_kernell<<<grid, block, 0, stream_black>>>(BLACK, n, red_u, red_v, blk_div, blk_p);

        // Sincronizar ambos streams
        checkCudaCall(cudaStreamSynchronize(stream_red));
        checkCudaCall(cudaStreamSynchronize(stream_black));

        set_bnd(n, NONE, div);
        set_bnd(n, NONE, p);

        lin_solve(n, NONE, p, div, 1, 4);

        project_rb_step_2_kernell<<<grid, block, 0, stream_red>>>(RED, n, blk_p, red_u, red_v);
        project_rb_step_2_kernell<<<grid, block, 0, stream_black>>>(BLACK, n, red_p, blk_u, blk_v);

        // Sincronizar ambos streams
        checkCudaCall(cudaStreamSynchronize(stream_red));
        checkCudaCall(cudaStreamSynchronize(stream_black));

        set_bnd(n, VERTICAL, u);
        set_bnd(n, HORIZONTAL, v);
    }

    void dens_step(unsigned int n, float* x, float* x0, float* u, float* v, float diff, float dt)
    {   
        // al inicio
        cudaStreamCreate(&stream_red);
        cudaStreamCreate(&stream_black);

        add_source(n, x, x0, dt);
        SWAP(x0, x);
        diffuse(n, NONE, x, x0, diff, dt);
        SWAP(x0, x);
        advect(n, NONE, x, x0, u, v, dt);

        cudaStreamDestroy(stream_red);
        cudaStreamDestroy(stream_black);

    }

    void vel_step(unsigned int n, float* u, float* v, float* u0, float* v0, float visc, float dt)
    {   
                // al inicio
        cudaStreamCreate(&stream_red);
        cudaStreamCreate(&stream_black);

        add_source(n, u, u0, dt);
        add_source(n, v, v0, dt);
        SWAP(u0, u);
        diffuse(n, VERTICAL, u, u0, visc, dt);
        SWAP(v0, v);
        diffuse(n, HORIZONTAL, v, v0, visc, dt);
        project(n, u, v, u0, v0);
        SWAP(u0, u);
        SWAP(v0, v);
        advect(n, VERTICAL, u, u0, u0, v0, dt);
        advect(n, HORIZONTAL, v, v0, u0, v0, dt);
        project(n, u, v, u0, v0);

        cudaStreamDestroy(stream_red);
        cudaStreamDestroy(stream_black);
    }
