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
#define BLUR_SIZE 5
#define TILE_SIZE 16

// ======================================== KERNEL ========================================
__global__ void blurKernel(unsigned char* in, unsigned char* out, int width, int height, int num_channel) 
{   
    // ===== Global Pixel Position
    int idx_Global = blockIdx.x * blockDim.x + threadIdx.x;

    // ===== Shared Memory
    __shared__ unsigned char shared_Image[TILE_SIZE*TILE_SIZE][BLUR_SIZE][BLUR_SIZE][3];

    // ===== Work on each color channel
    for (int channel = 0; channel < num_channel; channel++)
    {   
        // ===== Shared Memory Position
        int local_row = 0, local_col = 0, count = 0;

        // ===== Horizontal offset from Global Pixel
        for (int i = -BLUR_SIZE / 2; i <= BLUR_SIZE / 2; i++)
        {
            // ===== Vertical offset from Global Pixel
            for (int j = -BLUR_SIZE / 2; j <= BLUR_SIZE / 2; j++)
            {
                // ===== Out of Bounds of Image
                if (idx_Global + i*width + j < 0 || idx_Global + i*width + j >= width*height)
                {
                    shared_Image[threadIdx.x][local_row][local_col][channel] = 0;  
                    if (idx_Global == 0)
                }
                // ===== In Bounds of Image
                else
                    shared_Image[threadIdx.x][local_row][local_col][channel] = (unsigned char)in[(idx_Global + i*width + j) * num_channel + channel];
                    count++;
                
                // ===== Update Local Position (in kernel)
                local_col++;
            }
            // ===== Update Local Position (in kernel)
            local_row++;
            local_col = 0;
        }
        __syncthreads();
            
        // ===== Blur Pixel
        int sum = 0;
        for (int i = 0; i < BLUR_SIZE; i++)
        {
            for (int j = 0; j < BLUR_SIZE; j++)
            {
                sum += shared_Image[threadIdx.x][i][j][channel];
            }
        }
        __syncthreads();

        // ===== Save Blurred Pixel
        out[idx_Global * num_channel + channel] = (unsigned char)(sum / count);
        __syncthreads();
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
    int threadsPerBlock = TILE_SIZE * TILE_SIZE;
    int BlocksPerGrid = (width * height + threadsPerBlock - 1) / threadsPerBlock;

    // ===== Start Time
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    
    // ===== Kernel Call
    blurKernel <<<BlocksPerGrid, threadsPerBlock>>>(Dev_Input_Image, Dev_Output_Image, width, height, n);
    
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