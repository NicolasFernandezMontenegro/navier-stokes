/*
  ======================================================================
   demo.c --- protoype to show off the simple solver
  ----------------------------------------------------------------------
   Author : Jos Stam (jstam@aw.sgi.com)
   Creation Date : Jan 9 2003

   Description:

	This code is a simple prototype that demonstrates how to use the
	code provided in my GDC2003 paper entitles "Real-Time Fluid Dynamics
	for Games". This code uses OpenGL and GLUT for graphics and interface

  =======================================================================
*/

#include <cmath>
#include <cstdlib>
#include <cstdio>

#include "indices.h"
#include "solver.h"
#include "timing.h"

#include "cuda.h"
#include "helper_cuda.h"
#include "cub/cub.cuh"


/* macros */
#define N_SIZE 1024
#define IX(x,y) (rb_idx((x),(y),(N+2)))

/* global variables */

static int N;
static float dt, diff, visc;
static float force, source;

static float * u, * v, * u_prev, * v_prev;
static float * dens, * dens_prev;


/*
  ----------------------------------------------------------------------
   free/clear/allocate simulation data
  ----------------------------------------------------------------------
*/


static void free_data ( void )
{
	if ( u ) checkCudaCall(cudaFree( u ));
	if ( v ) checkCudaCall(cudaFree( v ));
	if ( u_prev ) checkCudaCall(cudaFree( u_prev ));
	if ( v_prev ) checkCudaCall(cudaFree( v_prev ));
	if ( dens ) checkCudaCall(cudaFree( dens ));
	if ( dens_prev ) checkCudaCall(cudaFree( dens_prev ));
}

__global__ static void clear_data_kernell ( int size,
											float * u, 
											float* v, 
											float * u_prev, 
											float * v_prev,
											float * dens, 
											float * dens_prev) {
	uint i = blockIdx.x * blockDim.x + threadIdx.x;

	if (i < size){
		u[i] = v[i] = u_prev[i] = v_prev[i] = dens[i] = dens_prev[i] = 0.0f;
	}

}


static void clear_data ( void )
{
	int size=(N+2)*(N+2);
	dim3 block(128);
    dim3 grid(div_ceil(size, block.x));

    clear_data_kernell<<<grid, block>>>(size, u, v, u_prev, v_prev, dens, dens_prev);
    checkCudaCall(cudaGetLastError());
    checkCudaCall(cudaDeviceSynchronize());

}

static int allocate_data ( void )
{
	int size = (N+2)*(N+2);
	
	size_t array_size = size*sizeof(float);
	
	checkCudaCall(cudaMallocManaged(&u, array_size));
	checkCudaCall(cudaMallocManaged(&v, array_size));
	checkCudaCall(cudaMallocManaged(&u_prev, array_size));
	checkCudaCall(cudaMallocManaged(&v_prev, array_size));
	checkCudaCall(cudaMallocManaged(&dens, array_size));
	checkCudaCall(cudaMallocManaged(&dens_prev, array_size));
	
	cudaMemPrefetchAsync(u,         size*sizeof(float), 0);
	cudaMemPrefetchAsync(v,         size*sizeof(float), 0);
	cudaMemPrefetchAsync(u_prev,    size*sizeof(float), 0);
	cudaMemPrefetchAsync(v_prev,    size*sizeof(float), 0);
	cudaMemPrefetchAsync(dens,      size*sizeof(float), 0);
	cudaMemPrefetchAsync(dens_prev, size*sizeof(float), 0);

	if ( !u || !v || !u_prev || !v_prev || !dens || !dens_prev ) {
		fprintf ( stderr, "cannot allocate data\n" );
		return ( 0 );
	}

	return ( 1 );
}



__global__ void compute_velocity_squared(int size, const float* u, const float* v, float* velocity2) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < size) {
        float ui = u[i];
        float vi = v[i];
        velocity2[i] = ui * ui + vi * vi;
    }
}

__global__ void clear_arrays_kernel(int size, float* u, float* v, float* d) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < size) {
        u[i] = 0.0f;
        v[i] = 0.0f;
        d[i] = 0.0f;
    }
}

__global__ void inject_center_kernel(float* u, float* v, float* d,
                                     float max_velocity2, float max_density,
                                     float force, float source, int center) {
    if (threadIdx.x == 0 && blockIdx.x == 0) {
        if (max_velocity2 < 0.0000005f) {
            float val = force * 10.0f;
            u[center] = val;
            v[center] = val;
        }
        if (max_density < 1.0f) {
            float val = source * 10.0f;
            d[center] = val;
        }
    }
}

