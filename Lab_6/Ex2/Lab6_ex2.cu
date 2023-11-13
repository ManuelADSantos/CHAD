// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 07/11/2023
// ============================================================================
// -> Compile
// nvcc -o Lab6_ex2 Lab6_ex2.cu
// ============================================================================

#include <stdio.h>
#include <curand_kernel.h>

__global__ void get_pi(int *count_circle, int *count_square)
{
    int idx = threadIdx.x + blockIdx.x * blockDim.x;

    curandState state;
    curand_init(1234, idx, 0, &state);

    float x = curand_uniform(&state)*2.0 - 1.0;
    float y = curand_uniform(&state)*2.0 - 1.0;

    if (x*x + y*y <= 1.0)
        atomicAdd(count_circle, 1);
    else
        atomicAdd(count_square, 1);
}


int main(int argc, char *argv[])
{   
    int circle_host = 0, square_host = 0;
    int *circle_device, *square_device;

    cudaMalloc((void**)&circle_device, sizeof(int));
    cudaMalloc((void**)&square_device, sizeof(int));

    cudaMemcpy(circle_device, &circle_host, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(square_device, &square_host, sizeof(int), cudaMemcpyHostToDevice);

    int threadsPerBlock = 256;
    int blocksPerGrid = 2000;

    get_pi<<<blocksPerGrid, threadsPerBlock>>>(circle_device, square_device);

    cudaMemcpy(&circle_host, circle_device, sizeof(int), cudaMemcpyDeviceToHost);
    cudaMemcpy(&square_host, square_device, sizeof(int), cudaMemcpyDeviceToHost);

    printf("Pi = %f\n", 4.0*circle_host/(circle_host+square_host));

    return 0;
}