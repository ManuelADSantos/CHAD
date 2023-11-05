// gcc -o lab5_ex2_seq.out lab5_ex2_seq.c -lrt -lm
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main( int argc, char* argv[])
{
	int N = 9984;

	// vector declaration
	int *v1;
	int final = 0;
	
	// Size, in bytes, of each vector
	size_t bytes = N * sizeof(int);

	// Allocate memory for each vector
	v1=(int*)malloc(bytes);

	// Initialize content of input vector a, b and c
	int i;
	for(i=0; i<N; i++)
	{
		v1[i] = 1;
	} 

	//CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

	// y=a.x+y com a = 5
	for(i=0; i<N; i++)
	{
		final += v1[i],
	}

	clock_gettime(CLOCK_MONOTONIC, &end);
	//
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
	// DEBUG
	printf("final = %i\n", final);
	//
	printf("Sequential (%i elemens):\t%f ms\n", N, (finalTime - initialTime));
	// Release memory
	free(v1);
	return 0;
}