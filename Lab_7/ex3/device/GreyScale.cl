// ============================================================================
// Programmer: Manuel Santos 2019231352
// Date: 11/12/2023
// ============================================================================
// Summary: This program performs a grayscale filter on an image using OpenCL.
//
// This file contains the kernel function that performs the filter.
// ============================================================================

__kernel void GreyScale(__global const unsigned char * rgbImage,
						__global unsigned char * grayImage)
{
	// Get index of the worker
	int pixel = get_global_id(0);

	// Perform the grayscale filter on a 512x512 image

	// We multiply by floating point constants
	grayImage[pixel] = rgbImage[3*pixel] * 0.21f + 
						rgbImage[3*pixel+1] * 0.71f + 
						rgbImage[3*pixel+2] * 0.07f; 
	
	// 0.21f*r + 0.71f*g + 0.07f*b;
}
