#!/bin/bash

# Set up environment variables for OpenCL
export ALTERAOCLSDKROOT=/usr/local/altera/14.1/hld/
source /usr/local/altera/14.1/hld/init_opencl.sh

# Check if the environment variables are set
echo -e "\n==================== Version ===================="
aocl version
echo -e "\n==================== Board List ===================="
aoc --list-boards