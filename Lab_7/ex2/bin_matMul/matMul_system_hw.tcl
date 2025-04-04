package require -exact qsys 14.0
set_module_property NAME matMul_system
set_module_property VERSION 14.0
set_module_property INTERNAL false
set_module_property GROUP Accelerators
set_module_property DISPLAY_NAME matMul_system
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true

add_interface clock_reset clock end
set_interface_property clock_reset ENABLED true
add_interface_port clock_reset clock clk Input 1
add_interface_port clock_reset resetn reset_n Input 1
add_interface clock_reset2x clock end
set_interface_property clock_reset2x ENABLED true
add_interface_port clock_reset2x clock2x clk Input 1

### SLAVE interface avs_matMul_cra
add_interface avs_matMul_cra avalon end
set_interface_property avs_matMul_cra addressAlignment DYNAMIC
set_interface_property avs_matMul_cra burstOnBurstBoundariesOnly false
set_interface_property avs_matMul_cra explicitAddressSpan 0
set_interface_property avs_matMul_cra holdTime 0
set_interface_property avs_matMul_cra isMemoryDevice false
set_interface_property avs_matMul_cra isNonVolatileStorage false
set_interface_property avs_matMul_cra linewrapBursts false
set_interface_property avs_matMul_cra maximumPendingReadTransactions 1
set_interface_property avs_matMul_cra printableDevice false
set_interface_property avs_matMul_cra readLatency 0
set_interface_property avs_matMul_cra readWaitTime 0
set_interface_property avs_matMul_cra setupTime 0
set_interface_property avs_matMul_cra timingUnits Cycles
set_interface_property avs_matMul_cra writeWaitTime 0
set_interface_property avs_matMul_cra ASSOCIATED_CLOCK clock_reset
set_interface_property avs_matMul_cra ENABLED true
add_interface_port avs_matMul_cra avs_matMul_cra_read read Input 1
add_interface_port avs_matMul_cra avs_matMul_cra_write write Input 1
add_interface_port avs_matMul_cra avs_matMul_cra_address address Input 4
add_interface_port avs_matMul_cra avs_matMul_cra_writedata writedata Input 64
add_interface_port avs_matMul_cra avs_matMul_cra_byteenable byteenable Input 8
add_interface_port avs_matMul_cra avs_matMul_cra_readdata readdata Output 64
add_interface_port avs_matMul_cra avs_matMul_cra_readdata readdata Output 64
add_interface_port avs_matMul_cra avs_matMul_cra_readdatavalid readdatavalid Output 1

### IRQ interface kernel_irq
add_interface kernel_irq interrupt end
set_interface_property kernel_irq associatedClock clock_reset
set_interface_property kernel_irq ASSOCIATED_CLOCK clock_reset
set_interface_property kernel_irq ENABLED true
add_interface_port kernel_irq kernel_irq irq Output 1

### MASTER interface avm_memgmem0_port_0_0_rw with base address 0
add_interface avm_memgmem0_port_0_0_rw avalon start
set_interface_property avm_memgmem0_port_0_0_rw associatedClock clock_reset
set_interface_property avm_memgmem0_port_0_0_rw burstOnBurstBoundariesOnly false
set_interface_property avm_memgmem0_port_0_0_rw doStreamReads false
set_interface_property avm_memgmem0_port_0_0_rw doStreamWrites false
set_interface_property avm_memgmem0_port_0_0_rw linewrapBursts false
set_interface_property avm_memgmem0_port_0_0_rw ASSOCIATED_CLOCK clock_reset
set_interface_property avm_memgmem0_port_0_0_rw ENABLED true
add_interface_port avm_memgmem0_port_0_0_rw avm_memgmem0_port_0_0_rw_address address Output 30
add_interface_port avm_memgmem0_port_0_0_rw avm_memgmem0_port_0_0_rw_read read Output 1
add_interface_port avm_memgmem0_port_0_0_rw avm_memgmem0_port_0_0_rw_write write Output 1
add_interface_port avm_memgmem0_port_0_0_rw avm_memgmem0_port_0_0_rw_burstcount burstcount Output 5
add_interface_port avm_memgmem0_port_0_0_rw avm_memgmem0_port_0_0_rw_writedata writedata Output 256
add_interface_port avm_memgmem0_port_0_0_rw avm_memgmem0_port_0_0_rw_byteenable byteenable Output 32
add_interface_port avm_memgmem0_port_0_0_rw avm_memgmem0_port_0_0_rw_readdata readdata Input 256
add_interface_port avm_memgmem0_port_0_0_rw avm_memgmem0_port_0_0_rw_waitrequest waitrequest Input 1
add_interface_port avm_memgmem0_port_0_0_rw avm_memgmem0_port_0_0_rw_readdatavalid readdatavalid Input 1


