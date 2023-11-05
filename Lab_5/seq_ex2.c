// gcc -o seq_ex2.out seq_ex2.c -lrt -lm
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define N 8192
		
int main(int argc, char* argv[]){

    //Criar Imagem com valores random
    //int N = 4096;
    int result = 0;
    int *v1 = (int*)malloc(N * sizeof(int));

    for (int i = 0; i < N; i++){
	v1[i] = 1;
    }


    //Versão sequencial

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    for (int i = 0; i < N; i++){
	result += v1[i];
    }
	
    clock_gettime(CLOCK_MONOTONIC, &end);

    double initialTime=(start.tv_sec*1e3)+(start.tv_nsec*1e-6);
    double finalTime=(end.tv_sec*1e3)+(end.tv_nsec*1e-6);

    printf("Exercício 2 - Sequencial: %f ms\n", (finalTime - initialTime));
    printf("Resultado da Soma: %d \n", result);

    free(v1);

    return 0;
}
