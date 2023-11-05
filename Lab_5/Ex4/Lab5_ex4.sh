#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 03/11/2023
# ============================================================================
# -> Run
# ./Lab5_ex4.sh

echo "Default values: 256 256"
# Run exercise 4
echo "========== Running Lab5 Exercise 4 CPU "==========
gcc -o ex4_CPU ex4_CPU.c -lm -lrt
./ex4_CPU
rm ex4_CPU

# Run exercise 4.1
echo -e "\n========== Running Lab5 Exercise 4.1 GPU - Simple =========="
nvcc -o ex4_1_GPU ex4_1_GPU.cu -lrt -lm
./ex4_1_GPU 
rm ex4_1_GPU

# Run exercise 4.2
echo -e "\n========== Running Lab5 Exercise 4.2 GPU - Shared Mem =========="
nvcc -o ex4_2_GPU ex4_2_GPU.cu -lrt -lm
./ex4_2_GPU
rm ex4_2_GPU
