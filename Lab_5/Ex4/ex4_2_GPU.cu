// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 03/11/2023
// ============================================================================
// -> Compile
// nvcc -o ex4_2_GPU ex4_2_GPU.cu
// -> Run
// ./ex4_2_GPU
// ============================================================================

#include <stdio.h>
#define bin 16
#define N 65536

// ===================== Kernel =====================
__global__ void histogram(unsigned char * image, int * hist, int size)
{   
    // ===== Shared memory for image
    __shared__ unsigned char s_data[256];

    // ===== Shared memory for histogram
    __shared__ int s_hist[bin];


    // ===== Calculate row and column index
    int Col = threadIdx.x + (blockIdx.x * blockDim.x);
    int Row = threadIdx.y + (blockIdx.y * blockDim.y);

    // ===== Calculate index
    int i = Row * size + Col;
    int i_thread = threadIdx.y * blockDim.x + threadIdx.x;

    // ===== Load image to shared memory
    s_data[i_thread] = image[i];
    if (i_thread < bin)
    {
        s_hist[i_thread] = 0;
    }
    __syncthreads();

    // ===== Update Histogram
    atomicAdd(&s_hist[(int)(s_data[i_thread]/bin)],1);

    __syncthreads();

    if (i_thread < bin)
    {
        atomicAdd(&hist[i_thread + blockIdx.x * bin], s_hist[i_thread]);
    }
}

// ===================== Main =====================

int main()
{
    // ===== Image properties
    int size = 256;

    // ===== Initialize image
    unsigned char aux[N];
    for (int i=0; i<N; i++)
    {
        aux[i] = 255 * sin(i) * sin(i);
    }

    // ===== Allocate device memory
    unsigned char *image = NULL;
    int *hist = NULL;

    int err = 0;
    err = cudaMalloc(&image, sizeof(unsigned char)*N);
    err = cudaMalloc(&hist, sizeof(int)*bin*bin);
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
    if(err != cudaSuccess)
    {
        printf("Error transfering data to device memory.\n");
    }

    // ===== Define block and grid dimensions
    dim3 threadsPerBlock(16, 16, 1);
    dim3 blocksPerGrid(size/16, size/16, 1);

    // ===== Launch kernel
    histogram<<<blocksPerGrid,threadsPerBlock>>>(image, hist, size);

    // ===== Copy data from device memory to host memory
    int * host_image_final = (int *)malloc(sizeof(int)*bin*bin);
    err = cudaMemcpy(host_image_final,hist,sizeof(int)*bin*bin,cudaMemcpyDeviceToHost);
    if(err != cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }
    
    // ===== Get histogram
    int histogram[bin];
    for (int i=0; i<bin; i++)
    {
        histogram[i] = 0;
        for (int j=0; j<bin; j++)
        {
            histogram[i] += host_image_final[j*bin + i];
        }
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
		printf("hist[%i]=%u\n", i, histogram[i]);
		counter += histogram[i];
	} 

    // ===== Show results
	printf("--> Total pixels = %i\n", counter);
	printf("--> Time (%ix%i elemens):\t%f ms\n", size, size, (finalTime - initialTime));
    
    // ===== Free device memory
    cudaFree(image);
    cudaFree(hist);

    // ===== Free host memory
    free(host_image_final);

    return 0;
}
