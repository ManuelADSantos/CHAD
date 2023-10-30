// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 18/10/2023
// ============================================================================
// -> Compile
// nvcc -o ex3 ex3.cu
// -> Run
// ./ex3

#include <stdio.h>

// ===== Device code =====
__global__ void matrix_add(int *a, int *b, int* c, int N)
{
    // ===== Kernel Code
    // Get row and column of matrix
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    
    // Sum matrices a and b and store result in matrix c
    c[row * N + col] = a[row * N + col] + b[row * N + col];
}

// ===== Host code =====
int main()
{
    int N = 16, err = 0, N_show = 16;
    int M1[N][N], M2[N][N], M3[N][N];
    int *a, *b, *c = NULL;

    // ===== Initialize host matrices
    for(int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {   
            M1[i][j] = i + j;
            M2[i][j] = i + j;
        }
    }

    // ===== Print host matrices
    printf("\nMatrix M1:\n");
    for(int i = 0; i < N_show; i++)
    {
        for (int j = 0; j < N_show; j++)
        {
            printf("%2d ", M1[i][j]);
        }
        printf("\n");
    }
    printf("\nMatrix M2:\n");
    for(int i = 0; i < N_show; i++)
    {
        for (int j = 0; j < N_show; j++)
        {
            printf("%2d ", M2[i][j]);
        }
        printf("\n");
    }

    // ==== Allocate matrices to sum and result in device memory
    err = cudaMalloc(&a, sizeof(int)*N*N);
    err = cudaMalloc(&b, sizeof(int)*N*N);
    err = cudaMalloc(&c, sizeof(int)*N*N);
    if(err != cudaSuccess)
    {
        perror("Memory allocation for vector A, B or C failed in device\n");
        return -1;
    }

    // ===== Copy data from host memory to device memory
    err = cudaMemcpy(a, M1, sizeof(int)*N*N, cudaMemcpyHostToDevice);
    err = cudaMemcpy(b, M2, sizeof(int)*N*N, cudaMemcpyHostToDevice);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector M1 or M2 from host memory to device.\n");
        return -1;
    }

    // ===== Launch device function
    dim3 blocksPerGrid(1, 1);
    dim3 threadsPerBlock(N, N);
    matrix_add<<<blocksPerGrid,threadsPerBlock>>>(a, b, c, N);
    cudaDeviceSynchronize();

    // ===== Copy result from device memory to host memory
    err = cudaMemcpy(M3, c, sizeof(int)*N*N, cudaMemcpyDeviceToHost);
    if(err != cudaSuccess)
    {
        perror("Error transfering vector C from device memory.\n");
        return -1;
    }

    // ===== Run validation
    printf("\nMatrix M3:\n");
    for(int i = 0; i < N_show; i++)
    {
        for (int j = 0; j < N_show; j++)
        {
            printf("%2d ", M3[i][j]);
        }
        printf("\n");
    }

    // ===== Free device buffers   
    cudaFree(a);
    cudaFree(b);
    cudaFree(c);

    // ===== Done
    printf("\n-> Done :)\n");

    return 0;
}