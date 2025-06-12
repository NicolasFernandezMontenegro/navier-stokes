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
    cudaMemPrefetchAsync(x, (n + 2)*(n + 2) * sizeof(float), 0);
    cudaMemPrefetchAsync(s, (n + 2)*(n + 2) * sizeof(float), 0);

    unsigned int size = (n + 2) * (n + 2);
    dim3 block(128);
    dim3 grid(div_ceil(size, block.x));

    add_source_kernell<<<grid, block>>>(n, x, s, dt);
    checkCudaCall(cudaGetLastError());
    checkCudaCall(cudaDeviceSynchronize());    

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
    checkCudaCall(cudaDeviceSynchronize());
}

__global__ static void lin_solve_rb_step_kernell(grid_color color,
                              unsigned int n,
                              float a,
                              float ic,
                              const float * __restrict__ same0,
                              const float * __restrict__ neigh,
                              float * __restrict__ same)
{
    uint x = blockIdx.x * blockDim.x + threadIdx.x;
    uint y = blockIdx.y * blockDim.y + threadIdx.y + 1;

    unsigned int width = (n + 2) / 2;
    unsigned int start = (color == RED && (y % 2) || (color == BLACK && ((y+1) % 2)));

    if (y <= n && x < width) {
            int index = idx(x, y, width);
            same[index] = (same0[index] + a * (neigh[index - width] +
                                               neigh[index - start] +
                                               neigh[index - start + 1] +
                                               neigh[index + width])) / ic;
    }
}

static void lin_solve(unsigned int n, boundary b,
                      float * __restrict__ x,
                      const float * __restrict__ x0,
                      float a, float c)
{
    unsigned int color_size = (n + 2) * ((n + 2) / 2);
    const float * red0 = x0;
    const float * blk0 = x0 + color_size;
    float * red = x;
    float * blk = x + color_size;
    float ic = 1/c;

    dim3 block(16, 8);
    dim3 grid(div_ceil(n-2, block.x), div_ceil(n-2, block.y));

    for (unsigned int k = 0; k < 20; ++k) {
        lin_solve_rb_step_kernell<<<grid, block>>>(RED, n, a, ic, red0, blk, red);
        checkCudaCall(cudaGetLastError());

        lin_solve_rb_step_kernell<<<grid, block>>>(BLACK, n, a, ic, blk0, red, blk);
        checkCudaCall(cudaGetLastError());
        checkCudaCall(cudaDeviceSynchronize());
        set_bnd(n, b, x);
    }
}

static void diffuse(unsigned int n, boundary b, float * x, const float * x0, float diff, float dt)
{
    float a = dt * diff * n * n;
    lin_solve(n, b, x, x0, a, 1 + 4 * a);
}

static void advect(unsigned int n, boundary b, float * d, const float * d0, const float * u, const float * v, float dt)
{
    int i0, i1, j0, j1;
    float x, y, s0, t0, s1, t1;

    float dt0 = dt * n;
    for (unsigned int i = 1; i <= n; i++) {
        for (unsigned int j = 1; j <= n; j++) {
            x = i - dt0 * u[IX(i, j)];
            y = j - dt0 * v[IX(i, j)];
            if (x < 0.5f) {
                x = 0.5f;
            } else if (x > n + 0.5f) {
                x = n + 0.5f;
            }
            i0 = (int) x;
            i1 = i0 + 1;
            if (y < 0.5f) {
                y = 0.5f;
            } else if (y > n + 0.5f) {
                y = n + 0.5f;
            }
            j0 = (int) y;
            j1 = j0 + 1;
            s1 = x - i0;
            s0 = 1 - s1;
            t1 = y - j0;
            t0 = 1 - t1;
            d[IX(i, j)] = s0 * (t0 * d0[IX(i0, j0)] + t1 * d0[IX(i0, j1)]) +
                          s1 * (t0 * d0[IX(i1, j0)] + t1 * d0[IX(i1, j1)]);
        }
    }
    set_bnd(n, b, d);
}

static void project(unsigned int n, float *u, float *v, float *p, float *div)
{
    for (unsigned int i = 1; i <= n; i++) {
        for (unsigned int j = 1; j <= n; j++) {
            div[IX(i, j)] = -0.5f * (u[IX(i + 1, j)] - u[IX(i - 1, j)] +
                                     v[IX(i, j + 1)] - v[IX(i, j - 1)]) / n;
            p[IX(i, j)] = 0;
        }
    }
    set_bnd(n, NONE, div);
    set_bnd(n, NONE, p);

    lin_solve(n, NONE, p, div, 1, 4);

    for (unsigned int i = 1; i <= n; i++) {
        for (unsigned int j = 1; j <= n; j++) {
            u[IX(i, j)] -= 0.5f * n * (p[IX(i + 1, j)] - p[IX(i - 1, j)]);
            v[IX(i, j)] -= 0.5f * n * (p[IX(i, j + 1)] - p[IX(i, j - 1)]);
        }
    }
    set_bnd(n, VERTICAL, u);
    set_bnd(n, HORIZONTAL, v);
}

void dens_step(unsigned int n, float *x, float *x0, float *u, float *v, float diff, float dt)
{
    add_source(n, x, x0, dt);
    SWAP(x0, x);
    diffuse(n, NONE, x, x0, diff, dt);
    SWAP(x0, x);
    advect(n, NONE, x, x0, u, v, dt);
}

void vel_step(unsigned int n, float *u, float *v, float *u0, float *v0, float visc, float dt)
{
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
}
