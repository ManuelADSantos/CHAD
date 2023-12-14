// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 11/12/2023
// ============================================================================
// Summary: This program performs matrix multiplication on an FPGA device
//         using OpenCL. The host program creates two input matrices and
//         and one output matrix. The host program then sends the input
//         matrices to the FPGA device. The FPGA device performs the matrix
//         multiplication and sends the result back to the host program.
//         The host program then verifies the result.
//
// This file contains the kernel function that performs the matrix
//      multiplication on the FPGA device.
// ============================================================================

__kernel void matMul(__global const float *A, __global const float *B, __global float *restrict C)
{
    // === Get the row and column of the element
    int row = get_global_id(1);
    int col = get_global_id(0);

    // === Check if the row and column are within the matrix bounds
    if ((row < 1024) && (col < 1024))
    {
        float sum = 0.0;
        for (int k = 0; k < 1024; k++)
            sum += A[row * 1024 + k] * B[k * 1024 + col];
        C[row * 1024 + col] = sum;
    }
}
