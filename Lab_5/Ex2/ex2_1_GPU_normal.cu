// nvcc -o ex2_1_GPU_normal ex2_1_GPU_normal.cu -lrt -lm
#include <stdio.h>

#define N 10


__global__ void sum(int *a, int *result)
{
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    
    atomicAdd(result, a[index]);
}

int main()
{
    int *a, *result;
    int *d_a, *d_result;
    int size = N * sizeof(int);

    a = (int*)malloc(size);
    result = (int*)calloc(1, sizeof(int));
    *result = 0;

    printf("result = %d\n", *result);
    for (int i = 0; i < N; i++) 
    {
        a[i] = i;
        printf("a[%d] = %d  ",i, a[i]);
    }

    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_result, sizeof(int));

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);

    dim3 dimBlock(N, 1, 1);
    dim3 dimGrid(1, 1, 1);

    sum<<<dimGrid, dimBlock>>>(d_a, d_result);

    cudaMemcpy(result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    printf("\nSum of all elements in the vector: %d\n", *result);

    cudaFree(d_a);
    cudaFree(d_result);
    free(a);
    free(result);

    return 0;
}
