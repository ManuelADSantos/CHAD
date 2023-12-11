 // ACL kernel for multiply two input vectors
__kernel void vectorMul(__global const float *x, 
                        __global const float *y, 
                        __global float *restrict z)
{
    // get index of the work item
    int index = get_global_id(0);

    // multiply the vector elements
    int i = index / SIZE;
    int j = index % SIZE;
    float value;

    if (i < SIZE)
    {
        value = 0.0;
        for (int k=0; k<SIZE; k++)
            value += x[i*SIZE + k] * y[k*SIZE + j];
        z[i*SIZE + j] = value;
    }
}

