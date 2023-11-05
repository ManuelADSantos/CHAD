// gcc -o lab5_ex3_seq.out lab5_ex3_seq.c -lrt -lm
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main( int argc, char* argv[])
{
	if(argc!=3)
	{
		printf("./lab5_ex3_seq width height \n");
		return 0;
	}
	int width, height;
	width = atoi(argv[1]);
	height = atoi(argv[2]);

	int n = width * height;

	// vector declaration
	int *m_original;
	int *m_transposta;
	
	// Size, in bytes, of each vector
	size_t bytes = n * sizeof(int);

	// Allocate memory for each vector
	m_original=(int*)malloc(bytes);
	m_transposta=(int*)malloc(bytes);

	// Initialize content of input vector a, b and c
	int i;
	for(i=0; i<height; i++)
	{
		for (int j=0; j<width; j++)
		{
			m_original[i*width + j] = i;
		}
	} 

	//CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

	for(i=0; i<height; i++)
	{
		for (int j=0; j<width; j++)
		{
			m_transposta[j*height + i] = m_original[i*width + j];
		}
	} 

	clock_gettime(CLOCK_MONOTONIC, &end);
	//
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
	// DEBUG 
	printf("m_transposta[%i][%i]=%u\n", width/2, height/4, m_transposta[((width/2) * height) + height/4]);
  printf("m_transposta[%i][%i]=%u\n", width/4, 3*height/4, m_transposta[((width/4) * height) + 3*height/4]);
  printf("m_transposta[%i][%i]=%u\n", 3*width/4, height/2, m_transposta[((3*width/4) * height) + height/2]);
	//
	printf("Sequential (%ix%i elemens):\t%f ms\n", width, height, (finalTime - initialTime));
	// Release memory
	free(m_original);
	free(m_transposta);
	//
	return 0;
}