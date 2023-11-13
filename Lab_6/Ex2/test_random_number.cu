// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 07/11/2023
// ============================================================================
// -> Compile
// nvcc -o test_random_number test_random_number.cu
// ============================================================================

#include <stdio.h>
#include <curand_kernel.h>

__global__ void get_pi(float *results)
{
    int idx = threadIdx.x + blockIdx.x * blockDim.x;

    curandState state;
    curand_init(1234, idx, 0, &state);
    results[idx] = curand_uniform(&state);    
}


int main(int argc, char *argv[])
{   
    int N = 256;

    float *result_host, *result_device;

    result_host = (float*)malloc(N*sizeof(float));
    cudaMalloc((void**)&result_device, N*sizeof(float));

    get_pi<<<1, N>>>(result_device);

    cudaMemcpy(result_host, result_device, N*sizeof(float), cudaMemcpyDeviceToHost);

    for (int i = 0; i < N; i++)
    {
        printf("[%d]: %g\n", i, result_host[i]);
    }

    return 0;
}