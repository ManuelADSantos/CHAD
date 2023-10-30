// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 17/10/2023
// ============================================================================
// -> Compile
// nvcc -o cuda_example cuda_example.cu
// -> Run
// ./cuda_example

#include <stdio.h>
// Device code
__global__ void device_func_name(int * device_buffer, int N)
{
    // Thread identifier (1 dimensional problem)
    int index= threadIdx.x + blockIdx.x * blockDim.x;
    // CODE
    if(index<N)
        device_buffer[index]=index*2;
}

int main()
{
    int N=1024;
    int err=0;
    // Allocate buffer in the device
    int *device_buffer=NULL;
    err=cudaMalloc(&device_buffer, sizeof(int)*N);
    if(err!=cudaSuccess)
    {
        printf("Error allocating device memory.\n");
    }
    // Launch device function
    int threadsPerBlock=256;
    int blocksPerGrid=N/256;
    device_func_name<<<blocksPerGrid,threadsPerBlock>>>(device_buffer,N);
    // Copy data from device memory to host memory
    int * host_buffer=(int *)malloc(sizeof(int)*N);
    err=cudaMemcpy(host_buffer,device_buffer, sizeof(int)*N,cudaMemcpyDeviceToHost);
    if(err!=cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }
    printf("host_buffer[%i]=%i\n", N/2+1, host_buffer[N/2+1]);
    // Free device buffers
    cudaFree(device_buffer);

    free(host_buffer);
    return 0;
}
