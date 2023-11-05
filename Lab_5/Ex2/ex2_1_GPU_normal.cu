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
#include <time.h>

#define N 1234

__global__ void sum(int* a, int *result)
{
    int tid = threadIdx.x;
    int index = threadIdx.x + (blockIdx.x * blockDim.x);

    result[tid] = a[index];
        
    for (int s = 1; s < blockDim.x; s *= 2) {
	if (tid % (2*s) == 0)
    {
	    result[tid] += result[tid + s];
	}
	__syncthreads();
    }
}

int main()
{
    // ===== Show number of elements
    printf("-> Number of elements:  %d\n", N);

    int *a, *result, soma = 0;
    int *d_a, *d_result;
    int size = N * sizeof(int);

    // ===== Initialize timer variables
    struct timespec start, end;

    // ===== Allocate host memory
    a = (int*)malloc(size);
    result = (int*)calloc(N, sizeof(int));
    int check = 0;

    // ===== Initialize vector
    for (int i = 0; i < N; i++) 
    {
        a[i] = i;
    }
    
    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_result, sizeof(int));

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);

    int threadsPerBlock = 256; 
    int blocksPerGrid = (int)ceil(N/256.0);
    
    // ===== Get initial time
    clock_gettime(CLOCK_MONOTONIC, &start);

    sum<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_result);

    cudaMemcpy(result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    // ===== Get final time
    clock_gettime(CLOCK_MONOTONIC, &end);
    // ===== Calculate the elapsed time
    double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
    double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
    printf("-> Execution Time:\t%f ms\n", (finalTime - initialTime));

    for(int i = 0; i < blocksPerGrid; i++)
    {
    	soma += result[i];
    }
    printf("Sum of all elements in the vector: %d\n", *result);

    
    cudaFree(d_a);
    cudaFree(d_result);
    free(a);
    free(result);

    return 0;
}
