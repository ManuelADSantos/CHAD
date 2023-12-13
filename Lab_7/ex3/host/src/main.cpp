// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 11/12/2023
// ============================================================================
// Summary: This program performs a grayscale filter on an image using OpenCL.
//
// This file contains the host code.
// ============================================================================

// Image read libraries
/*#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
/*#define STBI_MALLOC
#define STBI_REALLOC
#define STBI_FREE 
#define STBI_MSC_SECURE_CRT
#define STBI_ONLY_JPEG*/

/*include "lib/stb_image.h"
#include "lib/stb_image_write.h"*/
// OpenCL libraries
#include "CL/opencl.h"
#include "AOCL_Utils.h"
// C libraries
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

using namespace aocl_utils;

// OpenCL runtime configuration
cl_platform_id platform = NULL;
unsigned num_devices = 0;
scoped_array<cl_device_id> device;
cl_context context = NULL;
scoped_array<cl_command_queue> queue;
cl_program program = NULL;
scoped_array<cl_kernel> kernel;


// Problem dimensions
#define WIDTH 64
#define HEIGHT 64
#define CHANNELS 3
const unsigned N = WIDTH*HEIGHT;

// Image buffers on the device
scoped_array<cl_mem> buffer_img_RGB; // num_devices elements
scoped_array<cl_mem> buffer_img_GRAY; // num_devices elements

// Image buffers on the host
scoped_array<scoped_aligned_ptr<unsigned char> > host_img_rgb;
scoped_array<scoped_aligned_ptr<unsigned char> > host_img_gray;

// Kernel properties
scoped_array<unsigned> n_per_device; // num_devices elements

// Function prototypes
bool init_opencl();
float rand_float();
void init_problem();
void run();
void cleanup();

// Entry point.
int main()
{
  // Initialize OpenCL.
  if(!init_opencl()) 
  {
    return -1;
  }

  // Initialize the problem data.
  // Requires the number of devices to be known.
  init_problem();

  // Run the kernel.
  run();

  // Free the resources allocated
  cleanup();

  return 0;
}

/////// HELPER FUNCTIONS ///////
// Randomly generate a floating-point number between -10 and 10.
unsigned char rand_char()
{
  int x = rand() % 255;
  return (unsigned char)x;
}

