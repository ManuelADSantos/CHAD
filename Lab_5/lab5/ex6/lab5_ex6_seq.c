// gcc -o lab5_ex6_seq.out lab5_ex6_seq.c -lrt -lm
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main( int argc, char* argv[])
{
	if(argc!=2)
	{
		printf("./lab5_ex6_seq size \n");
		return 0;
	}
	int size;
	size = atoi(argv[1]);

	int n = size * size;
	int t_filtro = 3;

	// vector declaration
	unsigned char *img;
	float *filtro;
	unsigned char *res;
	
	// Size, in bytes, of each vector
	size_t bytes = n * sizeof(unsigned char);
	size_t bytes_fil = t_filtro * t_filtro * sizeof(float);

	// Allocate memory for each vector
	img = (unsigned char*)malloc(bytes);
	filtro = (float*)malloc(bytes_fil); 
	res = (unsigned char*)malloc(bytes);

	// Initialize content of input vector a, b and c
	for(int i=0; i<size; i++)
	{
		for(int j=0; j<size; j++)
  	{
  		if (i%2 == j%2)
  			img[i*size + j] = 255;
  		else 
  			img[i*size + j] = 0;
  	} 
	} 

	for(int i=0; i<t_filtro*t_filtro; i++)
	{
		filtro[i] = 1;
   filtro[i] = filtro[i]/9;
	} 

	//CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);

	int aux[t_filtro*t_filtro];
	float valor = 0;
	for(int i=0; i<size; i++)
	{
		for(int j=0; j<size; j++)
		{
			for(int k=0; k<t_filtro; k++)
			{
				for(int m=0; m<t_filtro; m++)
				{
					if(i+k-1 < 0 || i+k-1 == size || j+m-1 < 0 || j+m-1 == size)
						aux[k*t_filtro + m] = 0;
					else
						aux[k*t_filtro + m] = img[(i+k-1)*size + (j+m-1)];
				}
			}
			for (int n=0; n<t_filtro*t_filtro; n++)
			{
				valor += aux[n] * filtro[n]; 
			}
			res[i*size + j] = (unsigned char)valor;
      valor = 0;
		}
	}

	clock_gettime(CLOCK_MONOTONIC, &end);
	//
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
	// DEBUG
	int contador = 0;
	for(int i=0; i<10; i++)
	{
		for(int j=0; j<10; j++)
		{
			printf("%-4u ", res[i*size + j]);
		} 
		printf("\n");
	} 
	printf("Sequential (%ix%i elemens):\t%f ms\n", size, size, (finalTime - initialTime));
	// Release memory
	free(img);
	free(filtro);
	free(res);
	return 0;
}