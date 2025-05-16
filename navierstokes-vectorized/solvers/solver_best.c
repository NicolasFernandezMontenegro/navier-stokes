#include <math.h>
#include <stddef.h>
#include <stdio.h>

#include <omp.h>
#include "indices.h"
#include "solver.h"

//#define SIZE_BLOCK 16
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

static void add_source(unsigned int n, float* x, const float* s, float dt)
{
    unsigned int size = (n + 2) * (n + 2);
    for (unsigned int i = 0; i < size; i++) {
        x[i] += dt * s[i];
    }
}

static void set_bnd(unsigned int n, boundary b, float* x)
{
    for (unsigned int i = 1; i <= n; i++) {
        x[IX(0, i)] = b == VERTICAL ? -x[IX(1, i)] : x[IX(1, i)];
        x[IX(n + 1, i)] = b == VERTICAL ? -x[IX(n, i)] : x[IX(n, i)];
        x[IX(i, 0)] = b == HORIZONTAL ? -x[IX(i, 1)] : x[IX(i, 1)];
        x[IX(i, n + 1)] = b == HORIZONTAL ? -x[IX(i, n)] : x[IX(i, n)];
    }
    x[IX(0, 0)] = 0.5f * (x[IX(1, 0)] + x[IX(0, 1)]);
    x[IX(0, n + 1)] = 0.5f * (x[IX(1, n + 1)] + x[IX(0, n)]);
    x[IX(n + 1, 0)] = 0.5f * (x[IX(n, 0)] + x[IX(n + 1, 1)]);
    x[IX(n + 1, n + 1)] = 0.5f * (x[IX(n, n + 1)] + x[IX(n + 1, n)]);
}

static void lin_solve_rb_step(grid_color color,
                              unsigned int n,
                              unsigned int width,
                              float a,
                              float c,
                              const float* restrict same0,
                              const float* restrict neigh,
                              float* restrict same)
{
   
    #pragma omp for 
    {
        for (unsigned int y = 1; y <= n; ++y) {
            #pragma omp simd 
            for (unsigned int x = 0; x < n / 2; ++x) {
                int index = idx(x + ((y + 1 + (color == BLACK)) % 2), y, width);
                int shift = 1 - 2 * ((y + 1 + (color == BLACK)) % 2);
                same[index] = (same0[index] + a * (neigh[index - width] + neigh[index] + neigh[index + shift] + neigh[index + width])) / c;
            }
        }
    }
}

static void lin_solve(unsigned int n, boundary b,
                      float* restrict x,
                      const float* restrict x0,
                      float a, float c)
{
    unsigned int color_size = (n + 2) * ((n + 2) / 2);
    const float* red0 = x0;
    const float* blk0 = x0 + color_size;
    float* red = x;
    float* blk = x + color_size;
    unsigned int width = (n + 2) / 2;

    for (unsigned int k = 0; k < 20; ++k) { 
        #pragma omp parallel 
        {
            lin_solve_rb_step(RED, n, width, a, c, red0, blk, red);
            lin_solve_rb_step(BLACK, n, width, a, c, blk0, red, blk);
        }
        set_bnd(n, b, x);   
    }
}

static void diffuse(unsigned int n, boundary b, float* x, const float* x0, float diff, float dt)
{
    float a = dt * diff * n * n;
    lin_solve(n, b, x, x0, a, 1 + 4 * a);
}


static void advect_rb(grid_color color,
                          unsigned int n,
                          float* restrict d,
                          const float* restrict d0,
                          const float* restrict u,
                          const float* restrict v,
                          float dt)
    {
        int i0, i1, j0, j1;
        float x, y, s0, t0, s1, t1;
        unsigned int width = (n + 2) / 2;
        float dt0 = dt * n;
        for (unsigned int j = 1; j <= n; j++) {
            unsigned int is_odd = (color == BLACK) ? 1 - (j % 2) : (j % 2);
            for (unsigned int  i= 1; i <= n/2; i++) { 
                int index = idx(i - is_odd, j, width);
                x = (2 * i - is_odd) - dt0 * u[index];
                y = j - dt0 * v[index];

                x = fmaxf(x, 0.5f);
                x = fminf(x, n + 0.5f);
                y = fmaxf(y, 0.5f);
                y = fminf(y, n + 0.5f);

                i0 = (int)x;
                i1 = i0 + 1;
                j0 = (int)y;
                j1 = j0 + 1;
                s1 = x - i0;
                s0 = 1 - s1;
                t1 = y - j0;
                t0 = 1 - t1;

                d[index] = s0 * (t0 * d0[IX(i0, j0)] + t1 * d0[IX(i0, j1)]) +
                        s1 * (t0 * d0[IX(i1, j0)] + t1 * d0[IX(i1, j1)]);
           
            }
        }
    }

