/* (C) 1992-2014 Altera Corporation. All rights reserved.                          */
/* Your use of Altera Corporation's design tools, logic functions and other        */
/* software and tools, and its AMPP partner logic functions, and any output        */
/* files any of the foregoing (including device programming or simulation          */
/* files), and any associated documentation or information are expressly subject   */
/* to the terms and conditions of the Altera Program License Subscription          */
/* Agreement, Altera MegaCore Function License Agreement, or other applicable      */
/* license agreement, including, without limitation, that your use is for the      */
/* sole purpose of programming logic devices manufactured by Altera and sold by    */
/* Altera or its authorized distributors.  Please refer to the applicable          */
/* agreement for further details.                                                  */
    



void ocl_device_init( cl_platform_id in_platform,
                      cl_device_id in_device,
                      cl_context in_context,
                      cl_command_queue in_queue);
void ocl_kernel_init(const char *kernel_name, const char * cl_file);
void ocl_kernel_run( int n, double *time) ;
void ocl_modify_src( int offset, unsigned val ) ;
void ocl_transfer_src( unsigned int *src, int n) ;
void ocl_transfer_index( unsigned int *index, int n) ;
void ocl_transfer_dst( unsigned int *dst, int n) ;
void ocl_transfer_dum( int n ) ;
