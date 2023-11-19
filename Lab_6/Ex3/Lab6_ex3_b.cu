// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 07/11/2023
// ============================================================================
// -> Compile
// nvcc -o Lab6_ex3_b Lab6_ex3_b.cu -lrt
// ============================================================================

#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "lib/stb_image.h"
#include "lib/stb_image_write.h"

#define BLUR_SIZE 16
#define R 0
#define G 1
#define B 2
#define TILE_DIM 16
#define BLOCK_SIZE 16

__global__ void blurKernel_shared(unsigned char* in, unsigned char* out, int width, int height, int num_channel, int channel)
{
    __shared__ unsigned char tile[BLOCK_SIZE*BLOCK_SIZE];
    int col = blockIdx.x * TILE_DIM + threadIdx.x;
    int row = blockIdx.y * TILE_DIM + threadIdx.y;
    int pixVal;
    int pixels;

    if(col > -1 && col < width && row > -1 && row < height )
    {
        pixVal = 0;
        pixels = 0;
        tile[row*width*num_channel + col*num_channel] = in[row*width*num_channel + col*num_channel];
        __syncthreads();
        for(int blurRow = -BLUR_SIZE; blurRow < BLUR_SIZE + 1; ++blurRow)
        {
            for(int blurCol = -BLUR_SIZE; blurCol < BLUR_SIZE + 1; ++blurCol)
            {
                int curRow = row + blurRow;
                int curCol = col + blurCol;
                if(curRow > -1 && curRow < height && curCol > -1 && curCol < width)
                {
                    pixVal += tile[curRow * width * num_channel + curCol * num_channel + channel];
                    pixels++;
                    __syncthreads();
                }
            }
        }
        out[row * width * num_channel + col * num_channel + channel] = (unsigned char)(pixVal/pixels);
    }
}

// ==================== MAIN ==================== 
int main(int argc, char *argv[])
{
    // ===== Get correct image
    int img_id = atoi(argv[1]);
    char img_name[50];
    sprintf(img_name, "images/in/image%d.jpg", img_id);

    int width, height, n;
    unsigned char *image = stbi_load(img_name,&width,&height,&n,0);

    // printf("Image width: %dpx, height: %dpx, channels: %d\n", width, height, n);
    // return 0;

    unsigned char *output = (unsigned char*)malloc(width * height * n *sizeof(unsigned char));
    unsigned char* Dev_Input_Image = NULL;
    unsigned char* Dev_Output_Image = NULL;
    
    cudaMalloc((void**)&Dev_Input_Image, sizeof(unsigned char)* height * width * n);
    cudaMalloc((void**)&Dev_Output_Image, sizeof(unsigned char)* height * width * n);
    //kernel call
    dim3 blockSize(BLOCK_SIZE, BLOCK_SIZE);
    dim3 gridSize(width/blockSize.x+1, height/blockSize.y+1);
    
    struct timespec start, end;
    
    //b)
    cudaMalloc((void**)&Dev_Input_Image, sizeof(unsigned char)* height * width * n);
    cudaMalloc((void**)&Dev_Output_Image, sizeof(unsigned char)* height * width * n);
    clock_gettime(CLOCK_MONOTONIC, &start);
    cudaMemcpy(Dev_Input_Image, image, sizeof(unsigned char) * height * width * n, cudaMemcpyHostToDevice);

    blurKernel_shared <<<gridSize, blockSize>>>(Dev_Input_Image, Dev_Output_Image, width, height, n, 0);
    blurKernel_shared <<<gridSize, blockSize>>>(Dev_Input_Image, Dev_Output_Image, width, height,n,1);
    blurKernel_shared <<<gridSize, blockSize>>>(Dev_Input_Image, Dev_Output_Image, width, height,n,2);
    cudaDeviceSynchronize(); // we need this so the kernel is guaranteed to finish (and the output from the kernel will find a waiting standard output queue), before the application is allowed to exit
    cudaMemcpy(image, Dev_Output_Image, sizeof(unsigned char) * height * width * n, cudaMemcpyDeviceToHost);
    clock_gettime(CLOCK_MONOTONIC, &end);
    cudaFree(Dev_Input_Image);
    cudaFree(Dev_Output_Image);

    sprintf(img_name, "images/out/image%d_shared.jpg", img_id);
    stbi_write_jpg(img_name, width, height, n, image, width * n);

    double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
    double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
    printf("Time of execution: %f ms\n", (finalTime - initialTime));
    return 0;
}