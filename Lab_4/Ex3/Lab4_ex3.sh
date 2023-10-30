#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 18/10/2023
# ============================================================================
# -> Run
# ./Lab4_ex3.sh


# Flag for valid argument
valid=0

# Run exercise 3
echo "========== Running Lab4 Exercise 3 "==========
echo "M1 + M2 = M3"
nvcc -o ex3 ex3.cu
./ex3
rm ex3