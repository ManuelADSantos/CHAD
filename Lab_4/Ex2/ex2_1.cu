// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 17/10/2023
// ============================================================================
// -> Compile
// nvcc -o ex2_1 ex2_1.cu
// -> Run
// ./ex2_1

#include <stdio.h>

// ===== Device code =====
__global__ void add_CPU(int *a, int *b, int* c)
{
    // ===== Thread identifier (1 dimensional problem)
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    
    // ===== Kernel Code
    c[index] = a[index] + b[index];
}

// ===== Host code =====
int main()
{
    int N = 1024;
    int err = 0;

    int *v1, *v2, *v3 = NULL;
    int *a, *b, *c = NULL;

    // ==== Allocate vectors to sum in device memory 
    // v1 (host) = a (device)
    v1 = (int *)malloc(sizeof(int)*N);
    if (v1 == NULL) {
        perror("Memory allocation for vector V1 failed in host\n");
        return -1;
    }
    err = cudaMalloc(&a, sizeof(int)*N);
    if(err != cudaSuccess)
    {
        perror("Memory allocation for vector A failed in device\n");
        return -1;
    }
    // v2 (host) = b (device)
    v2 = (int *)malloc(sizeof(int)*N);
    if (v2 == NULL) {
        perror("Memory allocation for vector V2 failed in host\n");
        return -1;
    }
    err = cudaMalloc(&b, sizeof(int)*N);
    if(err != cudaSuccess)
    {
        perror("Memory allocation for vector B failed in device\n");
        return -1;
    }

    // ===== Initialize host buffers
    for (int i = 0; i < N; i++)
    {
        v1[i] = i;
        v2[i] = i;
    }

    // ===== Copy vectors to sum from host memory to device memory
    err = cudaMemcpy(a, v1, sizeof(int)*N, cudaMemcpyHostToDevice);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector A from host memory.\n");
        return -1;
    }
    err = cudaMemcpy(b, v2, sizeof(int)*N, cudaMemcpyHostToDevice);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector B from host memory.\n");
        return -1;
    }
    
    // ==== Allocate result vector in host memory
    v3 = (int *)malloc(sizeof(int)*N);
    if (v3 == NULL) {
        perror("Memory allocation for vector V3 failed in host\n");
        return -1;
    }
    // ==== Allocate result vector in device memory
    err = cudaMalloc(&c, sizeof(int)*N);
    if(err != cudaSuccess)
    {
        perror("Memory allocation for vector C failed in device\n");
        return -1;
    }

    // ===== Launch device function
    int threadsPerBlock = 256;
    int blocksPerGrid = N/256;
    add_CPU<<<blocksPerGrid,threadsPerBlock>>>(a, b, c);
    cudaDeviceSynchronize();

    // ===== Copy data from device memory to host memory
    err = cudaMemcpy(v3, c, sizeof(int)*N, cudaMemcpyDeviceToHost);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector C from device memory.\n");
        return -1;
    }
    
    // ===== Run validation
    printf("-> Validating results (should be double the index)...\n");
    for(int i = 0; i < 5; i++)
    {
        printf("host_buffer[%i]=%i\n", i, v3[i]);
    }

    // ===== Free host buffers
    free(v1);
    free(v2);
    free(v3);
    // ===== Free device buffers
    cudaFree(a);
    cudaFree(b);
    cudaFree(c);

    // ===== Done
    printf("-> Done :)\n");

    return 0;
}
