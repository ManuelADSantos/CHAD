
kernel void add_1( global int* A ) {
   size_t gid = get_global_id(0);
   A[gid] += 1;
}
