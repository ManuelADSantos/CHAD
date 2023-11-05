// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 03/11/2023
// ============================================================================
// -> Compile
// nvcc -o ex3_1_GPU ex3_1_GPU.cu
// -> Run
// ./ex3_1_GPU width height
// ============================================================================

#include <stdio.h>

// ===================== Kernel =====================
__global__ void reduce(int *inData, int *outData, int width, int height)
{   
    // ===== Calculate index 
    int col = threadIdx.x + blockIdx.x * blockDim.x;
    int row = threadIdx.y + blockIdx.y * blockDim.y;
    
    // ===== Transpose
    outData[col * height + row] = inData[row * width + col];
}


// ===================== Main =====================
int main(int argc, char *argv[])
{   
    // ===== Check arguments
    if (argc != 3)
	{
		printf("./ex3_1_GPU width height \n");
		return -1;
	}

	// ===== Get width and height
	int width, height;
	width = atoi(argv[1]);
	height = atoi(argv[2]);

    // ===== Declare timer variables
	struct timespec start, end;

	// ===== Get total number of elements
	int N = width * height;

    // ===== Show number of elements
	printf("\n-> Dimensions: 		%d x %d\n", width, height);
	printf("-> Number of elements:  %d\n\n", N);

    // ===== Initialize host matrix
    int host_original[N];
    for(int i=0; i<height; i++)
	{
		for (int j=0; j<width; j++)
		{
			host_original[i*width + j] = i;
		}
	} 
    
    // ===== Allocate device memory
    int *device_original = NULL, *device_transposed = NULL, err = 0;

    err = cudaMalloc(&device_original, sizeof(int)*N);
    err = cudaMalloc(&device_transposed, sizeof(int)*N);
    if(err != cudaSuccess)
    {
        printf("Error allocating device memory.\n");
    }
    
	// ===== Get initial time
	clock_gettime(CLOCK_MONOTONIC, &start);

    // ===== Copy data from host memory to device memory
    err = cudaMemcpy(device_original,&host_original,sizeof(int)*N,cudaMemcpyHostToDevice);
    if(err != cudaSuccess)
    {
        printf("Error transfering data to device memory.\n");
    }

    // ===== Define block and grid dimensions
    dim3 threadsPerBlock(16, 16, 1);
    dim3 blocksPerGrid(width/16, height/16, 1);
    
    // ===== Launch kernel
    reduce<<<blocksPerGrid,threadsPerBlock>>>(device_original, device_transposed, width, height);
    
    // ===== Copy data from device memory to host memory
    int * host_transposed = (int *)malloc(sizeof(int)*N);
    err = cudaMemcpy(host_transposed,device_transposed,sizeof(int)*N,cudaMemcpyDeviceToHost);
    if(err != cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }

    // ===== Get final time
    clock_gettime(CLOCK_MONOTONIC, &end);
	
    // ===== Calculate the elapsed time
    double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);~

    // ===== Validate results
    printf("host_transposed[%i][%i]=%u\n", width/2, height/4, host_transposed[((width/2) * height) + height/4]);
    printf("host_transposed[%i][%i]=%u\n", width/4, 3*height/4, host_transposed[((width/4) * height) + 3*height/4]);
    printf("host_transposed[%i][%i]=%u\n", 3*width/4, height/2, host_transposed[((3*width/4) * height) + height/2]);
    
    // ===== Print time
	printf("\n--> Execution Time:\t%f ms\n\n", (finalTime - initialTime));

    // ===== Free device buffers
    cudaFree(device_original);
    cudaFree(device_transposed);

    // ===== Free host buffers
    free(host_transposed);

    return 0;
}
