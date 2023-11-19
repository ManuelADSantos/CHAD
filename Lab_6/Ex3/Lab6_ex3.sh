#!/bin/bash

# ============================================================================
# Programmer: Manuel Santos 2019231352
# Date: 07/11/2023
# ============================================================================
# -> Run
# ./Lab6_ex3.sh

num=2

out_directory="images/out"
if [ -n "$(ls -A $out_directory)" ]; then
    # Directory is not empty, proceed with deletion
    rm -f $out_directory/*
fi

# Run exercise 3 a)
echo -e "\n========== Running Lab6 Exercise 3 - a)Simple =========="
nvcc -o Lab6_ex3_a Lab6_ex3_a.cu -lrt
for ((img=1; img<=$num; img++))
do
    echo "-- Image $img"
    ./Lab6_ex3_a "$img"
done
rm Lab6_ex3_a

# Run exercise 3 b)
echo -e "\n========== Running Lab6 Exercise 3 - b)Optimized =========="
nvcc -o Lab6_ex3_b Lab6_ex3_b.cu -lrt
for ((img=1; img<=$num; img++))
do
    echo "-- Image $img"
    ./Lab6_ex3_b "$img"
done
rm Lab6_ex3_b