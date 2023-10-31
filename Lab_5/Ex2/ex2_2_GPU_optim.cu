// nvcc -o ex2_2_GPU_optim ex2_2_GPU_optim.cu -lrt -lm
#include <stdio.h>

#define N 10

__global__ void sum(int *a, int *result) {
    __shared__ int temp[N];

    int tid = threadIdx.x;
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    temp[tid] = a[i];
    __syncthreads();

    for (int s = 1; s < blockDim.x; s *= 2) {
        if (tid % (2 * s) == 0) {
            temp[tid] += temp[tid + s];
        }
        __syncthreads();
    }

    if (tid == 0) {
        *result = temp[0];
    }
}

int main() {
    int *a, *result, *d_a, *d_result;
    int size = N * sizeof(int);

    a = (int*)malloc(size);
    result = (int*)malloc(sizeof(int));

    for (int i = 0; i < N; i++) {
        a[i] = i;
    }

    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_result, sizeof(int));

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);

    dim3 dimBlock(N, 1, 1);
    dim3 dimGrid(1, 1, 1);

    sum<<<dimGrid, dimBlock>>>(d_a, d_result);

    cudaMemcpy(result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    printf("Sum of all elements in the vector: %d\n", *result);

    cudaFree(d_a);
    cudaFree(d_result);
    free(a);
    free(result);

    return 0;
}