add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL matMul_system
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file matMul.v SYSTEM_VERILOG PATH matMul.v TOP_LEVEL_FILE
add_fileset_file matMul_system.v SYSTEM_VERILOG PATH matMul_system.v TOP_LEVEL_FILE
add_fileset_file acl_data_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_data_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_debug_mem.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_debug_mem.v TOP_LEVEL_FILE
add_fileset_file acl_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_id_iterator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_id_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_int_mult.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_int_mult.v TOP_LEVEL_FILE
add_fileset_file acl_kernel_finish_detector.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_kernel_finish_detector.v TOP_LEVEL_FILE
add_fileset_file acl_ll_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ll_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_ll_ram_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ll_ram_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_loop_limiter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_loop_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_multi_fanout_adaptor.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multi_fanout_adaptor.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_accumulator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multistage_accumulator.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_adder.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multistage_adder.v TOP_LEVEL_FILE
add_fileset_file acl_profiler.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_profiler.v TOP_LEVEL_FILE
add_fileset_file acl_shift_register.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_shift_register.v TOP_LEVEL_FILE
add_fileset_file acl_staging_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_staging_reg.v TOP_LEVEL_FILE
add_fileset_file acl_stall_free_sink.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_stall_free_sink.v TOP_LEVEL_FILE
add_fileset_file acl_toggle_detect.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_toggle_detect.v TOP_LEVEL_FILE
add_fileset_file acl_valid_fifo_counter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_valid_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_work_group_dispatcher.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_group_dispatcher.v TOP_LEVEL_FILE
add_fileset_file acl_work_group_limiter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_group_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_work_item_iterator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_item_iterator.v TOP_LEVEL_FILE
add_fileset_file lsu_atomic.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_atomic.v TOP_LEVEL_FILE
add_fileset_file lsu_basic_coalescer.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_basic_coalescer.v TOP_LEVEL_FILE
add_fileset_file lsu_burst_master.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_burst_master.v TOP_LEVEL_FILE
add_fileset_file lsu_bursting_load_stores.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_bursting_load_stores.v TOP_LEVEL_FILE
add_fileset_file lsu_non_aligned_write.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_non_aligned_write.v TOP_LEVEL_FILE
add_fileset_file lsu_pipelined.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_pipelined.v TOP_LEVEL_FILE
add_fileset_file lsu_prefetch_block.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_prefetch_block.v TOP_LEVEL_FILE
add_fileset_file lsu_read_cache.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_read_cache.v TOP_LEVEL_FILE
add_fileset_file lsu_simple.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_simple.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_streaming.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming_prefetch.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_streaming_prefetch.v TOP_LEVEL_FILE
add_fileset_file lsu_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_top.v TOP_LEVEL_FILE
add_fileset_file lsu_wide_wrapper.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_wide_wrapper.v TOP_LEVEL_FILE
add_fileset_file six_three_comp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/six_three_comp.v TOP_LEVEL_FILE
add_fileset_file sv_mult27.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/sv_mult27.v TOP_LEVEL_FILE
add_fileset_file ternary_add.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/ternary_add.v TOP_LEVEL_FILE
add_fileset_file thirtysix_six_comp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/thirtysix_six_comp.v TOP_LEVEL_FILE
add_fileset_file acl_arb2.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_arb2.v TOP_LEVEL_FILE
add_fileset_file acl_arb_intf.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_arb_intf.v TOP_LEVEL_FILE
add_fileset_file acl_avm_to_ic.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_avm_to_ic.v TOP_LEVEL_FILE
add_fileset_file acl_ic_intf.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_intf.v TOP_LEVEL_FILE
add_fileset_file acl_ic_master_endpoint.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_master_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_endpoint.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_rrp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_rrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_wrp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_wrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_rrp_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_rrp_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ic_wrp_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_wrp_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ic_to_avm.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_to_avm.v TOP_LEVEL_FILE
add_fileset_file acl_atomics_nostall.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_atomics_nostall.v TOP_LEVEL_FILE
add_fileset_file acl_atomics_arb_stall.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_atomics_arb_stall.v TOP_LEVEL_FILE
add_fileset_file acl_address_to_bankaddress.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_address_to_bankaddress.v TOP_LEVEL_FILE
add_fileset_file acl_ic_mem_router.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_mem_router.v TOP_LEVEL_FILE
add_fileset_file acl_profiler_extmem.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_profiler_extmem.v TOP_LEVEL_FILE


