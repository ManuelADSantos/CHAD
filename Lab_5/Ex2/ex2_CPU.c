// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 03/11/2023
// ============================================================================
// -> Compile
// gcc -o ex2_CPU ex2_CPU.c -lm -lrt
// -> Run
// ./ex2_CPU
// ============================================================================
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// ===================== Main program =====================
int main(int argc, char *argv[])
{
    // ===== Check if the number of arguments is correct
    if (argc != 2)
    {
        printf("./ex2_CPU num_elements\n");
        return -1;
    }

    // ===== Get the number of elements
    int N = atoi(argv[1]);
    printf("-> Number of elements:  %d\n", N);

    // ===== Declare the vector and the sum
    int vector[N];
    int sum = 0;

    // ===== Initialize timer variables
    struct timespec start, end;

    // ===== Initialize the vector
    for (int i = 0; i < N; i++)
    {
        vector[i] = i;
    }

    // ===== Get initial time
    clock_gettime(CLOCK_MONOTONIC, &start);

    // ===== Calculate the sum of all elements in the vector
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

    // ===== Print the sum (Validation)
    printf("The sum of all elements in the vector is: %d\n", sum);

    return 0;
}
