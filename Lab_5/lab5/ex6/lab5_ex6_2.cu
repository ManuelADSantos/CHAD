// nvcc -o lab5_ex6_2 lab5_ex6_2.cu
#include <stdio.h>
#define t_filtro 3
#define N 65536
#define TILE 16

// Device code
__global__ void convolution(unsigned char *img, unsigned char *res, float *filtro, int size)
{
    int col = threadIdx.x + blockIdx.x * blockDim.x;
    int row = threadIdx.y + blockIdx.y * blockDim.y;
    int tcol = threadIdx.x;
    int trow = threadIdx.y;

    float valor = 0;

    __shared__ unsigned char image[TILE][TILE];
    __shared__ float fil[t_filtro][t_filtro];

    if (col < 3 && row < 3)
    {
        fil[row][col] = filtro[row*3 + col];
    }

    image[trow][tcol] = img[row*size + col];

    __syncthreads();

    for (int i=0; i<t_filtro; i++)
    {
        for (int j=0; j<t_filtro; j++)
        {
            if ((trow + i - 1)<0  || (trow + i - 1)>15 || (tcol + j - 1)<0 || (tcol + j - 1)>15)
            {
                if ((row + i - 1)>=0  || (row + i - 1)<=255 || (col + j - 1)>=0 || (col + j - 1)<=255)
                    valor += img[(row + i - 1)*size + (col + j - 1)];
            }
            else
                valor += image[trow + i - 1][tcol + j - 1] * fil[i][j]; 
        }
    }
    res[row*size + col] = (unsigned char)valor;
}

int main()
{
    int size = 256;

    //inicialização do vetor
    unsigned char aux1[N];
    float aux2[t_filtro*t_filtro];
    for(int i=0; i<size; i++)
	{
		for(int j=0; j<size; j++)
  		{
  			if (i%2 == j%2)
                aux1[i*size + j] = 255;
  			else 
                aux1[i*size + j] = 0;
  		} 
	} 

    for(int i=0; i<t_filtro*t_filtro; i++)
	{
		aux2[i] = 1;
		aux2[i] = aux2[i]/9;
	} 

    unsigned char *img = NULL;
    float *filtro = NULL;
    unsigned char *res = NULL;
    int err1 = 0;
    int err2 = 0;
    int err3 = 0;
    err1 = cudaMalloc(&img, sizeof(unsigned char)*N);
    err2 = cudaMalloc(&filtro, sizeof(float)*t_filtro*t_filtro);
    err3 = cudaMalloc(&res, sizeof(unsigned char)*N);
    if(err1 != cudaSuccess || err2 != cudaSuccess || err3 != cudaSuccess)
    {
        printf("Error allocating device memory.\n");
    }
    //CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

    err1 = cudaMemcpy(img,&aux1,sizeof(unsigned char)*N,cudaMemcpyHostToDevice);
    err2 = cudaMemcpy(filtro,&aux2,sizeof(float)*t_filtro*t_filtro,cudaMemcpyHostToDevice);
    if(err1 != cudaSuccess || err2 != cudaSuccess || err3 != cudaSuccess)
    {
        printf("Error transfering data to device memory.\n");
    }
    // Launch device function
    dim3 threadsPerBlock(16, 16, 1);
    dim3 blocksPerGrid(size/16, size/16, 1);
    convolution<<<blocksPerGrid,threadsPerBlock>>>(img, res, filtro, size);
    
    // Copy data from device memory to host memory
    unsigned char * host_buffer = (unsigned char *)malloc(sizeof(unsigned char)*N);
    err1 = cudaMemcpy(host_buffer,res,sizeof(unsigned char)*N,cudaMemcpyDeviceToHost);
    if(err1 != cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }
    clock_gettime(CLOCK_MONOTONIC, &end);
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    for(int i=0; i<10; i++)
	{
		for(int j=0; j<10; j++)
		{
			printf("%-4u ", host_buffer[i*size + j]);
		} 
		printf("\n");
	} 
    printf("Cuda (%ix%i elemens):\t%f ms\n", size, size, (finalTime - initialTime));
    // Free device buffers
    cudaFree(img);
    cudaFree(filtro);
    cudaFree(res);
    return 0;
}
