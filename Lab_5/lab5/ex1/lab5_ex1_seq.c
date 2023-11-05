// gcc -o lab5_ex1_seq.out lab5_ex1_seq.c -lrt -lm
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#define CHANNELS 3

int main( int argc, char* argv[])
{
	if(argc!=3)
	{
		printf("./lab5_ex1_seq width height \n");
		return 0;
	}
	int width, height;
	width = atoi(argv[1]);
	height = atoi(argv[2]);

	int n = width * height;

	// vector declaration
	unsigned char *img_rgb;
	unsigned char *img_grey;
	
	// Size, in bytes, of each vector
	size_t bytes = n * sizeof(unsigned char);

	// Allocate memory for each vector
	img_rgb=(unsigned char*)malloc(bytes*CHANNELS);
	img_grey=(unsigned char*)malloc(bytes);

	// Initialize content of input vector a, b and c
	int i;
	for(i=0; i<n; i++)
	{
		img_rgb[i*CHANNELS] = 255 * sin(i) * sin(i);
        img_rgb[i*CHANNELS + 1] = 255 * sin(i) * sin(i);
        img_rgb[i*CHANNELS + 2] = 255 * sin(i) * sin(i);
	} 

	//CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

	// y=a.x+y com a = 5
	for(i=0; i<n; i++)
	{
		img_grey[i] = (unsigned char)(0.21f * img_rgb[i*CHANNELS] + 0.71f * img_rgb[i*CHANNELS + 1] + 0.07f * img_rgb[i*CHANNELS + 2]);
	}

	clock_gettime(CLOCK_MONOTONIC, &end);
	//
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
	// DEBUG
	printf("img_grey[%i][%i]=%u\n", height/2, width/2, img_grey[((height/2) * width) + width/2]);
    printf("img_grey[%i][%i]=%u\n", height/4, width/4, img_grey[((height/4) * width) + width/4]);
    printf("img_grey[%i][%i]=%u\n", 3*height/4, 3*width/4, img_grey[((3*height/4) * width) + 3*width/4]);
	//
	printf("Sequential (%ix%i elemens):\t%f ms\n", width, height, (finalTime - initialTime));
	// Release memory
	free(img_rgb);
	free(img_grey);
	//
	return 0;
}