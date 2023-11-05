// nvcc -o lab5_ex2_2 lab5_ex2_2.cu
#include <stdio.h>
#define N 9984

// Device code
__global__ void reduce(int *g_idata, int *g_odata)
{
    __shared__ int s_data[N];
    unsigned int tid = threadIdx.x;
    unsigned int gid = threadIdx.x + (blockIdx.x * blockDim.x); 

    s_data[tid] = g_idata[gid];
    __syncthreads();

    //reduction in shared memory
    for(unsigned int s=1; s<blockDim.x; s*=2)
    {
        if (tid % (2*s) == 0)
        {
            
            s_data[tid] += s_data[tid+s];
        }
        __syncthreads();
    }

    //write result to global memory
    if (tid == 0)
        g_odata[blockIdx.x] = s_data[tid];
}

int main()
{
    //inicialização do vetor
    int aux[N];
    int final = 0;
    for (int i=0; i<N; i++)
    {
        aux[i] = 1;
    }
    int *v1 = NULL;
    int *v2 = NULL;
    int err1 = 0;
    int err2 = 0;
    err1 = cudaMalloc(&v1, sizeof(int)*N);
    err2 = cudaMalloc(&v2, sizeof(int)*(N/256));
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
    int threadsPerBlock = 256;
    int blocksPerGrid = N/256;
    reduce<<<blocksPerGrid,threadsPerBlock>>>(v1, v2);
    
    // Copy data from device memory to host memory
    int * host_buffer = (int *)malloc(sizeof(int)*(N/256));
    err1 = cudaMemcpy(host_buffer,v2,sizeof(int)*(N/256),cudaMemcpyDeviceToHost);
    if(err1 != cudaSuccess)
    {
        printf("Error transfering data from device memory.\n");
    }
    for (int i=0; i<N/256; i++)
    {
        final += host_buffer[i];
    }
    clock_gettime(CLOCK_MONOTONIC, &end);
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    printf("final = %i\n", final);
    printf("Cuda (%i elemens):\t%f ms\n", N, (finalTime - initialTime));
    // Free device buffers
    cudaFree(v1);
    cudaFree(v2);
    return 0;
}
