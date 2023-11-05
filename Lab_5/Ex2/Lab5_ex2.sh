#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 03/11/2023
# ============================================================================
# -> Run
# ./Lab5_ex2.sh

# Run exercise 2
echo "========== Running Lab5 Exercise 2 CPU "==========
gcc -o ex2_CPU ex2_CPU.c -lm -lrt
./ex2_CPU
rm ex2_CPU

# Run exercise 2.1
echo -e "\n========== Running Lab5 Exercise 2.1 GPU - Simple =========="
nvcc -o ex2_1_GPU ex2_1_GPU.cu -lrt -lm
./ex2_1_GPU
rm ex2_1_GPU

# Run exercise 2.2
echo -e "\n========== Running Lab5 Exercise 2.2 GPU - Shared Mem =========="
nvcc -o ex2_2_GPU ex2_2_GPU.cu -lrt -lm
./ex2_2_GPU
rm ex2_2_GPU
