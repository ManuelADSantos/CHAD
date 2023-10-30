// nvcc -o rgbtogray_cuda rgbtogray_cuda.cu -lrt -lm

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define CHANNELS 3 // we have 3 channels corresponding to RGB

typedef struct
{
    unsigned char red, green, blue;
} PPMPixel;

typedef struct
{
    int x, y;
    int color_value;
    PPMPixel *data;
} PPMImage;

// Device code
__global__ void colorToGreyScaleConvertion( PPMPixel *grayImage, PPMPixel *rgbImage, int width, int height)
{
    int Col = threadIdx.x + (blockIdx.x * blockDim.x);
    int Row = threadIdx.y + (blockIdx.y * blockDim.y);
    if (Col < width && Row < height)
    {
        // get 1D coordinate for the grayscale image
        int greyOffset = Row * width + Col;
        // one can think of the RGB image having
        // CHANNEL times columns of the gray scale image
        // int rgbOffset = greyOffset * CHANNELS;
        int rgbOffset = greyOffset;
        unsigned char r = rgbImage[rgbOffset].red;
        // red value for pixel
        unsigned char g = rgbImage[rgbOffset].green;
        // green value for pixel
        unsigned char b = rgbImage[rgbOffset].blue;
        // blue value for pixel
        // perform the rescaling and store it
        // We multiply by floating point constants
        grayImage[greyOffset].red = grayImage[greyOffset].green = grayImage[greyOffset].blue = 0.21f * r + 0.71f * g + 0.07f * b;
        // grayImage[greyOffset].red = r;
        // grayImage[greyOffset].green = g;
        // grayImage[greyOffset].blue = b;
    }
}
// ===========================================================

static PPMImage *readPPM(const char *filename)
{
    char buff[16];
    PPMImage *img;
    FILE *fp;
    // open PPM file for reading
    fp = fopen(filename, "rb");
    if (!fp)
    {
        fprintf(stderr, "Unable to open file '%s'\n", filename);
        exit(1);
    }

    // read image format
    if (!fgets(buff, sizeof(buff), fp))
    {
        perror(filename);
        exit(1);
    }

    // check the image format
    if (buff[0] != 'P' || buff[1] != '6')
    {
        fprintf(stderr, "Invalid image format (must be 'P6')\n");
        exit(1);
    }

    // alloc memory form image
    img = (PPMImage *)malloc(sizeof(PPMImage));
    if (!img)
    {
        fprintf(stderr, "Unable to allocate memory\n");
        exit(1);
    }

    // read image size information
    if (fscanf(fp, "%d %d", &img->x, &img->y) != 2)
    {
        fprintf(stderr, "Invalid image size (error loading '%s')\n", filename);
        exit(1);
    }

    // read rgb component
    if (fscanf(fp, "%d", &img->color_value) != 1)
    {
        fprintf(stderr, "Invalid rgb component (error loading '%s')\n", filename);
        exit(1);
    }

    while (fgetc(fp) != '\n')
        ;

    // memory allocation for pixel data
    img->data = (PPMPixel *)malloc(img->x * img->y * sizeof(PPMPixel));

    if (!img)
    {
        fprintf(stderr, "Unable to allocate memory\n");
        exit(1);
    }

    // read pixel data from file
    if (fread(img->data, 3 * img->x, img->y, fp) != img->y)
    {
        fprintf(stderr, "Error loading image '%s'\n", filename);
        exit(1);
    }

    fclose(fp);
    return img;
}
void writePPM(const char *filename, PPMImage *img)
{
    FILE *fp;
    // open file for output
    fp = fopen(filename, "wb");
    if (!fp)
    {
        fprintf(stderr, "Unable to open file '%s'\n", filename);
        exit(1);
    }

    // write the header file
    // image format
    fprintf(fp, "P6\n");
    // image size
    fprintf(fp, "%d\n%d\n", img->x, img->y);

    // rgb component depth
    fprintf(fp, "%d\n", img->color_value);

    // pixel data
    fwrite(img->data, 3 * img->x, img->y, fp);

    fclose(fp);
}

int main(int argc, char *argv[])
{
    // int height = 5184, width = 3456;
    int err;

    if (argc == 2)
    {
        PPMImage *image, *gs_image;
        PPMPixel *d_image_data, *d_gs_image_data;
        image = readPPM(argv[1]);

        int height = image->x, width = image->y;

        // for (int i = 0; i < 20; i++)
        // {
        //     printf("Pixel %d: %d %d %d\n", i, image->data[i].red, image->data[i].green, image->data[i].blue);
        // }

        // ===== Initialize timer variables
        struct timespec start, end;

        gs_image = (PPMImage *)malloc(sizeof(PPMImage));
        gs_image->data = (PPMPixel *)malloc(image->x * image->y * sizeof(PPMPixel));
        
        gs_image->color_value = image->color_value;
        // printf("Color Value: %d\n", image->color_value);
        // printf("GS Color Value: %d\n", gs_image->color_value);

        gs_image->x = image->x;
        // printf("GS X: %d\n", gs_image->x);
        // printf("X: %d\n", image->x);

        gs_image->y = image->y;
        // printf("GS Y: %d\n", gs_image->y);
        // printf("Y: %d\n", image->y);
        
        // ===== Allocate memory for the device (rgb image)
        err = cudaMalloc(&d_image_data, sizeof(PPMPixel) * image->x * image->y);
        if(err != cudaSuccess)
        {
            perror("Error: cudaMalloc &d_image_data\n");
            return -1;
        }
        // ===== Copy the host (rgb image) to the device
        err = cudaMemcpy(d_image_data, image->data, sizeof(PPMPixel) * image->x * image->y, cudaMemcpyHostToDevice);
        if(err != cudaSuccess)
        {
            perror("Error: cudaMemcpy image->data to d_image_data (H2D)\n");
            return -1;
        }
        
        // ===== Allocate memory for the device (gs image)
        err = cudaMalloc(&d_gs_image_data, sizeof(PPMPixel) * image->x * image->y);
        if(err != cudaSuccess)
        {
            perror("Error: cudaMalloc &d_gs_image_data\n");
            return -1;
        }

        // ===== Get initial time
        clock_gettime(CLOCK_MONOTONIC, &start);
        colorToGreyScaleConvertion<<<ceil(width / 32.0), ceil(height / 32.0)>>>(d_gs_image_data, d_image_data, width, height);
        cudaDeviceSynchronize();
        
        // ===== Copy the result back to the host
        err = cudaMemcpy(gs_image->data, d_gs_image_data, sizeof(PPMPixel) * image->x * image->y, cudaMemcpyDeviceToHost);
        if(err != cudaSuccess)
        {
            perror("Error: cudaMemcpy d_gs_image_data to gs_image->data (D2H)\n");
            return -1;
        }

        // ===== Get final time
        clock_gettime(CLOCK_MONOTONIC, &end);
        // ===== Calculate the elapsed time
        double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
        double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
        printf("-> GPU Execution Time:\t%f ms\n", (finalTime - initialTime));
        
        for (int i = 0; i < 10; i++)
        {
            printf("Pixel %d: %d %d %d\n", i, gs_image->data[i].red, gs_image->data[i].green, gs_image->data[i].blue);
        }

        writePPM("output_GPU.ppm", gs_image);

        writePPM("output_GPU_original.ppm", image);

        free(gs_image->data);
        free(gs_image);
        free(image->data);
        free(image);
        cudaFree(d_image_data);
        cudaFree(d_gs_image_data);
    }
    else
    {
        printf("Usage: ./rgbtogray_cuda <input_image>\n");
        return -1;
    }

    return 0;
}