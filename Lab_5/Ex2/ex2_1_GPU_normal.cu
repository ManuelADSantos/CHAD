// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 03/11/2023
// ============================================================================
// -> Compile
// nvcc -o ex2_1_GPU_normal ex2_1_GPU_normal.cu -lrt -lm
// -> Run
// ./ex2_1_GPU_normal
// ============================================================================
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// ===================== Kernel function =====================
__global__ void sum(int *a, int *result)
{
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    
    atomicAdd(result, a[index]);
}

// ===================== Main function =====================
int main(int argc, char *argv[])
{
    // ===== Check if the number of arguments is correct
    if (argc != 2)
    {
        printf("./ex2_1_GPU_normal num_elements\n");
        return -1;
    }

    // ===== Get the number of elements
    int N = atoi(argv[1]);
    printf("-> Number of elements:  %d\n", N);

    // ===== Initialize variables
    int *a, *result;
    int *d_a, *d_result;
    int size = N * sizeof(int);

    // ===== Initialize timer variables
    struct timespec start, end;

    // ===== Allocate memory
    a = (int*)malloc(size);
    result = (int*)calloc(1, sizeof(int));
    *result = 0;

    // ===== Initialize vector
    for (int i = 0; i < N; i++) 
    {
        a[i] = i;
    }
    
    // ===== Allocate memory on the device
    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_result, sizeof(int));

    // ===== Initialize the grid and block dimensions
    int threadsPerBlock = 256;
    int blocksPerGrid = ceil(N/256.0);
    
    // ===== Get initial time
    clock_gettime(CLOCK_MONOTONIC, &start);
    
    // ===== Copy data from host to device
    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);

    // ===== Execute the kernel
    sum<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_result);

    // ===== Copy data from device to host
    cudaMemcpy(result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    // ===== Get final time
    clock_gettime(CLOCK_MONOTONIC, &end);

    // ===== Calculate the elapsed time
    double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
    double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
    printf("-> Execution Time:\t%f ms\n", (finalTime - initialTime));

    // ===== Print the result (Validating the result)
    printf("Sum of all elements in the vector: %d\n", *result);

    // ===== Free device memory
    cudaFree(d_a);
    cudaFree(d_result);

    // ===== Free host memory
    free(a);
    free(result);

    return 0;
}
