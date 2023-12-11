__kernel void device_func_name(__global int *device_buffer_1, int *device_buffer_2, int *device_buffer_3, int N)
{
	// Work-item identifier (1 dimensional problem)
	int index=get_global_id(0);
    
	// CODE
	if(index<N)
		device_buffer_3[index]=1234;
    
}





/*
// Work-item identifier (1 dimensional problem)
	int index=get_global_id(0);
    
	// CODE
	if(index<N)
		device_buffer[index]=index*2;

*/
