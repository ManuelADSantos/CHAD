#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 03/11/2023
# ============================================================================
# -> Run
# ./Lab5_ex3.sh width height

if [ -z $1 ] || [ -z $2 ]; then    
    # ===== Default =====
    echo "Default values: 512 512"
    # Run exercise 3
    echo "========== Running Lab5 Exercise 3 CPU "==========
    gcc -o ex3_CPU ex3_CPU.c -lm -lrt
    ./ex3_CPU 512 512 
    rm ex3_CPU

    # Run exercise 3.1
    echo -e "\n========== Running Lab5 Exercise 3.1 GPU - Simple =========="
    nvcc -o ex3_1_GPU ex3_1_GPU.cu -lrt -lm
    ./ex3_1_GPU 512 512 
    rm ex3_1_GPU

    # Run exercise 3.2
    echo -e "\n========== Running Lab5 Exercise 3.2 GPU - Shared Mem =========="
    nvcc -o ex3_2_GPU ex3_2_GPU.cu -lrt -lm
    ./ex3_2_GPU 512 512
    rm ex3_2_GPU
else
    # ===== Given argument =====
    echo "Given values: $1 $2"
    # Run exercise 3
    echo "========== Running Lab5 Exercise 3 CPU "==========
    gcc -o ex3_CPU ex3_CPU.c -lm -lrt
    ./ex3_CPU $1 $2
    rm ex3_CPU

    # Run exercise 3.1
    echo -e "\n========== Running Lab5 Exercise 3.1 GPU - Simple =========="
    nvcc -o ex3_1_GPU ex3_1_GPU.cu -lrt -lm
    ./ex3_1_GPU $1 $2
    rm ex3_1_GPU

    # Run exercise 3.2
    echo -e "\n========== Running Lab5 Exercise 3.2 GPU - Shared Mem =========="
    nvcc -o ex3_2_GPU ex3_2_GPU.cu -lrt -lm
    ./ex3_2_GPU $1 $2
    rm ex3_2_GPU
fi