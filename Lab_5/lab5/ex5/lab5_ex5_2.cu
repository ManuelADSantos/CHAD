// nvcc -o lab5_ex5_2 lab5_ex5_2.cu
#include <stdio.h>
#define TILE 16

// Device code
__global__ void reduce(int *m1, int *m2, int *m3, int width, int height)
{
    __shared__ int sub1[TILE][TILE];
    __shared__ int sub2[TILE][TILE];

    int bx = blockIdx.x;
    int by = blockIdx.y;
    int tx = threadIdx.x;
    int ty = threadIdx.y;

    int col = tx + bx * TILE;
    int row = ty + by * TILE;
    int vfinal = 0;

    // Loop que corre todos os sub-blocos necessários para calcular 1 elemento
    for (int m=0; m<width/TILE; ++m)
    {
        sub1[ty][tx] = m1[row*width + m*TILE + tx];
        sub2[ty][tx] = m2[(m*TILE + ty)*width + col];
        __syncthreads();
        for (int k=0; k<TILE; ++k)
            vfinal += sub1[ty][k] * sub2[k][tx];
        __syncthreads();
    }

    m3[row * width + col] = vfinal;
}

int main()
{
    int width = 256;
    int height = 256;
    int N = width * height;

    //inicialização do vetor
    int aux1[N];
    int aux2[N];
    for(int i=0; i<N; i++)
	{
		aux1[i] = 1;
        aux2[i] = 2;
	} 

    int *m1 = NULL;
    int *m2 = NULL;
    int *m3 = NULL;
    int err1 = 0;
    int err2 = 0;
    int err3 = 0;
    err1 = cudaMalloc(&m1, sizeof(int)*N);
    err2 = cudaMalloc(&m2, sizeof(int)*N);
    err3 = cudaMalloc(&m3, sizeof(int)*N);
    if(err1 != cudaSuccess || err2 != cudaSuccess || err3 != cudaSuccess)
    {
        printf("Error allocating device memory.\n");
    }
    //CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

    err1 = cudaMemcpy(m1,&aux1,sizeof(int)*N,cudaMemcpyHostToDevice);
    err2 = cudaMemcpy(m2,&aux2,sizeof(int)*N,cudaMemcpyHostToDevice);
    if(err1 != cudaSuccess || err2 != cudaSuccess)
    {
        printf("Error transfering data to device memory.\n");
    }
    // Launch device function
    dim3 threadsPerBlock(16, 16, 1);
    dim3 blocksPerGrid(width/16, height/16, 1);
    reduce<<<blocksPerGrid,threadsPerBlock>>>(m1, m2, m3, width, height);
    
    // Copy data from device memory to host memory
    int * host_buffer = (int *)malloc(sizeof(int)*N);
    err1 = cudaMemcpy(host_buffer,m3,sizeof(int)*N,cudaMemcpyDeviceToHost);
    if(err1 != cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }
    clock_gettime(CLOCK_MONOTONIC, &end);
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    printf("host_buffer[%i][%i]=%u\n", width/2, height/4, host_buffer[((width/2) * height) + height/4]);
    printf("host_buffer[%i][%i]=%u\n", width/4, 3*height/4, host_buffer[((width/4) * height) + 3*height/4]);
    printf("host_buffer[%i][%i]=%u\n", 3*width/4, height/2, host_buffer[((3*width/4) * height) + height/2]);
    printf("Cuda (%ix%i elemens):\t%f ms\n", width, height, (finalTime - initialTime));
    // Free device buffers
    cudaFree(m1);
    cudaFree(m2);
    cudaFree(m3);
    return 0;
}
