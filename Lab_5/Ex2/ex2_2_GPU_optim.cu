// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 03/11/2023
// ============================================================================
// -> Compile
// nvcc -o ex2_2_GPU_optim ex2_2_GPU_optim.cu -lrt -lm
// -> Run
// ./ex2_2_GPU_optim num_elements
// ============================================================================
#include <stdio.h>
#include <time.h>

// ===================== Kernel function =====================
__global__ void sum(int *a, int *result, int n)
{
    extern __shared__ int temp[];

    int tid = threadIdx.x;
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    // Initialize temp array with input or 0 if out of bounds
    temp[tid] = (i < n) ? a[i] : 0;
    __syncthreads();

    for (int s = blockDim.x / 2; s > 0; s >>= 1) {
        if (tid < s) 
        {
            temp[tid] += temp[tid + s];
        }
        __syncthreads();
    }

    if (tid == 0) {
        atomicAdd(result, temp[0]);
    }
}

// ===================== Main function =====================
int main(int argc, char *argv[])
{
    // Check if the number of arguments is correct
    if (argc != 2)
    {
        printf("./ex2_2_GPU_optim num_elements\n");
        return -1;
    }
    int N = atoi(argv[1]);
    printf("-> Number of elements:  %d\n", N);

    int *a, *result, *d_a, *d_result;
    int size = N * sizeof(int);

    // ===== Initialize timer variables
    struct timespec start, end;

    a = (int*)malloc(size);
    result = (int*)malloc(sizeof(int));

    for (int i = 0; i < N; i++)
    {
        a[i] = i;
    }

    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_result, sizeof(int));

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);

    int threadsPerBlock = 256;
    int blocksPerGrid = ceil(N/256.0);
    int sharedMemorySize = N * sizeof(int);

    // ===== Get initial time
    clock_gettime(CLOCK_MONOTONIC, &start);

    sum<<<blocksPerGrid, threadsPerBlock, sharedMemorySize>>>(d_a, d_result, N);

    cudaMemcpy(result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    // ===== Get final time
    clock_gettime(CLOCK_MONOTONIC, &end);
    // ===== Calculate the elapsed time
    double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
    double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
    printf("-> Execution Time:\t%f ms\n", (finalTime - initialTime));

    printf("Sum of all elements in the vector: %d\n", *result);

    cudaFree(d_a);
    cudaFree(d_result);
    free(a);
    free(result);

    return 0;
}
