#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 17/10/2023
# ============================================================================
# -> Run
# ./Lab5_ex2.sh

# Check if argument is given
if [ -z $1 ]; then
    # ========== Default ==========
    # Run exercise 2.1
    echo "========== Running Lab5 Exercise 2 CPU "==========
    gcc -o ex2_CPU ex2_CPU.c -lm -lrt
    ./ex2_CPU 100
    rm ex2_CPU
    # Run exercise 2.2
    echo -e "\n========== Running Lab5 Exercise 2.1 GPU - Simple =========="
    nvcc -o ex2_1_GPU_normal ex2_1_GPU_normal.cu -lrt -lm
    ./ex2_1_GPU_normal 100
    rm ex2_1_GPU_normal
    # Run exercise 2.3
    echo -e "\n========== Running Lab5 Exercise 2.2 GPU - Shared Mem =========="
    nvcc -o ex2_2_GPU_optim ex2_2_GPU_optim.cu -lrt -lm
    ./ex2_2_GPU_optim 100
    rm ex2_2_GPU_optim
else
    # ========== Argument given ==========
    # Run exercise 2.1
    echo "========== Running Lab5 Exercise 2 CPU "==========
    gcc -o ex2_CPU ex2_CPU.c -lm -lrt
    ./ex2_CPU $1
    rm ex2_CPU
    # Run exercise 2.2
    echo -e "\n========== Running Lab5 Exercise 2.1 GPU - Simple =========="
    nvcc -o ex2_1_GPU_normal ex2_1_GPU_normal.cu -lrt -lm
    ./ex2_1_GPU_normal $1
    rm ex2_1_GPU_normal
    # Run exercise 2.3
    echo -e "\n========== Running Lab5 Exercise 2.2 GPU - Shared Mem =========="
    nvcc -o ex2_2_GPU_optim ex2_2_GPU_optim.cu -lrt -lm
    ./ex2_2_GPU_optim $1
    rm ex2_2_GPU_optim
fi