add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL matMul_system
add_fileset_file matMul.v SYSTEM_VERILOG PATH matMul.v TOP_LEVEL_FILE
add_fileset_file matMul_system.v SYSTEM_VERILOG PATH matMul_system.v TOP_LEVEL_FILE
add_fileset_file acl_data_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_data_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_debug_mem.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_debug_mem.v TOP_LEVEL_FILE
add_fileset_file acl_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_id_iterator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_id_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_int_mult.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_int_mult.v TOP_LEVEL_FILE
add_fileset_file acl_kernel_finish_detector.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_kernel_finish_detector.v TOP_LEVEL_FILE
add_fileset_file acl_ll_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ll_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_ll_ram_fifo.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ll_ram_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_loop_limiter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_loop_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_multi_fanout_adaptor.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multi_fanout_adaptor.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_accumulator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multistage_accumulator.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_adder.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_multistage_adder.v TOP_LEVEL_FILE
add_fileset_file acl_profiler.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_profiler.v TOP_LEVEL_FILE
add_fileset_file acl_shift_register.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_shift_register.v TOP_LEVEL_FILE
add_fileset_file acl_staging_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_staging_reg.v TOP_LEVEL_FILE
add_fileset_file acl_stall_free_sink.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_stall_free_sink.v TOP_LEVEL_FILE
add_fileset_file acl_toggle_detect.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_toggle_detect.v TOP_LEVEL_FILE
add_fileset_file acl_valid_fifo_counter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_valid_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_work_group_dispatcher.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_group_dispatcher.v TOP_LEVEL_FILE
add_fileset_file acl_work_group_limiter.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_group_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_work_item_iterator.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_work_item_iterator.v TOP_LEVEL_FILE
add_fileset_file lsu_atomic.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_atomic.v TOP_LEVEL_FILE
add_fileset_file lsu_basic_coalescer.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_basic_coalescer.v TOP_LEVEL_FILE
add_fileset_file lsu_burst_master.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_burst_master.v TOP_LEVEL_FILE
add_fileset_file lsu_bursting_load_stores.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_bursting_load_stores.v TOP_LEVEL_FILE
add_fileset_file lsu_non_aligned_write.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_non_aligned_write.v TOP_LEVEL_FILE
add_fileset_file lsu_pipelined.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_pipelined.v TOP_LEVEL_FILE
add_fileset_file lsu_prefetch_block.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_prefetch_block.v TOP_LEVEL_FILE
add_fileset_file lsu_read_cache.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_read_cache.v TOP_LEVEL_FILE
add_fileset_file lsu_simple.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_simple.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_streaming.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming_prefetch.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_streaming_prefetch.v TOP_LEVEL_FILE
add_fileset_file lsu_top.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_top.v TOP_LEVEL_FILE
add_fileset_file lsu_wide_wrapper.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/lsu_wide_wrapper.v TOP_LEVEL_FILE
add_fileset_file six_three_comp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/six_three_comp.v TOP_LEVEL_FILE
add_fileset_file sv_mult27.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/sv_mult27.v TOP_LEVEL_FILE
add_fileset_file ternary_add.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/ternary_add.v TOP_LEVEL_FILE
add_fileset_file thirtysix_six_comp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/thirtysix_six_comp.v TOP_LEVEL_FILE
add_fileset_file acl_arb2.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_arb2.v TOP_LEVEL_FILE
add_fileset_file acl_arb_intf.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_arb_intf.v TOP_LEVEL_FILE
add_fileset_file acl_avm_to_ic.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_avm_to_ic.v TOP_LEVEL_FILE
add_fileset_file acl_ic_intf.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_intf.v TOP_LEVEL_FILE
add_fileset_file acl_ic_master_endpoint.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_master_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_endpoint.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_rrp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_rrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_wrp.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_slave_wrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_rrp_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_rrp_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ic_wrp_reg.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_wrp_reg.v TOP_LEVEL_FILE
add_fileset_file acl_ic_to_avm.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_to_avm.v TOP_LEVEL_FILE
add_fileset_file acl_atomics_nostall.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_atomics_nostall.v TOP_LEVEL_FILE
add_fileset_file acl_atomics_arb_stall.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_atomics_arb_stall.v TOP_LEVEL_FILE
add_fileset_file acl_address_to_bankaddress.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_address_to_bankaddress.v TOP_LEVEL_FILE
add_fileset_file acl_ic_mem_router.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_ic_mem_router.v TOP_LEVEL_FILE
add_fileset_file acl_profiler_extmem.v SYSTEM_VERILOG PATH $::env(ALTERAOCLSDKROOT)/ip/acl_profiler_extmem.v TOP_LEVEL_FILE
