// nvcc -o lab5_ex3_1 lab5_ex3_1.cu
#include <stdio.h>

// Device code
__global__ void reduce(int *g_idata, int *g_odata, int width, int height)
{
    int col = threadIdx.x + blockIdx.x * blockDim.x;
    int row = threadIdx.y + blockIdx.y * blockDim.y;
    // CODE
    g_odata[col * height + row] = g_idata[row * width + col];
}

int main()
{
    int width = 512;
    int height = 512;
    int N = width * height;

    //inicialização do vetor
    int aux[N];
    for(int i=0; i<height; i++)
	{
		for (int j=0; j<width; j++)
		{
			aux[i*width + j] = i;
		}
	} 
    int *v1 = NULL;
    int *v2 = NULL;
    int err1 = 0;
    int err2 = 0;
    err1 = cudaMalloc(&v1, sizeof(int)*N);
    err2 = cudaMalloc(&v2, sizeof(int)*(N));
    if(err1 != cudaSuccess || err2 != cudaSuccess)
    {
        printf("Error allocating device memory.\n");
    }
    //CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

    err1 = cudaMemcpy(v1,&aux,sizeof(int)*N,cudaMemcpyHostToDevice);
    if(err1 != cudaSuccess)
    {
        printf("Error transfering data to device memory.\n");
    }
    // Launch device function
    dim3 threadsPerBlock(16, 16, 1);
    dim3 blocksPerGrid(width/16, height/16, 1);
    reduce<<<blocksPerGrid,threadsPerBlock>>>(v1, v2, width, height);
    
    // Copy data from device memory to host memory
    int * host_buffer = (int *)malloc(sizeof(int)*N);
    err1 = cudaMemcpy(host_buffer,v2,sizeof(int)*N,cudaMemcpyDeviceToHost);
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
    cudaFree(v1);
    cudaFree(v2);
    return 0;
}
