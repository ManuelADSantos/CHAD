// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 10/10/2023
// ============================================================================
// Compilling commands
// pgcc -lm -lrt -Minfo=all -acc -ta=tesla -o Lab3_ex3_seq.out Lab3_ex3_seq.c
// ./Lab3_ex3_seq.out num_iterations

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[])
{
	printf("===== Lab3_ex3_seq =====\n");

	// Check if the number of arguments is correct
	if (argc != 2)
	{
		printf("./Lab3_ex3_seq matrix_dimension\n");
		return 0;
	}
	int n = atoi(argv[1]);

	// Declare base matrix
	float *restrict matrix;

	// Size, in bytes, of base matrix
	size_t bytes = n * n * sizeof(float);

	// Allocate memory for matrix
	matrix = (float *)malloc(bytes);

	// Initialize content of matrix
	for (int i = 0; i < n * n; i++)
	{
		matrix[i] = i * (i + 1);
	}

	// Initialize timer variables
	struct timespec start, end;

	// Declare auxiliary variables
	float result = 0;
	int size = ((n * n - n) / 2) + n;

	// Get initial time
	clock_gettime(CLOCK_MONOTONIC, &start);

	// Main for loop
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (i >= j)
			{
				result += matrix[n * i + j];
			}
		}
	}
	result = result / size;

	// Get final time
	clock_gettime(CLOCK_MONOTONIC, &end);

	// Calculate the elapsed time
	double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
	double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
	printf("--> Lab3_ex3_seq (%i elements):\t%f ms\n", n, (finalTime - initialTime));

	// Check if the result is correct
	printf("--> Validate Result: %f\n", result);

	return 0;
}
