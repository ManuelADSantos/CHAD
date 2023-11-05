// nvcc -o lab5_ex1_3840x2160 lab5_ex1_3840x2160.cu
#include <stdio.h>
#define CHANNELS 3

// Device code
__global__ void colorToGreyScaleConvertion(unsigned char * grayImage, unsigned char * rgbImage, int width, int height)
{
    int Col = threadIdx.x + (blockIdx.x * blockDim.x);
    int Row = threadIdx.y + (blockIdx.y * blockDim.y);
    if(Col < width && Row < height)
    {
        //get 1D coordinate for the grayscale image
        int greyOffset = Row * width + Col;
        //onre can think of the RGB image having CHANNEL times columns of the gray scale image
        int rgbOffset = greyOffset * CHANNELS;
        unsigned char r = rgbImage[rgbOffset];
        //printf("r = %u\n", r);
        //red value for pixel
        unsigned char g = rgbImage[rgbOffset + 1];
        //green value for pixel
        unsigned char b = rgbImage[rgbOffset + 2];
        //blue value for pixel
        //perform the rescaling and store it 
        //we multiply by floating point constants
        grayImage[greyOffset] = (unsigned char)(0.21f * r + 0.71f * g + 0.07f * b);
    }
}

int main()
{
    int width = 3840;
    int height = 2160;
    int N = width * height;

    //inicialização da imagem
    unsigned char aux[N * CHANNELS];
    for (int i=0; i<N; i++)
    {
        aux[i*CHANNELS] = 255 * sin(i) * sin(i);
        aux[i*CHANNELS + 1] = 255 * sin(i) * sin(i);
        aux[i*CHANNELS + 2] = 255 * sin(i) * sin(i);
    }

    //alocação de memória para a GPU
    unsigned char *rgbImage = NULL;
    unsigned char *grayImage = NULL;

    int err1 = 0;
    int err2 = 0;
    err1 = cudaMalloc(&rgbImage, sizeof(unsigned char)*N*CHANNELS);
    err2 = cudaMalloc(&grayImage, sizeof(unsigned char)*N);
    if(err1 != cudaSuccess || err2 != cudaSuccess)
    {
        printf("Error allocating device memory.\n");
    }

    //CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

    err1 = cudaMemcpy(rgbImage,&aux,sizeof(unsigned char)*N*CHANNELS,cudaMemcpyHostToDevice);
    if(err1 != cudaSuccess)
    {
        printf("Error transfering data to device memory.\n");
    }

    // Launch device function
    dim3 threadsPerBlock(16, 16, 1);
    dim3 blocksPerGrid(width/16, height/16, 1);
    colorToGreyScaleConvertion<<<blocksPerGrid,threadsPerBlock>>>(grayImage, rgbImage, width, height);
    
    // Copy data from device memory to host memory
    unsigned char * host_buffer = (unsigned char *)malloc(sizeof(unsigned char)*N);
    err1 = cudaMemcpy(host_buffer,grayImage,sizeof(unsigned char)*N,cudaMemcpyDeviceToHost);
    if(err1 != cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }
    clock_gettime(CLOCK_MONOTONIC, &end);
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    printf("host_buffer[%i][%i]=%u\n", height/2, width/2, host_buffer[((height/2) * width) + width/2]);
    printf("host_buffer[%i][%i]=%u\n", height/4, width/4, host_buffer[((height/4) * width) + width/4]);
    printf("host_buffer[%i][%i]=%u\n", 3*height/4, 3*width/4, host_buffer[((3*height/4) * width) + 3*width/4]);
    printf("Cuda (%i*%i elemens):\t%f ms\n", width, height, (finalTime - initialTime));
    // Free device buffers
    cudaFree(rgbImage);
    cudaFree(grayImage);
    return 0;
}
