// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 07/11/2023
// ============================================================================
// -> Compile
// nvcc -o Lab6_ex3_b Lab6_ex3_b.cu -lrt
// ============================================================================

// ===== Images Library
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "lib/stb_image.h"
#include "lib/stb_image_write.h"
#include <stdio.h>
#include <stdlib.h>

// ===== Kernel Properties
#define BLUR_SIZE 3

// ======================================== KERNEL ========================================
// ======================================== KERNEL ========================================
__global__ void blurKernel(unsigned char* in, unsigned char* out, int width, int height, int num_channel) 
{   
    // ===== Pixel Variables
    int pixSum, numPixels;

    // ===== Global Pixel Position
    int col_global = blockIdx.x * blockDim.x + threadIdx.x;
    int row_global = blockIdx.y * blockDim.y + threadIdx.y;

    // ===== Check if pixel is inside image
    if(col_global > -1 && col_global < width && row_global > -1 && row_global < height ) 
    {
        // ===== Iterate over all color channels
        for(int channel = 0; channel < num_channel; channel++)
        {
            // ===== Shared Memory
            __shared__ unsigned char tile[BLUR_SIZE*BLUR_SIZE];

            // ===== Local Pixel Position
            int col_local = 0, row_local = 0;

            for(int i = -BLUR_SIZE/2; i <= BLUR_SIZE/2; i++)
            {
                for(int j = -BLUR_SIZE/2; j <= BLUR_SIZE/2; j++)
                {
                    // ===== Check if pixel is inside image
                    if((row_global + i) < 0 || (row_global + i) >= height || (col_global + j) < 0 || (col_global + j) >= width)
                        tile[row_local * BLUR_SIZE + col_local] = 0;
                    else
                        tile[row_local * BLUR_SIZE + col_local] = in[((row_global + i) * width  + (col_global + j)) * num_channel + channel];
                    
                    __syncthreads();
                    col_local++;
                }
                row_local++;
            }

            // ===== Calculate Pixel Sum
            pixSum = 0;
            numPixels = 0;
            for(int i = 0; i < BLUR_SIZE; i++)
            {
                for(int j = 0; j < BLUR_SIZE; j++)
                {
                    pixSum += tile[i * BLUR_SIZE + j];
                    __syncthreads();
                    numPixels++;
                }
            }

            // ===== Calculate Pixel Average
            out[row_global * width * num_channel + col_global * num_channel + channel] = (unsigned char)(pixSum / numPixels);
        }
    }
}


// ======================================== MAIN ========================================
int main(int argc, char *argv[])
{
    // ===== Get correct image
    int img_id = atoi(argv[1]);
    char img_name[50];
    sprintf(img_name, "images/in/image%d.jpg", img_id);

    // ===== Image Properties
    int width, height, n;

    // ===== Load Original Image
    unsigned char *image = stbi_load(img_name,&width,&height,&n,0);
    
    // ===== Allocate Memory for Blurred Image
    unsigned char *output = (unsigned char*)malloc(width * height * n *sizeof(unsigned char));
    
    // ===== Allocate Device Memory
    unsigned char* Dev_Input_Image = NULL;
    unsigned char* Dev_Output_Image = NULL;
    cudaMalloc((void**)&Dev_Input_Image, sizeof(unsigned char)* height * width * n);
    cudaMalloc((void**)&Dev_Output_Image, sizeof(unsigned char)* height * width * n);
    
    // ===== Copy Host Image to Device Image
    cudaMemcpy(Dev_Input_Image, image, sizeof(unsigned char) * height * width * n, cudaMemcpyHostToDevice);
    
    // ===== Kernel Dimensions
    dim3 blockSize(16, 16);
    dim3 gridSize((width + blockSize.x - 1) / blockSize.x, (height + blockSize.y - 1) / blockSize.y);

    // ===== Start Time
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    
    // ===== Kernel Call
    blurKernel <<<gridSize, blockSize>>>(Dev_Input_Image, Dev_Output_Image, width, height, n);
    
    // ===== End Time
    clock_gettime(CLOCK_MONOTONIC, &end);

    // ===== Copy Device Image to Host Image
    cudaMemcpy(image, Dev_Output_Image, sizeof(unsigned char) * height * width * n, cudaMemcpyDeviceToHost);
    
    // ===== Save Blurred Image
    sprintf(img_name, "images/out/image%d_shared.jpg", img_id);
    stbi_write_jpg(img_name, width, height, n, image, width * n);
    
    // ===== Print Time Results
    double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
    double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    printf("Time of execution: %f ms\n", (finalTime - initialTime));
    
    // ===== Free Device Memory
    cudaFree(Dev_Input_Image);
    cudaFree(Dev_Output_Image);
    
    return 0;
}