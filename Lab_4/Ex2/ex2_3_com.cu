// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 17/10/2023
// ============================================================================
// -> Compile
// nvcc -o ex2_3_com ex2_3_com.cu
// -> Run
// ./ex2_3_com

#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <time.h>

// ===== Device code =====
__global__ void add_CPU(int *a, int *b, int* c)
{
    // ===== Thread identifier (1 dimensional problem)
    int index = threadIdx.x + blockIdx.x * blockDim.x;

    // ===== Kernel Code
    c[index] = a[index] + b[index];
}

// Function to compress the vector
void compress_by_4(int *original, int *compressed, int N)
{
    int regist = 0;
    for(int i = 0; i < N; i++)
    {
        char aux = (char)original[i]; 
        regist = (int)aux | regist;
        if (i % 4 == 3)
        {  
            compressed[i/4] = regist;
            regist = 0;
        }
        regist = regist << 8;
    }
}

// Function to decompress the vector
void decompress_by_4(int *compressed, int *decompressed, int N)
{    
    int idx = 0;
    for(int i = 0; i < N; i++)
    {
        decompressed[i] = (compressed[idx] >> (24-8*(i%4))) & 0xFF;
        if (i % 4 == 3)
            idx++;
    }
}

// ===== Host code =====
int main()
{
    int N = 32768;
    int N_short = N/4;
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
    err = cudaMalloc(&a, sizeof(int)*N_short);
    if(err != cudaSuccess)
    {
        perror("Memory allocation for vector A failed in device\n");
        return -1;
    }

    err = cudaMalloc(&b, sizeof(int)*N_short);
    if(err != cudaSuccess)
    {
        perror("Memory allocation for vector B failed in device\n");
        return -1;
    }

    // ===== Compress the vectors
    int v1_short[N/4], v2_short[N/4];
    compress_by_4(v1, v1_short, N);
    compress_by_4(v2, v2_short, N);

    // ===== Copy data from host memory to device memory
    err = cudaMemcpy(a, v1_short, sizeof(int)*N_short, cudaMemcpyHostToDevice);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector A from host memory.\n");
        return -1;
    }
    err = cudaMemcpy(b, v2_short, sizeof(int)*N_short, cudaMemcpyHostToDevice);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector B from host memory.\n");
        return -1;
    }
    
    // ===== Allocate results vector in device memory
    err = cudaMalloc(&c, sizeof(int)*N_short);
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
    int v3_short[N];
    err = cudaMemcpy(v3_short, c, sizeof(int)*N_short, cudaMemcpyDeviceToHost);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector C from device memory.\n");
        return -1;
    }

    // ===== Decompress the vector
    decompress_by_4(v3_short, v3, N);
    
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
        printf("v3[%i]=%d\n", i, v3[i]);
    }

    // ===== Calculate the elapsed time
	double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
	double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
	printf("-> Execution Time:\t%f ms\n", (finalTime - initialTime));

    // ===== Done
    printf("-> Done :)\n");

    return 0;
}
