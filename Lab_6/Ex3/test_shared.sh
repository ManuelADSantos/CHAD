#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 07/11/2023
# ============================================================================
# -> Run
# ./test_shared.sh

echo -e "\n========== Running Lab6 Exercise 3 - Test =========="
nvcc -o Lab6_ex3_b Lab6_ex3_b.cu -lrt
./Lab6_ex3_b 2
rm Lab6_ex3_b