// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 03/11/2023
// ============================================================================
// -> Compile
// nvcc -o ex4_1_GPU ex4_1_GPU.cu
// -> Run
// ./ex4_1_GPU
// ============================================================================

#include <stdio.h>
#define bin 16

// ===================== Kernel =====================
__global__ void histogram(unsigned char * image, int * hist, int size)
{
    // ===== Calculate row and column index
    int Col = threadIdx.x + (blockIdx.x * blockDim.x);
    int Row = threadIdx.y + (blockIdx.y * blockDim.y);

    // ===== Calculate index
    int i = Row * size + Col;
    unsigned char pixel = image[i];
    int index = (int)(pixel/bin);

    // ===== Update histogram
    atomicAdd(&hist[index],1);
}

// ===================== Main =====================
int main()
{   
    // ===== Image properties
    int size = 256;
    int N = size * size;

    // ===== Initialize image
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

    // ===== Allocate host memory
    int * host_histogram = (int *)malloc(sizeof(int)*bin);
    
    // ===== Allocate device memory
    unsigned char *image = NULL;
    int *hist = NULL;
    int err = 0;
    err = cudaMalloc(&image, sizeof(unsigned char)*N);
    err = cudaMalloc(&hist, sizeof(int)*bin);
    if(err != cudaSuccess)
    {
        printf("Error allocating device memory.\n");
    }

    // ===== Declare timer variables
	struct timespec start, end;

    // ===== Get initial time
	clock_gettime(CLOCK_MONOTONIC, &start);

    // ===== Copy data from host memory to device memory
    err = cudaMemcpy(image,&aux,sizeof(unsigned char)*N,cudaMemcpyHostToDevice);
    err = cudaMemcpy(hist,&aux2,sizeof(int)*bin,cudaMemcpyHostToDevice);
    if(err != cudaSuccess || err != cudaSuccess)
    {
        printf("Error transfering data to device memory.\n");
    }

    // ===== Define block and grid dimensions
    dim3 threadsPerBlock(16, 16, 1);
    dim3 blocksPerGrid(size/16, size/16, 1);
    
    // ===== Launch kernel
    histogram<<<blocksPerGrid,threadsPerBlock>>>(image, hist, size);

    // ===== Copy data from device memory to host memory
    err = cudaMemcpy(host_histogram,hist,sizeof(int)*bin,cudaMemcpyDeviceToHost);
    if(err != cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }

    // ===== Get final time
    clock_gettime(CLOCK_MONOTONIC, &end);
	
    // ===== Calculate the elapsed time
    double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    
    // ===== Validation
    int counter = 0;
	for(int i=0; i<bin; i++)
	{
		printf("hist[%i]=%u\n", i, host_histogram[i]);
		counter += host_histogram[i];
	} 
	
    // ===== Show results
    printf("--> Total pixels = %i\n", counter);
	printf("--> Time (%ix%i elemens):\t%f ms\n", size, size, (finalTime - initialTime));
 
    // ===== Free device memory
    cudaFree(image);
    cudaFree(hist);

    // ===== Free host memory
    free(host_histogram);

    return 0;
}
