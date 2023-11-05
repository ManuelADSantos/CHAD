// gcc -o ex2_CPU ex2_CPU.c -lm -lrt
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// #define N 100

int main(int argc, char *argv[])
{
    // Check if the number of arguments is correct
    if (argc != 2)
    {
        printf("./ex2_CPU num_elements\n");
        return -1;
    }
    int N = atoi(argv[1]);
    printf("Number of elements: %d\n", N);
    int vector[N];

    // ===== Initialize timer variables
    struct timespec start, end;

    for (int i = 0; i < N; i++)
    {
        vector[i] = i;
    }

    int sum = 0;

    // ===== Get initial time
    clock_gettime(CLOCK_MONOTONIC, &start);

    for (int i = 0; i < N; i++)
    {
        sum += vector[i];
    }

    // ===== Get final time
    clock_gettime(CLOCK_MONOTONIC, &end);
    // ===== Calculate the elapsed time
    double initialTime = (start.tv_sec * 1e3) + (start.tv_nsec * 1e-6);
    double finalTime = (end.tv_sec * 1e3) + (end.tv_nsec * 1e-6);
    printf("-> Execution Time:\t%f ms\n", (finalTime - initialTime));

    printf("The sum of all elements in the vector is: %d\n", sum);

    return 0;
}
