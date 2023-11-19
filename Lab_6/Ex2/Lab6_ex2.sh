#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 07/11/2023
# ============================================================================
# -> Run
# ./Lab6_ex2.sh

# Run exercise 2
echo -e "\n=========== Running Lab6 Exercise 2 ==========="
nvcc -o Lab6_ex2 Lab6_ex2.cu -lrt
./Lab6_ex2 
rm Lab6_ex2