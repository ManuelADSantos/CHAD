// (C) 1992-2014 Altera Corporation. All rights reserved.                         
// Your use of Altera Corporation's design tools, logic functions and other       
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Altera MegaCore Function License Agreement, or other applicable     
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Altera and sold by   
// Altera or its authorized distributors.  Please refer to the applicable         
// agreement for further details.                                                 
    

// This host program mimics test 0 in conformance_contractions

#include "CL/opencl.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include "timer.h"

#define NUM_ITERATIONS 6

#define CHECK(X) assert(CL_SUCCESS == (X))
#define BUFSIZE 50

const unsigned char *binary = 0;

cl_platform_id platform;
cl_device_id device;
cl_context context;
cl_command_queue cq;
cl_program first_program;
cl_program second_program;
cl_kernel first_kernel;
cl_kernel second_kernel;

cl_mem mem = 0;

cl_int CL_ALIGNED(128) device_buf[BUFSIZE];
cl_int CL_ALIGNED(128) cpu_buf[BUFSIZE];

void notify_print( const char* errinfo, const void* private_info, size_t cb, void *user_data )
{
   private_info = private_info;
   cb = cb;
   user_data = user_data;
   printf("Error: %s\n", errinfo);
}

unsigned char* load_file(const char* filename,size_t*size_ret)
{
   FILE* fp;
   const size_t CHUNK_SIZE = 1000000;
   unsigned char *result = (unsigned char*)malloc(100000000);
   size_t r = 0;
   size_t w = 0;
   if ( !result )  return 0;
   fp = fopen(filename,"rb");
   if ( !fp ) return 0;
   while ( 0 < (r=fread(result+w,1,CHUNK_SIZE,fp) ) ) { w+=r; }
   fclose(fp);
   *size_ret = w;
   return result;
}

float running_time( cl_event e ) {
   cl_ulong start;
   cl_ulong end;

   CHECK( clGetEventProfilingInfo( e, CL_PROFILING_COMMAND_START, sizeof(start), &start, 0 ) );
   CHECK( clGetEventProfilingInfo( e, CL_PROFILING_COMMAND_END, sizeof(end), &end, 0 ) );

   return (end - start) / 1000000000.0f; // it's in nanoseconds
}

int main(int argc, char**argv) 
{
   cl_int status = 0;
   cl_int bin_status = 0;
   size_t bin_len = 0;
   CHECK( clGetPlatformIDs(1,&platform,0) );
   CHECK( clGetDeviceIDs(platform,CL_DEVICE_TYPE_ACCELERATOR,1,&device,0) );

   cl_event add_1_event[NUM_ITERATIONS];
   cl_event mul_2_event[NUM_ITERATIONS];

   // We're running in "offline" compiler mode by default.
   // So no need to specify special compiler mode properties.
   context = clCreateContext( 0, 1, &device, notify_print, 0, &status );
   CHECK( status );

   cq = clCreateCommandQueue( context, device, 0, &status );
   CHECK( status );

   const unsigned char* first_binary; size_t first_binary_len = 0;
   const unsigned char* second_binary; size_t second_binary_len = 0;

   printf("Loading first.aocx...\n");
   first_binary = load_file("first.aocx",&first_binary_len); 
   printf("Loading second.aocx...\n");
   second_binary = load_file("second.aocx",&second_binary_len); 

   first_program = clCreateProgramWithBinary(context,1,&device,&first_binary_len,&first_binary,&bin_status,&status);
   CHECK(status);
   second_program = clCreateProgramWithBinary(context,1,&device,&second_binary_len,&second_binary,&bin_status,&status);
   CHECK(status);

   printf("build first program\n");
   CHECK( clBuildProgram(first_program,1,&device,"",0,0) );
   printf("build second program\n");
   CHECK( clBuildProgram(second_program,1,&device,"",0,0) );

   printf("create first kernel\n");
   first_kernel = clCreateKernel(first_program,"add_1",&status);
   CHECK(status);
   printf("create second kernel\n");
   second_kernel = clCreateKernel(second_program,"mul_2",&status);
   CHECK(status);

   printf("create buffer\n");
   mem = clCreateBuffer(context,CL_MEM_READ_WRITE,BUFSIZE*sizeof(device_buf[0]),0,&status);
   CHECK(status);

   int num_errs = 0;
   int i;
   for ( i = 0; i < BUFSIZE ; i++ ) {
      device_buf[i] = cpu_buf[i] = i;
   }

   CHECK( clSetKernelArg(first_kernel,0,sizeof(cl_mem),&mem) );
   CHECK( clSetKernelArg(second_kernel,0,sizeof(cl_mem),&mem) );

   CHECK( clEnqueueWriteBuffer(cq,mem,0,0,sizeof(device_buf),device_buf,0,0,0) );

   Timer t;
   t.start();

   int iter;
   for ( iter = 0; iter < NUM_ITERATIONS; iter++ ) {
      size_t dims[3] = { BUFSIZE,0,0 };
      printf("Enqueueing add_1 with 1-d global size %d\n", (int)dims[0] ); fflush(stdout);
      CHECK( clEnqueueNDRangeKernel(cq,first_kernel,1,0,dims,0,0,0,add_1_event+iter) );
      printf("Enqueueing mul_2 with 1-d global size %d\n", (int)dims[0] ); fflush(stdout);
      CHECK( clEnqueueNDRangeKernel(cq,second_kernel,1,0,dims,0,0,0,mul_2_event+iter) );

      printf("Doing CPU work:\n"); fflush(stdout);
      for ( i = 0; i < BUFSIZE; i++ ) {
         cpu_buf[i] += 1;
         cpu_buf[i] *= 2;
      }
   }

   t.stop();

   printf("Reading buf...\n"); fflush(stdout);
   CHECK( clEnqueueReadBuffer(cq,mem,1,0,sizeof(device_buf),device_buf,0,0,0) );
   printf("clFinish...\n"); fflush(stdout);
   CHECK( clFinish(cq) );

   printf("Checking result...\n"); fflush(stdout);
   for ( i = 0; i < BUFSIZE; i++ ) {
      if ( cpu_buf[i] != device_buf[i] ) {
         printf(" FAILED [%d] cpu_buf %d != device_buf %d\n", i, cpu_buf[i], device_buf[i] );
         num_errs++;
      }
   }

   for ( iter = 0; iter < NUM_ITERATIONS; iter++ ) {
      printf("Time for add_1 iteration %d : %.3f\n", iter, running_time( add_1_event[ iter ] ) );
      printf("Time for mul_2 iteration %d : %.3f\n", iter, running_time( mul_2_event[ iter ] ) );
   }

   float reprogram_time = t.get_time_s()/NUM_ITERATIONS/2.0; /* 2 reprograms per iteration */
   printf("Total time = %f s\n",t.get_time_s());
   printf("Time per kernel swap-and-execute = %f s\n",reprogram_time);
   printf("Throughput = %f swap-and-executes/s\n",1.0/reprogram_time);

   for ( iter = 0; iter < NUM_ITERATIONS; iter++ ) {
      clReleaseEvent( add_1_event[ iter ] );
      clReleaseEvent( mul_2_event[ iter ] );
   }
   clReleaseMemObject(mem);
   clReleaseKernel(first_kernel);
   clReleaseKernel(second_kernel);
   clReleaseKernel(first_kernel);
   clReleaseKernel(second_kernel);
   clReleaseProgram(first_program);
   clReleaseProgram(second_program);
   clReleaseContext(context);
   if ( num_errs ) { 
      printf("Done FAILED\n");
   } else {
      printf("Done PASSED\n");
   }

   return 0;
}
