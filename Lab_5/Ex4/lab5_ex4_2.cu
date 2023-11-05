// nvcc -o lab5_ex4_2 lab5_ex4_2.cu
#include <stdio.h>
#define bin 16
#define N 65536

// Device code
__global__ void histogram(unsigned char * image, int * hist, int size)
{
    __shared__ unsigned char s_data[256];
    __shared__ int s_hist[bin];

    int Col = threadIdx.x + (blockIdx.x * blockDim.x);
    int Row = threadIdx.y + (blockIdx.y * blockDim.y);

    int i = Row * size + Col;
    int i_thread = threadIdx.y * blockDim.x + threadIdx.x;

    s_data[i_thread] = image[i];
    if (i_thread < bin)
    {
        s_hist[i_thread] = 0;
    }
    __syncthreads();

    atomicAdd(&s_hist[(int)(s_data[i_thread]/bin)],1);

    __syncthreads();

    if (i_thread < bin)
    {
        atomicAdd(&hist[i_thread + blockIdx.x * bin], s_hist[i_thread]);
    }
}

int main()
{
    int size = 256;

    //inicialização da imagem
    unsigned char aux[N];
    for (int i=0; i<N; i++)
    {
        aux[i] = 255 * sin(i) * sin(i);
    }

    //alocação de memória para a GPU
    unsigned char *image = NULL;
    int *hist = NULL;

    int err1 = 0;
    int err2 = 0;
    err1 = cudaMalloc(&image, sizeof(unsigned char)*N);
    err2 = cudaMalloc(&hist, sizeof(int)*bin*bin);
    if(err1 != cudaSuccess || err2 != cudaSuccess)
    {
        printf("Error allocating device memory.\n");
    }

    //CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

    err1 = cudaMemcpy(image,&aux,sizeof(unsigned char)*N,cudaMemcpyHostToDevice);
    if(err1 != cudaSuccess)
    {
        printf("Error transfering data to device memory.\n");
    }

    // Launch device function
    dim3 threadsPerBlock(16, 16, 1);
    dim3 blocksPerGrid(size/16, size/16, 1);
    histogram<<<blocksPerGrid,threadsPerBlock>>>(image, hist, size);

    // Copy data from device memory to host memory
    int * host_buffer = (int *)malloc(sizeof(int)*bin*bin);
    err1 = cudaMemcpy(host_buffer,hist,sizeof(int)*bin*bin,cudaMemcpyDeviceToHost);
    if(err1 != cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }
    int histograma[bin];
    for (int i=0; i<bin; i++)
    {
        histograma[i] = 0;
        for (int j=0; j<bin; j++)
        {
            histograma[i] += host_buffer[j*bin + i];
        }
    }

    clock_gettime(CLOCK_MONOTONIC, &end);
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    int contador = 0;
	for(int i=0; i<bin; i++)
	{
		printf("hist[%i]=%u\n", i, histograma[i]);
		contador += histograma[i];
	} 
	printf("Contagem total = %i\n", contador);
    printf("Cuda (%i*%i elemens):\t%f ms\n", size, size, (finalTime - initialTime));
    // Free device buffers
    cudaFree(image);
    cudaFree(hist);
    return 0;
}
