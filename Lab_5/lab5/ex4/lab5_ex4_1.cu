// nvcc -o lab5_ex4_1 lab5_ex4_1.cu
#include <stdio.h>
#define bin 16

// Device code
__global__ void histogram(unsigned char * image, int * hist, int size)
{
    int Col = threadIdx.x + (blockIdx.x * blockDim.x);
    int Row = threadIdx.y + (blockIdx.y * blockDim.y);

    int i = Row * size + Col;
    unsigned char pixel = image[i];

    int index = (int)(pixel/bin);

    atomicAdd(&hist[index],1);
}

int main()
{
    int size = 256;
    int N = size * size;

    //inicialização da imagem
    unsigned char aux[N];
    int aux2[bin];
    for (int i=0; i<N; i++)
    {
        aux[i] = 255 * sin(i) * sin(i);
    }

    for (int i=0; i<bin; i++)
    {
        aux2[i] = 0;
    }

    //alocação de memória para a GPU
    unsigned char *image = NULL;
    int *hist = NULL;

    int err1 = 0;
    int err2 = 0;
    err1 = cudaMalloc(&image, sizeof(unsigned char)*N);
    err2 = cudaMalloc(&hist, sizeof(int)*bin);
    if(err1 != cudaSuccess || err2 != cudaSuccess)
    {
        printf("Error allocating device memory.\n");
    }

    //CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

    err1 = cudaMemcpy(image,&aux,sizeof(unsigned char)*N,cudaMemcpyHostToDevice);
    err2 = cudaMemcpy(hist,&aux2,sizeof(int)*bin,cudaMemcpyHostToDevice);
    if(err1 != cudaSuccess || err2 != cudaSuccess)
    {
        printf("Error transfering data to device memory.\n");
    }

    // Launch device function
    dim3 threadsPerBlock(16, 16, 1);
    dim3 blocksPerGrid(size/16, size/16, 1);
    histogram<<<blocksPerGrid,threadsPerBlock>>>(image, hist, size);

    // Copy data from device memory to host memory
    int * host_buffer = (int *)malloc(sizeof(int)*bin);
    err1 = cudaMemcpy(host_buffer,hist,sizeof(int)*bin,cudaMemcpyDeviceToHost);
    if(err1 != cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }

    clock_gettime(CLOCK_MONOTONIC, &end);
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    int contador = 0;
	for(int i=0; i<bin; i++)
	{
		printf("hist[%i]=%u\n", i, host_buffer[i]);
		contador += host_buffer[i];
	} 
	printf("Contagem total = %i\n", contador);
    printf("Cuda (%i*%i elemens):\t%f ms\n", size, size, (finalTime - initialTime));
    // Free device buffers
    cudaFree(image);
    cudaFree(hist);
    return 0;
}