static void react(float* d, float* u, float* v) {
    const int size = (N + 2) * (N + 2);
    dim3 block(128);
    dim3 grid((size + block.x - 1) / block.x);

    float* d_velocity2;
    checkCudaCall(cudaMalloc(&d_velocity2, size * sizeof(float)));


    compute_velocity_squared<<<grid, block>>>(size, u, v, d_velocity2);
    checkCudaCall(cudaGetLastError());
	checkCudaCall(cudaDeviceSynchronize());


    void* temp_storage = nullptr;
    size_t temp_storage_bytes = 0;
    checkCudaCall(cub::DeviceReduce::Max(nullptr, temp_storage_bytes, d_velocity2, d_velocity2, size));
    checkCudaCall(cudaMalloc(&temp_storage, temp_storage_bytes));
    checkCudaCall(cub::DeviceReduce::Max(temp_storage, temp_storage_bytes, d_velocity2, d_velocity2, size));

    float* d_max_density;
    checkCudaCall(cudaMalloc(&d_max_density, sizeof(float)));
    void* temp_storage2 = nullptr;
    size_t temp_storage_bytes2 = 0;
    checkCudaCall(cub::DeviceReduce::Max(nullptr, temp_storage_bytes2, d, d_max_density, size));
    checkCudaCall(cudaMalloc(&temp_storage2, temp_storage_bytes2));
    checkCudaCall(cub::DeviceReduce::Max(temp_storage2, temp_storage_bytes2, d, d_max_density, size));

    float max_velocity2;
    float max_density;
    checkCudaCall(cudaMemcpy(&max_velocity2, d_velocity2, sizeof(float), cudaMemcpyDeviceToHost));
    checkCudaCall(cudaMemcpy(&max_density, d_max_density, sizeof(float), cudaMemcpyDeviceToHost));

    clear_arrays_kernel<<<grid, block>>>(size, u, v, d);
    checkCudaCall(cudaGetLastError());

    int center = IX(N / 2, N / 2);
    inject_center_kernel<<<1, 1>>>(u, v, d, max_velocity2, max_density, force, source, center);
    checkCudaCall(cudaGetLastError());
	checkCudaCall(cudaDeviceSynchronize());

    cudaFree(d_velocity2);
    cudaFree(d_max_density);
    cudaFree(temp_storage);
    cudaFree(temp_storage2);
}

static void one_step ( void )
{
	static int times = 1;
	static double start_t = 0.0;
	static double one_second = 0.0;
	static double react_ns_p_cell = 0.0;
	static double vel_ns_p_cell = 0.0;
	static double dens_ns_p_cell = 0.0;

	start_t = wtime();
	react ( dens_prev, u_prev, v_prev );
	react_ns_p_cell += 1.0e9 * (wtime()-start_t)/(N*N);

	start_t = wtime();
	vel_step ( N, u, v, u_prev, v_prev, visc, dt );
	vel_ns_p_cell += 1.0e9 * (wtime()-start_t)/(N*N);

	start_t = wtime();
	dens_step ( N, dens, dens_prev, u, v, diff, dt );
	dens_ns_p_cell += 1.0e9 * (wtime()-start_t)/(N*N);

	if (1.0<wtime()-one_second) { /* at least 1s between stats */
		printf("%lf, %lf, %lf, %lf: ns per cell total, react, vel_step, dens_step\n",
			(react_ns_p_cell+vel_ns_p_cell+dens_ns_p_cell)/times,
			react_ns_p_cell/times, vel_ns_p_cell/times, dens_ns_p_cell/times);
		one_second = wtime();
		react_ns_p_cell = 0.0;
		vel_ns_p_cell = 0.0;
		dens_ns_p_cell = 0.0;
		times = 1;
	} else {
		times++;
	}
}


/*
  ----------------------------------------------------------------------
   main --- main routine
  ----------------------------------------------------------------------
*/

int main ( int argc, char ** argv )
{
	int i = 0;

	if ( argc != 1 && argc != 7 ) {
		fprintf ( stderr, "usage : %s N dt diff visc force source\n", argv[0] );
		fprintf ( stderr, "where:\n" );\
		fprintf ( stderr, "\t N      : grid resolution\n" );
		fprintf ( stderr, "\t dt     : time step\n" );
		fprintf ( stderr, "\t diff   : diffusion rate of the density\n" );
		fprintf ( stderr, "\t visc   : viscosity of the fluid\n" );
		fprintf ( stderr, "\t force  : scales the mouse movement that generate a force\n" );
		fprintf ( stderr, "\t source : amount of density that will be deposited\n" );
		exit ( 1 );
	}

	if ( argc == 1 ) {
		N = N_SIZE;
		dt = 0.1f;
		diff = 0.0f;
		visc = 0.0f;
		force = 5.0f;
		source = 100.0f;
		fprintf ( stderr, "Using defaults : N=%d dt=%g diff=%g visc=%g force = %g source=%g\n",
			N, dt, diff, visc, force, source );
	} else {
		N = atoi(argv[1]);
		dt = atof(argv[2]);
		diff = atof(argv[3]);
		visc = atof(argv[4]);
		force = atof(argv[5]);
		source = atof(argv[6]);
	}

	if ( !allocate_data () ) exit ( 1 );
	clear_data ();
	for (i=0; i<2048; i++)
		one_step ();
	free_data ();

	exit ( 0 );
}
