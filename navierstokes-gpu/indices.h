#pragma once
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"

#include <cstddef>  // para size_t

static __device__ __host__ inline size_t rb_idx(size_t x, size_t y, size_t dim)
{
    size_t base = ((x % 2) ^ (y % 2)) * dim * (dim / 2);
    size_t offset = (x / 2) + y * (dim / 2) ;
    return base + offset;
}


static __device__ __host__ inline size_t idx(size_t x, size_t y, size_t stride) {
    return x + y * stride;
}

#pragma GCC diagnostic pop

static __device__ __host__ inline uint div_ceil(uint a, uint b)
{
    return (a + b - 1) / b;
}

