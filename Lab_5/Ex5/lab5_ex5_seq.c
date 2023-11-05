// gcc -o lab5_ex5_seq.out lab5_ex5_seq.c -lrt -lm
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main( int argc, char* argv[])
{
	if(argc!=2)
	{
		printf("./lab5_ex5_seq size \n");
		return 0;
	}
	int size;
	size = atoi(argv[1]);

	int n = size * size;

	// vector declaration
	int *m1;
	int *m2;
	int *m3;
	
	// Size, in bytes, of each vector
	size_t bytes = n * sizeof(int);

	// Allocate memory for each vector
	m1 = (int*)malloc(bytes);
	m2 = (int*)malloc(bytes); 
	m3 = (int*)malloc(bytes); 

	// Initialize content of input vector a, b and c
	int i;
	for(i=0; i<n; i++)
	{
		m1[i] = 1;
    m2[i] = 2;
		//m2[i] = (int)(i/size);
		m3[i] = 0;
	} 

	//CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

	for(i=0; i<size; i++)
	{
		for(int j=0; j<size; j++)
		{
			for(int k=0; k<size; k++)
			{
				m3[i*size + j] += m1[i*size + k] * m2[k*size + j];
			}
		}
	}

	clock_gettime(CLOCK_MONOTONIC, &end);
	//
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
	// DEBUG
	printf("m3[%i][%i] = %i\n", size/4, size/4, m3[(size/4 * size) + size/4]);
	printf("Sequential (%ix%i elemens):\t%f ms\n", size, size, (finalTime - initialTime));
	// Release memory
	free(m1);
	free(m2);
  free(m3);
	return 0;
}