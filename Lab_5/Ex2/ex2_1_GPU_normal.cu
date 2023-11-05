// nvcc -o ex2_1_GPU_normal ex2_1_GPU_normal.cu -lrt -lm
#include <stdio.h>
#include <time.h>

// #define N 100


__global__ void sum(int *a, int *result)
{
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    
    atomicAdd(result, a[index]);
}

int main(int argc, char *argv[])
{
    // Check if the number of arguments is correct
    if (argc != 2)
    {
        printf("./ex2_CPU num_elements\n");
        return -1;
    }
    int N = atoi(argv[1]);
    printf("Number of elements: %d\n", N);

    int *a, *result;
    int *d_a, *d_result;
    int size = N * sizeof(int);

    // ===== Initialize timer variables
    struct timespec start, end;


    a = (int*)malloc(size);
    result = (int*)calloc(1, sizeof(int));
    *result = 0;

    //printf("result = %d\n", *result);
    for (int i = 0; i < N; i++) 
    {
        a[i] = i;
        //printf("a[%d] = %d  ",i, a[i]);
    }
    
    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_result, sizeof(int));

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);

    int threadsPerBlock = 256;
    int blocksPerGrid = ceil(N/256.0);
    
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

    printf("Sum of all elements in the vector: %d\n", *result);

    cudaFree(d_a);
    cudaFree(d_result);
    free(a);
    free(result);

    return 0;
}
