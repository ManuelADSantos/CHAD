// pgcc -lrt -lm -Minfo=all -acc -ta=tesla -o matrixMul_openacc.out matrixMul_openacc.c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

int main( int argc, char* argv[])
{
	if(argc!=2)
	{
		printf("./matrixMul_openacc num_rows_cols \n");
		return 0;
	}
	int n;
	n=atoi(argv[1]); // num_rows_cols
	// vector declaration
	float *restrict a;
	float *restrict b;
	float *restrict c;
	// Size, in bytes, of each vector
	size_t bytes=n*n*sizeof(float);
	// Allocate memory for each vector
	a=(float*)malloc(bytes);
	b=(float*)malloc(bytes);
	c=(float*)malloc(bytes);
	// Initialize content of input vector a, b and c
	int i,j,k;
	for(i=0; i<n*n; i++)
	{
		a[i]=sin(i)*sin(i);
		b[i]=cos(i)*sin(i);
		c[i]=0.0;
	}
	//CLOCK_PROCESS_CPUTIME_ID - Profiling the execution time of loop
	struct timespec start, end;
	clock_gettime(CLOCK_MONOTONIC, &start);
	// c=a*b
	// ========== Exercise 3.1
	/*#pragma acc kernels
	for(i=0; i<n; i++)
	{
		for(j=0;j<n;j++)
		{
			for(k=0;k<n;k++)
			{
				c[i*n+j]+=a[i*n+k]*b[k*n+j];
			}
		}
	}*/
	// ========== Exercise 3.3
	#pragma acc data copyin(a[0:n*n],b[0:n*n]),copy(c[0:n*n])
	{	
		#pragma acc kernels
		for(i=0; i<n; i++)
		{
			for(j=0;j<n;j++)
			{
				for(k=0;k<n;k++)
				{
					c[i*n+j]+=a[i*n+k]*b[k*n+j];
				}
			}
		}
	}
	clock_gettime(CLOCK_MONOTONIC, &end);
	//
	double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
	double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);
	// DEBUG
	printf("DEBUG: c[%i*n+%i]=%f\n", (n/2), (n/2), c[((n/2)*n)+(n/2)]);
	//
	printf("OpenACC (%ix%i elemens):\t%f ms\n", n,n, (finalTime - initialTime));
	// Release memory
	free(a);
	free(b);
	free(c);
	//
	return 0;
}