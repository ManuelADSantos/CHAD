// nvcc -o cuda_ex2_1 cuda_ex2_1.cu
//
#include <stdio.h>  
#include <stdlib.h> 
#include <math.h> 
#include <time.h> 

#define N 1234

__global__ void somaCuda(int* v1, int *result)
{
    int tid = threadIdx.x;
    int index = threadIdx.x + (blockIdx.x * blockDim.x);

    result[tid] = v1[index];
        
    for (int s = 1; s < blockDim.x; s *= 2) {
	if (tid % (2*s) == 0) {
	    result[tid] += result[tid + s];
	}
	__syncthreads();
    }
}

int main( int argc, char** argv){

    //Criar Imagem com valores random
    //int N = 2048;
    int result = 0;
    int result2 = 0;
    int *v1 = (int*)malloc(N * sizeof(int));
    int *vOut = (int*)malloc(N * sizeof(int));

    for (int i = 0; i < N; i++){
	v1[i] = i;
	vOut[i] = 0;
    }


    // Versão sequencial
    for (int i = 0; i < N; i++){
	result += v1[i];
    }
	
    printf("Resultado da Soma - Sequencial: %d \n", result);
    
    
    // Versão paralela
    
    int threadsPerBlock = 256; 
    int blocksPerGrid = N/256;

    int *v1Cuda = NULL;
    int *vOutCuda = NULL;

    cudaMalloc(&v1Cuda, N * sizeof(int));
    cudaMalloc(&vOutCuda, N * sizeof(int));

    cudaMemcpy(v1Cuda, v1, N * sizeof(int), cudaMemcpyHostToDevice);
    
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    somaCuda<<<blocksPerGrid, threadsPerBlock>>>(v1Cuda, vOutCuda);
    
    clock_gettime(CLOCK_MONOTONIC, &end);
    
    cudaMemcpy(vOut, vOutCuda, N * sizeof(int), cudaMemcpyDeviceToHost);
    
    for(int i = 0; i < blocksPerGrid; i++){
    	result2 += vOut[i];
    }

    double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
    double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    
    
    printf("Exercício 2.1 - CUDA sem otimizações: %f ms\n", (finalTime - initialTime));
    printf("Resultado da Soma - CUDA sem otimizações: %d \n", result);

    cudaFree(v1Cuda);
    cudaFree(vOutCuda);
    
    free(v1);
    free(vOut);

    return 0;
}

