// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 10/10/2023
// ============================================================================
// Compilling commands
// pgcc -lm -lrt -Minfo=all -acc -ta=tesla -o Lab3_ex2_OpenACC.out Lab3_ex2_OpenACC.c
// ./Lab3_ex2_OpenACC.out num_iterations

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[])
{
	printf("===== Lab3_ex2_OpenACC =====\n");

	// Check if the number of arguments is correct
	if (argc != 2)
	{
		printf("./Lab3_ex2_OpenACC num_iterations\n");
		return 0;
	}
	int n = atoi(argv[1]);

	double ln2 = 0;

	// Initialize timer variables
	struct timespec start, end;
	// Get initial time
	clock_gettime(CLOCK_MONOTONIC, &start);

#pragma acc kernels
	for (int i = 1; i <= n; i++)
	{
		ln2 += (i & 1) ? 1.0 / i : -1.0 / i;
	}

	// Get final time
	clock_gettime(CLOCK_MONOTONIC, &end);

	// Calculate the elapsed time
	double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
	double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
	printf("--> Lab3_ex2_OpenACC (%i elements):\t%f ms\n", n, (finalTime - initialTime));

	printf("ln(2) = %20f\n", ln2);

	return 0;
}