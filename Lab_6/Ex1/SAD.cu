/*===================================================================================
	SAD.C
=====================================================================================

Contains:

Written by: Oscar Ferraz
			University of Coimbra - Electrical Computer end Engineering Department
			Instituto de Telecomunicações
			email: <oscar.ferraz@co.it.pt>
			
Date: October 2023
=====================================================================================*/



//==============================================//
// I N C L U D E S								//
//==============================================//
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <float.h>
#include <string.h>
#include <time.h>
#include <assert.h>
#include <errno.h>
//#include <helper_cuda.h>
#include <cuda_runtime.h>  

// Defines
#define W 1920
#define H 1080
#define NUM_FRAMES 500
#define WINDOW_SIZE 21



unsigned char frame[H][W] = {0};


__global__ void GPU_AD(unsigned char * d_v_left, unsigned char * d_v_right, signed char * d_differences);

__global__ void GPU_S(unsigned int * d_result, signed char * d_differences, unsigned short d_index);


//**************************************************************************************************
//Absolute differences
__global__ void GPU_AD(unsigned char * d_v_left, unsigned char * d_v_right, signed char * d_differences){

    unsigned short x=threadIdx.x+blockIdx.x*blockDim.x;
    unsigned short y=threadIdx.y+blockIdx.y*blockDim.y;
    unsigned short z=threadIdx.z+blockIdx.z*blockDim.z;


    d_differences[(z*H*W)+(y*W)+x]=d_v_left[(y*W)+x]-d_v_right[(z*H*W)+(y*W)+x];


    if(d_differences[(z*H*W)+(y*W)+x]<0)
        d_differences[(z*H*W)+(y*W)+x]=-d_differences[(z*H*W)+(y*W)+x]; 
} 


//**************************************************************************************************
//Sum
__global__ void GPU_S(unsigned int * d_result, signed char * d_differences, unsigned short d_index){

    register unsigned int sum=0;

    for(int y=0; y<H; y++){
        for(int x=0; x<W; x++){
            sum=sum+d_differences[(threadIdx.x*H*W)+(y*W)+x];
        }
    }
    __syncthreads();
    d_result[(d_index*WINDOW_SIZE)+threadIdx.x]=sum;
    
} 



