#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 07/11/2023
# ============================================================================
# -> Run
# ./Lab6_ex1.sh

# Run exercise 1
echo -e "\n=========== Running Lab6 Exercise 1 ==========="
nvcc -o Lab6_ex1 SAD.cu -lrt -lm
./Lab6_ex1 
rm Lab6_ex1