// Initializes the OpenCL objects.
bool init_opencl()
{
  cl_int status;

  printf("Initializing OpenCL\n");

  if(!setCwdToExeDir()) {
    return false;
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
  for(unsigned i = 0; i < num_devices; ++i) {
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

  // Create per-device objects.
  queue.reset(num_devices);
  kernel.reset(num_devices);
  n_per_device.reset(num_devices);
  buffer_img_RGB.reset(num_devices);
  buffer_img_GRAY.reset(num_devices);

  for(unsigned i = 0; i < num_devices; ++i) {
    // Command queue.
    queue[i] = clCreateCommandQueue(context, device[i], CL_QUEUE_PROFILING_ENABLE, &status);
    checkError(status, "Failed to create command queue");

    // Kernel.
    const char *kernel_name = "GreyScale";
    kernel[i] = clCreateKernel(program, kernel_name, &status);
    checkError(status, "Failed to create kernel");

    // Determine the number of elements processed by this device.
    n_per_device[i] = N / num_devices; // number of elements handled by this device

    // Spread out the remainder of the elements over the first
    // N % num_devices.
    if(i < (N % num_devices))
    {
      n_per_device[i]++;
    }

    // Input buffers.
    buffer_img_RGB[i] = clCreateBuffer(context, CL_MEM_READ_ONLY, n_per_device[i] * sizeof(unsigned char) * CHANNELS, NULL, &status);
    checkError(status, "Failed to create buffer for RGB image");

    // Output buffer.
    buffer_img_GRAY[i] = clCreateBuffer(context, CL_MEM_WRITE_ONLY, n_per_device[i] * sizeof(unsigned char), NULL, &status);
    checkError(status, "Failed to create buffer for Grayscale image");
  }
    
  printf("init_opencl function was sucessfull\n");
    
  return true;
}

// Initialize the data for the problem. Requires num_devices to be known.
void init_problem()
{
  if(num_devices == 0)
  {
    checkError(-1, "No devices");
  }

  host_img_rgb.reset(num_devices);
  host_img_gray.reset(num_devices);
  
  // ===== Image Properties
  //int width, height, n;
  //unsigned char *img_rgb_object = stbi_load("image.jpg", &width, &height, &n, 0);

  /*if (img_rgb_object == NULL)
  {
      printf("Error in loading the image\n");
      exit(1);
  }*/


  // Generate input vectors A and B and the reference output consisting
  // of a total of N elements.
  // We create separate arrays for each device so that each device has an
  // aligned buffer. 
  for(unsigned i = 0; i < num_devices; ++i)
  {
    host_img_rgb[i].reset(n_per_device[i]);
    host_img_gray[i].reset(n_per_device[i]);
    
    printf("Dados | num_devices = %d | n_per_devices = %d\n", num_devices, n_per_device[i]);
    
    // Popular matriz (512*512 = 262 144)
    for(unsigned j = 0; j < n_per_device[i]; ++j) 
    {
      //printf("Entrou\n");
      
      //printf("Red done\n");
      //host_img_rgb[i][3*j+0] = img_rgb_object[i*n_per_device[i] + (3*j+0)];
      host_img_rgb[i][3*j+0] = rand_char();
      //printf("R = %d\n", host_img_rgb[i][3*j+0]);
      //printf("Green done\n");
      //host_img_rgb[i][3*j+1] = img_rgb_object[i*n_per_device[i] + (3*j+1)];
      host_img_rgb[i][3*j+0] = rand_char();
      //printf("Blue done\n");
      //host_img_rgb[i][3*j+2] = img_rgb_object[i*n_per_device[i] + (3*j+2)];
      host_img_rgb[i][3*j+0] = rand_char();
      //printf("Pixel %d = %d %d %d\n", j, host_img_rgb[i][3*j+0], host_img_rgb[i][3*j+1], host_img_rgb[i][3*j+2]);
      
    }
    
    printf("init_problem function was sucessfull\n");
  }

  //unsigned char *img_gray_object = stbi_load("image.jpg", &width, &height, &n, 0);

  //printf("Size of host_img_rgb[0] = %d\n", sizeof(host_img_rgb[0]));  
}

// This function is used to verify the results.
void run()
{
  printf("Entering run function\n");
  cl_int status;

  const double start_time = getCurrentTimestamp();

  // Launch the problem for each device.
  scoped_array<cl_event> kernel_event(num_devices);
  scoped_array<cl_event> finish_event(num_devices);

  printf("Events launched\n");

  for(unsigned i = 0; i < num_devices; ++i) 
  {
    printf("Entering for\n");

    // Transfer inputs to each device. Each of the host buffers supplied to
    // clEnqueueWriteBuffer here is already aligned to ensure that DMA is used
    // for the host-to-device transfer.
    cl_event write_event[1];
    status = clEnqueueWriteBuffer(queue[i], buffer_img_RGB[i], CL_FALSE, 0, n_per_device[i] * CHANNELS * sizeof(unsigned char), host_img_rgb[i], 0, NULL, &write_event[0]);
    checkError(status, "Failed to transfer input A");

    printf("Inputs transfered\n");

    // Set kernel arguments.
    unsigned argi = 0;

    status = clSetKernelArg(kernel[i], argi++, sizeof(cl_mem), &buffer_img_RGB[i]);
    checkError(status, "Failed to set argument %d", argi - 1);

    status = clSetKernelArg(kernel[i], argi++, sizeof(cl_mem), &buffer_img_GRAY[i]);
    checkError(status, "Failed to set argument %d", argi - 1);

    printf("Argumets setted\n");
    // Enqueue kernel.
    // Use a global work size corresponding to the number of elements to add
    // for this device.
    // 
    // We don't specify a local work size and let the runtime choose
    // (it'll choose to use one work-group with the same size as the global
    // work-size).
    //
    // Events are used to ensure that the kernel is not launched until
    
    size_t global_work_size[1];
    // the writes to the input buffers have completed.
    // const size_t global_work_size[2] = {sqrt(n_per_device[i]),sqrt(n_per_device[i])};
    
    global_work_size[0]=N;
    printf("Launching for device %d (%d elements)\n", i, global_work_size);

    status = clEnqueueNDRangeKernel(queue[i], kernel[i], 1, NULL, 
                                    global_work_size, NULL, 2, write_event, 
                                    &kernel_event[i]); //passe para 0 caso n funcione
    checkError(status, "Failed to launch kernel");

    // Read the result. This the final operation.
    status = clEnqueueReadBuffer(queue[i], buffer_img_GRAY[i], CL_FALSE, 0, 
                                n_per_device[i] * sizeof(unsigned char), 
                                host_img_gray[i], 1, &kernel_event[i], 
                                &finish_event[i]);
  
    // Release local events.
    printf("Releasing local events\n");
    clReleaseEvent(write_event[0]);
  }

  // Wait for all devices to finish.
  clWaitForEvents(num_devices, finish_event);

  const double end_time = getCurrentTimestamp();

  // Wall-clock time taken.
  printf("\nTime: %0.3f ms\n", (end_time - start_time) * 1e3);

  // Get kernel times using the OpenCL event profiling API.
  for(unsigned i = 0; i < num_devices; ++i)
  {
    cl_ulong time_ns = getStartEndTime(kernel_event[i]);
    printf("Kernel time (device %d): %0.3f ms\n", i, double(time_ns) * 1e-6);
  }

  // Release all events.
  for(unsigned i = 0; i < num_devices; ++i)
  {
    clReleaseEvent(kernel_event[i]);
    clReleaseEvent(finish_event[i]);
  }
}

// Free the resources allocated during initialization
void cleanup() {
  for(unsigned i = 0; i < num_devices; ++i) {
    if(kernel && kernel[i]) {
      clReleaseKernel(kernel[i]);
    }
    if(queue && queue[i]) {
      clReleaseCommandQueue(queue[i]);
    }
    if(buffer_img_RGB && buffer_img_RGB[i]) {
      clReleaseMemObject(buffer_img_RGB[i]);
    }
    if(buffer_img_GRAY && buffer_img_GRAY[i]) {
      clReleaseMemObject(buffer_img_GRAY[i]);
    }
  }

  if(program) {
    clReleaseProgram(program);
  }
  if(context) {
    clReleaseContext(context);
  }
}

