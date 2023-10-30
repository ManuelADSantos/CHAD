// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 17/10/2023
// ============================================================================
// -> Compile
// nvcc -o ex2_2 ex2_2.cu
// -> Run
// ./ex2_2

#include <stdio.h>

// ===== Device code =====
__global__ void add_CPU(int *a, int *b, int* c)
{
    // ===== Thread identifier (1 dimensional problem)
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    
    // ===== Kernel Code
    // Initialize vectors a and b with index
    a[index] = index;
    b[index] = index;
    // Sum vectors a and b and store result in vector c
    c[index] = a[index] + b[index];
}

// ===== Host code =====
int main()
{
    int N = 1024;
    int err = 0;

    int *v3 = NULL;
    int *a, *b, *c = NULL;

    // ==== Allocate vectors to sum in device memory  
    err = cudaMalloc(&a, sizeof(int)*N);
    if(err != cudaSuccess)
    {
        perror("Memory allocation for vector A failed in device\n");
        return -1;
    }
    err = cudaMalloc(&b, sizeof(int)*N);
    if(err != cudaSuccess)
    {
        perror("Memory allocation for vector B failed in device\n");
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

    // ===== Free device buffers
    free(v3);
    cudaFree(a);
    cudaFree(b);
    cudaFree(c);

    // ===== Done
    printf("-> Done :)\n");

    return 0;
}