
__kernel void GreyScale(__global unsigned char * grayImage,__global unsigned char
*rgbImage)
{
	int width=1024;
	int height=1024;
	int Row = get_global_id(1);
    	int Col = get_global_id(0);
	if (Col<width && Row<height)
	{
	// get 1D coordinate for the grayscale image
	int greyOffset=Row*width + Col;
	// one can think of the RGB image having
	// CHANNEL times columns of the gray scale image
	int rgbOffset=greyOffset*3;
	unsigned char r=rgbImage[rgbOffset];
	// red value for pixel
	unsigned char g=rgbImage[rgbOffset+1];
	// green value for pixel
	unsigned char b=rgbImage[rgbOffset+2];
	// blue value for pixel
	// perform the rescaling and store it
	// We multiply by floating point constants
	grayImage[greyOffset]=0.21f*r + 0.71f*g + 0.07f*b;
	}
}
