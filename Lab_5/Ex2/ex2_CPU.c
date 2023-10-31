// gcc -o ex2_CPU ex2_CPU.c -lm -lrt
#include <stdio.h>

#define N 10

int main()
{
    int vector[N];

    for (int i = 0; i < N; i++)
    {
        vector[i] = i;
    }

    int sum = 0;

    for (int i = 0; i < N; i++)
    {
        sum += vector[i];
    }

    printf("The sum of all elements in the vector is: %d\n", sum);

    return 0;
}
