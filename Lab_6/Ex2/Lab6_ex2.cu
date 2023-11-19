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

#define threadsPerBlock 256
#define blocksPerGrid 1024
#define totalThreads (threadsPerBlock*blocksPerGrid)
#define triesPerThread 1000000

// ==================== KERNEL ====================
__global__ void get_pi(unsigned long long int *count_circle, unsigned long long int *count_square, int seed)
{
    // ===== Calculate global index
    int idx = threadIdx.x + blockIdx.x * blockDim.x;

    // ===== Initialize random number generator
    curandState state;
    curand_init(seed, idx, 0, &state);

    // ===== Initialize counters
    count_circle[idx] = 0;
    count_square[idx] = 0;

    // ===== Generate random numbers and count
    for(int i = 0; i < triesPerThread; i++)
    {
        float x = curand_uniform(&state)*2.0 - 1.0;
        float y = curand_uniform(&state)*2.0 - 1.0;

        if (x*x + y*y <= 1.0)
            count_circle[idx]++;
        else
            count_square[idx]++;
    }
}


// ==================== MAIN ====================
int main(int argc, char *argv[])
{   
    // ===== Variables
    // -- Host
    unsigned long long int *circle_host = NULL, *square_host = NULL;
    // -- Device
    unsigned long long int *circle_device = NULL, *square_device = NULL;
    // -- Random seed
    int rand_seed = time(NULL);

    // ===== Alocate memory in host
    circle_host = (unsigned long long int*)malloc(sizeof(unsigned long long int)*totalThreads);
    square_host = (unsigned long long int*)malloc(sizeof(unsigned long long int)*totalThreads);

    // ===== Alocate memory in device
    cudaMalloc((void**)&circle_device, sizeof(unsigned long long int)*totalThreads);
    cudaMalloc((void**)&square_device, sizeof(unsigned long long int)*totalThreads);

    // ===== Print info
    printf("Threads per block: %d || Blocks per grid: %d\n", threadsPerBlock, blocksPerGrid);

    // ===== Call kernel
    get_pi<<<blocksPerGrid, threadsPerBlock>>>(circle_device, square_device, rand_seed);

    // ===== Copy memory from device to host
    cudaMemcpy(circle_host, circle_device, sizeof(unsigned long long int)*totalThreads, cudaMemcpyDeviceToHost);
    cudaMemcpy(square_host, square_device, sizeof(unsigned long long int)*totalThreads, cudaMemcpyDeviceToHost);

    // ===== Sum all results
    unsigned long long int circle_sum = 0, square_sum = 0;
    for(int i = 0; i < totalThreads; i++)
    {
        circle_sum += circle_host[i];
        square_sum += square_host[i];
    }

    // ===== Print results and validate results (pi = 3.141 592 653 58979323846)
    printf("--> Pi = %.10lf\n", (double)(4.0*circle_sum/(double)(circle_sum + square_sum)));
    printf("Points: Circle = %llu\n        Square = %llu\n", circle_sum, square_sum);

    // ===== Free memory
    // -- Host
    free(circle_host);
    free(square_host);
    // -- Device
    cudaFree(circle_device);
    cudaFree(square_device);

    return 0;
}