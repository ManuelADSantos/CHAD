#include <stdio.h>
#include <stdlib.h>
#include <CL/cl.h>

#define SIZE 10

const char *kernelSource =
    "__kernel void vectorAdd(__global const float *a, __global const float *b, __global float *result) {\n"
    "    int i = get_global_id(0);\n"
    "    result[i] = a[i] + b[i];\n"
    "}\n";

int main() {
    cl_platform_id platform;
    cl_device_id device;
    cl_context context;
    cl_command_queue queue;
    cl_program program;
    cl_kernel kernel;
    cl_mem bufferA, bufferB, bufferResult;
    cl_int err;

    float a[SIZE], b[SIZE], result[SIZE];

    // Initialize input arrays
    for (int i = 0; i < SIZE; ++i) {
        a[i] = i;
        b[i] = SIZE - i;
    }

    // Get platform and device information
    clGetPlatformIDs(1, &platform, NULL);
    clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 1, &device, NULL);

    // Create OpenCL context
    context = clCreateContext(NULL, 1, &device, NULL, NULL, &err);

    // Create command queue
    queue = clCreateCommandQueue(context, device, 0, &err);

    // Create memory buffers on the device
    bufferA = clCreateBuffer(context, CL_MEM_READ_ONLY, SIZE * sizeof(float), NULL, &err);
    bufferB = clCreateBuffer(context, CL_MEM_READ_ONLY, SIZE * sizeof(float), NULL, &err);
    bufferResult = clCreateBuffer(context, CL_MEM_WRITE_ONLY, SIZE * sizeof(float), NULL, &err);

    // Write input arrays to the device buffers
    clEnqueueWriteBuffer(queue, bufferA, CL_TRUE, 0, SIZE * sizeof(float), a, 0, NULL, NULL);
    clEnqueueWriteBuffer(queue, bufferB, CL_TRUE, 0, SIZE * sizeof(float), b, 0, NULL, NULL);

    // Create OpenCL program from the kernel source
    program = clCreateProgramWithSource(context, 1, &kernelSource, NULL, &err);
    clBuildProgram(program, 1, &device, NULL, NULL, NULL);

    // Create OpenCL kernel
    kernel = clCreateKernel(program, "vectorAdd", &err);

    // Set the arguments of the kernel
    clSetKernelArg(kernel, 0, sizeof(cl_mem), &bufferA);
    clSetKernelArg(kernel, 1, sizeof(cl_mem), &bufferB);
    clSetKernelArg(kernel, 2, sizeof(cl_mem), &bufferResult);

    // Execute the OpenCL kernel on the array
    size_t globalSize = SIZE;
    clEnqueueNDRangeKernel(queue, kernel, 1, NULL, &globalSize, NULL, 0, NULL, NULL);

    // Read the output buffer back to the host
    clEnqueueReadBuffer(queue, bufferResult, CL_TRUE, 0, SIZE * sizeof(float), result, 0, NULL, NULL);

    // Display the result
    printf("Result: ");
    for (int i = 0; i < SIZE; ++i) {
        printf("%.2f ", result[i]);
    }
    printf("\n");

    // Clean up
    clReleaseMemObject(bufferA);
    clReleaseMemObject(bufferB);
    clReleaseMemObject(bufferResult);
    clReleaseKernel(kernel);
    clReleaseProgram(program);
    clReleaseCommandQueue(queue);
    clReleaseContext(context);

    return 0;
}
