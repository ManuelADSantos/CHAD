// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 10/10/2023
// ============================================================================
// Compilling commands
// pgcc -lm -lrt -Minfo=all -acc -ta=tesla -o jacobi Lab3_ex7_OpenACC.c
// ./jacobi 10 10 200

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <math.h>
#include <stdlib.h>
int main(int argc, char **argv)
{
	int n, m, iter_max;
	if (argc > 1)
	{
		n = atoi(argv[1]);
	}
	else
	{
		n = 4096;
	}
	if (argc > 2)
	{
		m = atoi(argv[2]);
	}
	else
	{
		m = 4096;
	}
	if (argc > 3)
	{
		iter_max = atoi(argv[3]);
	}
	else
	{
		iter_max = 1000;
	}
	const double tol = 1.0e-6;
	double error = 1.0;
	double err;
	double *restrict A = (double *)malloc(sizeof(double) * n * m);
	double *restrict Anew = (double *)malloc(sizeof(double) * n * m);
	for (int i = 0; i < m; i++)
	{
		A[i] = 1.0;
		Anew[i] = 1.0;
	}
	printf("Jacobi relaxation Calculation: %d x %d mesh\n", n, m);
	double st = omp_get_wtime();
	int iter = 0;
#pragma acc data copy(A[ : m * n]) copyin(Anew[ : m * n])
	{
		while (error > tol && iter < iter_max)
		{
			err = 0.0;
#pragma acc parallel loop
			for (int j = 1; j < n - 1; j++)
			{
#pragma acc loop
				for (int i = 1; i < m - 1; i++)
				{
					Anew[(j * m) + i] = 0.25 * (A[(j * m) + i + 1] + A[(j * m) + i - 1] + A[((j - 1) * m) + i] + A[((j + 1) * m) + i]);
					err = fmax(error, fabs(Anew[(j * m) + i] - A[(j * m) + i]));
				}
			}

#pragma acc parallel loop
			for (int j = 1; j < n - 1; j++)
			{
#pragma acc loop
				for (int i = 1; i < m - 1; i++)
				{
					A[(j * m) + i] = Anew[(j * m) + i];
				}
			}
#pragma acc update self(A[0 : m * n])
			if (iter % 100 == 0)
			{
				printf("%5d, %0.6f\n", iter, err);
				for (int j = 0; j < m; j++)
				{
					for (int i = 0; i < n; i++)
					{
						printf("%0.2f ", A[i + j * m]);
					}
					printf("\n");
				}
			}
			iter++;
		}
	}
	double runtime = omp_get_wtime() - st;
	printf(" total: %f s\n", runtime);
	free(A);
	free(Anew);
	return 0;
}
