#!/bin/bash

echo "===== Running Jacobi code 5 times as ./jacobi $1 $2 $3 ====="
for i in {1..5}
do
   echo -e "\n"
   ./jacobi $1 $2 $3
done
