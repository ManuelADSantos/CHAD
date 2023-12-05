
kernel void mul_2( global int* A ) {
   size_t gid = get_global_id(0);
   A[gid] *= 2;
}
