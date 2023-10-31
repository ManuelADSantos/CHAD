// gcc -o rgbtogray rgbtogray.c -lm -lrt
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

// something remains in the memory (not unalocated) 13 times allocated 10 times

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

PPMImage *changeToGrayscalePPM(PPMImage *img)
{
    PPMImage *gs_img;
    gs_img = (PPMImage *)malloc(sizeof(PPMImage));
    gs_img->data = (PPMPixel *)malloc(img->x * img->y * sizeof(PPMPixel));
    gs_img->color_value = img->color_value;
    gs_img->x = img->x;
    gs_img->y = img->y;
    if (gs_img)
    {
        for (int i = 0; i < gs_img->x * gs_img->y; i++)
        {
            gs_img->data[i].red = gs_img->data[i].green = gs_img->data[i].blue = 0.21f * img->data[i].red + 0.71f * img->data[i].green + 0.07f * img->data[i].blue;
        }
    }
    return (gs_img);
}

int main(int argc, char *argv[])
{

    if (argc == 2)
    {
        PPMImage *image, *gs_image;
        image = readPPM(argv[1]);

        // ===== Initialize timer variables
        struct timespec start, end;
        // ===== Get initial time
        clock_gettime(CLOCK_MONOTONIC, &start);

        gs_image = changeToGrayscalePPM(image);

        // ===== Get final time
        clock_gettime(CLOCK_MONOTONIC, &end);
        // ===== Calculate the elapsed time
        double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
        double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
        printf("-> CPU Execution Time:\t%f ms\n", (finalTime - initialTime));

        for (int i = 0; i < 20; i++)
        {
            printf("Pixel %d: %d %d %d\n", i, gs_image->data[i].red, gs_image->data[i].green, gs_image->data[i].blue);
        }

        writePPM("output_CPU.ppm", gs_image);

        free(gs_image->data);
        free(gs_image);
        free(image->data);
        free(image);
    }
    else
    {
        printf("Usage: ./rgbtogray <input_file>\n");
    }

    return 0;
}
