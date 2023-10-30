// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 17/10/2023
// ============================================================================
// -> Compile
// nvcc -o ex2_3_sem ex2_3_sem.cu
// -> Run
// ./ex2_3_sem

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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
    int N = 32768;
    int err = 0;

    int v1[N], v2[N], v3[N];
    int *a, *b, *c = NULL;

    // ===== Initialize host buffers
    for (int i = 0; i < N; i++)
    {
        v1[i] = rand() % 64;
        v2[i] = rand() % 64;
    }

    // ===== Initialize timer variables
	struct timespec start, end;
	// ===== Get initial time
	clock_gettime(CLOCK_MONOTONIC, &start);

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

    // ===== Copy data from host memory to device memory
    err = cudaMemcpy(a, v1, sizeof(int)*N, cudaMemcpyHostToDevice);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector A from host memory to device.\n");
        return -1;
    }
    err = cudaMemcpy(b, v2, sizeof(int)*N, cudaMemcpyHostToDevice);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector B from host memory to device.\n");
        return -1;
    }
    
    // ===== Allocate results vector in device memory
    err = cudaMalloc(&c, sizeof(int)*N);
    if(err != cudaSuccess)
    {
        perror("Memory allocation for vector C failed in device\n");
        return -1;
    }

    // ===== Launch device function
    int threadsPerBlock = 256;
    int blocksPerGrid = (N/4)/256;
    add_CPU<<<blocksPerGrid,threadsPerBlock>>>(a, b, c);
    cudaDeviceSynchronize();

    // ===== Copy data from device memory to host memory
    err = cudaMemcpy(v3, c, sizeof(int)*N, cudaMemcpyDeviceToHost);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector C from device memory.\n");
        return -1;
    }
    
    // ===== Free device buffers
    cudaFree(a);
    cudaFree(b);
    cudaFree(c);

    // ===== Get final time
	clock_gettime(CLOCK_MONOTONIC, &end);
    
    // ===== Run validation
    printf("-> Validating results for N = %d...\n", N);
    for(int i = 0; i < 5; i++)
    {
        printf("v1[%i]=%i + ", i, v1[i]);
        printf("v2[%i]=%i = ", i, v2[i]);
        printf("v3[%i]=%i\n", i, v3[i]);
    }

	// ===== Calculate the elapsed time
	double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
	double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
	printf("-> Execution Time:\t%f ms\n", (finalTime - initialTime));

    // ===== Done
    printf("-> Done :)\n");

    return 0;
}
