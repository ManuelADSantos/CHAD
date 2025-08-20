// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 11/12/2023
// ============================================================================
// Summary: This program performs a grayscale filter on an image using OpenCL.
//
// This file contains the host code.
// ============================================================================

// Image read libraries
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "lib/stb_image.h"
#include "lib/stb_image_write.h"
// OpenCL libraries
#include "CL/opencl.h"
#include "AOCL_Utils.h"
// C libraries
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

using namespace aocl_utils;

// Image size
#define WIDTH 512
#define HEIGHT 512
#define CHANNELS 3
#define SIZE WIDTH * HEIGHT

int main() {
    cl_platform_id platform = NULL;
    unsigned num_devices = 0;
    scoped_array<cl_device_id> device;
    cl_context context = NULL;
    scoped_array<cl_command_queue> queue;
    cl_program program = NULL;
    scoped_array<cl_kernel> kernel;

    cl_mem buffer_img_RGB, buffer_img_GRAY;
    cl_int err, status;

    // ===== Image Properties
    int width, height, n;

    unsigned char *img_rgb = stbi_load("image.jpg", &width, &height, &n, 0);
    unsigned char *img_GRAY = (unsigned char *) malloc(SIZE * sizeof(unsigned char));

    if (img_rgb == NULL) {
        printf("Error in loading the image\n");
        exit(1);
    }

    // Get the OpenCL platform.
    platform = findPlatform("Altera");
    if(platform == NULL) {
      printf("ERROR: Unable to find Altera OpenCL platform.\n");
      return false;
    }

    // Query the available OpenCL device.
    device.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));
    printf("Platform: %s\n", getPlatformName(platform).c_str());
    printf("Using %d device(s)\n", num_devices);
    for(unsigned i = 0; i < num_devices; ++i)
    {
      printf("  %s\n", getDeviceName(device[i]).c_str());
    }

    // Create the context.
    context = clCreateContext(NULL, num_devices, device, NULL, NULL, &status);
    checkError(status, "Failed to create context");

    // Create the program for all device. Use the first device as the
    // representative device (assuming all device are of the same type).
    std::string binary_file = getBoardBinaryFile("GreyScale", device[0]);
    printf("Using AOCX: %s\n", binary_file.c_str());
    program = createProgramFromBinary(context, binary_file.c_str(), device, num_devices);

    // Build the program that was just created.
    status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
    checkError(status, "Failed to build program");

    // Create command queue
    queue = clCreateCommandQueue(context, device, 0, &err);

    // Create memory buffers on the device
    buffer_img_RGB = clCreateBuffer(context, CL_MEM_READ_ONLY, SIZE * sizeof(unsigned char) * CHANNELS, NULL, &err);
    buffer_img_GRAY = clCreateBuffer(context, CL_MEM_WRITE_ONLY, SIZE * sizeof(unsigned char), NULL, &err);

    // Write input arrays to the device buffers
    clEnqueueWriteBuffer(queue, buffer_img_RGB, CL_TRUE, 0, SIZE * sizeof(unsigned char) * CHANNELS, img_rgb, 0, NULL, NULL);

    // Create OpenCL program from the kernel source
    program = clCreateProgramWithSource(context, 1, &kernelSource, NULL, &err);
    clBuildProgram(program, 1, &device, NULL, NULL, NULL);

    // Create OpenCL kernel
    kernel = clCreateKernel(program, "GrayScale", &err);

    // Set the arguments of the kernel
    clSetKernelArg(kernel, 0, sizeof(cl_mem), &buffer_img_RGB);
    clSetKernelArg(kernel, 1, sizeof(cl_mem), &buffer_img_GRAY);

    // Execute the OpenCL kernel on the array
    size_t globalSize = SIZE;
    clEnqueueNDRangeKernel(queue, kernel, 1, NULL, &globalSize, NULL, 0, NULL, NULL);

    // Read the output buffer back to the host
    clEnqueueReadBuffer(queue, buffer_img_GRAY, CL_TRUE, 0, SIZE * sizeof(unsigned char), img_GRAY, 0, NULL, NULL);

    // Display the result
    printf("Grayscale image obtained\n");
    sprintf(img_name, "image_gray.jpg");
    stbi_write_jpg(img_name, width, height, 1, img_GRAY, width);
    printf("Image saved\n");

    // Clean up
    clReleaseMemObject(buffer_img_RGB);
    clReleaseMemObject(buffer_img_GRAY);
    clReleaseKernel(kernel);
    clReleaseProgram(program);
    clReleaseCommandQueue(queue);
    clReleaseContext(context);

    return 0;
}