static void advect(unsigned int n, boundary b,
                       float* restrict d,
                       const float* restrict d0,
                       const float* restrict u,
                       const float* restrict v,
                       float dt)
    {
        unsigned int color_size = (n + 2) * ((n + 2) / 2);
        float* restrict d_Red = d;
        float* restrict d_Blk = d + color_size;
        const float* restrict u_Red = u;
        const float* restrict u_Blk = u + color_size;
        const float* restrict v_Red = v;
        const float* restrict v_Blk = v + color_size;

        advect_rb(RED, n, d_Red, d0, u_Red, v_Red, dt);
        advect_rb(BLACK, n, d_Blk, d0, u_Blk, v_Blk, dt);
        
        set_bnd(n, b, d);
    }

static void project_rb_step_1(grid_color color,
                                  unsigned int n,
                                  float* restrict u,
                                  float* restrict v,
                                  float* restrict div,
                                  float* restrict p)
    {
        unsigned int width = (n + 2) / 2;
        for (unsigned int y = 1; y <= n; ++y) {
            int parity = ((y + 1 + (color == BLACK)) % 2);
            for (unsigned int x = 0; x < n / 2; ++x) {
                int index = idx(x + parity, y, width);
                int shift = 1 - 2 * parity;

                // float dudx = (parity == 1) ? (u[index] - u[index + shift]) : u[index + shift] - u[index] ;
                float dudx = shift * (u[index + shift] - u[index]);
                float dvdy = v[index + width] - v[index - width];

                div[index] = -0.5 * (dudx + dvdy) / n;
                p[index] = 0;
            }
        }
    }

static void project_rb_step_2(grid_color color,
                                  unsigned int n,
                                  float* restrict p,
                                  float* restrict u,
                                  float* restrict v)
    {
        unsigned int width = (n + 2) / 2;
        for (unsigned int y = 1; y <= n; ++y) {
            int parity = ((y + 1 + (color == BLACK)) % 2);
            for (unsigned int x = 0; x < n / 2; ++x) {
                int index = idx(x + parity, y, width);
                int shift = 1 - 2 * parity;

                u[index] -= 0.5 * n * (shift * (p[index + shift] - p[index]));
                v[index] -= 0.5 * n * (p[index + width] - p[index - width]);
            }
        }
    }

    static void project(unsigned int n, float* restrict u, float* restrict v, float* restrict p, float* restrict div)
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

        project_rb_step_1(RED, n, blk_u, blk_v, red_div, red_p);
        project_rb_step_1(BLACK, n, red_u, red_v, blk_div, blk_p);

        set_bnd(n, NONE, div);
        set_bnd(n, NONE, p);

        lin_solve(n, NONE, p, div, 1, 4);

        project_rb_step_2(RED, n, blk_p, red_u, red_v);
        project_rb_step_2(BLACK, n, red_p, blk_u, blk_v);

        set_bnd(n, VERTICAL, u);
        set_bnd(n, HORIZONTAL, v);
    }

    void dens_step(unsigned int n, float* x, float* x0, float* u, float* v, float diff, float dt)
    {
        add_source(n, x, x0, dt);
        SWAP(x0, x);
        diffuse(n, NONE, x, x0, diff, dt);
        SWAP(x0, x);
        advect(n, NONE, x, x0, u, v, dt);
    }

    void vel_step(unsigned int n, float* u, float* v, float* u0, float* v0, float visc, float dt)
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
