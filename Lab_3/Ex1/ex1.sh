#!/bin/bash

echo "===== Running OpenACC code 5 times for N = $1 ====="
for i in {1..5}
do
   ./Lab3_ex1_OpenACC.out $1
done

echo -e "\n===== Running Sequential code 5 times for N = $1 ====="
for i in {1..5}
do
   ./Lab3_ex1_seq.out $1
done
