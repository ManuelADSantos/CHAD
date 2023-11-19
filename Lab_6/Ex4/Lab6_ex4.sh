#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 07/11/2023
# ============================================================================
# -> Run
# ./Lab6_ex3.sh

# Run exercise 4 a)
echo -e "\n========== Running Lab6 Exercise 4 - a) =========="
nvcc -o Lab6_ex4_a Lab6_ex4_a.cu -lrt
./Lab6_ex4_a 
rm Lab6_ex4_a

# Run exercise 4 b)
echo -e "\n========== Running Lab6 Exercise 4 - b) =========="
nvcc -o Lab6_ex4_b Lab6_ex4_b.cu -lrt
./Lab6_ex4_b
rm Lab6_ex4_b

# Run exercise 4 c)
echo -e "\n========== Running Lab6 Exercise 4 - c) =========="
nvcc -o Lab6_ex4_c Lab6_ex4_c.cu -lrt
./Lab6_ex4_c
rm Lab6_ex4_c

# Run exercise 4 d)
echo -e "\n========== Running Lab6 Exercise 4 - d) =========="
nvcc -o Lab6_ex4_d Lab6_ex4_d.cu -lrt
./Lab6_ex4_d
rm Lab6_ex4_d