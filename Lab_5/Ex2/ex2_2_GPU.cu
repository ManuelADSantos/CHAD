// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 03/11/2023
// ============================================================================
// -> Compile
// nvcc -o ex2_2_GPU ex2_2_GPU.cu -lrt -lm
// ============================================================================

#include <stdio.h>
#include <time.h>

#define N 1234

// ===================== Kernel ===================== 
__global__ void sum(int *a, int *result)
{
    __shared__ int temp[256];

    //===== Calculate the index of the current thread
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    
    // ===== ADD
    temp[threadIdx.x] = a[index];
    __syncthreads();

    // ===== REDUCE
    for (int i = blockDim.x/2; i > 0; i /= 2)
    {
        if (threadIdx.x < i)
        {
            temp[threadIdx.x] += temp[threadIdx.x + i];
        }
        __syncthreads();
    }

    // ===== Store the result
    if (threadIdx.x == 0)
    {
        atomicAdd(result, temp[0]);
    }
}

// ===================== Main =====================
int main(int argc, char *argv[])
{
    // ===== Show number of elements
    printf("-> Number of elements:  %d\n", N);

    // ===== Declare variables
    int *a, *result;
    int *d_a, *d_result;
    int size = N * sizeof(int);

    // ===== Initialize timer variables
    struct timespec start, end;

    // ===== Allocate host memory
    a = (int*)malloc(size);
    result = (int*)calloc(1, sizeof(int));
    *result = 0;

    // ===== Initialize the vector
    for (int i = 0; i < N; i++) 
    {
        a[i] = i;
    }
    
    // ===== Allocate device memory
    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_result, sizeof(int));

    // ===== Copy data from host to device
    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);

    // ===== Initialize the grid and block dimensions
    int threadsPerBlock = 256;
    int blocksPerGrid = ceil(N/256.0);
    
    // ===== Get initial time
    clock_gettime(CLOCK_MONOTONIC, &start);
    
    // ===== Call the kernel
    sum<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_result);

    // ===== Copy data from device to host
    cudaMemcpy(result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    // ===== Get final time
    clock_gettime(CLOCK_MONOTONIC, &end);

    // ===== Calculate the elapsed time
    double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
    double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
    printf("-> Execution Time:\t%f ms\n", (finalTime - initialTime));

    // ===== Show the result (validation)
    printf("Sum of all elements in the vector: %d\n", *result);

    // ===== Free device memory
    cudaFree(d_a);
    cudaFree(d_result);

    // ===== Free host memory
    free(a);
    free(result);

    return 0;
}