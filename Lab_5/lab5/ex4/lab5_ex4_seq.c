// gcc -o lab5_ex4_seq.out lab5_ex4_seq.c -lrt -lm
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main( int argc, char* argv[])
{
	if(argc!=2)
	{
		printf("./lab5_ex4_seq size \n");
		return 0;
	}
	int size;
	size = atoi(argv[1]);

	int n = size * size;
	int bin = 16;

	// vector declaration
	unsigned char *img_rgb;
	int *hist;
	
	// Size, in bytes, of each vector
	size_t bytes = n * sizeof(unsigned char);
	size_t bytes_bin = bin * sizeof(int);

	// Allocate memory for each vector
	img_rgb = (unsigned char*)malloc(bytes);
	hist = (int*)malloc(bytes_bin); 

	// Initialize content of input vector a, b and c
	int i;
	for(i=0; i<n; i++)
	{
		img_rgb[i] = 255 * sin(i) * sin(i);
	} 

	for(i=0; i<bin; i++)
	{
		hist[i] = 0;
	} 

	//CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

	// y=a.x+y com a = 5
	for(i=0; i<n; i++)
	{
     hist[(int)(img_rgb[i]/bin)] += 1;
	}

	clock_gettime(CLOCK_MONOTONIC, &end);
	//
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
	// DEBUG
	int contador = 0;
	for(i=0; i<bin; i++)
	{
		printf("hist[%i]=%u\n", i, hist[i]);
		contador += hist[i];
	} 
	printf("Contagem total = %i\n", contador);
	printf("Sequential (%ix%i elemens):\t%f ms\n", size, size, (finalTime - initialTime));
	// Release memory
	free(img_rgb);
	free(hist);
	return 0;
}