/*************************************************************************************************************/
/*																											 */
/*  M A I N   P R O G R A M																					 */		
/*																											 */
/*************************************************************************************************************/
int main(){

    cudaError_t err=cudaSuccess; 

    //======================================================================================================================================================================
    //kernel dimensions

    dim3 threadsPerBlock_AD(W/2,1,1);
    dim3 numBlocks_AD(2,H,WINDOW_SIZE);

    dim3 threadsPerBlock_S(WINDOW_SIZE,1,1);
    dim3 numBlocks_S(1,1,1);

    //======================================================================================================================================================================
    //size of variables


    size_t size_video=(sizeof(unsigned char)*W*H*NUM_FRAMES);
    size_t size_differences=(sizeof(signed char)*W*H*NUM_FRAMES);  
    size_t size_left=(sizeof(unsigned char)*W*H); 
    size_t size_right=(sizeof(unsigned char)*W*H*WINDOW_SIZE); 
    size_t size_result=(sizeof(unsigned int)*NUM_FRAMES*WINDOW_SIZE); 

    //==================================================================================================================LPi====================================================
    //variables declaration

    unsigned char *h_v_left=NULL;
    unsigned char *h_v_right=NULL;
    unsigned int *h_result=NULL;
    unsigned char *d_v_left=NULL;
    unsigned char *d_v_right=NULL;
    unsigned int *d_result=NULL;
    signed char *d_differences=NULL;
    unsigned int *d_index=NULL;

    //======================================================================================================================================================================
    //allocate host memory

    err=cudaHostAlloc((void **)&h_v_left, size_video, cudaHostAllocDefault );
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to allocate host h_v_left(error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaHostAlloc((void **)&h_v_right, size_video, cudaHostAllocDefault );
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to allocate host h_v_right(error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaHostAlloc((void **)&h_result, size_result, cudaHostAllocDefault );
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to allocate host h_result(error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    //======================================================================================================================================================================
    //allocate device memory

    err=cudaMalloc((void **)&d_v_left, size_left);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to allocate device d_v_left (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaMalloc((void **)&d_v_right, size_right);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to allocate device d_v_right (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaMalloc((void **)&d_result, size_result);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to allocate device d_result (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaMalloc((void **)&d_differences, size_differences);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to allocate device d_differences (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaMalloc((void **)&d_index, sizeof(unsigned short));
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to allocate device d_differences (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    //======================================================================================================================================================================
    //Load Left video
    int x, y, count, index=0;
     
    FILE *pipein = popen("ffmpeg -i Left_gray.mp4 -f image2pipe -vcodec rawvideo -vframes 500 -pix_fmt gray -", "r");
     
    // Process video frames
    while(1)
    {
        // Read a frame from the input pipe into the buffer
        count = fread(frame, 1, H*W, pipein);
         
        // If we didn't get a frame of video, we're probably at the end
        if (count != H*W)break;
         
        // Process this frame
        for (y=0 ; y<H ; ++y){
            for (x=0 ; x<W ; ++x){
                h_v_left[(index*H*W)+(y*W)+x]=frame[y][x];
                
            }
        }
        index++;
    }
     
    // Flush and close input and output pipes
    fflush(pipein);
    pclose(pipein);


    //======================================================================================================================================================================
    //Load Right video
    index=0;
     
    // Open an input pipe from ffmpeg 
    FILE *pipein2 = popen("ffmpeg -i Right_gray.mp4 -f image2pipe -vcodec rawvideo -vframes 500 -pix_fmt gray -", "r");
     
    // Process video frames
    while(1)
    {
        // Read a frame from the input pipe into the buffer
        count = fread(frame, 1, H*W, pipein2);
         
        // If we didn't get a frame of video, we're probably at the end
        if (count != H*W)break;
         
        // Process this frame
        for (y=0 ; y<H ; ++y){
            for (x=0 ; x<W ; ++x){
                h_v_right[(index*H*W)+(y*W)+x]=frame[y][x];
                
            }
        }
        index++;
    }
     
    // Flush and close input and output pipes
    fflush(pipein2);
    pclose(pipein2);



    //======================================================================================================================================================================
    //Main loop
    for (int j=((WINDOW_SIZE-1)/2); j< NUM_FRAMES-((WINDOW_SIZE-1)/2); j++){

        //======================================================================================================================================================================
        //copy data to device
        err=cudaMemcpy(d_v_left, h_v_left + (W*H*j), size_left, cudaMemcpyHostToDevice);
        if(err!=cudaSuccess){
            fprintf(stderr, "Failed to copy the d_v_left from host to device (error code %d)!\n", cudaGetLastError());
            exit(EXIT_FAILURE);
        }

        
        printf("frames=%d\n", (j - ((WINDOW_SIZE-1)/2)));
        err=cudaMemcpy(d_v_right, h_v_right + (W*H*(j - ((WINDOW_SIZE-1)/2))) , size_right, cudaMemcpyHostToDevice);
        if(err!=cudaSuccess){
            fprintf(stderr, "Failed to copy the d_v_right from host to device (error code %d)!\n", cudaGetLastError());
            exit(EXIT_FAILURE);
        }

        //======================================================================================================================================================================
        //execute the kernel
        GPU_AD<<<numBlocks_AD, threadsPerBlock_AD>>>(d_v_left, d_v_right, d_differences);
        if(err!=cudaSuccess){
            fprintf(stderr, "Failed to launch the kernel (error code %d)!\n", cudaGetLastError());
            exit(EXIT_FAILURE);
        }

        cudaDeviceSynchronize();

        GPU_S<<<numBlocks_S, threadsPerBlock_S>>>( d_result, d_differences, j - ((WINDOW_SIZE/2)-1));
        if(err!=cudaSuccess){
            fprintf(stderr, "Failed to launch the kernel (error code %d)!\n", cudaGetLastError());
            exit(EXIT_FAILURE);
        }

        cudaDeviceSynchronize();
        printf("frame=%d\n", j);
    }

    //======================================================================================================================================================================
    //copy the data from device to host
    err=cudaMemcpy(h_result , d_result, size_result, cudaMemcpyDeviceToHost);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to copy the result from device to host (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    } 

    //======================================================================================================================================================================
    //Write histogram to file
    FILE *fptr;

    fptr = fopen("file.txt","w");

    if(fptr == NULL)
    {
        printf("Error!");   
        exit(1);             
    }

    for(int y=0; y<NUM_FRAMES; y++){
        for(int x=0; x<WINDOW_SIZE; x++){
            fprintf(fptr,"%d\t",h_result[(y*WINDOW_SIZE)+x]);
        }
        fprintf(fptr,"\n");
    }

    fclose(fptr); 


    //======================================================================================================================================================================
    //free the device memory

    err=cudaFree(d_v_left);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to free the d_v_left from the device (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaFree(d_v_right);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to free the d_v_right from the device (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaFree(d_result);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to free the d_result from the device (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaFree(d_differences);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to free the d_differences from the device (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaFree(d_index);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to free the d_differences from the device (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }


    //======================================================================================================================================================================
    //free the host memory

    err=cudaFreeHost(h_v_left);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to free the h_v_left from the host (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaFreeHost(h_v_right);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to free the h_v_right from the host (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }

    err=cudaFreeHost(h_result);
    if(err!=cudaSuccess){
        fprintf(stderr, "Failed to free the h_result from the host (error code %d)!\n", cudaGetLastError());
        exit(EXIT_FAILURE);
    }


    return(0);
}


