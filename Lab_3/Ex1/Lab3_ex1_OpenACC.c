// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 10/10/2023
// ============================================================================
// Compilling commands
// pgcc -lm -lrt -Minfo=all -acc -ta=tesla -o Lab3_ex1_OpenACC.out Lab3_ex1_OpenACC.c
// ./Lab3_ex1_OpenACC.out 100

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main(int argc, char *argv[])
{
	// Check if the number of arguments is correct
	if (argc != 2)
	{
		printf("./Lab3_ex1_OpenACC num_rows_cols \n");
		return 0;
	}

	printf("===== Lab3_ex1_OpenACC =====\n");

	// Get the dimension of the vector
	int n = atoi(argv[1]);

	// Constant 'a'
	int a = 5;

	// Declare vectors (with keyword restrict to indicate that the pointers are not aliased)
	float *restrict x;
	float *restrict y;

	// Size, in bytes, of each vector - x and y are vectors so is going to be just n values
	size_t bytes = n * sizeof(float);
	// Allocate memory for each vector
	x = (float *)malloc(bytes);
	y = (float *)malloc(bytes);

	// Check if the memory allocation was successful
	if (x == NULL || y == NULL)
	{
		perror("Memory allocation failed");
		return -1;
	}
	else
	{
		printf("--> Memory allocation successful\n");
	}

	// Initialize content of input vector a, b and c
	for (int i = 0; i < n; i++)
	{
		x[i] = i + 1;
		y[i] = i + 2;
	}

	printf("--> Initialize times\n");
	// Initialize timer variables
	struct timespec start, end;
	// Get initial time
	clock_gettime(CLOCK_MONOTONIC, &start);

	printf("--> Starting SAXPY operation\n");
// SAXPY: y = a.x+y
#pragma acc kernels
	{
		for (int i = 0; i < n; i++)
			y[i] = a * x[i] + y[i];
	}

	// Get final time
	clock_gettime(CLOCK_MONOTONIC, &end);

	// Calculate the elapsed time
	double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
	double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
	printf("--> Lab3_ex1_OpenACC (%i elements):\t%f ms\n", n, (finalTime - initialTime));

	// Check if the result is correct
	printf("--> Validate Result: %f\n", y[(int)(n / 2)]);

	// Free memory
	free(x);
	free(y);

	return 0;
}
