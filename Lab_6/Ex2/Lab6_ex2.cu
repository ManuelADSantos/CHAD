// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 07/11/2023
// ============================================================================
// -> Compile
// nvcc -o Lab6_ex2 Lab6_ex2.cu -lrt
// ============================================================================

#include <stdio.h>
#include <time.h>
#include <curand_kernel.h>
#include <cuda_runtime.h>

__global__ void get_pi(int *count_circle, int *count_square, int seed)
{
    int idx = threadIdx.x + blockIdx.x * blockDim.x;

    curandState state;
    curand_init(seed, idx, 0, &state);

    for(int i = 0; i < 1000; i++)
    {
        float x = curand_uniform(&state)*2.0 - 1.0;
        float y = curand_uniform(&state)*2.0 - 1.0;

        if (x*x + y*y <= 1.0)
            atomicAdd(count_circle, 1);
        else
            atomicAdd(count_square, 1);
    }
}


int main(int argc, char *argv[])
{   
    int circle_host = 0, square_host = 0;
    int *circle_device, *square_device;
    int time_host = time(NULL);

    cudaMalloc((void**)&circle_device, sizeof(int));
    cudaMalloc((void**)&square_device, sizeof(int));

    cudaMemcpy(circle_device, &circle_host, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(square_device, &square_host, sizeof(int), cudaMemcpyHostToDevice);

    int threadsPerBlock = 256;
    int blocksPerGrid = 256;

    get_pi<<<blocksPerGrid, threadsPerBlock>>>(circle_device, square_device, time_host);

    cudaMemcpy(&circle_host, circle_device, sizeof(int), cudaMemcpyDeviceToHost);
    cudaMemcpy(&square_host, square_device, sizeof(int), cudaMemcpyDeviceToHost);

    printf("Pi = %f\n", 4.0*circle_host/(circle_host+square_host));

    return 0;
}