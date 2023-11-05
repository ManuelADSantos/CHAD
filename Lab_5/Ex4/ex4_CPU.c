// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 03/11/2023
// ============================================================================
// -> Compile
// gcc -o ex4_CPU.out ex4_CPU.c -lrt -lm
// -> Run
// ./ex4_CPU width height
// ============================================================================

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

// ===================== Main =====================
int main(int argc, char *argv[])
{
	// ===== Image properties
	int size = 256;
	int n = size * size;
	int bin = 16;

	// ===== Image declaration
	unsigned char *img_rgb;
	int *hist;

	// ==== Size of matrices
	size_t bytes = n * sizeof(unsigned char);
	size_t bytes_bin = bin * sizeof(int);

	// ===== Allocate host memory for image
	img_rgb = (unsigned char *)malloc(bytes);

	// ===== Allocate host memory for histogram
	hist = (int *)malloc(bytes_bin);

	// ===== Initialize image
	for (int i = 0; i < n; i++)
	{
		img_rgb[i] = 255 * sin(i) * sin(i);
	}

	// ===== Initialize histogram
	for (int i = 0; i < bin; i++)
	{
		hist[i] = 0;
	}

	// ===== Declare timer variables
	struct timespec start, end;

	// ===== Get initial time
	clock_gettime(CLOCK_MONOTONIC, &start);

	// ===== Build histogram
	for (int i = 0; i < n; i++)
	{
		hist[(int)(img_rgb[i] / bin)] += 1;
	}

	// ===== Get final time
	clock_gettime(CLOCK_MONOTONIC, &end);

	// ===== Calculate the elapsed time
	double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
	double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);

	// ===== Validation
	int counter = 0;
	for (int i = 0; i < bin; i++)
	{
		printf("hist[%i]=%u\n", i, hist[i]);
		counter += hist[i];
	}

	// ===== Show results
	printf("--> Total pixels = %i\n", counter);
	printf("--> Time (%ix%i elemens):\t%f ms\n", size, size, (finalTime - initialTime));

	// Free memory
	free(img_rgb);
	free(hist);

	return 0;
}