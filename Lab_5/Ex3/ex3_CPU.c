// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 03/11/2023
// ============================================================================
// -> Compile
// gcc -o ex3_CPU.out ex3_CPU.c -lrt -lm
// -> Run
// ./ex3_CPU width height
// ============================================================================

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

// ===================== Main =====================
int main(int argc, char *argv[])
{
	// ===== Check arguments
	if (argc != 3)
	{
		printf("./ex3_CPU width height \n");
		return -1;
	}

	// ===== Get width and height
	int width, height;
	width = atoi(argv[1]);
	height = atoi(argv[2]);

	// ===== Get total number of elements
	int N = width * height;

	// ===== Show number of elements
	printf("\n-> Dimensions: 		%d x %d\n", width, height);
	printf("-> Number of elements:  %d\n\n", N);

	// ===== Declare timer variables
	struct timespec start, end;

	// ===== Matrix declaration
	int *m_original = NULL, *m_transposed = NULL;

	// ===== Size of matrices
	size_t size = N * sizeof(int);

	// ===== Allocate memory for each matrix
	m_original = (int *)malloc(size);
	m_transposed = (int *)malloc(size);

	// ===== Initialize original matrix
	for (int i = 0; i < height; i++)
	{
		for (int j = 0; j < width; j++)
		{
			m_original[i * width + j] = i;
		}
	}

	// ===== Get initial time
	clock_gettime(CLOCK_MONOTONIC, &start);

	// ===== Transpose matrix
	for (int i = 0; i < height; i++)
	{
		for (int j = 0; j < width; j++)
		{
			m_transposed[j * height + i] = m_original[i * width + j];
		}
	}

	// ===== Get final time
	clock_gettime(CLOCK_MONOTONIC, &end);

	// ===== Calculate the elapsed time
	double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
	double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);

	// ===== Validate results
	printf("m_transposed[%i][%i]=%u\n", width / 2, height / 4, m_transposed[((width / 2) * height) + height / 4]);
	printf("m_transposed[%i][%i]=%u\n", width / 4, 3 * height / 4, m_transposed[((width / 4) * height) + 3 * height / 4]);
	printf("m_transposed[%i][%i]=%u\n", 3 * width / 4, height / 2, m_transposed[((3 * width / 4) * height) + height / 2]);

	// ===== Print time
	printf("\n--> Execution Time:\t%f ms\n\n", (finalTime - initialTime));

	// ===== Free memory
	free(m_original);
	free(m_transposed);

	return 0;
}