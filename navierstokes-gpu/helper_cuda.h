#pragma once

#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>

inline void _checkCudaReturnValue(cudaError_t result, const char* const func, const char* const file, const int line)
{
    if (result) {
        fprintf(stderr, "CUDA error at %s:%d code=%d(%s) \"%s\" \n",
                file, line, static_cast<int>(result), cudaGetErrorString(result), func);
        cudaDeviceReset();
        // Make sure we call CUDA Device Reset before exiting
        exit(static_cast<int>(result));
    }
}

// This will output the proper CUDA error strings in the event that a CUDA host call returns an error
#define checkCudaCall(val) _checkCudaReturnValue((val), #val, __FILE__, __LINE__)

inline void __getLastCudaError(const char* errorMessage, const char* file, const int line)
{
    cudaError_t err = cudaGetLastError();

    if (cudaSuccess != err) {
        fprintf(stderr, "%s(%i) : getLastCudaError() CUDA error : %s : (%d) %s.\n",
                file, line, errorMessage, static_cast<int>(err), cudaGetErrorString(err));
        cudaDeviceReset();
        exit(static_cast<int>(err));
    }
}

// This will output the proper error string when calling cudaGetLastError
#define getLastCudaError(msg) __getLastCudaError(msg, __FILE__, __LINE__)

inline int getCudaDeviceAttribute(cudaDeviceAttr attr)
{
    int device = 0;
    int value = 0;
    checkCudaCall(cudaGetDevice(&device));
    checkCudaCall(cudaDeviceGetAttribute(&value, attr, device));
    return value;
}
