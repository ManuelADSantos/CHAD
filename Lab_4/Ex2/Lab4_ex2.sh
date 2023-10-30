#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 17/10/2023
# ============================================================================
# -> Run
# ./Lab4_ex2.sh [exercise number - 1, 2, 3 | 0 or empty for all]
# -> Example
# ./Lab4_ex2.sh 1


# Flag for valid argument
valid=0

# Check if argument is given
if [ -z $1 ]; then
   set -- 0
   valid=1
fi

# Run exercise 2.1
if [[ $1 -eq 1 || $1 -eq 0 ]]; then
   echo "========== Running Lab4 Exercise 2.1 "==========
   nvcc -o ex2_1 ex2_1.cu
   ./ex2_1
   rm ex2_1
   valid=1
fi 

# Run exercise 2.2
if [[ $1 -eq 2 || $1 -eq 0 ]]; then
   echo -e "\n========== Running Lab4 Exercise 2.2 =========="
   nvcc -o ex2_2 ex2_2.cu
   ./ex2_2
   rm ex2_2
   valid=1
fi

# Run exercise 2.3
if [[ $1 -eq 3 || $1 -eq 0 || $1 -eq 30 ]]; then
   echo -e "\n========== Running Lab4 Exercise 2.3 =========="
   echo "==> Without  packing"
   nvcc -o ex2_3_sem ex2_3_sem.cu
   ./ex2_3_sem
   rm ex2_3_sem
   valid=1
fi
if [[ $1 -eq 3 || $1 -eq 0 || $1 -eq 31 ]]; then
   if [ $valid -eq 0 ]; then
      echo -e "\n========== Running Lab4 Exercise 2.3 =========="
      echo "==> With packing"
   else
      echo -e "\n==> With packing"
   fi
   nvcc -o ex2_3_com ex2_3_com.cu
   ./ex2_3_com
   rm ex2_3_com
   valid=1
fi

# Error message if argument is invalid
if [ $valid -eq 0 ]; then
   echo "Invalid argument"
   echo "Usage: ./Lab4_ex2.sh [exercise number - 1, 2, 3 | 0 or empty for all]"
   echo "Example: ./Lab4_ex2.sh 1"
fi