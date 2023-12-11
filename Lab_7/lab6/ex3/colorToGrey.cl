 // ACL kernel for convert a image to grayscale
__kernel void colorToGrey(__global const float *x, 
                        __global float *restrict z)
{
    // get index of the work item
    int index = get_global_id(0);

    // multiply the vector elements
    float value;

    if (index < SIZE)
    {
        int offset = index * 3;
        z[index] = 0.21*x[offset] + 0.71*x[offset + 1] + 0.07*x[offset + 2];
    }
}

