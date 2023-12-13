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
    

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module GreyScale_basic_block_0
	(
		input 		clock,
		input 		resetn,
		input 		start,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_input_global_id_0,
		input [31:0] 		workgroup_size
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in;
 reg merge_node_valid_out_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = (|(merge_node_stall_in & merge_node_valid_out_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_global_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_global_id_0_staging_reg_NO_SHIFT_REG <= input_global_id_0;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in))
			begin
				merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_input_global_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_input_global_id_0 = lvb_input_global_id_0_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_input_global_id_0_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_input_global_id_0_reg_NO_SHIFT_REG <= local_lvm_input_global_id_0_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module GreyScale_basic_block_1
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_grayImage,
		input [63:0] 		input_rgbImage,
		input [31:0] 		input_global_size_0,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdata,
		input 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdatavalid,
		input 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_waitrequest,
		output [29:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_address,
		output 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_read,
		output 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_write,
		input 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writeack,
		output [255:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writedata,
		output [31:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_byteenable,
		output [4:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_burstcount,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_incr,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_extra_unaligned_reqs_cntl,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_stall_cntl,
		output 		local_bb1_ld_memcoalesce_rgbImage_load_0_active,
		input 		clock2x,
		input [255:0] 		avm_local_bb1_st_c0_exe1_readdata,
		input 		avm_local_bb1_st_c0_exe1_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_waitrequest,
		output [29:0] 		avm_local_bb1_st_c0_exe1_address,
		output 		avm_local_bb1_st_c0_exe1_read,
		output 		avm_local_bb1_st_c0_exe1_write,
		input 		avm_local_bb1_st_c0_exe1_writeack,
		output [255:0] 		avm_local_bb1_st_c0_exe1_writedata,
		output [31:0] 		avm_local_bb1_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_burstcount,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb1_st_c0_exe1_profile_bw_incr,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_avm_stall_cntl,
		output 		local_bb1_st_c0_exe1_active
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_global_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_global_id_0_staging_reg_NO_SHIFT_REG <= input_global_id_0;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_var__stall_local;
wire [31:0] local_bb1_var_;

assign local_bb1_var_ = (local_lvm_input_global_id_0_NO_SHIFT_REG << 32'h1);

// Register node:
//  * latency = 193
//  * capacity = 193
 logic rnode_1to194_input_global_id_0_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to194_input_global_id_0_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to194_input_global_id_0_0_NO_SHIFT_REG;
 logic rnode_1to194_input_global_id_0_0_reg_194_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to194_input_global_id_0_0_reg_194_NO_SHIFT_REG;
 logic rnode_1to194_input_global_id_0_0_valid_out_reg_194_NO_SHIFT_REG;
 logic rnode_1to194_input_global_id_0_0_stall_in_reg_194_NO_SHIFT_REG;
 logic rnode_1to194_input_global_id_0_0_stall_out_reg_194_NO_SHIFT_REG;

acl_data_fifo rnode_1to194_input_global_id_0_0_reg_194_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to194_input_global_id_0_0_reg_194_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to194_input_global_id_0_0_stall_in_reg_194_NO_SHIFT_REG),
	.valid_out(rnode_1to194_input_global_id_0_0_valid_out_reg_194_NO_SHIFT_REG),
	.stall_out(rnode_1to194_input_global_id_0_0_stall_out_reg_194_NO_SHIFT_REG),
	.data_in(local_lvm_input_global_id_0_NO_SHIFT_REG),
	.data_out(rnode_1to194_input_global_id_0_0_reg_194_NO_SHIFT_REG)
);

defparam rnode_1to194_input_global_id_0_0_reg_194_fifo.DEPTH = 194;
defparam rnode_1to194_input_global_id_0_0_reg_194_fifo.DATA_WIDTH = 32;
defparam rnode_1to194_input_global_id_0_0_reg_194_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to194_input_global_id_0_0_reg_194_fifo.IMPL = "ram";

assign rnode_1to194_input_global_id_0_0_reg_194_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to194_input_global_id_0_0_stall_out_reg_194_NO_SHIFT_REG;
assign rnode_1to194_input_global_id_0_0_NO_SHIFT_REG = rnode_1to194_input_global_id_0_0_reg_194_NO_SHIFT_REG;
assign rnode_1to194_input_global_id_0_0_stall_in_reg_194_NO_SHIFT_REG = rnode_1to194_input_global_id_0_0_stall_in_NO_SHIFT_REG;
assign rnode_1to194_input_global_id_0_0_valid_out_NO_SHIFT_REG = rnode_1to194_input_global_id_0_0_valid_out_reg_194_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_mul_add62_valid_out;
wire local_bb1_mul_add62_stall_in;
wire local_bb1_mul_add62_inputs_ready;
wire local_bb1_mul_add62_stall_local;
wire [31:0] local_bb1_mul_add62;

assign local_bb1_mul_add62_inputs_ready = (merge_node_valid_out_0_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG);
assign local_bb1_mul_add62 = (local_bb1_var_ + local_lvm_input_global_id_0_NO_SHIFT_REG);
assign local_bb1_mul_add62_valid_out = local_bb1_mul_add62_inputs_ready;
assign local_bb1_mul_add62_stall_local = local_bb1_mul_add62_stall_in;
assign merge_node_stall_in_0 = (local_bb1_mul_add62_stall_local | ~(local_bb1_mul_add62_inputs_ready));
assign merge_node_stall_in_1 = (local_bb1_mul_add62_stall_local | ~(local_bb1_mul_add62_inputs_ready));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_194to195_input_global_id_0_0_valid_out_NO_SHIFT_REG;
 logic rnode_194to195_input_global_id_0_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_194to195_input_global_id_0_0_NO_SHIFT_REG;
 logic rnode_194to195_input_global_id_0_0_reg_195_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_194to195_input_global_id_0_0_reg_195_NO_SHIFT_REG;
 logic rnode_194to195_input_global_id_0_0_valid_out_reg_195_NO_SHIFT_REG;
 logic rnode_194to195_input_global_id_0_0_stall_in_reg_195_NO_SHIFT_REG;
 logic rnode_194to195_input_global_id_0_0_stall_out_reg_195_NO_SHIFT_REG;

acl_data_fifo rnode_194to195_input_global_id_0_0_reg_195_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_194to195_input_global_id_0_0_reg_195_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_194to195_input_global_id_0_0_stall_in_reg_195_NO_SHIFT_REG),
	.valid_out(rnode_194to195_input_global_id_0_0_valid_out_reg_195_NO_SHIFT_REG),
	.stall_out(rnode_194to195_input_global_id_0_0_stall_out_reg_195_NO_SHIFT_REG),
	.data_in(rnode_1to194_input_global_id_0_0_NO_SHIFT_REG),
	.data_out(rnode_194to195_input_global_id_0_0_reg_195_NO_SHIFT_REG)
);

defparam rnode_194to195_input_global_id_0_0_reg_195_fifo.DEPTH = 2;
defparam rnode_194to195_input_global_id_0_0_reg_195_fifo.DATA_WIDTH = 32;
defparam rnode_194to195_input_global_id_0_0_reg_195_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_194to195_input_global_id_0_0_reg_195_fifo.IMPL = "ll_reg";

assign rnode_194to195_input_global_id_0_0_reg_195_inputs_ready_NO_SHIFT_REG = rnode_1to194_input_global_id_0_0_valid_out_NO_SHIFT_REG;
assign rnode_1to194_input_global_id_0_0_stall_in_NO_SHIFT_REG = rnode_194to195_input_global_id_0_0_stall_out_reg_195_NO_SHIFT_REG;
assign rnode_194to195_input_global_id_0_0_NO_SHIFT_REG = rnode_194to195_input_global_id_0_0_reg_195_NO_SHIFT_REG;
assign rnode_194to195_input_global_id_0_0_stall_in_reg_195_NO_SHIFT_REG = rnode_194to195_input_global_id_0_0_stall_in_NO_SHIFT_REG;
assign rnode_194to195_input_global_id_0_0_valid_out_NO_SHIFT_REG = rnode_194to195_input_global_id_0_0_valid_out_reg_195_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb1_mul_add62_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb1_mul_add62_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG;
 logic rnode_1to2_bb1_mul_add62_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb1_mul_add62_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_mul_add62_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_mul_add62_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_mul_add62_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb1_mul_add62_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb1_mul_add62_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb1_mul_add62_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb1_mul_add62_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb1_mul_add62_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb1_mul_add62),
	.data_out(rnode_1to2_bb1_mul_add62_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb1_mul_add62_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb1_mul_add62_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb1_mul_add62_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb1_mul_add62_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb1_mul_add62_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb1_mul_add62_valid_out;
assign local_bb1_mul_add62_stall_in = rnode_1to2_bb1_mul_add62_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG = rnode_1to2_bb1_mul_add62_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_mul_add62_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_bb1_mul_add62_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_bb1_mul_add62_0_valid_out_NO_SHIFT_REG = rnode_1to2_bb1_mul_add62_0_valid_out_reg_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_idxprom20_stall_local;
wire [63:0] local_bb1_idxprom20;

assign local_bb1_idxprom20[32] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[33] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[34] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[35] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[36] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[37] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[38] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[39] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[40] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[41] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[42] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[43] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[44] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[45] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[46] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[47] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[48] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[49] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[50] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[51] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[52] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[53] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[54] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[55] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[56] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[57] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[58] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[59] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[60] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[61] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[62] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[63] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom20[31:0] = rnode_194to195_input_global_id_0_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_idxprom_stall_local;
wire [63:0] local_bb1_idxprom;

assign local_bb1_idxprom[32] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[33] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[34] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[35] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[36] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[37] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[38] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[39] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[40] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[41] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[42] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[43] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[44] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[45] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[46] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[47] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[48] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[49] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[50] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[51] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[52] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[53] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[54] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[55] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[56] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[57] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[58] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[59] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[60] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[61] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[62] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[63] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG[31];
assign local_bb1_idxprom[31:0] = rnode_1to2_bb1_mul_add62_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx21_valid_out;
wire local_bb1_arrayidx21_stall_in;
wire local_bb1_arrayidx21_inputs_ready;
wire local_bb1_arrayidx21_stall_local;
wire [63:0] local_bb1_arrayidx21;

assign local_bb1_arrayidx21_inputs_ready = rnode_194to195_input_global_id_0_0_valid_out_NO_SHIFT_REG;
assign local_bb1_arrayidx21 = (input_grayImage + local_bb1_idxprom20);
assign local_bb1_arrayidx21_valid_out = local_bb1_arrayidx21_inputs_ready;
assign local_bb1_arrayidx21_stall_local = local_bb1_arrayidx21_stall_in;
assign rnode_194to195_input_global_id_0_0_stall_in_NO_SHIFT_REG = (|local_bb1_arrayidx21_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx_stall_local;
wire [63:0] local_bb1_arrayidx;

assign local_bb1_arrayidx = (input_rgbImage + local_bb1_idxprom);

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_rgbImage_bitcast_0_valid_out;
wire local_bb1_memcoalesce_rgbImage_bitcast_0_stall_in;
wire local_bb1_memcoalesce_rgbImage_bitcast_0_inputs_ready;
wire local_bb1_memcoalesce_rgbImage_bitcast_0_stall_local;
wire [63:0] local_bb1_memcoalesce_rgbImage_bitcast_0;

assign local_bb1_memcoalesce_rgbImage_bitcast_0_inputs_ready = rnode_1to2_bb1_mul_add62_0_valid_out_NO_SHIFT_REG;
assign local_bb1_memcoalesce_rgbImage_bitcast_0 = local_bb1_arrayidx;
assign local_bb1_memcoalesce_rgbImage_bitcast_0_valid_out = local_bb1_memcoalesce_rgbImage_bitcast_0_inputs_ready;
assign local_bb1_memcoalesce_rgbImage_bitcast_0_stall_local = local_bb1_memcoalesce_rgbImage_bitcast_0_stall_in;
assign rnode_1to2_bb1_mul_add62_0_stall_in_NO_SHIFT_REG = (|local_bb1_memcoalesce_rgbImage_bitcast_0_stall_local);

// This section implements a registered operation.
// 
wire local_bb1_ld_memcoalesce_rgbImage_load_0_inputs_ready;
 reg local_bb1_ld_memcoalesce_rgbImage_load_0_valid_out_NO_SHIFT_REG;
wire local_bb1_ld_memcoalesce_rgbImage_load_0_stall_in;
wire local_bb1_ld_memcoalesce_rgbImage_load_0_output_regs_ready;
wire local_bb1_ld_memcoalesce_rgbImage_load_0_fu_stall_out;
wire local_bb1_ld_memcoalesce_rgbImage_load_0_fu_valid_out;
wire [31:0] local_bb1_ld_memcoalesce_rgbImage_load_0_lsu_dataout;
 reg [31:0] local_bb1_ld_memcoalesce_rgbImage_load_0_NO_SHIFT_REG;
wire local_bb1_ld_memcoalesce_rgbImage_load_0_causedstall;

lsu_top lsu_local_bb1_ld_memcoalesce_rgbImage_load_0 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_ld_memcoalesce_rgbImage_load_0_fu_stall_out),
	.i_valid(local_bb1_ld_memcoalesce_rgbImage_load_0_inputs_ready),
	.i_address(local_bb1_memcoalesce_rgbImage_bitcast_0),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(1'b0),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_ld_memcoalesce_rgbImage_load_0_output_regs_ready)),
	.o_valid(local_bb1_ld_memcoalesce_rgbImage_load_0_fu_valid_out),
	.o_readdata(local_bb1_ld_memcoalesce_rgbImage_load_0_lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_ld_memcoalesce_rgbImage_load_0_active),
	.avm_address(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_address),
	.avm_read(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_read),
	.avm_readdata(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdata),
	.avm_write(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_write),
	.avm_writeack(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writeack),
	.avm_burstcount(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_burstcount),
	.avm_writedata(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writedata),
	.avm_byteenable(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_byteenable),
	.avm_waitrequest(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_waitrequest),
	.avm_readdatavalid(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdatavalid),
	.profile_bw(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_cntl),
	.profile_bw_incr(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_incr),
	.profile_total_ivalid(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_total_ivalid_cntl),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_readwrite_count_cntl),
	.profile_avm_burstcount_total(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_cntl),
	.profile_avm_burstcount_total_incr(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_incr),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_extra_unaligned_reqs_cntl),
	.profile_avm_stall(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_stall_cntl)
);

defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.AWIDTH = 30;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.WIDTH_BYTES = 4;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.ALIGNMENT_BYTES = 1;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.READ = 1;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.ATOMIC = 0;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.WIDTH = 32;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.MWIDTH = 256;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.MEMORY_SIDE_MEM_LATENCY = 57;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.NUMBER_BANKS = 1;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.USEINPUTFIFO = 0;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.USECACHING = 0;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.HIGH_FMAX = 1;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.ACL_PROFILE = 1;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.ACL_PROFILE_INCREMENT_WIDTH = 32;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.ADDRSPACE = 1;
defparam lsu_local_bb1_ld_memcoalesce_rgbImage_load_0.STYLE = "BURST-NON-ALIGNED";

assign local_bb1_ld_memcoalesce_rgbImage_load_0_inputs_ready = local_bb1_memcoalesce_rgbImage_bitcast_0_valid_out;
assign local_bb1_ld_memcoalesce_rgbImage_load_0_output_regs_ready = (&(~(local_bb1_ld_memcoalesce_rgbImage_load_0_valid_out_NO_SHIFT_REG) | ~(local_bb1_ld_memcoalesce_rgbImage_load_0_stall_in)));
assign local_bb1_memcoalesce_rgbImage_bitcast_0_stall_in = (local_bb1_ld_memcoalesce_rgbImage_load_0_fu_stall_out | ~(local_bb1_ld_memcoalesce_rgbImage_load_0_inputs_ready));
assign local_bb1_ld_memcoalesce_rgbImage_load_0_causedstall = (local_bb1_ld_memcoalesce_rgbImage_load_0_inputs_ready && (local_bb1_ld_memcoalesce_rgbImage_load_0_fu_stall_out && !(~(local_bb1_ld_memcoalesce_rgbImage_load_0_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_ld_memcoalesce_rgbImage_load_0_NO_SHIFT_REG <= 'x;
		local_bb1_ld_memcoalesce_rgbImage_load_0_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_ld_memcoalesce_rgbImage_load_0_output_regs_ready)
		begin
			local_bb1_ld_memcoalesce_rgbImage_load_0_NO_SHIFT_REG <= local_bb1_ld_memcoalesce_rgbImage_load_0_lsu_dataout;
			local_bb1_ld_memcoalesce_rgbImage_load_0_valid_out_NO_SHIFT_REG <= local_bb1_ld_memcoalesce_rgbImage_load_0_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_ld_memcoalesce_rgbImage_load_0_stall_in))
			begin
				local_bb1_ld_memcoalesce_rgbImage_load_0_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_valid_out;
wire rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_stall_in;
wire rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_inputs_ready;
wire rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_stall_local;
 reg rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_valid_NO_SHIFT_REG;
wire rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_combined_valid;
 reg [31:0] rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0;

assign rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_inputs_ready = local_bb1_ld_memcoalesce_rgbImage_load_0_valid_out_NO_SHIFT_REG;
assign rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0 = (rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_valid_NO_SHIFT_REG ? rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_reg_NO_SHIFT_REG : local_bb1_ld_memcoalesce_rgbImage_load_0_NO_SHIFT_REG);
assign rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_combined_valid = (rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_valid_NO_SHIFT_REG | rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_inputs_ready);
assign rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_valid_out = rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_combined_valid;
assign rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_stall_local = rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_stall_in;
assign local_bb1_ld_memcoalesce_rgbImage_load_0_stall_in = (|rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_stall_local)
		begin
			if (~(rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_valid_NO_SHIFT_REG))
			begin
				rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_valid_NO_SHIFT_REG <= rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_inputs_ready;
			end
		end
		else
		begin
			rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_valid_NO_SHIFT_REG))
		begin
			rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_staging_reg_NO_SHIFT_REG <= local_bb1_ld_memcoalesce_rgbImage_load_0_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni1_valid_out;
wire local_bb1_c0_eni1_stall_in;
wire local_bb1_c0_eni1_inputs_ready;
wire local_bb1_c0_eni1_stall_local;
wire [39:0] local_bb1_c0_eni1;

assign local_bb1_c0_eni1_inputs_ready = rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_valid_out;
assign local_bb1_c0_eni1[7:0] = 8'bxxxxxxxx;
assign local_bb1_c0_eni1[39:8] = rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0;
assign local_bb1_c0_eni1_valid_out = local_bb1_c0_eni1_inputs_ready;
assign local_bb1_c0_eni1_stall_local = local_bb1_c0_eni1_stall_in;
assign rstag_162to162_bb1_ld_memcoalesce_rgbImage_load_0_stall_in = (|local_bb1_c0_eni1_stall_local);

// This section implements a registered operation.
// 
wire local_bb1_c0_enter_c0_eni1_inputs_ready;
 reg local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni1_stall_in;
wire local_bb1_c0_enter_c0_eni1_output_regs_ready;
 reg [39:0] local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni1_input_accepted;
wire local_bb1_c0_exit_c0_exi1_entry_stall;
wire local_bb1_c0_exit_c0_exi1_output_regs_ready;
wire [28:0] local_bb1_c0_exit_c0_exi1_valid_bits;
wire local_bb1_c0_exit_c0_exi1_phases;
wire local_bb1_c0_enter_c0_eni1_inc_pipelined_thread;
wire local_bb1_c0_enter_c0_eni1_dec_pipelined_thread;
wire local_bb1_c0_enter_c0_eni1_causedstall;

assign local_bb1_c0_enter_c0_eni1_inputs_ready = local_bb1_c0_eni1_valid_out;
assign local_bb1_c0_enter_c0_eni1_output_regs_ready = 1'b1;
assign local_bb1_c0_enter_c0_eni1_input_accepted = (local_bb1_c0_enter_c0_eni1_inputs_ready && !(local_bb1_c0_exit_c0_exi1_entry_stall));
assign local_bb1_c0_enter_c0_eni1_inc_pipelined_thread = 1'b1;
assign local_bb1_c0_enter_c0_eni1_dec_pipelined_thread = ~(1'b0);
assign local_bb1_c0_eni1_stall_in = ((~(local_bb1_c0_enter_c0_eni1_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) | ~(1'b1));
assign local_bb1_c0_enter_c0_eni1_causedstall = (1'b1 && ((~(local_bb1_c0_enter_c0_eni1_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG <= 'x;
		local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_enter_c0_eni1_output_regs_ready)
		begin
			local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG <= local_bb1_c0_eni1;
			local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_c0_enter_c0_eni1_stall_in))
			begin
				local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene1_stall_local;
wire [31:0] local_bb1_c0_ene1;

assign local_bb1_c0_ene1 = local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG[39:8];

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_rgbImage_extrValue_0_stall_local;
wire [7:0] local_bb1_memcoalesce_rgbImage_extrValue_0;

assign local_bb1_memcoalesce_rgbImage_extrValue_0 = local_bb1_c0_ene1[7:0];

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_rgbImage_extrValue_1_stall_local;
wire [7:0] local_bb1_memcoalesce_rgbImage_extrValue_1;

assign local_bb1_memcoalesce_rgbImage_extrValue_1 = local_bb1_c0_ene1[15:8];

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_rgbImage_extrValue_2_stall_local;
wire [7:0] local_bb1_memcoalesce_rgbImage_extrValue_2;

assign local_bb1_memcoalesce_rgbImage_extrValue_2 = local_bb1_c0_ene1[23:16];

// This section implements an unregistered operation.
// 
wire local_bb1_conv1_stall_local;
wire [31:0] local_bb1_conv1;

assign local_bb1_conv1[31:8] = 24'h0;
assign local_bb1_conv1[7:0] = local_bb1_memcoalesce_rgbImage_extrValue_0;

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_rgbImage_extrValue_2_valid_out;
wire local_bb1_memcoalesce_rgbImage_extrValue_2_stall_in;
 reg local_bb1_memcoalesce_rgbImage_extrValue_2_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv1_valid_out;
wire local_bb1_conv1_stall_in;
 reg local_bb1_conv1_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv7_valid_out;
wire local_bb1_conv7_stall_in;
 reg local_bb1_conv7_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv7_inputs_ready;
wire local_bb1_conv7_stall_local;
wire [31:0] local_bb1_conv7;

assign local_bb1_conv7_inputs_ready = local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG;
assign local_bb1_conv7[31:8] = 24'h0;
assign local_bb1_conv7[7:0] = local_bb1_memcoalesce_rgbImage_extrValue_1;
assign local_bb1_memcoalesce_rgbImage_extrValue_2_valid_out = 1'b1;
assign local_bb1_conv1_valid_out = 1'b1;
assign local_bb1_conv7_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni1_stall_in = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_memcoalesce_rgbImage_extrValue_2_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv1_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv7_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_memcoalesce_rgbImage_extrValue_2_consumed_0_NO_SHIFT_REG <= (local_bb1_conv7_inputs_ready & (local_bb1_memcoalesce_rgbImage_extrValue_2_consumed_0_NO_SHIFT_REG | ~(local_bb1_memcoalesce_rgbImage_extrValue_2_stall_in)) & local_bb1_conv7_stall_local);
		local_bb1_conv1_consumed_0_NO_SHIFT_REG <= (local_bb1_conv7_inputs_ready & (local_bb1_conv1_consumed_0_NO_SHIFT_REG | ~(local_bb1_conv1_stall_in)) & local_bb1_conv7_stall_local);
		local_bb1_conv7_consumed_0_NO_SHIFT_REG <= (local_bb1_conv7_inputs_ready & (local_bb1_conv7_consumed_0_NO_SHIFT_REG | ~(local_bb1_conv7_stall_in)) & local_bb1_conv7_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_NO_SHIFT_REG;
 logic rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_NO_SHIFT_REG;
 logic rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb1_memcoalesce_rgbImage_extrValue_2),
	.data_out(rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_fifo.DEPTH = 1;
defparam rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_fifo.DATA_WIDTH = 8;
defparam rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_fifo.IMPL = "shift_reg";

assign rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_memcoalesce_rgbImage_extrValue_2_stall_in = 1'b0;
assign rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_NO_SHIFT_REG = rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_reg_164_NO_SHIFT_REG = 1'b0;
assign rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_conv2_inputs_ready;
 reg local_bb1_conv2_valid_out_NO_SHIFT_REG;
wire local_bb1_conv2_stall_in;
wire local_bb1_conv2_output_regs_ready;
wire [31:0] local_bb1_conv2;
 reg local_bb1_conv2_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_conv2_valid_pipe_1_NO_SHIFT_REG;
 reg local_bb1_conv2_valid_pipe_2_NO_SHIFT_REG;
 reg local_bb1_conv2_valid_pipe_3_NO_SHIFT_REG;
 reg local_bb1_conv2_valid_pipe_4_NO_SHIFT_REG;
wire local_bb1_conv2_causedstall;

acl_fp_sitofp fp_module_local_bb1_conv2 (
	.clock(clock),
	.dataa(local_bb1_conv1),
	.enable(local_bb1_conv2_output_regs_ready),
	.result(local_bb1_conv2)
);


assign local_bb1_conv2_inputs_ready = 1'b1;
assign local_bb1_conv2_output_regs_ready = 1'b1;
assign local_bb1_conv1_stall_in = 1'b0;
assign local_bb1_conv2_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv2_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv2_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv2_valid_pipe_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv2_valid_pipe_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv2_valid_pipe_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv2_output_regs_ready)
		begin
			local_bb1_conv2_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_conv2_valid_pipe_1_NO_SHIFT_REG <= local_bb1_conv2_valid_pipe_0_NO_SHIFT_REG;
			local_bb1_conv2_valid_pipe_2_NO_SHIFT_REG <= local_bb1_conv2_valid_pipe_1_NO_SHIFT_REG;
			local_bb1_conv2_valid_pipe_3_NO_SHIFT_REG <= local_bb1_conv2_valid_pipe_2_NO_SHIFT_REG;
			local_bb1_conv2_valid_pipe_4_NO_SHIFT_REG <= local_bb1_conv2_valid_pipe_3_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv2_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv2_output_regs_ready)
		begin
			local_bb1_conv2_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_conv2_stall_in))
			begin
				local_bb1_conv2_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_conv8_inputs_ready;
 reg local_bb1_conv8_valid_out_NO_SHIFT_REG;
wire local_bb1_conv8_stall_in;
wire local_bb1_conv8_output_regs_ready;
wire [31:0] local_bb1_conv8;
 reg local_bb1_conv8_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_conv8_valid_pipe_1_NO_SHIFT_REG;
 reg local_bb1_conv8_valid_pipe_2_NO_SHIFT_REG;
 reg local_bb1_conv8_valid_pipe_3_NO_SHIFT_REG;
 reg local_bb1_conv8_valid_pipe_4_NO_SHIFT_REG;
wire local_bb1_conv8_causedstall;

acl_fp_sitofp fp_module_local_bb1_conv8 (
	.clock(clock),
	.dataa(local_bb1_conv7),
	.enable(local_bb1_conv8_output_regs_ready),
	.result(local_bb1_conv8)
);


assign local_bb1_conv8_inputs_ready = 1'b1;
assign local_bb1_conv8_output_regs_ready = 1'b1;
assign local_bb1_conv7_stall_in = 1'b0;
assign local_bb1_conv8_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv8_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv8_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv8_valid_pipe_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv8_valid_pipe_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv8_valid_pipe_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv8_output_regs_ready)
		begin
			local_bb1_conv8_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_conv8_valid_pipe_1_NO_SHIFT_REG <= local_bb1_conv8_valid_pipe_0_NO_SHIFT_REG;
			local_bb1_conv8_valid_pipe_2_NO_SHIFT_REG <= local_bb1_conv8_valid_pipe_1_NO_SHIFT_REG;
			local_bb1_conv8_valid_pipe_3_NO_SHIFT_REG <= local_bb1_conv8_valid_pipe_2_NO_SHIFT_REG;
			local_bb1_conv8_valid_pipe_4_NO_SHIFT_REG <= local_bb1_conv8_valid_pipe_3_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv8_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv8_output_regs_ready)
		begin
			local_bb1_conv8_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_conv8_stall_in))
			begin
				local_bb1_conv8_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 5
//  * capacity = 5
 logic rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_NO_SHIFT_REG;
 logic rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_NO_SHIFT_REG;
 logic rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_NO_SHIFT_REG),
	.data_out(rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_fifo.DEPTH = 5;
defparam rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_fifo.DATA_WIDTH = 8;
defparam rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_163to164_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_NO_SHIFT_REG = rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_169_NO_SHIFT_REG;
assign rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u0_stall_local;
wire [31:0] local_bb1_var__u0;

assign local_bb1_var__u0 = local_bb1_conv2;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u1_stall_local;
wire [31:0] local_bb1_var__u1;

assign local_bb1_var__u1 = local_bb1_conv8;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [7:0] rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_fifo.DATA_WIDTH = 8;
defparam rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_164to169_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_NO_SHIFT_REG = rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_stall_local;
wire [31:0] local_bb1_shr_i;

assign local_bb1_shr_i = (local_bb1_var__u0 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_and4_i_stall_local;
wire [31:0] local_bb1_and4_i;

assign local_bb1_and4_i = (local_bb1_var__u0 & 32'h80000000);

// This section implements an unregistered operation.
// 
wire local_bb1_and5_i_stall_local;
wire [31:0] local_bb1_and5_i;

assign local_bb1_and5_i = (local_bb1_var__u0 & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i282_stall_local;
wire [31:0] local_bb1_shr_i282;

assign local_bb1_shr_i282 = (local_bb1_var__u1 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_and4_i285_stall_local;
wire [31:0] local_bb1_and4_i285;

assign local_bb1_and4_i285 = (local_bb1_var__u1 & 32'h80000000);

// This section implements an unregistered operation.
// 
wire local_bb1_and5_i286_stall_local;
wire [31:0] local_bb1_and5_i286;

assign local_bb1_and5_i286 = (local_bb1_var__u1 & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_conv15_valid_out;
wire local_bb1_conv15_stall_in;
wire local_bb1_conv15_inputs_ready;
wire local_bb1_conv15_stall_local;
wire [31:0] local_bb1_conv15;

assign local_bb1_conv15_inputs_ready = rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_valid_out_NO_SHIFT_REG;
assign local_bb1_conv15[31:8] = 24'h0;
assign local_bb1_conv15[7:0] = rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_NO_SHIFT_REG;
assign local_bb1_conv15_valid_out = 1'b1;
assign rnode_169to170_bb1_memcoalesce_rgbImage_extrValue_2_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_lnot14_not_i_stall_local;
wire local_bb1_lnot14_not_i;

assign local_bb1_lnot14_not_i = (local_bb1_and5_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i_stall_local;
wire [31:0] local_bb1_or_i;

assign local_bb1_or_i = (local_bb1_and5_i | 32'h800000);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot14_not_i297_stall_local;
wire local_bb1_lnot14_not_i297;

assign local_bb1_lnot14_not_i297 = (local_bb1_and5_i286 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i300_stall_local;
wire [31:0] local_bb1_or_i300;

assign local_bb1_or_i300 = (local_bb1_and5_i286 | 32'h800000);

// This section implements a registered operation.
// 
wire local_bb1_conv16_inputs_ready;
 reg local_bb1_conv16_valid_out_NO_SHIFT_REG;
wire local_bb1_conv16_stall_in;
wire local_bb1_conv16_output_regs_ready;
wire [31:0] local_bb1_conv16;
 reg local_bb1_conv16_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_conv16_valid_pipe_1_NO_SHIFT_REG;
 reg local_bb1_conv16_valid_pipe_2_NO_SHIFT_REG;
 reg local_bb1_conv16_valid_pipe_3_NO_SHIFT_REG;
 reg local_bb1_conv16_valid_pipe_4_NO_SHIFT_REG;
wire local_bb1_conv16_causedstall;

acl_fp_sitofp fp_module_local_bb1_conv16 (
	.clock(clock),
	.dataa(local_bb1_conv15),
	.enable(local_bb1_conv16_output_regs_ready),
	.result(local_bb1_conv16)
);


assign local_bb1_conv16_inputs_ready = 1'b1;
assign local_bb1_conv16_output_regs_ready = 1'b1;
assign local_bb1_conv15_stall_in = 1'b0;
assign local_bb1_conv16_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv16_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv16_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv16_valid_pipe_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv16_valid_pipe_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv16_valid_pipe_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv16_output_regs_ready)
		begin
			local_bb1_conv16_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_conv16_valid_pipe_1_NO_SHIFT_REG <= local_bb1_conv16_valid_pipe_0_NO_SHIFT_REG;
			local_bb1_conv16_valid_pipe_2_NO_SHIFT_REG <= local_bb1_conv16_valid_pipe_1_NO_SHIFT_REG;
			local_bb1_conv16_valid_pipe_3_NO_SHIFT_REG <= local_bb1_conv16_valid_pipe_2_NO_SHIFT_REG;
			local_bb1_conv16_valid_pipe_4_NO_SHIFT_REG <= local_bb1_conv16_valid_pipe_3_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv16_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv16_output_regs_ready)
		begin
			local_bb1_conv16_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_conv16_stall_in))
			begin
				local_bb1_conv16_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_valid_out;
wire local_bb1_shr_i_stall_in;
 reg local_bb1_shr_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_and4_i_valid_out;
wire local_bb1_and4_i_stall_in;
 reg local_bb1_and4_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_lnot14_not_i_valid_out;
wire local_bb1_lnot14_not_i_stall_in;
 reg local_bb1_lnot14_not_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv_i_i_valid_out;
wire local_bb1_conv_i_i_stall_in;
 reg local_bb1_conv_i_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv_i_i_inputs_ready;
wire local_bb1_conv_i_i_stall_local;
wire [63:0] local_bb1_conv_i_i;

assign local_bb1_conv_i_i_inputs_ready = local_bb1_conv2_valid_out_NO_SHIFT_REG;
assign local_bb1_conv_i_i[63:32] = 32'h0;
assign local_bb1_conv_i_i[31:0] = local_bb1_or_i;
assign local_bb1_shr_i_valid_out = 1'b1;
assign local_bb1_and4_i_valid_out = 1'b1;
assign local_bb1_lnot14_not_i_valid_out = 1'b1;
assign local_bb1_conv_i_i_valid_out = 1'b1;
assign local_bb1_conv2_stall_in = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_shr_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and4_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_lnot14_not_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv_i_i_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_shr_i_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i_inputs_ready & (local_bb1_shr_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_shr_i_stall_in)) & local_bb1_conv_i_i_stall_local);
		local_bb1_and4_i_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i_inputs_ready & (local_bb1_and4_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and4_i_stall_in)) & local_bb1_conv_i_i_stall_local);
		local_bb1_lnot14_not_i_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i_inputs_ready & (local_bb1_lnot14_not_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_lnot14_not_i_stall_in)) & local_bb1_conv_i_i_stall_local);
		local_bb1_conv_i_i_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i_inputs_ready & (local_bb1_conv_i_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_conv_i_i_stall_in)) & local_bb1_conv_i_i_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_shr_i282_valid_out;
wire local_bb1_shr_i282_stall_in;
 reg local_bb1_shr_i282_consumed_0_NO_SHIFT_REG;
wire local_bb1_and4_i285_valid_out;
wire local_bb1_and4_i285_stall_in;
 reg local_bb1_and4_i285_consumed_0_NO_SHIFT_REG;
wire local_bb1_lnot14_not_i297_valid_out;
wire local_bb1_lnot14_not_i297_stall_in;
 reg local_bb1_lnot14_not_i297_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv_i_i301_valid_out;
wire local_bb1_conv_i_i301_stall_in;
 reg local_bb1_conv_i_i301_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv_i_i301_inputs_ready;
wire local_bb1_conv_i_i301_stall_local;
wire [63:0] local_bb1_conv_i_i301;

assign local_bb1_conv_i_i301_inputs_ready = local_bb1_conv8_valid_out_NO_SHIFT_REG;
assign local_bb1_conv_i_i301[63:32] = 32'h0;
assign local_bb1_conv_i_i301[31:0] = local_bb1_or_i300;
assign local_bb1_shr_i282_valid_out = 1'b1;
assign local_bb1_and4_i285_valid_out = 1'b1;
assign local_bb1_lnot14_not_i297_valid_out = 1'b1;
assign local_bb1_conv_i_i301_valid_out = 1'b1;
assign local_bb1_conv8_stall_in = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_shr_i282_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and4_i285_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_lnot14_not_i297_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv_i_i301_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_shr_i282_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i301_inputs_ready & (local_bb1_shr_i282_consumed_0_NO_SHIFT_REG | ~(local_bb1_shr_i282_stall_in)) & local_bb1_conv_i_i301_stall_local);
		local_bb1_and4_i285_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i301_inputs_ready & (local_bb1_and4_i285_consumed_0_NO_SHIFT_REG | ~(local_bb1_and4_i285_stall_in)) & local_bb1_conv_i_i301_stall_local);
		local_bb1_lnot14_not_i297_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i301_inputs_ready & (local_bb1_lnot14_not_i297_consumed_0_NO_SHIFT_REG | ~(local_bb1_lnot14_not_i297_stall_in)) & local_bb1_conv_i_i301_stall_local);
		local_bb1_conv_i_i301_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i301_inputs_ready & (local_bb1_conv_i_i301_consumed_0_NO_SHIFT_REG | ~(local_bb1_conv_i_i301_stall_in)) & local_bb1_conv_i_i301_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_var__u2_stall_local;
wire [31:0] local_bb1_var__u2;

assign local_bb1_var__u2 = local_bb1_conv16;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1_shr_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb1_shr_i_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb1_shr_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1_shr_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1_shr_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1_shr_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1_shr_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1_shr_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_shr_i),
	.data_out(rnode_169to171_bb1_shr_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1_shr_i_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1_shr_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_169to171_bb1_shr_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1_shr_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1_shr_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr_i_stall_in = 1'b0;
assign rnode_169to171_bb1_shr_i_0_NO_SHIFT_REG = rnode_169to171_bb1_shr_i_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1_shr_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1_shr_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_and4_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and4_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and4_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_and4_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_and4_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_and4_i_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_and4_i_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_and4_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_and4_i),
	.data_out(rnode_169to170_bb1_and4_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_and4_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_and4_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1_and4_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_and4_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_and4_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and4_i_stall_in = 1'b0;
assign rnode_169to170_bb1_and4_i_0_NO_SHIFT_REG = rnode_169to170_bb1_and4_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_and4_i_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and4_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_lnot14_not_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_lnot14_not_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_lnot14_not_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_lnot14_not_i_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_lnot14_not_i_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_lnot14_not_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_lnot14_not_i),
	.data_out(rnode_169to170_bb1_lnot14_not_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_lnot14_not_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_lnot14_not_i_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_lnot14_not_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_lnot14_not_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_lnot14_not_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lnot14_not_i_stall_in = 1'b0;
assign rnode_169to170_bb1_lnot14_not_i_0_NO_SHIFT_REG = rnode_169to170_bb1_lnot14_not_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_lnot14_not_i_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_lnot14_not_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_mul_i_i_inputs_ready;
 reg local_bb1_mul_i_i_valid_out_0_NO_SHIFT_REG;
wire local_bb1_mul_i_i_stall_in_0;
 reg local_bb1_mul_i_i_valid_out_1_NO_SHIFT_REG;
wire local_bb1_mul_i_i_stall_in_1;
wire local_bb1_mul_i_i_output_regs_ready;
wire [63:0] local_bb1_mul_i_i;
 reg local_bb1_mul_i_i_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul_i_i_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul_i_i_causedstall;

acl_int_mult int_module_local_bb1_mul_i_i (
	.clock(clock),
	.dataa(local_bb1_conv_i_i),
	.datab(64'hD70A3D),
	.enable(local_bb1_mul_i_i_output_regs_ready),
	.result(local_bb1_mul_i_i)
);

defparam int_module_local_bb1_mul_i_i.INPUT1_WIDTH = 24;
defparam int_module_local_bb1_mul_i_i.INPUT2_WIDTH = 24;
defparam int_module_local_bb1_mul_i_i.OUTPUT_WIDTH = 64;
defparam int_module_local_bb1_mul_i_i.LATENCY = 3;
defparam int_module_local_bb1_mul_i_i.SIGNED = 0;

assign local_bb1_mul_i_i_inputs_ready = 1'b1;
assign local_bb1_mul_i_i_output_regs_ready = 1'b1;
assign local_bb1_conv_i_i_stall_in = 1'b0;
assign local_bb1_mul_i_i_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_i_i_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul_i_i_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_i_i_output_regs_ready)
		begin
			local_bb1_mul_i_i_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_mul_i_i_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul_i_i_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_i_i_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul_i_i_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_i_i_output_regs_ready)
		begin
			local_bb1_mul_i_i_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_mul_i_i_valid_out_1_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_mul_i_i_stall_in_0))
			begin
				local_bb1_mul_i_i_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_mul_i_i_stall_in_1))
			begin
				local_bb1_mul_i_i_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_169to171_bb1_shr_i282_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i282_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb1_shr_i282_0_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i282_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to171_bb1_shr_i282_0_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i282_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i282_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_169to171_bb1_shr_i282_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_169to171_bb1_shr_i282_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to171_bb1_shr_i282_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to171_bb1_shr_i282_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_169to171_bb1_shr_i282_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_169to171_bb1_shr_i282_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_shr_i282),
	.data_out(rnode_169to171_bb1_shr_i282_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_169to171_bb1_shr_i282_0_reg_171_fifo.DEPTH = 2;
defparam rnode_169to171_bb1_shr_i282_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_169to171_bb1_shr_i282_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to171_bb1_shr_i282_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_169to171_bb1_shr_i282_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr_i282_stall_in = 1'b0;
assign rnode_169to171_bb1_shr_i282_0_NO_SHIFT_REG = rnode_169to171_bb1_shr_i282_0_reg_171_NO_SHIFT_REG;
assign rnode_169to171_bb1_shr_i282_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_169to171_bb1_shr_i282_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_and4_i285_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i285_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and4_i285_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i285_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and4_i285_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i285_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i285_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and4_i285_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_and4_i285_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_and4_i285_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_and4_i285_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_and4_i285_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_and4_i285_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_and4_i285),
	.data_out(rnode_169to170_bb1_and4_i285_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_and4_i285_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_and4_i285_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1_and4_i285_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_and4_i285_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_and4_i285_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and4_i285_stall_in = 1'b0;
assign rnode_169to170_bb1_and4_i285_0_NO_SHIFT_REG = rnode_169to170_bb1_and4_i285_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_and4_i285_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and4_i285_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_lnot14_not_i297_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i297_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i297_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i297_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i297_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i297_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i297_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot14_not_i297_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_lnot14_not_i297_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_lnot14_not_i297_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_lnot14_not_i297_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_lnot14_not_i297_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_lnot14_not_i297_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_lnot14_not_i297),
	.data_out(rnode_169to170_bb1_lnot14_not_i297_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_lnot14_not_i297_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_lnot14_not_i297_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_lnot14_not_i297_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_lnot14_not_i297_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_lnot14_not_i297_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lnot14_not_i297_stall_in = 1'b0;
assign rnode_169to170_bb1_lnot14_not_i297_0_NO_SHIFT_REG = rnode_169to170_bb1_lnot14_not_i297_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_lnot14_not_i297_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_lnot14_not_i297_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_mul_i_i302_inputs_ready;
 reg local_bb1_mul_i_i302_valid_out_0_NO_SHIFT_REG;
wire local_bb1_mul_i_i302_stall_in_0;
 reg local_bb1_mul_i_i302_valid_out_1_NO_SHIFT_REG;
wire local_bb1_mul_i_i302_stall_in_1;
wire local_bb1_mul_i_i302_output_regs_ready;
wire [63:0] local_bb1_mul_i_i302;
 reg local_bb1_mul_i_i302_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul_i_i302_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul_i_i302_causedstall;

acl_int_mult int_module_local_bb1_mul_i_i302 (
	.clock(clock),
	.dataa(local_bb1_conv_i_i301),
	.datab(64'hB5C28F),
	.enable(local_bb1_mul_i_i302_output_regs_ready),
	.result(local_bb1_mul_i_i302)
);

defparam int_module_local_bb1_mul_i_i302.INPUT1_WIDTH = 24;
defparam int_module_local_bb1_mul_i_i302.INPUT2_WIDTH = 24;
defparam int_module_local_bb1_mul_i_i302.OUTPUT_WIDTH = 64;
defparam int_module_local_bb1_mul_i_i302.LATENCY = 3;
defparam int_module_local_bb1_mul_i_i302.SIGNED = 0;

assign local_bb1_mul_i_i302_inputs_ready = 1'b1;
assign local_bb1_mul_i_i302_output_regs_ready = 1'b1;
assign local_bb1_conv_i_i301_stall_in = 1'b0;
assign local_bb1_mul_i_i302_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_i_i302_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul_i_i302_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_i_i302_output_regs_ready)
		begin
			local_bb1_mul_i_i302_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_mul_i_i302_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul_i_i302_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_i_i302_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul_i_i302_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_i_i302_output_regs_ready)
		begin
			local_bb1_mul_i_i302_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_mul_i_i302_valid_out_1_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_mul_i_i302_stall_in_0))
			begin
				local_bb1_mul_i_i302_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_mul_i_i302_stall_in_1))
			begin
				local_bb1_mul_i_i302_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_shr_i26_stall_local;
wire [31:0] local_bb1_shr_i26;

assign local_bb1_shr_i26 = (local_bb1_var__u2 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_and4_i29_stall_local;
wire [31:0] local_bb1_and4_i29;

assign local_bb1_and4_i29 = (local_bb1_var__u2 & 32'h80000000);

// This section implements an unregistered operation.
// 
wire local_bb1_and5_i30_stall_local;
wire [31:0] local_bb1_and5_i30;

assign local_bb1_and5_i30 = (local_bb1_var__u2 & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and_i_stall_local;
wire [31:0] local_bb1_and_i;

assign local_bb1_and_i = (rnode_169to171_bb1_shr_i_0_NO_SHIFT_REG & 32'hFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_170to172_bb1_and4_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to172_bb1_and4_i_0_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to172_bb1_and4_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_170to172_bb1_and4_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to172_bb1_and4_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to172_bb1_and4_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_170to172_bb1_and4_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_170to172_bb1_and4_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_and4_i_0_NO_SHIFT_REG),
	.data_out(rnode_170to172_bb1_and4_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_170to172_bb1_and4_i_0_reg_172_fifo.DEPTH = 2;
defparam rnode_170to172_bb1_and4_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_170to172_bb1_and4_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to172_bb1_and4_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_170to172_bb1_and4_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_and4_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_and4_i_0_NO_SHIFT_REG = rnode_170to172_bb1_and4_i_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb1_and4_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_and4_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_170to172_bb1_lnot14_not_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i_0_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_170to172_bb1_lnot14_not_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to172_bb1_lnot14_not_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to172_bb1_lnot14_not_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_170to172_bb1_lnot14_not_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_170to172_bb1_lnot14_not_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_lnot14_not_i_0_NO_SHIFT_REG),
	.data_out(rnode_170to172_bb1_lnot14_not_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_170to172_bb1_lnot14_not_i_0_reg_172_fifo.DEPTH = 2;
defparam rnode_170to172_bb1_lnot14_not_i_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_170to172_bb1_lnot14_not_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to172_bb1_lnot14_not_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_170to172_bb1_lnot14_not_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_lnot14_not_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_lnot14_not_i_0_NO_SHIFT_REG = rnode_170to172_bb1_lnot14_not_i_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb1_lnot14_not_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_lnot14_not_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_conv3_i_i_stall_local;
wire [31:0] local_bb1_conv3_i_i;

assign local_bb1_conv3_i_i = local_bb1_mul_i_i[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_var__u3_stall_local;
wire [63:0] local_bb1_var__u3;

assign local_bb1_var__u3 = (local_bb1_mul_i_i >> 64'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_and_i283_stall_local;
wire [31:0] local_bb1_and_i283;

assign local_bb1_and_i283 = (rnode_169to171_bb1_shr_i282_0_NO_SHIFT_REG & 32'hFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_170to172_bb1_and4_i285_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i285_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to172_bb1_and4_i285_0_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i285_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to172_bb1_and4_i285_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i285_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i285_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and4_i285_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_170to172_bb1_and4_i285_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to172_bb1_and4_i285_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to172_bb1_and4_i285_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_170to172_bb1_and4_i285_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_170to172_bb1_and4_i285_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_and4_i285_0_NO_SHIFT_REG),
	.data_out(rnode_170to172_bb1_and4_i285_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_170to172_bb1_and4_i285_0_reg_172_fifo.DEPTH = 2;
defparam rnode_170to172_bb1_and4_i285_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_170to172_bb1_and4_i285_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to172_bb1_and4_i285_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_170to172_bb1_and4_i285_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_and4_i285_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_and4_i285_0_NO_SHIFT_REG = rnode_170to172_bb1_and4_i285_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb1_and4_i285_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_and4_i285_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_170to172_bb1_lnot14_not_i297_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i297_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i297_0_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i297_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i297_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i297_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i297_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_lnot14_not_i297_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_170to172_bb1_lnot14_not_i297_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to172_bb1_lnot14_not_i297_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to172_bb1_lnot14_not_i297_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_170to172_bb1_lnot14_not_i297_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_170to172_bb1_lnot14_not_i297_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_lnot14_not_i297_0_NO_SHIFT_REG),
	.data_out(rnode_170to172_bb1_lnot14_not_i297_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_170to172_bb1_lnot14_not_i297_0_reg_172_fifo.DEPTH = 2;
defparam rnode_170to172_bb1_lnot14_not_i297_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_170to172_bb1_lnot14_not_i297_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to172_bb1_lnot14_not_i297_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_170to172_bb1_lnot14_not_i297_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_lnot14_not_i297_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_lnot14_not_i297_0_NO_SHIFT_REG = rnode_170to172_bb1_lnot14_not_i297_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb1_lnot14_not_i297_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_lnot14_not_i297_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_conv3_i_i303_stall_local;
wire [31:0] local_bb1_conv3_i_i303;

assign local_bb1_conv3_i_i303 = local_bb1_mul_i_i302[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_var__u4_stall_local;
wire [63:0] local_bb1_var__u4;

assign local_bb1_var__u4 = (local_bb1_mul_i_i302 >> 64'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot14_not_i41_stall_local;
wire local_bb1_lnot14_not_i41;

assign local_bb1_lnot14_not_i41 = (local_bb1_and5_i30 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i44_stall_local;
wire [31:0] local_bb1_or_i44;

assign local_bb1_or_i44 = (local_bb1_and5_i30 | 32'h800000);

// This section implements an unregistered operation.
// 
wire local_bb1_and_i_valid_out_1;
wire local_bb1_and_i_stall_in_1;
 reg local_bb1_and_i_consumed_1_NO_SHIFT_REG;
wire local_bb1_add_i_valid_out;
wire local_bb1_add_i_stall_in;
 reg local_bb1_add_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_add_i_inputs_ready;
wire local_bb1_add_i_stall_local;
wire [31:0] local_bb1_add_i;

assign local_bb1_add_i_inputs_ready = rnode_169to171_bb1_shr_i_0_valid_out_NO_SHIFT_REG;
assign local_bb1_add_i = (local_bb1_and_i + 32'h7C);
assign local_bb1_and_i_valid_out_1 = 1'b1;
assign local_bb1_add_i_valid_out = 1'b1;
assign rnode_169to171_bb1_shr_i_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_and_i_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_add_i_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_and_i_consumed_1_NO_SHIFT_REG <= (local_bb1_add_i_inputs_ready & (local_bb1_and_i_consumed_1_NO_SHIFT_REG | ~(local_bb1_and_i_stall_in_1)) & local_bb1_add_i_stall_local);
		local_bb1_add_i_consumed_0_NO_SHIFT_REG <= (local_bb1_add_i_inputs_ready & (local_bb1_add_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_add_i_stall_in)) & local_bb1_add_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_and4_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and4_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and4_i_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and4_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_and4_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_and4_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_and4_i_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_and4_i_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_and4_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_170to172_bb1_and4_i_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_and4_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_and4_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_and4_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_and4_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_and4_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_and4_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to172_bb1_and4_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and4_i_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and4_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_and4_i_0_NO_SHIFT_REG = rnode_172to173_bb1_and4_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_and4_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_and4_i_1_NO_SHIFT_REG = rnode_172to173_bb1_and4_i_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_lnot14_not_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_lnot14_not_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_lnot14_not_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_lnot14_not_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_lnot14_not_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_lnot14_not_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_170to172_bb1_lnot14_not_i_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_lnot14_not_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_lnot14_not_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_lnot14_not_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_lnot14_not_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_lnot14_not_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_lnot14_not_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to172_bb1_lnot14_not_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot14_not_i_0_NO_SHIFT_REG = rnode_172to173_bb1_lnot14_not_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_lnot14_not_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot14_not_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i16_i_stall_local;
wire [31:0] local_bb1_shr_i16_i;

assign local_bb1_shr_i16_i = (local_bb1_conv3_i_i >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_shl1_i18_i_stall_local;
wire [31:0] local_bb1_shl1_i18_i;

assign local_bb1_shl1_i18_i = (local_bb1_conv3_i_i << 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u5_stall_local;
wire [31:0] local_bb1_var__u5;

assign local_bb1_var__u5 = (local_bb1_conv3_i_i >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_shl1_i_i_stall_local;
wire [31:0] local_bb1_shl1_i_i;

assign local_bb1_shl1_i_i = (local_bb1_conv3_i_i << 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1__tr_i_stall_local;
wire [31:0] local_bb1__tr_i;

assign local_bb1__tr_i = local_bb1_var__u3[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_and_i283_valid_out_1;
wire local_bb1_and_i283_stall_in_1;
 reg local_bb1_and_i283_consumed_1_NO_SHIFT_REG;
wire local_bb1_add_i309_valid_out;
wire local_bb1_add_i309_stall_in;
 reg local_bb1_add_i309_consumed_0_NO_SHIFT_REG;
wire local_bb1_add_i309_inputs_ready;
wire local_bb1_add_i309_stall_local;
wire [31:0] local_bb1_add_i309;

assign local_bb1_add_i309_inputs_ready = rnode_169to171_bb1_shr_i282_0_valid_out_NO_SHIFT_REG;
assign local_bb1_add_i309 = (local_bb1_and_i283 + 32'h7E);
assign local_bb1_and_i283_valid_out_1 = 1'b1;
assign local_bb1_add_i309_valid_out = 1'b1;
assign rnode_169to171_bb1_shr_i282_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_and_i283_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_add_i309_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_and_i283_consumed_1_NO_SHIFT_REG <= (local_bb1_add_i309_inputs_ready & (local_bb1_and_i283_consumed_1_NO_SHIFT_REG | ~(local_bb1_and_i283_stall_in_1)) & local_bb1_add_i309_stall_local);
		local_bb1_add_i309_consumed_0_NO_SHIFT_REG <= (local_bb1_add_i309_inputs_ready & (local_bb1_add_i309_consumed_0_NO_SHIFT_REG | ~(local_bb1_add_i309_stall_in)) & local_bb1_add_i309_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_and4_i285_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i285_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and4_i285_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i285_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i285_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and4_i285_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i285_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and4_i285_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i285_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i285_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and4_i285_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_and4_i285_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_and4_i285_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_and4_i285_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_and4_i285_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_and4_i285_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_170to172_bb1_and4_i285_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_and4_i285_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_and4_i285_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_and4_i285_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_and4_i285_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_and4_i285_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_and4_i285_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to172_bb1_and4_i285_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and4_i285_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and4_i285_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_and4_i285_0_NO_SHIFT_REG = rnode_172to173_bb1_and4_i285_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_and4_i285_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_and4_i285_1_NO_SHIFT_REG = rnode_172to173_bb1_and4_i285_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_lnot14_not_i297_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i297_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i297_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i297_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i297_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i297_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i297_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot14_not_i297_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_lnot14_not_i297_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_lnot14_not_i297_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_lnot14_not_i297_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_lnot14_not_i297_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_lnot14_not_i297_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_170to172_bb1_lnot14_not_i297_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_lnot14_not_i297_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_lnot14_not_i297_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_lnot14_not_i297_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_lnot14_not_i297_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_lnot14_not_i297_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_lnot14_not_i297_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to172_bb1_lnot14_not_i297_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot14_not_i297_0_NO_SHIFT_REG = rnode_172to173_bb1_lnot14_not_i297_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_lnot14_not_i297_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot14_not_i297_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i16_i306_stall_local;
wire [31:0] local_bb1_shr_i16_i306;

assign local_bb1_shr_i16_i306 = (local_bb1_conv3_i_i303 >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_shl1_i18_i308_stall_local;
wire [31:0] local_bb1_shl1_i18_i308;

assign local_bb1_shl1_i18_i308 = (local_bb1_conv3_i_i303 << 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u6_stall_local;
wire [31:0] local_bb1_var__u6;

assign local_bb1_var__u6 = (local_bb1_conv3_i_i303 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_shl1_i_i316_stall_local;
wire [31:0] local_bb1_shl1_i_i316;

assign local_bb1_shl1_i_i316 = (local_bb1_conv3_i_i303 << 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1__tr_i304_stall_local;
wire [31:0] local_bb1__tr_i304;

assign local_bb1__tr_i304 = local_bb1_var__u4[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i26_valid_out;
wire local_bb1_shr_i26_stall_in;
 reg local_bb1_shr_i26_consumed_0_NO_SHIFT_REG;
wire local_bb1_and4_i29_valid_out;
wire local_bb1_and4_i29_stall_in;
 reg local_bb1_and4_i29_consumed_0_NO_SHIFT_REG;
wire local_bb1_lnot14_not_i41_valid_out;
wire local_bb1_lnot14_not_i41_stall_in;
 reg local_bb1_lnot14_not_i41_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv_i_i45_valid_out;
wire local_bb1_conv_i_i45_stall_in;
 reg local_bb1_conv_i_i45_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv_i_i45_inputs_ready;
wire local_bb1_conv_i_i45_stall_local;
wire [63:0] local_bb1_conv_i_i45;

assign local_bb1_conv_i_i45_inputs_ready = local_bb1_conv16_valid_out_NO_SHIFT_REG;
assign local_bb1_conv_i_i45[63:32] = 32'h0;
assign local_bb1_conv_i_i45[31:0] = local_bb1_or_i44;
assign local_bb1_shr_i26_valid_out = 1'b1;
assign local_bb1_and4_i29_valid_out = 1'b1;
assign local_bb1_lnot14_not_i41_valid_out = 1'b1;
assign local_bb1_conv_i_i45_valid_out = 1'b1;
assign local_bb1_conv16_stall_in = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_shr_i26_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and4_i29_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_lnot14_not_i41_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv_i_i45_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_shr_i26_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i45_inputs_ready & (local_bb1_shr_i26_consumed_0_NO_SHIFT_REG | ~(local_bb1_shr_i26_stall_in)) & local_bb1_conv_i_i45_stall_local);
		local_bb1_and4_i29_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i45_inputs_ready & (local_bb1_and4_i29_consumed_0_NO_SHIFT_REG | ~(local_bb1_and4_i29_stall_in)) & local_bb1_conv_i_i45_stall_local);
		local_bb1_lnot14_not_i41_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i45_inputs_ready & (local_bb1_lnot14_not_i41_consumed_0_NO_SHIFT_REG | ~(local_bb1_lnot14_not_i41_stall_in)) & local_bb1_conv_i_i45_stall_local);
		local_bb1_conv_i_i45_consumed_0_NO_SHIFT_REG <= (local_bb1_conv_i_i45_inputs_ready & (local_bb1_conv_i_i45_consumed_0_NO_SHIFT_REG | ~(local_bb1_conv_i_i45_stall_in)) & local_bb1_conv_i_i45_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_and_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and_i_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and_i_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_and_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_and_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_and_i_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_and_i_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_and_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_and_i),
	.data_out(rnode_171to172_bb1_and_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_and_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_and_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_and_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_and_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_and_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and_i_stall_in_1 = 1'b0;
assign rnode_171to172_bb1_and_i_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and_i_0_NO_SHIFT_REG = rnode_171to172_bb1_and_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_and_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and_i_1_NO_SHIFT_REG = rnode_171to172_bb1_and_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_and_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and_i_2_NO_SHIFT_REG = rnode_171to172_bb1_and_i_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_add_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_add_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_add_i_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_add_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_add_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_add_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_add_i_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_add_i_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_add_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_add_i),
	.data_out(rnode_171to172_bb1_add_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_add_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_add_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_add_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_add_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_add_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add_i_stall_in = 1'b0;
assign rnode_171to172_bb1_add_i_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_add_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_add_i_0_NO_SHIFT_REG = rnode_171to172_bb1_add_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_add_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_add_i_1_NO_SHIFT_REG = rnode_171to172_bb1_add_i_0_reg_172_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_i_stall_local;
wire [31:0] local_bb1_shr_i_i;

assign local_bb1_shr_i_i = (local_bb1_var__u5 & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i15_i_stall_local;
wire [31:0] local_bb1_shl_i15_i;

assign local_bb1_shl_i15_i = (local_bb1__tr_i & 32'hFFFF00);

// This section implements an unregistered operation.
// 
wire local_bb1_and48_i_stall_local;
wire [31:0] local_bb1_and48_i;

assign local_bb1_and48_i = (local_bb1__tr_i & 32'h800000);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_and_i283_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i283_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and_i283_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i283_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i283_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and_i283_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i283_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i283_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and_i283_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i283_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and_i283_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i283_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i283_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and_i283_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_and_i283_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_and_i283_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_and_i283_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_and_i283_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_and_i283_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_and_i283),
	.data_out(rnode_171to172_bb1_and_i283_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_and_i283_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_and_i283_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_and_i283_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_and_i283_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_and_i283_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and_i283_stall_in_1 = 1'b0;
assign rnode_171to172_bb1_and_i283_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and_i283_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and_i283_0_NO_SHIFT_REG = rnode_171to172_bb1_and_i283_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_and_i283_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and_i283_1_NO_SHIFT_REG = rnode_171to172_bb1_and_i283_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_and_i283_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and_i283_2_NO_SHIFT_REG = rnode_171to172_bb1_and_i283_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_add_i309_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i309_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_add_i309_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i309_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i309_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_add_i309_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i309_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_add_i309_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i309_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i309_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_add_i309_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_add_i309_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_add_i309_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_add_i309_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_add_i309_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_add_i309_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_add_i309),
	.data_out(rnode_171to172_bb1_add_i309_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_add_i309_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_add_i309_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_add_i309_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_add_i309_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_add_i309_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add_i309_stall_in = 1'b0;
assign rnode_171to172_bb1_add_i309_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_add_i309_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_add_i309_0_NO_SHIFT_REG = rnode_171to172_bb1_add_i309_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_add_i309_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_add_i309_1_NO_SHIFT_REG = rnode_171to172_bb1_add_i309_0_reg_172_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_i314_stall_local;
wire [31:0] local_bb1_shr_i_i314;

assign local_bb1_shr_i_i314 = (local_bb1_var__u6 & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i15_i305_stall_local;
wire [31:0] local_bb1_shl_i15_i305;

assign local_bb1_shl_i15_i305 = (local_bb1__tr_i304 & 32'hFFFF00);

// This section implements an unregistered operation.
// 
wire local_bb1_and48_i310_stall_local;
wire [31:0] local_bb1_and48_i310;

assign local_bb1_and48_i310 = (local_bb1__tr_i304 & 32'h800000);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_176to178_bb1_shr_i26_0_valid_out_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr_i26_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_176to178_bb1_shr_i26_0_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr_i26_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_176to178_bb1_shr_i26_0_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr_i26_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr_i26_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr_i26_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_176to178_bb1_shr_i26_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to178_bb1_shr_i26_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to178_bb1_shr_i26_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_176to178_bb1_shr_i26_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_176to178_bb1_shr_i26_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1_shr_i26),
	.data_out(rnode_176to178_bb1_shr_i26_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_176to178_bb1_shr_i26_0_reg_178_fifo.DEPTH = 2;
defparam rnode_176to178_bb1_shr_i26_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_176to178_bb1_shr_i26_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to178_bb1_shr_i26_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_176to178_bb1_shr_i26_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr_i26_stall_in = 1'b0;
assign rnode_176to178_bb1_shr_i26_0_NO_SHIFT_REG = rnode_176to178_bb1_shr_i26_0_reg_178_NO_SHIFT_REG;
assign rnode_176to178_bb1_shr_i26_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_176to178_bb1_shr_i26_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_176to177_bb1_and4_i29_0_valid_out_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and4_i29_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_and4_i29_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and4_i29_0_reg_177_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_and4_i29_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and4_i29_0_valid_out_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and4_i29_0_stall_in_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and4_i29_0_stall_out_reg_177_NO_SHIFT_REG;

acl_data_fifo rnode_176to177_bb1_and4_i29_0_reg_177_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to177_bb1_and4_i29_0_reg_177_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to177_bb1_and4_i29_0_stall_in_reg_177_NO_SHIFT_REG),
	.valid_out(rnode_176to177_bb1_and4_i29_0_valid_out_reg_177_NO_SHIFT_REG),
	.stall_out(rnode_176to177_bb1_and4_i29_0_stall_out_reg_177_NO_SHIFT_REG),
	.data_in(local_bb1_and4_i29),
	.data_out(rnode_176to177_bb1_and4_i29_0_reg_177_NO_SHIFT_REG)
);

defparam rnode_176to177_bb1_and4_i29_0_reg_177_fifo.DEPTH = 1;
defparam rnode_176to177_bb1_and4_i29_0_reg_177_fifo.DATA_WIDTH = 32;
defparam rnode_176to177_bb1_and4_i29_0_reg_177_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to177_bb1_and4_i29_0_reg_177_fifo.IMPL = "shift_reg";

assign rnode_176to177_bb1_and4_i29_0_reg_177_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and4_i29_stall_in = 1'b0;
assign rnode_176to177_bb1_and4_i29_0_NO_SHIFT_REG = rnode_176to177_bb1_and4_i29_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_and4_i29_0_stall_in_reg_177_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_and4_i29_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_176to177_bb1_lnot14_not_i41_0_valid_out_NO_SHIFT_REG;
 logic rnode_176to177_bb1_lnot14_not_i41_0_stall_in_NO_SHIFT_REG;
 logic rnode_176to177_bb1_lnot14_not_i41_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_lnot14_not_i41_0_reg_177_inputs_ready_NO_SHIFT_REG;
 logic rnode_176to177_bb1_lnot14_not_i41_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_lnot14_not_i41_0_valid_out_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_lnot14_not_i41_0_stall_in_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_lnot14_not_i41_0_stall_out_reg_177_NO_SHIFT_REG;

acl_data_fifo rnode_176to177_bb1_lnot14_not_i41_0_reg_177_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to177_bb1_lnot14_not_i41_0_reg_177_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to177_bb1_lnot14_not_i41_0_stall_in_reg_177_NO_SHIFT_REG),
	.valid_out(rnode_176to177_bb1_lnot14_not_i41_0_valid_out_reg_177_NO_SHIFT_REG),
	.stall_out(rnode_176to177_bb1_lnot14_not_i41_0_stall_out_reg_177_NO_SHIFT_REG),
	.data_in(local_bb1_lnot14_not_i41),
	.data_out(rnode_176to177_bb1_lnot14_not_i41_0_reg_177_NO_SHIFT_REG)
);

defparam rnode_176to177_bb1_lnot14_not_i41_0_reg_177_fifo.DEPTH = 1;
defparam rnode_176to177_bb1_lnot14_not_i41_0_reg_177_fifo.DATA_WIDTH = 1;
defparam rnode_176to177_bb1_lnot14_not_i41_0_reg_177_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to177_bb1_lnot14_not_i41_0_reg_177_fifo.IMPL = "shift_reg";

assign rnode_176to177_bb1_lnot14_not_i41_0_reg_177_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lnot14_not_i41_stall_in = 1'b0;
assign rnode_176to177_bb1_lnot14_not_i41_0_NO_SHIFT_REG = rnode_176to177_bb1_lnot14_not_i41_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_lnot14_not_i41_0_stall_in_reg_177_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_lnot14_not_i41_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_mul_i_i46_inputs_ready;
 reg local_bb1_mul_i_i46_valid_out_0_NO_SHIFT_REG;
wire local_bb1_mul_i_i46_stall_in_0;
 reg local_bb1_mul_i_i46_valid_out_1_NO_SHIFT_REG;
wire local_bb1_mul_i_i46_stall_in_1;
wire local_bb1_mul_i_i46_output_regs_ready;
wire [63:0] local_bb1_mul_i_i46;
 reg local_bb1_mul_i_i46_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul_i_i46_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul_i_i46_causedstall;

acl_int_mult int_module_local_bb1_mul_i_i46 (
	.clock(clock),
	.dataa(local_bb1_conv_i_i45),
	.datab(64'h8F5C29),
	.enable(local_bb1_mul_i_i46_output_regs_ready),
	.result(local_bb1_mul_i_i46)
);

defparam int_module_local_bb1_mul_i_i46.INPUT1_WIDTH = 24;
defparam int_module_local_bb1_mul_i_i46.INPUT2_WIDTH = 24;
defparam int_module_local_bb1_mul_i_i46.OUTPUT_WIDTH = 64;
defparam int_module_local_bb1_mul_i_i46.LATENCY = 3;
defparam int_module_local_bb1_mul_i_i46.SIGNED = 0;

assign local_bb1_mul_i_i46_inputs_ready = 1'b1;
assign local_bb1_mul_i_i46_output_regs_ready = 1'b1;
assign local_bb1_conv_i_i45_stall_in = 1'b0;
assign local_bb1_mul_i_i46_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_i_i46_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul_i_i46_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_i_i46_output_regs_ready)
		begin
			local_bb1_mul_i_i46_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_mul_i_i46_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul_i_i46_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_i_i46_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul_i_i46_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_i_i46_output_regs_ready)
		begin
			local_bb1_mul_i_i46_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_mul_i_i46_valid_out_1_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_mul_i_i46_stall_in_0))
			begin
				local_bb1_mul_i_i46_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_mul_i_i46_stall_in_1))
			begin
				local_bb1_mul_i_i46_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_lnot_i_valid_out;
wire local_bb1_lnot_i_stall_in;
wire local_bb1_lnot_i_inputs_ready;
wire local_bb1_lnot_i_stall_local;
wire local_bb1_lnot_i;

assign local_bb1_lnot_i_inputs_ready = rnode_171to172_bb1_and_i_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_lnot_i = (rnode_171to172_bb1_and_i_0_NO_SHIFT_REG == 32'h0);
assign local_bb1_lnot_i_valid_out = 1'b1;
assign rnode_171to172_bb1_and_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_i_valid_out;
wire local_bb1_cmp_i_stall_in;
wire local_bb1_cmp_i_inputs_ready;
wire local_bb1_cmp_i_stall_local;
wire local_bb1_cmp_i;

assign local_bb1_cmp_i_inputs_ready = rnode_171to172_bb1_and_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_cmp_i = (rnode_171to172_bb1_and_i_1_NO_SHIFT_REG == 32'hFF);
assign local_bb1_cmp_i_valid_out = 1'b1;
assign rnode_171to172_bb1_and_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_inc_i_stall_local;
wire [31:0] local_bb1_inc_i;

assign local_bb1_inc_i = (rnode_171to172_bb1_and_i_2_NO_SHIFT_REG + 32'h7D);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp50_not_i_stall_local;
wire local_bb1_cmp50_not_i;

assign local_bb1_cmp50_not_i = (rnode_171to172_bb1_add_i_0_NO_SHIFT_REG != 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i17_i_stall_local;
wire [31:0] local_bb1_or_i17_i;

assign local_bb1_or_i17_i = (local_bb1_shl_i15_i | local_bb1_shr_i16_i);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool49_i_stall_local;
wire local_bb1_tobool49_i;

assign local_bb1_tobool49_i = (local_bb1_and48_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_i287_valid_out;
wire local_bb1_lnot_i287_stall_in;
wire local_bb1_lnot_i287_inputs_ready;
wire local_bb1_lnot_i287_stall_local;
wire local_bb1_lnot_i287;

assign local_bb1_lnot_i287_inputs_ready = rnode_171to172_bb1_and_i283_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_lnot_i287 = (rnode_171to172_bb1_and_i283_0_NO_SHIFT_REG == 32'h0);
assign local_bb1_lnot_i287_valid_out = 1'b1;
assign rnode_171to172_bb1_and_i283_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_i288_valid_out;
wire local_bb1_cmp_i288_stall_in;
wire local_bb1_cmp_i288_inputs_ready;
wire local_bb1_cmp_i288_stall_local;
wire local_bb1_cmp_i288;

assign local_bb1_cmp_i288_inputs_ready = rnode_171to172_bb1_and_i283_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_cmp_i288 = (rnode_171to172_bb1_and_i283_1_NO_SHIFT_REG == 32'hFF);
assign local_bb1_cmp_i288_valid_out = 1'b1;
assign rnode_171to172_bb1_and_i283_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_inc_i312_stall_local;
wire [31:0] local_bb1_inc_i312;

assign local_bb1_inc_i312 = (rnode_171to172_bb1_and_i283_2_NO_SHIFT_REG + 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp50_not_i317_stall_local;
wire local_bb1_cmp50_not_i317;

assign local_bb1_cmp50_not_i317 = (rnode_171to172_bb1_add_i309_0_NO_SHIFT_REG != 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i17_i307_stall_local;
wire [31:0] local_bb1_or_i17_i307;

assign local_bb1_or_i17_i307 = (local_bb1_shl_i15_i305 | local_bb1_shr_i16_i306);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool49_i311_stall_local;
wire local_bb1_tobool49_i311;

assign local_bb1_tobool49_i311 = (local_bb1_and48_i310 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_and_i27_stall_local;
wire [31:0] local_bb1_and_i27;

assign local_bb1_and_i27 = (rnode_176to178_bb1_shr_i26_0_NO_SHIFT_REG & 32'hFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_177to179_bb1_and4_i29_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to179_bb1_and4_i29_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_177to179_bb1_and4_i29_0_NO_SHIFT_REG;
 logic rnode_177to179_bb1_and4_i29_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_177to179_bb1_and4_i29_0_reg_179_NO_SHIFT_REG;
 logic rnode_177to179_bb1_and4_i29_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_177to179_bb1_and4_i29_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_177to179_bb1_and4_i29_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_177to179_bb1_and4_i29_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to179_bb1_and4_i29_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to179_bb1_and4_i29_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_177to179_bb1_and4_i29_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_177to179_bb1_and4_i29_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_176to177_bb1_and4_i29_0_NO_SHIFT_REG),
	.data_out(rnode_177to179_bb1_and4_i29_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_177to179_bb1_and4_i29_0_reg_179_fifo.DEPTH = 2;
defparam rnode_177to179_bb1_and4_i29_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_177to179_bb1_and4_i29_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to179_bb1_and4_i29_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_177to179_bb1_and4_i29_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_and4_i29_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_177to179_bb1_and4_i29_0_NO_SHIFT_REG = rnode_177to179_bb1_and4_i29_0_reg_179_NO_SHIFT_REG;
assign rnode_177to179_bb1_and4_i29_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_177to179_bb1_and4_i29_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_177to179_bb1_lnot14_not_i41_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to179_bb1_lnot14_not_i41_0_stall_in_NO_SHIFT_REG;
 logic rnode_177to179_bb1_lnot14_not_i41_0_NO_SHIFT_REG;
 logic rnode_177to179_bb1_lnot14_not_i41_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_177to179_bb1_lnot14_not_i41_0_reg_179_NO_SHIFT_REG;
 logic rnode_177to179_bb1_lnot14_not_i41_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_177to179_bb1_lnot14_not_i41_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_177to179_bb1_lnot14_not_i41_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_177to179_bb1_lnot14_not_i41_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to179_bb1_lnot14_not_i41_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to179_bb1_lnot14_not_i41_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_177to179_bb1_lnot14_not_i41_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_177to179_bb1_lnot14_not_i41_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_176to177_bb1_lnot14_not_i41_0_NO_SHIFT_REG),
	.data_out(rnode_177to179_bb1_lnot14_not_i41_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_177to179_bb1_lnot14_not_i41_0_reg_179_fifo.DEPTH = 2;
defparam rnode_177to179_bb1_lnot14_not_i41_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_177to179_bb1_lnot14_not_i41_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to179_bb1_lnot14_not_i41_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_177to179_bb1_lnot14_not_i41_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_lnot14_not_i41_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_177to179_bb1_lnot14_not_i41_0_NO_SHIFT_REG = rnode_177to179_bb1_lnot14_not_i41_0_reg_179_NO_SHIFT_REG;
assign rnode_177to179_bb1_lnot14_not_i41_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_177to179_bb1_lnot14_not_i41_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_conv3_i_i47_stall_local;
wire [31:0] local_bb1_conv3_i_i47;

assign local_bb1_conv3_i_i47 = local_bb1_mul_i_i46[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_var__u7_stall_local;
wire [63:0] local_bb1_var__u7;

assign local_bb1_var__u7 = (local_bb1_mul_i_i46 >> 64'h18);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_lnot_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_lnot_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_lnot_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_lnot_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_lnot_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_lnot_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_lnot_i),
	.data_out(rnode_172to173_bb1_lnot_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_lnot_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_lnot_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_lnot_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_lnot_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_lnot_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lnot_i_stall_in = 1'b0;
assign rnode_172to173_bb1_lnot_i_0_NO_SHIFT_REG = rnode_172to173_bb1_lnot_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_lnot_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_cmp_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_cmp_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_cmp_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_cmp_i_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_cmp_i_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_cmp_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_cmp_i),
	.data_out(rnode_172to173_bb1_cmp_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_cmp_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_cmp_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_cmp_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_cmp_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_cmp_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp_i_stall_in = 1'b0;
assign rnode_172to173_bb1_cmp_i_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_cmp_i_0_NO_SHIFT_REG = rnode_172to173_bb1_cmp_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_cmp_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_cmp_i_1_NO_SHIFT_REG = rnode_172to173_bb1_cmp_i_0_reg_173_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i_i_stall_local;
wire [31:0] local_bb1_shl_i_i;

assign local_bb1_shl_i_i = (local_bb1_or_i17_i << 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__31_i_stall_local;
wire local_bb1__31_i;

assign local_bb1__31_i = (local_bb1_tobool49_i & local_bb1_cmp50_not_i);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_lnot_i287_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i287_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i287_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i287_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i287_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i287_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i287_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_lnot_i287_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_lnot_i287_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_lnot_i287_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_lnot_i287_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_lnot_i287_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_lnot_i287_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_lnot_i287),
	.data_out(rnode_172to173_bb1_lnot_i287_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_lnot_i287_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_lnot_i287_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_lnot_i287_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_lnot_i287_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_lnot_i287_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lnot_i287_stall_in = 1'b0;
assign rnode_172to173_bb1_lnot_i287_0_NO_SHIFT_REG = rnode_172to173_bb1_lnot_i287_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_lnot_i287_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot_i287_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_cmp_i288_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp_i288_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_cmp_i288_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_cmp_i288_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_cmp_i288_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_cmp_i288_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_cmp_i288_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_cmp_i288),
	.data_out(rnode_172to173_bb1_cmp_i288_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_cmp_i288_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_cmp_i288_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_cmp_i288_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_cmp_i288_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_cmp_i288_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp_i288_stall_in = 1'b0;
assign rnode_172to173_bb1_cmp_i288_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp_i288_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_cmp_i288_0_NO_SHIFT_REG = rnode_172to173_bb1_cmp_i288_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_cmp_i288_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1_cmp_i288_1_NO_SHIFT_REG = rnode_172to173_bb1_cmp_i288_0_reg_173_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i_i313_stall_local;
wire [31:0] local_bb1_shl_i_i313;

assign local_bb1_shl_i_i313 = (local_bb1_or_i17_i307 << 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__31_i318_stall_local;
wire local_bb1__31_i318;

assign local_bb1__31_i318 = (local_bb1_tobool49_i311 & local_bb1_cmp50_not_i317);

// This section implements an unregistered operation.
// 
wire local_bb1_and_i27_valid_out_1;
wire local_bb1_and_i27_stall_in_1;
 reg local_bb1_and_i27_consumed_1_NO_SHIFT_REG;
wire local_bb1_add_i53_valid_out;
wire local_bb1_add_i53_stall_in;
 reg local_bb1_add_i53_consumed_0_NO_SHIFT_REG;
wire local_bb1_add_i53_inputs_ready;
wire local_bb1_add_i53_stall_local;
wire [31:0] local_bb1_add_i53;

assign local_bb1_add_i53_inputs_ready = rnode_176to178_bb1_shr_i26_0_valid_out_NO_SHIFT_REG;
assign local_bb1_add_i53 = (local_bb1_and_i27 + 32'h7B);
assign local_bb1_and_i27_valid_out_1 = 1'b1;
assign local_bb1_add_i53_valid_out = 1'b1;
assign rnode_176to178_bb1_shr_i26_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_and_i27_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_add_i53_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_and_i27_consumed_1_NO_SHIFT_REG <= (local_bb1_add_i53_inputs_ready & (local_bb1_and_i27_consumed_1_NO_SHIFT_REG | ~(local_bb1_and_i27_stall_in_1)) & local_bb1_add_i53_stall_local);
		local_bb1_add_i53_consumed_0_NO_SHIFT_REG <= (local_bb1_add_i53_inputs_ready & (local_bb1_add_i53_consumed_0_NO_SHIFT_REG | ~(local_bb1_add_i53_stall_in)) & local_bb1_add_i53_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_and4_i29_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and4_i29_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_and4_i29_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and4_i29_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and4_i29_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_and4_i29_1_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and4_i29_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_and4_i29_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and4_i29_0_valid_out_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and4_i29_0_stall_in_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and4_i29_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_and4_i29_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_and4_i29_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_and4_i29_0_stall_in_0_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_and4_i29_0_valid_out_0_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_and4_i29_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_177to179_bb1_and4_i29_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_and4_i29_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_and4_i29_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_and4_i29_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_and4_i29_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_and4_i29_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_and4_i29_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_177to179_bb1_and4_i29_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_and4_i29_0_stall_in_0_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_and4_i29_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_179to180_bb1_and4_i29_0_NO_SHIFT_REG = rnode_179to180_bb1_and4_i29_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_and4_i29_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_179to180_bb1_and4_i29_1_NO_SHIFT_REG = rnode_179to180_bb1_and4_i29_0_reg_180_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_lnot14_not_i41_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot14_not_i41_0_stall_in_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot14_not_i41_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot14_not_i41_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot14_not_i41_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot14_not_i41_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot14_not_i41_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot14_not_i41_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_lnot14_not_i41_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_lnot14_not_i41_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_lnot14_not_i41_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_lnot14_not_i41_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_lnot14_not_i41_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(rnode_177to179_bb1_lnot14_not_i41_0_NO_SHIFT_REG),
	.data_out(rnode_179to180_bb1_lnot14_not_i41_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_lnot14_not_i41_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_lnot14_not_i41_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1_lnot14_not_i41_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_lnot14_not_i41_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_lnot14_not_i41_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_177to179_bb1_lnot14_not_i41_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_lnot14_not_i41_0_NO_SHIFT_REG = rnode_179to180_bb1_lnot14_not_i41_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_lnot14_not_i41_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_lnot14_not_i41_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i16_i50_stall_local;
wire [31:0] local_bb1_shr_i16_i50;

assign local_bb1_shr_i16_i50 = (local_bb1_conv3_i_i47 >> 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_shl1_i18_i52_stall_local;
wire [31:0] local_bb1_shl1_i18_i52;

assign local_bb1_shl1_i18_i52 = (local_bb1_conv3_i_i47 << 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u8_stall_local;
wire [31:0] local_bb1_var__u8;

assign local_bb1_var__u8 = (local_bb1_conv3_i_i47 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_shl1_i_i60_stall_local;
wire [31:0] local_bb1_shl1_i_i60;

assign local_bb1_shl1_i_i60 = (local_bb1_conv3_i_i47 << 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1__tr_i48_stall_local;
wire [31:0] local_bb1__tr_i48;

assign local_bb1__tr_i48 = local_bb1_var__u7[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1__28_i_stall_local;
wire local_bb1__28_i;

assign local_bb1__28_i = (rnode_172to173_bb1_cmp_i_0_NO_SHIFT_REG & rnode_172to173_bb1_lnot14_not_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i_i_stall_local;
wire [31:0] local_bb1_or_i_i;

assign local_bb1_or_i_i = (local_bb1_shl_i_i | local_bb1_shr_i_i);

// This section implements an unregistered operation.
// 
wire local_bb1__32_i_stall_local;
wire [31:0] local_bb1__32_i;

assign local_bb1__32_i = (local_bb1__31_i ? local_bb1_shl1_i_i : local_bb1_shl1_i18_i);

// This section implements an unregistered operation.
// 
wire local_bb1__36_i_stall_local;
wire [31:0] local_bb1__36_i;

assign local_bb1__36_i = (local_bb1__31_i ? rnode_171to172_bb1_add_i_1_NO_SHIFT_REG : 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1__28_i298_stall_local;
wire local_bb1__28_i298;

assign local_bb1__28_i298 = (rnode_172to173_bb1_cmp_i288_0_NO_SHIFT_REG & rnode_172to173_bb1_lnot14_not_i297_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i_i315_stall_local;
wire [31:0] local_bb1_or_i_i315;

assign local_bb1_or_i_i315 = (local_bb1_shl_i_i313 | local_bb1_shr_i_i314);

// This section implements an unregistered operation.
// 
wire local_bb1__32_i319_stall_local;
wire [31:0] local_bb1__32_i319;

assign local_bb1__32_i319 = (local_bb1__31_i318 ? local_bb1_shl1_i_i316 : local_bb1_shl1_i18_i308);

// This section implements an unregistered operation.
// 
wire local_bb1__36_i323_stall_local;
wire [31:0] local_bb1__36_i323;

assign local_bb1__36_i323 = (local_bb1__31_i318 ? rnode_171to172_bb1_add_i309_1_NO_SHIFT_REG : 32'h7F);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_and_i27_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and_i27_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_and_i27_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and_i27_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and_i27_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_and_i27_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and_i27_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and_i27_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_and_i27_2_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and_i27_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_and_i27_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and_i27_0_valid_out_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and_i27_0_stall_in_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and_i27_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_and_i27_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_and_i27_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_and_i27_0_stall_in_0_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_and_i27_0_valid_out_0_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_and_i27_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_and_i27),
	.data_out(rnode_178to179_bb1_and_i27_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_and_i27_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_and_i27_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_bb1_and_i27_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_and_i27_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_and_i27_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and_i27_stall_in_1 = 1'b0;
assign rnode_178to179_bb1_and_i27_0_stall_in_0_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_and_i27_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1_and_i27_0_NO_SHIFT_REG = rnode_178to179_bb1_and_i27_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_and_i27_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1_and_i27_1_NO_SHIFT_REG = rnode_178to179_bb1_and_i27_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_and_i27_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1_and_i27_2_NO_SHIFT_REG = rnode_178to179_bb1_and_i27_0_reg_179_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_add_i53_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add_i53_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_add_i53_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add_i53_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add_i53_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_add_i53_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add_i53_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_add_i53_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add_i53_0_valid_out_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add_i53_0_stall_in_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add_i53_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_add_i53_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_add_i53_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_add_i53_0_stall_in_0_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_add_i53_0_valid_out_0_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_add_i53_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_add_i53),
	.data_out(rnode_178to179_bb1_add_i53_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_add_i53_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_add_i53_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_bb1_add_i53_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_add_i53_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_add_i53_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add_i53_stall_in = 1'b0;
assign rnode_178to179_bb1_add_i53_0_stall_in_0_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_add_i53_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1_add_i53_0_NO_SHIFT_REG = rnode_178to179_bb1_add_i53_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_add_i53_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1_add_i53_1_NO_SHIFT_REG = rnode_178to179_bb1_add_i53_0_reg_179_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_i58_stall_local;
wire [31:0] local_bb1_shr_i_i58;

assign local_bb1_shr_i_i58 = (local_bb1_var__u8 & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i15_i49_stall_local;
wire [31:0] local_bb1_shl_i15_i49;

assign local_bb1_shl_i15_i49 = (local_bb1__tr_i48 & 32'hFFFF00);

// This section implements an unregistered operation.
// 
wire local_bb1_and48_i54_stall_local;
wire [31:0] local_bb1_and48_i54;

assign local_bb1_and48_i54 = (local_bb1__tr_i48 & 32'h800000);

// This section implements an unregistered operation.
// 
wire local_bb1__34_i_stall_local;
wire [31:0] local_bb1__34_i;

assign local_bb1__34_i = (local_bb1__31_i ? local_bb1_or_i_i : local_bb1_or_i17_i);

// This section implements an unregistered operation.
// 
wire local_bb1__33_i_stall_local;
wire [31:0] local_bb1__33_i;

assign local_bb1__33_i = (local_bb1_tobool49_i ? local_bb1__32_i : local_bb1_shl1_i18_i);

// This section implements an unregistered operation.
// 
wire local_bb1__37_i_stall_local;
wire [31:0] local_bb1__37_i;

assign local_bb1__37_i = (local_bb1_tobool49_i ? local_bb1__36_i : local_bb1_inc_i);

// This section implements an unregistered operation.
// 
wire local_bb1__34_i321_stall_local;
wire [31:0] local_bb1__34_i321;

assign local_bb1__34_i321 = (local_bb1__31_i318 ? local_bb1_or_i_i315 : local_bb1_or_i17_i307);

// This section implements an unregistered operation.
// 
wire local_bb1__33_i320_stall_local;
wire [31:0] local_bb1__33_i320;

assign local_bb1__33_i320 = (local_bb1_tobool49_i311 ? local_bb1__32_i319 : local_bb1_shl1_i18_i308);

// This section implements an unregistered operation.
// 
wire local_bb1__37_i324_stall_local;
wire [31:0] local_bb1__37_i324;

assign local_bb1__37_i324 = (local_bb1_tobool49_i311 ? local_bb1__36_i323 : local_bb1_inc_i312);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_i31_valid_out;
wire local_bb1_lnot_i31_stall_in;
wire local_bb1_lnot_i31_inputs_ready;
wire local_bb1_lnot_i31_stall_local;
wire local_bb1_lnot_i31;

assign local_bb1_lnot_i31_inputs_ready = rnode_178to179_bb1_and_i27_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_lnot_i31 = (rnode_178to179_bb1_and_i27_0_NO_SHIFT_REG == 32'h0);
assign local_bb1_lnot_i31_valid_out = 1'b1;
assign rnode_178to179_bb1_and_i27_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_i32_valid_out;
wire local_bb1_cmp_i32_stall_in;
wire local_bb1_cmp_i32_inputs_ready;
wire local_bb1_cmp_i32_stall_local;
wire local_bb1_cmp_i32;

assign local_bb1_cmp_i32_inputs_ready = rnode_178to179_bb1_and_i27_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_cmp_i32 = (rnode_178to179_bb1_and_i27_1_NO_SHIFT_REG == 32'hFF);
assign local_bb1_cmp_i32_valid_out = 1'b1;
assign rnode_178to179_bb1_and_i27_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_inc_i56_stall_local;
wire [31:0] local_bb1_inc_i56;

assign local_bb1_inc_i56 = (rnode_178to179_bb1_and_i27_2_NO_SHIFT_REG + 32'h7C);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp50_not_i61_stall_local;
wire local_bb1_cmp50_not_i61;

assign local_bb1_cmp50_not_i61 = (rnode_178to179_bb1_add_i53_0_NO_SHIFT_REG != 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i17_i51_stall_local;
wire [31:0] local_bb1_or_i17_i51;

assign local_bb1_or_i17_i51 = (local_bb1_shl_i15_i49 | local_bb1_shr_i16_i50);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool49_i55_stall_local;
wire local_bb1_tobool49_i55;

assign local_bb1_tobool49_i55 = (local_bb1_and48_i54 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__35_i_stall_local;
wire [31:0] local_bb1__35_i;

assign local_bb1__35_i = (local_bb1_tobool49_i ? local_bb1__34_i : local_bb1_or_i17_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp77_i_stall_local;
wire local_bb1_cmp77_i;

assign local_bb1_cmp77_i = (local_bb1__33_i > 32'h80000000);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u9_stall_local;
wire local_bb1_var__u9;

assign local_bb1_var__u9 = ($signed(local_bb1__33_i) < $signed(32'h0));

// This section implements an unregistered operation.
// 
wire local_bb1__35_i322_stall_local;
wire [31:0] local_bb1__35_i322;

assign local_bb1__35_i322 = (local_bb1_tobool49_i311 ? local_bb1__34_i321 : local_bb1_or_i17_i307);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp77_i335_stall_local;
wire local_bb1_cmp77_i335;

assign local_bb1_cmp77_i335 = (local_bb1__33_i320 > 32'h80000000);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u10_stall_local;
wire local_bb1_var__u10;

assign local_bb1_var__u10 = ($signed(local_bb1__33_i320) < $signed(32'h0));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_lnot_i31_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot_i31_0_stall_in_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot_i31_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot_i31_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot_i31_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot_i31_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot_i31_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lnot_i31_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_lnot_i31_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_lnot_i31_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_lnot_i31_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_lnot_i31_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_lnot_i31_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1_lnot_i31),
	.data_out(rnode_179to180_bb1_lnot_i31_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_lnot_i31_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_lnot_i31_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1_lnot_i31_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_lnot_i31_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_lnot_i31_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lnot_i31_stall_in = 1'b0;
assign rnode_179to180_bb1_lnot_i31_0_NO_SHIFT_REG = rnode_179to180_bb1_lnot_i31_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_lnot_i31_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_lnot_i31_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_cmp_i32_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_1_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_0_valid_out_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_0_stall_in_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp_i32_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_cmp_i32_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_cmp_i32_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_cmp_i32_0_stall_in_0_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_cmp_i32_0_valid_out_0_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_cmp_i32_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1_cmp_i32),
	.data_out(rnode_179to180_bb1_cmp_i32_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_cmp_i32_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_cmp_i32_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1_cmp_i32_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_cmp_i32_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_cmp_i32_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp_i32_stall_in = 1'b0;
assign rnode_179to180_bb1_cmp_i32_0_stall_in_0_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_cmp_i32_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_179to180_bb1_cmp_i32_0_NO_SHIFT_REG = rnode_179to180_bb1_cmp_i32_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_cmp_i32_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_179to180_bb1_cmp_i32_1_NO_SHIFT_REG = rnode_179to180_bb1_cmp_i32_0_reg_180_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i_i57_stall_local;
wire [31:0] local_bb1_shl_i_i57;

assign local_bb1_shl_i_i57 = (local_bb1_or_i17_i51 << 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__31_i62_stall_local;
wire local_bb1__31_i62;

assign local_bb1__31_i62 = (local_bb1_tobool49_i55 & local_bb1_cmp50_not_i61);

// This section implements an unregistered operation.
// 
wire local_bb1_and75_i_stall_local;
wire [31:0] local_bb1_and75_i;

assign local_bb1_and75_i = (local_bb1__35_i & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and83_i_stall_local;
wire [31:0] local_bb1_and83_i;

assign local_bb1_and83_i = (local_bb1__35_i & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_and75_i330_stall_local;
wire [31:0] local_bb1_and75_i330;

assign local_bb1_and75_i330 = (local_bb1__35_i322 & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and83_i336_stall_local;
wire [31:0] local_bb1_and83_i336;

assign local_bb1_and83_i336 = (local_bb1__35_i322 & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__28_i42_stall_local;
wire local_bb1__28_i42;

assign local_bb1__28_i42 = (rnode_179to180_bb1_cmp_i32_0_NO_SHIFT_REG & rnode_179to180_bb1_lnot14_not_i41_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i_i59_stall_local;
wire [31:0] local_bb1_or_i_i59;

assign local_bb1_or_i_i59 = (local_bb1_shl_i_i57 | local_bb1_shr_i_i58);

// This section implements an unregistered operation.
// 
wire local_bb1__32_i63_stall_local;
wire [31:0] local_bb1__32_i63;

assign local_bb1__32_i63 = (local_bb1__31_i62 ? local_bb1_shl1_i_i60 : local_bb1_shl1_i18_i52);

// This section implements an unregistered operation.
// 
wire local_bb1__36_i67_stall_local;
wire [31:0] local_bb1__36_i67;

assign local_bb1__36_i67 = (local_bb1__31_i62 ? rnode_178to179_bb1_add_i53_1_NO_SHIFT_REG : 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool84_i_stall_local;
wire local_bb1_tobool84_i;

assign local_bb1_tobool84_i = (local_bb1_and83_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool84_i337_stall_local;
wire local_bb1_tobool84_i337;

assign local_bb1_tobool84_i337 = (local_bb1_and83_i336 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__34_i65_stall_local;
wire [31:0] local_bb1__34_i65;

assign local_bb1__34_i65 = (local_bb1__31_i62 ? local_bb1_or_i_i59 : local_bb1_or_i17_i51);

// This section implements an unregistered operation.
// 
wire local_bb1__33_i64_stall_local;
wire [31:0] local_bb1__33_i64;

assign local_bb1__33_i64 = (local_bb1_tobool49_i55 ? local_bb1__32_i63 : local_bb1_shl1_i18_i52);

// This section implements an unregistered operation.
// 
wire local_bb1__37_i68_stall_local;
wire [31:0] local_bb1__37_i68;

assign local_bb1__37_i68 = (local_bb1_tobool49_i55 ? local_bb1__36_i67 : local_bb1_inc_i56);

// This section implements an unregistered operation.
// 
wire local_bb1__37_i_valid_out;
wire local_bb1__37_i_stall_in;
 reg local_bb1__37_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp77_i_valid_out;
wire local_bb1_cmp77_i_stall_in;
 reg local_bb1_cmp77_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_and75_i_valid_out;
wire local_bb1_and75_i_stall_in;
 reg local_bb1_and75_i_consumed_0_NO_SHIFT_REG;
wire local_bb1__39_i_valid_out;
wire local_bb1__39_i_stall_in;
 reg local_bb1__39_i_consumed_0_NO_SHIFT_REG;
wire local_bb1__39_i_inputs_ready;
wire local_bb1__39_i_stall_local;
wire local_bb1__39_i;

assign local_bb1__39_i_inputs_ready = (rnode_171to172_bb1_and_i_0_valid_out_2_NO_SHIFT_REG & rnode_171to172_bb1_add_i_0_valid_out_1_NO_SHIFT_REG & local_bb1_mul_i_i_valid_out_0_NO_SHIFT_REG & rnode_171to172_bb1_add_i_0_valid_out_0_NO_SHIFT_REG & local_bb1_mul_i_i_valid_out_1_NO_SHIFT_REG);
assign local_bb1__39_i = (local_bb1_tobool84_i & local_bb1_var__u9);
assign local_bb1__37_i_valid_out = 1'b1;
assign local_bb1_cmp77_i_valid_out = 1'b1;
assign local_bb1_and75_i_valid_out = 1'b1;
assign local_bb1__39_i_valid_out = 1'b1;
assign rnode_171to172_bb1_and_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_add_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_mul_i_i_stall_in_0 = 1'b0;
assign rnode_171to172_bb1_add_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_mul_i_i_stall_in_1 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__37_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp77_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and75_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__39_i_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__37_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1__37_i_consumed_0_NO_SHIFT_REG | ~(local_bb1__37_i_stall_in)) & local_bb1__39_i_stall_local);
		local_bb1_cmp77_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1_cmp77_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp77_i_stall_in)) & local_bb1__39_i_stall_local);
		local_bb1_and75_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1_and75_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and75_i_stall_in)) & local_bb1__39_i_stall_local);
		local_bb1__39_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1__39_i_consumed_0_NO_SHIFT_REG | ~(local_bb1__39_i_stall_in)) & local_bb1__39_i_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__37_i324_valid_out;
wire local_bb1__37_i324_stall_in;
 reg local_bb1__37_i324_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp77_i335_valid_out;
wire local_bb1_cmp77_i335_stall_in;
 reg local_bb1_cmp77_i335_consumed_0_NO_SHIFT_REG;
wire local_bb1_and75_i330_valid_out;
wire local_bb1_and75_i330_stall_in;
 reg local_bb1_and75_i330_consumed_0_NO_SHIFT_REG;
wire local_bb1__39_i338_valid_out;
wire local_bb1__39_i338_stall_in;
 reg local_bb1__39_i338_consumed_0_NO_SHIFT_REG;
wire local_bb1__39_i338_inputs_ready;
wire local_bb1__39_i338_stall_local;
wire local_bb1__39_i338;

assign local_bb1__39_i338_inputs_ready = (rnode_171to172_bb1_and_i283_0_valid_out_2_NO_SHIFT_REG & rnode_171to172_bb1_add_i309_0_valid_out_1_NO_SHIFT_REG & local_bb1_mul_i_i302_valid_out_0_NO_SHIFT_REG & rnode_171to172_bb1_add_i309_0_valid_out_0_NO_SHIFT_REG & local_bb1_mul_i_i302_valid_out_1_NO_SHIFT_REG);
assign local_bb1__39_i338 = (local_bb1_tobool84_i337 & local_bb1_var__u10);
assign local_bb1__37_i324_valid_out = 1'b1;
assign local_bb1_cmp77_i335_valid_out = 1'b1;
assign local_bb1_and75_i330_valid_out = 1'b1;
assign local_bb1__39_i338_valid_out = 1'b1;
assign rnode_171to172_bb1_and_i283_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_add_i309_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_mul_i_i302_stall_in_0 = 1'b0;
assign rnode_171to172_bb1_add_i309_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_mul_i_i302_stall_in_1 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__37_i324_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp77_i335_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and75_i330_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__39_i338_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__37_i324_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i338_inputs_ready & (local_bb1__37_i324_consumed_0_NO_SHIFT_REG | ~(local_bb1__37_i324_stall_in)) & local_bb1__39_i338_stall_local);
		local_bb1_cmp77_i335_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i338_inputs_ready & (local_bb1_cmp77_i335_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp77_i335_stall_in)) & local_bb1__39_i338_stall_local);
		local_bb1_and75_i330_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i338_inputs_ready & (local_bb1_and75_i330_consumed_0_NO_SHIFT_REG | ~(local_bb1_and75_i330_stall_in)) & local_bb1__39_i338_stall_local);
		local_bb1__39_i338_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i338_inputs_ready & (local_bb1__39_i338_consumed_0_NO_SHIFT_REG | ~(local_bb1__39_i338_stall_in)) & local_bb1__39_i338_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1__35_i66_stall_local;
wire [31:0] local_bb1__35_i66;

assign local_bb1__35_i66 = (local_bb1_tobool49_i55 ? local_bb1__34_i65 : local_bb1_or_i17_i51);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp77_i79_stall_local;
wire local_bb1_cmp77_i79;

assign local_bb1_cmp77_i79 = (local_bb1__33_i64 > 32'h80000000);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u11_stall_local;
wire local_bb1_var__u11;

assign local_bb1_var__u11 = ($signed(local_bb1__33_i64) < $signed(32'h0));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1__37_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i_2_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i_3_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1__37_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1__37_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1__37_i_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1__37_i_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1__37_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1__37_i),
	.data_out(rnode_172to173_bb1__37_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1__37_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1__37_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1__37_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1__37_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1__37_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__37_i_stall_in = 1'b0;
assign rnode_172to173_bb1__37_i_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__37_i_0_NO_SHIFT_REG = rnode_172to173_bb1__37_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__37_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__37_i_1_NO_SHIFT_REG = rnode_172to173_bb1__37_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__37_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__37_i_2_NO_SHIFT_REG = rnode_172to173_bb1__37_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__37_i_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__37_i_3_NO_SHIFT_REG = rnode_172to173_bb1__37_i_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_cmp77_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_cmp77_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_cmp77_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_cmp77_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_cmp77_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_cmp77_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_cmp77_i),
	.data_out(rnode_172to173_bb1_cmp77_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_cmp77_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_cmp77_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_cmp77_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_cmp77_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_cmp77_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp77_i_stall_in = 1'b0;
assign rnode_172to173_bb1_cmp77_i_0_NO_SHIFT_REG = rnode_172to173_bb1_cmp77_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_cmp77_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp77_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_and75_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and75_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and75_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_and75_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_and75_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_and75_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_and75_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_and75_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_and75_i),
	.data_out(rnode_172to173_bb1_and75_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_and75_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_and75_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_and75_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_and75_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_and75_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and75_i_stall_in = 1'b0;
assign rnode_172to173_bb1_and75_i_0_NO_SHIFT_REG = rnode_172to173_bb1_and75_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_and75_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and75_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1__39_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1__39_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1__39_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1__39_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1__39_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1__39_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1__39_i),
	.data_out(rnode_172to173_bb1__39_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1__39_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1__39_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1__39_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1__39_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1__39_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__39_i_stall_in = 1'b0;
assign rnode_172to173_bb1__39_i_0_NO_SHIFT_REG = rnode_172to173_bb1__39_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__39_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__39_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1__37_i324_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i324_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i324_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i324_2_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i324_3_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1__37_i324_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__37_i324_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1__37_i324_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1__37_i324_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1__37_i324_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1__37_i324_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1__37_i324_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1__37_i324),
	.data_out(rnode_172to173_bb1__37_i324_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1__37_i324_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1__37_i324_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1__37_i324_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1__37_i324_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1__37_i324_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__37_i324_stall_in = 1'b0;
assign rnode_172to173_bb1__37_i324_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i324_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__37_i324_0_NO_SHIFT_REG = rnode_172to173_bb1__37_i324_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__37_i324_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__37_i324_1_NO_SHIFT_REG = rnode_172to173_bb1__37_i324_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__37_i324_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__37_i324_2_NO_SHIFT_REG = rnode_172to173_bb1__37_i324_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__37_i324_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__37_i324_3_NO_SHIFT_REG = rnode_172to173_bb1__37_i324_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_cmp77_i335_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i335_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i335_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i335_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i335_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i335_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i335_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp77_i335_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_cmp77_i335_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_cmp77_i335_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_cmp77_i335_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_cmp77_i335_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_cmp77_i335_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_cmp77_i335),
	.data_out(rnode_172to173_bb1_cmp77_i335_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_cmp77_i335_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_cmp77_i335_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_cmp77_i335_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_cmp77_i335_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_cmp77_i335_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp77_i335_stall_in = 1'b0;
assign rnode_172to173_bb1_cmp77_i335_0_NO_SHIFT_REG = rnode_172to173_bb1_cmp77_i335_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_cmp77_i335_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp77_i335_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_and75_i330_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i330_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and75_i330_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i330_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and75_i330_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i330_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i330_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and75_i330_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_and75_i330_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_and75_i330_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_and75_i330_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_and75_i330_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_and75_i330_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_and75_i330),
	.data_out(rnode_172to173_bb1_and75_i330_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_and75_i330_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_and75_i330_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_and75_i330_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_and75_i330_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_and75_i330_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and75_i330_stall_in = 1'b0;
assign rnode_172to173_bb1_and75_i330_0_NO_SHIFT_REG = rnode_172to173_bb1_and75_i330_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_and75_i330_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and75_i330_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1__39_i338_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i338_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i338_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i338_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i338_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i338_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i338_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__39_i338_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1__39_i338_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1__39_i338_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1__39_i338_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1__39_i338_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1__39_i338_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1__39_i338),
	.data_out(rnode_172to173_bb1__39_i338_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1__39_i338_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1__39_i338_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1__39_i338_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1__39_i338_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1__39_i338_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__39_i338_stall_in = 1'b0;
assign rnode_172to173_bb1__39_i338_0_NO_SHIFT_REG = rnode_172to173_bb1__39_i338_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__39_i338_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__39_i338_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_and75_i74_stall_local;
wire [31:0] local_bb1_and75_i74;

assign local_bb1_and75_i74 = (local_bb1__35_i66 & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and83_i80_stall_local;
wire [31:0] local_bb1_and83_i80;

assign local_bb1_and83_i80 = (local_bb1__35_i66 & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp53_i_stall_local;
wire local_bb1_cmp53_i;

assign local_bb1_cmp53_i = (rnode_172to173_bb1__37_i_0_NO_SHIFT_REG > 32'h17D);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp68_i_stall_local;
wire local_bb1_cmp68_i;

assign local_bb1_cmp68_i = (rnode_172to173_bb1__37_i_1_NO_SHIFT_REG < 32'h80);

// This section implements an unregistered operation.
// 
wire local_bb1_sub_i_stall_local;
wire [31:0] local_bb1_sub_i;

assign local_bb1_sub_i = (rnode_172to173_bb1__37_i_2_NO_SHIFT_REG << 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp71_not_i_stall_local;
wire local_bb1_cmp71_not_i;

assign local_bb1_cmp71_not_i = (rnode_172to173_bb1__37_i_3_NO_SHIFT_REG != 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1__40_i_stall_local;
wire local_bb1__40_i;

assign local_bb1__40_i = (rnode_172to173_bb1_cmp77_i_0_NO_SHIFT_REG | rnode_172to173_bb1__39_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp53_i325_stall_local;
wire local_bb1_cmp53_i325;

assign local_bb1_cmp53_i325 = (rnode_172to173_bb1__37_i324_0_NO_SHIFT_REG > 32'h17D);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp68_i329_stall_local;
wire local_bb1_cmp68_i329;

assign local_bb1_cmp68_i329 = (rnode_172to173_bb1__37_i324_1_NO_SHIFT_REG < 32'h80);

// This section implements an unregistered operation.
// 
wire local_bb1_sub_i331_stall_local;
wire [31:0] local_bb1_sub_i331;

assign local_bb1_sub_i331 = (rnode_172to173_bb1__37_i324_2_NO_SHIFT_REG << 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp71_not_i346_stall_local;
wire local_bb1_cmp71_not_i346;

assign local_bb1_cmp71_not_i346 = (rnode_172to173_bb1__37_i324_3_NO_SHIFT_REG != 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1__40_i339_stall_local;
wire local_bb1__40_i339;

assign local_bb1__40_i339 = (rnode_172to173_bb1_cmp77_i335_0_NO_SHIFT_REG | rnode_172to173_bb1__39_i338_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool84_i81_stall_local;
wire local_bb1_tobool84_i81;

assign local_bb1_tobool84_i81 = (local_bb1_and83_i80 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or581_i_stall_local;
wire local_bb1_or581_i;

assign local_bb1_or581_i = (rnode_172to173_bb1_cmp_i_1_NO_SHIFT_REG | local_bb1_cmp53_i);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u12_stall_local;
wire [31:0] local_bb1_var__u12;

assign local_bb1_var__u12[31:1] = 31'h0;
assign local_bb1_var__u12[0] = local_bb1_cmp68_i;

// This section implements an unregistered operation.
// 
wire local_bb1_and74_i_stall_local;
wire [31:0] local_bb1_and74_i;

assign local_bb1_and74_i = (local_bb1_sub_i + 32'h40800000);

// This section implements an unregistered operation.
// 
wire local_bb1_cond_i_stall_local;
wire [31:0] local_bb1_cond_i;

assign local_bb1_cond_i[31:1] = 31'h0;
assign local_bb1_cond_i[0] = local_bb1__40_i;

// This section implements an unregistered operation.
// 
wire local_bb1_or581_i326_stall_local;
wire local_bb1_or581_i326;

assign local_bb1_or581_i326 = (rnode_172to173_bb1_cmp_i288_1_NO_SHIFT_REG | local_bb1_cmp53_i325);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u13_stall_local;
wire [31:0] local_bb1_var__u13;

assign local_bb1_var__u13[31:1] = 31'h0;
assign local_bb1_var__u13[0] = local_bb1_cmp68_i329;

// This section implements an unregistered operation.
// 
wire local_bb1_and74_i332_stall_local;
wire [31:0] local_bb1_and74_i332;

assign local_bb1_and74_i332 = (local_bb1_sub_i331 + 32'h40800000);

// This section implements an unregistered operation.
// 
wire local_bb1_cond_i340_stall_local;
wire [31:0] local_bb1_cond_i340;

assign local_bb1_cond_i340[31:1] = 31'h0;
assign local_bb1_cond_i340[0] = local_bb1__40_i339;

// This section implements an unregistered operation.
// 
wire local_bb1__37_i68_valid_out;
wire local_bb1__37_i68_stall_in;
 reg local_bb1__37_i68_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp77_i79_valid_out;
wire local_bb1_cmp77_i79_stall_in;
 reg local_bb1_cmp77_i79_consumed_0_NO_SHIFT_REG;
wire local_bb1_and75_i74_valid_out;
wire local_bb1_and75_i74_stall_in;
 reg local_bb1_and75_i74_consumed_0_NO_SHIFT_REG;
wire local_bb1__39_i82_valid_out;
wire local_bb1__39_i82_stall_in;
 reg local_bb1__39_i82_consumed_0_NO_SHIFT_REG;
wire local_bb1__39_i82_inputs_ready;
wire local_bb1__39_i82_stall_local;
wire local_bb1__39_i82;

assign local_bb1__39_i82_inputs_ready = (rnode_178to179_bb1_and_i27_0_valid_out_2_NO_SHIFT_REG & rnode_178to179_bb1_add_i53_0_valid_out_1_NO_SHIFT_REG & local_bb1_mul_i_i46_valid_out_0_NO_SHIFT_REG & rnode_178to179_bb1_add_i53_0_valid_out_0_NO_SHIFT_REG & local_bb1_mul_i_i46_valid_out_1_NO_SHIFT_REG);
assign local_bb1__39_i82 = (local_bb1_tobool84_i81 & local_bb1_var__u11);
assign local_bb1__37_i68_valid_out = 1'b1;
assign local_bb1_cmp77_i79_valid_out = 1'b1;
assign local_bb1_and75_i74_valid_out = 1'b1;
assign local_bb1__39_i82_valid_out = 1'b1;
assign rnode_178to179_bb1_and_i27_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_add_i53_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign local_bb1_mul_i_i46_stall_in_0 = 1'b0;
assign rnode_178to179_bb1_add_i53_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign local_bb1_mul_i_i46_stall_in_1 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__37_i68_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp77_i79_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and75_i74_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__39_i82_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__37_i68_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i82_inputs_ready & (local_bb1__37_i68_consumed_0_NO_SHIFT_REG | ~(local_bb1__37_i68_stall_in)) & local_bb1__39_i82_stall_local);
		local_bb1_cmp77_i79_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i82_inputs_ready & (local_bb1_cmp77_i79_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp77_i79_stall_in)) & local_bb1__39_i82_stall_local);
		local_bb1_and75_i74_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i82_inputs_ready & (local_bb1_and75_i74_consumed_0_NO_SHIFT_REG | ~(local_bb1_and75_i74_stall_in)) & local_bb1__39_i82_stall_local);
		local_bb1__39_i82_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i82_inputs_ready & (local_bb1__39_i82_consumed_0_NO_SHIFT_REG | ~(local_bb1__39_i82_stall_in)) & local_bb1__39_i82_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_reduction_2_i_stall_local;
wire local_bb1_reduction_2_i;

assign local_bb1_reduction_2_i = (rnode_172to173_bb1_lnot_i_0_NO_SHIFT_REG | local_bb1_or581_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cond111_i_stall_local;
wire [31:0] local_bb1_cond111_i;

assign local_bb1_cond111_i = (local_bb1_or581_i ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i_stall_local;
wire [31:0] local_bb1_shl_i;

assign local_bb1_shl_i = (local_bb1_and74_i & 32'h7F800000);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_2_i328_stall_local;
wire local_bb1_reduction_2_i328;

assign local_bb1_reduction_2_i328 = (rnode_172to173_bb1_lnot_i287_0_NO_SHIFT_REG | local_bb1_or581_i326);

// This section implements an unregistered operation.
// 
wire local_bb1_cond111_i354_stall_local;
wire [31:0] local_bb1_cond111_i354;

assign local_bb1_cond111_i354 = (local_bb1_or581_i326 ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i333_stall_local;
wire [31:0] local_bb1_shl_i333;

assign local_bb1_shl_i333 = (local_bb1_and74_i332 & 32'h7F800000);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1__37_i68_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__37_i68_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__37_i68_1_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__37_i68_2_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__37_i68_3_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1__37_i68_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_valid_out_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_stall_in_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__37_i68_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1__37_i68_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1__37_i68_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1__37_i68_0_stall_in_0_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1__37_i68_0_valid_out_0_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1__37_i68_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1__37_i68),
	.data_out(rnode_179to180_bb1__37_i68_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1__37_i68_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1__37_i68_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1__37_i68_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1__37_i68_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1__37_i68_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__37_i68_stall_in = 1'b0;
assign rnode_179to180_bb1__37_i68_0_stall_in_0_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__37_i68_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_179to180_bb1__37_i68_0_NO_SHIFT_REG = rnode_179to180_bb1__37_i68_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1__37_i68_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_179to180_bb1__37_i68_1_NO_SHIFT_REG = rnode_179to180_bb1__37_i68_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1__37_i68_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_179to180_bb1__37_i68_2_NO_SHIFT_REG = rnode_179to180_bb1__37_i68_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1__37_i68_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_179to180_bb1__37_i68_3_NO_SHIFT_REG = rnode_179to180_bb1__37_i68_0_reg_180_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_cmp77_i79_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp77_i79_0_stall_in_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp77_i79_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp77_i79_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp77_i79_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp77_i79_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp77_i79_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_cmp77_i79_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_cmp77_i79_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_cmp77_i79_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_cmp77_i79_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_cmp77_i79_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_cmp77_i79_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1_cmp77_i79),
	.data_out(rnode_179to180_bb1_cmp77_i79_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_cmp77_i79_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_cmp77_i79_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1_cmp77_i79_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_cmp77_i79_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_cmp77_i79_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp77_i79_stall_in = 1'b0;
assign rnode_179to180_bb1_cmp77_i79_0_NO_SHIFT_REG = rnode_179to180_bb1_cmp77_i79_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_cmp77_i79_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_cmp77_i79_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_and75_i74_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and75_i74_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_and75_i74_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and75_i74_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_and75_i74_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and75_i74_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and75_i74_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_and75_i74_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_and75_i74_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_and75_i74_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_and75_i74_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_and75_i74_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_and75_i74_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1_and75_i74),
	.data_out(rnode_179to180_bb1_and75_i74_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_and75_i74_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_and75_i74_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_and75_i74_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_and75_i74_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_and75_i74_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and75_i74_stall_in = 1'b0;
assign rnode_179to180_bb1_and75_i74_0_NO_SHIFT_REG = rnode_179to180_bb1_and75_i74_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_and75_i74_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_and75_i74_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1__39_i82_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1__39_i82_0_stall_in_NO_SHIFT_REG;
 logic rnode_179to180_bb1__39_i82_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1__39_i82_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1__39_i82_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__39_i82_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__39_i82_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__39_i82_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1__39_i82_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1__39_i82_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1__39_i82_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1__39_i82_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1__39_i82_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1__39_i82),
	.data_out(rnode_179to180_bb1__39_i82_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1__39_i82_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1__39_i82_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1__39_i82_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1__39_i82_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1__39_i82_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__39_i82_stall_in = 1'b0;
assign rnode_179to180_bb1__39_i82_0_NO_SHIFT_REG = rnode_179to180_bb1__39_i82_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1__39_i82_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__39_i82_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_conv101_i_stall_local;
wire [31:0] local_bb1_conv101_i;

assign local_bb1_conv101_i[31:1] = 31'h0;
assign local_bb1_conv101_i[0] = local_bb1_reduction_2_i;

// This section implements an unregistered operation.
// 
wire local_bb1_or76_i_stall_local;
wire [31:0] local_bb1_or76_i;

assign local_bb1_or76_i = (local_bb1_shl_i | rnode_172to173_bb1_and75_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_conv101_i349_stall_local;
wire [31:0] local_bb1_conv101_i349;

assign local_bb1_conv101_i349[31:1] = 31'h0;
assign local_bb1_conv101_i349[0] = local_bb1_reduction_2_i328;

// This section implements an unregistered operation.
// 
wire local_bb1_or76_i334_stall_local;
wire [31:0] local_bb1_or76_i334;

assign local_bb1_or76_i334 = (local_bb1_shl_i333 | rnode_172to173_bb1_and75_i330_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp53_i69_stall_local;
wire local_bb1_cmp53_i69;

assign local_bb1_cmp53_i69 = (rnode_179to180_bb1__37_i68_0_NO_SHIFT_REG > 32'h17D);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp68_i73_stall_local;
wire local_bb1_cmp68_i73;

assign local_bb1_cmp68_i73 = (rnode_179to180_bb1__37_i68_1_NO_SHIFT_REG < 32'h80);

// This section implements an unregistered operation.
// 
wire local_bb1_sub_i75_stall_local;
wire [31:0] local_bb1_sub_i75;

assign local_bb1_sub_i75 = (rnode_179to180_bb1__37_i68_2_NO_SHIFT_REG << 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp71_not_i90_stall_local;
wire local_bb1_cmp71_not_i90;

assign local_bb1_cmp71_not_i90 = (rnode_179to180_bb1__37_i68_3_NO_SHIFT_REG != 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1__40_i83_stall_local;
wire local_bb1__40_i83;

assign local_bb1__40_i83 = (rnode_179to180_bb1_cmp77_i79_0_NO_SHIFT_REG | rnode_179to180_bb1__39_i82_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_add87_i_stall_local;
wire [31:0] local_bb1_add87_i;

assign local_bb1_add87_i = (local_bb1_cond_i + local_bb1_or76_i);

// This section implements an unregistered operation.
// 
wire local_bb1_add87_i341_stall_local;
wire [31:0] local_bb1_add87_i341;

assign local_bb1_add87_i341 = (local_bb1_cond_i340 + local_bb1_or76_i334);

// This section implements an unregistered operation.
// 
wire local_bb1_or581_i70_stall_local;
wire local_bb1_or581_i70;

assign local_bb1_or581_i70 = (rnode_179to180_bb1_cmp_i32_1_NO_SHIFT_REG | local_bb1_cmp53_i69);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u14_stall_local;
wire [31:0] local_bb1_var__u14;

assign local_bb1_var__u14[31:1] = 31'h0;
assign local_bb1_var__u14[0] = local_bb1_cmp68_i73;

// This section implements an unregistered operation.
// 
wire local_bb1_and74_i76_stall_local;
wire [31:0] local_bb1_and74_i76;

assign local_bb1_and74_i76 = (local_bb1_sub_i75 + 32'h40800000);

// This section implements an unregistered operation.
// 
wire local_bb1_cond_i84_stall_local;
wire [31:0] local_bb1_cond_i84;

assign local_bb1_cond_i84[31:1] = 31'h0;
assign local_bb1_cond_i84[0] = local_bb1__40_i83;

// This section implements an unregistered operation.
// 
wire local_bb1_and88_i_stall_local;
wire [31:0] local_bb1_and88_i;

assign local_bb1_and88_i = (local_bb1_add87_i & 32'h7FFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and90_i_stall_local;
wire [31:0] local_bb1_and90_i;

assign local_bb1_and90_i = (local_bb1_add87_i & 32'h800000);

// This section implements an unregistered operation.
// 
wire local_bb1_and88_i342_stall_local;
wire [31:0] local_bb1_and88_i342;

assign local_bb1_and88_i342 = (local_bb1_add87_i341 & 32'h7FFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and90_i344_stall_local;
wire [31:0] local_bb1_and90_i344;

assign local_bb1_and90_i344 = (local_bb1_add87_i341 & 32'h800000);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_2_i72_stall_local;
wire local_bb1_reduction_2_i72;

assign local_bb1_reduction_2_i72 = (rnode_179to180_bb1_lnot_i31_0_NO_SHIFT_REG | local_bb1_or581_i70);

// This section implements an unregistered operation.
// 
wire local_bb1_cond111_i98_stall_local;
wire [31:0] local_bb1_cond111_i98;

assign local_bb1_cond111_i98 = (local_bb1_or581_i70 ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i77_stall_local;
wire [31:0] local_bb1_shl_i77;

assign local_bb1_shl_i77 = (local_bb1_and74_i76 & 32'h7F800000);

// This section implements an unregistered operation.
// 
wire local_bb1_or89_i_stall_local;
wire [31:0] local_bb1_or89_i;

assign local_bb1_or89_i = (local_bb1_and88_i | rnode_172to173_bb1_and4_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp91_i_stall_local;
wire local_bb1_cmp91_i;

assign local_bb1_cmp91_i = (local_bb1_and90_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or89_i343_stall_local;
wire [31:0] local_bb1_or89_i343;

assign local_bb1_or89_i343 = (local_bb1_and88_i342 | rnode_172to173_bb1_and4_i285_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp91_i345_stall_local;
wire local_bb1_cmp91_i345;

assign local_bb1_cmp91_i345 = (local_bb1_and90_i344 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_conv101_i93_stall_local;
wire [31:0] local_bb1_conv101_i93;

assign local_bb1_conv101_i93[31:1] = 31'h0;
assign local_bb1_conv101_i93[0] = local_bb1_reduction_2_i72;

// This section implements an unregistered operation.
// 
wire local_bb1_or76_i78_stall_local;
wire [31:0] local_bb1_or76_i78;

assign local_bb1_or76_i78 = (local_bb1_shl_i77 | rnode_179to180_bb1_and75_i74_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge14_i_stall_local;
wire local_bb1_brmerge14_i;

assign local_bb1_brmerge14_i = (local_bb1_cmp91_i | local_bb1_cmp71_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge14_i347_stall_local;
wire local_bb1_brmerge14_i347;

assign local_bb1_brmerge14_i347 = (local_bb1_cmp91_i345 | local_bb1_cmp71_not_i346);

// This section implements an unregistered operation.
// 
wire local_bb1_add87_i85_stall_local;
wire [31:0] local_bb1_add87_i85;

assign local_bb1_add87_i85 = (local_bb1_cond_i84 + local_bb1_or76_i78);

// This section implements an unregistered operation.
// 
wire local_bb1_conv99_i_stall_local;
wire [31:0] local_bb1_conv99_i;

assign local_bb1_conv99_i = (local_bb1_brmerge14_i ? local_bb1_var__u12 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_conv99_i348_stall_local;
wire [31:0] local_bb1_conv99_i348;

assign local_bb1_conv99_i348 = (local_bb1_brmerge14_i347 ? local_bb1_var__u13 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_and88_i86_stall_local;
wire [31:0] local_bb1_and88_i86;

assign local_bb1_and88_i86 = (local_bb1_add87_i85 & 32'h7FFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and90_i88_stall_local;
wire [31:0] local_bb1_and90_i88;

assign local_bb1_and90_i88 = (local_bb1_add87_i85 & 32'h800000);

// This section implements an unregistered operation.
// 
wire local_bb1_or102_i_stall_local;
wire [31:0] local_bb1_or102_i;

assign local_bb1_or102_i = (local_bb1_conv99_i | local_bb1_conv101_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or102_i350_stall_local;
wire [31:0] local_bb1_or102_i350;

assign local_bb1_or102_i350 = (local_bb1_conv99_i348 | local_bb1_conv101_i349);

// This section implements an unregistered operation.
// 
wire local_bb1_or89_i87_stall_local;
wire [31:0] local_bb1_or89_i87;

assign local_bb1_or89_i87 = (local_bb1_and88_i86 | rnode_179to180_bb1_and4_i29_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp91_i89_stall_local;
wire local_bb1_cmp91_i89;

assign local_bb1_cmp91_i89 = (local_bb1_and90_i88 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool103_i_stall_local;
wire local_bb1_tobool103_i;

assign local_bb1_tobool103_i = (local_bb1_or102_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool103_i351_stall_local;
wire local_bb1_tobool103_i351;

assign local_bb1_tobool103_i351 = (local_bb1_or102_i350 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge14_i91_stall_local;
wire local_bb1_brmerge14_i91;

assign local_bb1_brmerge14_i91 = (local_bb1_cmp91_i89 | local_bb1_cmp71_not_i90);

// This section implements an unregistered operation.
// 
wire local_bb1_cond107_i_stall_local;
wire [31:0] local_bb1_cond107_i;

assign local_bb1_cond107_i = (local_bb1_tobool103_i ? rnode_172to173_bb1_and4_i_1_NO_SHIFT_REG : 32'hFFFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_cond107_i352_stall_local;
wire [31:0] local_bb1_cond107_i352;

assign local_bb1_cond107_i352 = (local_bb1_tobool103_i351 ? rnode_172to173_bb1_and4_i285_1_NO_SHIFT_REG : 32'hFFFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_conv99_i92_stall_local;
wire [31:0] local_bb1_conv99_i92;

assign local_bb1_conv99_i92 = (local_bb1_brmerge14_i91 ? local_bb1_var__u14 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_and108_i_stall_local;
wire [31:0] local_bb1_and108_i;

assign local_bb1_and108_i = (local_bb1_cond107_i & local_bb1_or89_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and108_i353_stall_local;
wire [31:0] local_bb1_and108_i353;

assign local_bb1_and108_i353 = (local_bb1_cond107_i352 & local_bb1_or89_i343);

// This section implements an unregistered operation.
// 
wire local_bb1_or102_i94_stall_local;
wire [31:0] local_bb1_or102_i94;

assign local_bb1_or102_i94 = (local_bb1_conv99_i92 | local_bb1_conv101_i93);

// This section implements an unregistered operation.
// 
wire local_bb1_or112_i_stall_local;
wire [31:0] local_bb1_or112_i;

assign local_bb1_or112_i = (local_bb1_and108_i | local_bb1_cond111_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or112_i355_stall_local;
wire [31:0] local_bb1_or112_i355;

assign local_bb1_or112_i355 = (local_bb1_and108_i353 | local_bb1_cond111_i354);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool103_i95_stall_local;
wire local_bb1_tobool103_i95;

assign local_bb1_tobool103_i95 = (local_bb1_or102_i94 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u15_valid_out;
wire local_bb1_var__u15_stall_in;
wire local_bb1_var__u15_inputs_ready;
wire local_bb1_var__u15_stall_local;
wire [31:0] local_bb1_var__u15;

assign local_bb1_var__u15_inputs_ready = (rnode_172to173_bb1_and4_i_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb1_and4_i_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb1_cmp_i_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb1_lnot14_not_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_lnot_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_cmp_i_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb1__37_i_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb1__37_i_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb1__37_i_0_valid_out_3_NO_SHIFT_REG & rnode_172to173_bb1__37_i_0_valid_out_2_NO_SHIFT_REG & rnode_172to173_bb1_and75_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_cmp77_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1__39_i_0_valid_out_NO_SHIFT_REG);
assign local_bb1_var__u15 = (local_bb1__28_i ? 32'h7FC00000 : local_bb1_or112_i);
assign local_bb1_var__u15_valid_out = 1'b1;
assign rnode_172to173_bb1_and4_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and4_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot14_not_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and75_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp77_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__39_i_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u16_valid_out;
wire local_bb1_var__u16_stall_in;
wire local_bb1_var__u16_inputs_ready;
wire local_bb1_var__u16_stall_local;
wire [31:0] local_bb1_var__u16;

assign local_bb1_var__u16_inputs_ready = (rnode_172to173_bb1_and4_i285_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb1_and4_i285_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb1_cmp_i288_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb1_lnot14_not_i297_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_lnot_i287_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_cmp_i288_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb1__37_i324_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb1__37_i324_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb1__37_i324_0_valid_out_3_NO_SHIFT_REG & rnode_172to173_bb1__37_i324_0_valid_out_2_NO_SHIFT_REG & rnode_172to173_bb1_and75_i330_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_cmp77_i335_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1__39_i338_0_valid_out_NO_SHIFT_REG);
assign local_bb1_var__u16 = (local_bb1__28_i298 ? 32'h7FC00000 : local_bb1_or112_i355);
assign local_bb1_var__u16_valid_out = 1'b1;
assign rnode_172to173_bb1_and4_i285_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and4_i285_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp_i288_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot14_not_i297_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_lnot_i287_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp_i288_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i324_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i324_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i324_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__37_i324_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and75_i330_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp77_i335_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__39_i338_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_cond107_i96_stall_local;
wire [31:0] local_bb1_cond107_i96;

assign local_bb1_cond107_i96 = (local_bb1_tobool103_i95 ? rnode_179to180_bb1_and4_i29_1_NO_SHIFT_REG : 32'hFFFFFFFF);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_var__u15_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u15_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u15_1_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u15_2_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u15_3_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u15_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_valid_out_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_stall_in_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u15_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_var__u15_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_var__u15_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_var__u15_0_stall_in_0_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_var__u15_0_valid_out_0_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_var__u15_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_var__u15),
	.data_out(rnode_173to174_bb1_var__u15_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_var__u15_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_var__u15_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_var__u15_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_var__u15_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_var__u15_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u15_stall_in = 1'b0;
assign rnode_173to174_bb1_var__u15_0_stall_in_0_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u15_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_var__u15_0_NO_SHIFT_REG = rnode_173to174_bb1_var__u15_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_var__u15_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_var__u15_1_NO_SHIFT_REG = rnode_173to174_bb1_var__u15_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_var__u15_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_var__u15_2_NO_SHIFT_REG = rnode_173to174_bb1_var__u15_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_var__u15_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_var__u15_3_NO_SHIFT_REG = rnode_173to174_bb1_var__u15_0_reg_174_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_var__u16_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u16_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u16_1_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u16_2_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u16_3_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u16_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_valid_out_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_stall_in_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u16_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_var__u16_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_var__u16_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_var__u16_0_stall_in_0_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_var__u16_0_valid_out_0_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_var__u16_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_var__u16),
	.data_out(rnode_173to174_bb1_var__u16_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_var__u16_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_var__u16_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_var__u16_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_var__u16_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_var__u16_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u16_stall_in = 1'b0;
assign rnode_173to174_bb1_var__u16_0_stall_in_0_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u16_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_var__u16_0_NO_SHIFT_REG = rnode_173to174_bb1_var__u16_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_var__u16_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_var__u16_1_NO_SHIFT_REG = rnode_173to174_bb1_var__u16_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_var__u16_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_var__u16_2_NO_SHIFT_REG = rnode_173to174_bb1_var__u16_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_var__u16_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_173to174_bb1_var__u16_3_NO_SHIFT_REG = rnode_173to174_bb1_var__u16_0_reg_174_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and108_i97_stall_local;
wire [31:0] local_bb1_and108_i97;

assign local_bb1_and108_i97 = (local_bb1_cond107_i96 & local_bb1_or89_i87);

// This section implements an unregistered operation.
// 
wire local_bb1_and2_i102_stall_local;
wire [31:0] local_bb1_and2_i102;

assign local_bb1_and2_i102 = (rnode_173to174_bb1_var__u15_0_NO_SHIFT_REG >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_and12_i107_stall_local;
wire [31:0] local_bb1_and12_i107;

assign local_bb1_and12_i107 = (rnode_173to174_bb1_var__u15_1_NO_SHIFT_REG & 32'hFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and_i100_stall_local;
wire [31:0] local_bb1_and_i100;

assign local_bb1_and_i100 = (rnode_173to174_bb1_var__u16_0_NO_SHIFT_REG >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_and10_i106_stall_local;
wire [31:0] local_bb1_and10_i106;

assign local_bb1_and10_i106 = (rnode_173to174_bb1_var__u16_1_NO_SHIFT_REG & 32'hFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_or112_i99_stall_local;
wire [31:0] local_bb1_or112_i99;

assign local_bb1_or112_i99 = (local_bb1_and108_i97 | local_bb1_cond111_i98);

// This section implements an unregistered operation.
// 
wire local_bb1_shr3_i103_stall_local;
wire [31:0] local_bb1_shr3_i103;

assign local_bb1_shr3_i103 = (local_bb1_and2_i102 & 32'h7FFF);

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i101_stall_local;
wire [31:0] local_bb1_shr_i101;

assign local_bb1_shr_i101 = (local_bb1_and_i100 & 32'h7FFF);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp13_i108_stall_local;
wire local_bb1_cmp13_i108;

assign local_bb1_cmp13_i108 = (local_bb1_and10_i106 > local_bb1_and12_i107);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u17_valid_out;
wire local_bb1_var__u17_stall_in;
wire local_bb1_var__u17_inputs_ready;
wire local_bb1_var__u17_stall_local;
wire [31:0] local_bb1_var__u17;

assign local_bb1_var__u17_inputs_ready = (rnode_179to180_bb1_and4_i29_0_valid_out_0_NO_SHIFT_REG & rnode_179to180_bb1_and4_i29_0_valid_out_1_NO_SHIFT_REG & rnode_179to180_bb1_cmp_i32_0_valid_out_0_NO_SHIFT_REG & rnode_179to180_bb1_lnot14_not_i41_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_lnot_i31_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_cmp_i32_0_valid_out_1_NO_SHIFT_REG & rnode_179to180_bb1__37_i68_0_valid_out_0_NO_SHIFT_REG & rnode_179to180_bb1__37_i68_0_valid_out_1_NO_SHIFT_REG & rnode_179to180_bb1__37_i68_0_valid_out_3_NO_SHIFT_REG & rnode_179to180_bb1__37_i68_0_valid_out_2_NO_SHIFT_REG & rnode_179to180_bb1_and75_i74_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_cmp77_i79_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1__39_i82_0_valid_out_NO_SHIFT_REG);
assign local_bb1_var__u17 = (local_bb1__28_i42 ? 32'h7FC00000 : local_bb1_or112_i99);
assign local_bb1_var__u17_valid_out = 1'b1;
assign rnode_179to180_bb1_and4_i29_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_and4_i29_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_cmp_i32_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_lnot14_not_i41_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_lnot_i31_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_cmp_i32_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__37_i68_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__37_i68_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__37_i68_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__37_i68_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_and75_i74_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_cmp77_i79_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__39_i82_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_i104_stall_local;
wire local_bb1_cmp_i104;

assign local_bb1_cmp_i104 = (local_bb1_shr_i101 > local_bb1_shr3_i103);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp8_i105_stall_local;
wire local_bb1_cmp8_i105;

assign local_bb1_cmp8_i105 = (local_bb1_shr_i101 == local_bb1_shr3_i103);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_180to181_bb1_var__u17_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_var__u17_0_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_var__u17_1_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_var__u17_2_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_var__u17_3_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_reg_181_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_var__u17_0_reg_181_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_valid_out_0_reg_181_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_stall_in_0_reg_181_NO_SHIFT_REG;
 logic rnode_180to181_bb1_var__u17_0_stall_out_reg_181_NO_SHIFT_REG;

acl_data_fifo rnode_180to181_bb1_var__u17_0_reg_181_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_180to181_bb1_var__u17_0_reg_181_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_180to181_bb1_var__u17_0_stall_in_0_reg_181_NO_SHIFT_REG),
	.valid_out(rnode_180to181_bb1_var__u17_0_valid_out_0_reg_181_NO_SHIFT_REG),
	.stall_out(rnode_180to181_bb1_var__u17_0_stall_out_reg_181_NO_SHIFT_REG),
	.data_in(local_bb1_var__u17),
	.data_out(rnode_180to181_bb1_var__u17_0_reg_181_NO_SHIFT_REG)
);

defparam rnode_180to181_bb1_var__u17_0_reg_181_fifo.DEPTH = 1;
defparam rnode_180to181_bb1_var__u17_0_reg_181_fifo.DATA_WIDTH = 32;
defparam rnode_180to181_bb1_var__u17_0_reg_181_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_180to181_bb1_var__u17_0_reg_181_fifo.IMPL = "shift_reg";

assign rnode_180to181_bb1_var__u17_0_reg_181_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u17_stall_in = 1'b0;
assign rnode_180to181_bb1_var__u17_0_stall_in_0_reg_181_NO_SHIFT_REG = 1'b0;
assign rnode_180to181_bb1_var__u17_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_180to181_bb1_var__u17_0_NO_SHIFT_REG = rnode_180to181_bb1_var__u17_0_reg_181_NO_SHIFT_REG;
assign rnode_180to181_bb1_var__u17_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_180to181_bb1_var__u17_1_NO_SHIFT_REG = rnode_180to181_bb1_var__u17_0_reg_181_NO_SHIFT_REG;
assign rnode_180to181_bb1_var__u17_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_180to181_bb1_var__u17_2_NO_SHIFT_REG = rnode_180to181_bb1_var__u17_0_reg_181_NO_SHIFT_REG;
assign rnode_180to181_bb1_var__u17_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_180to181_bb1_var__u17_3_NO_SHIFT_REG = rnode_180to181_bb1_var__u17_0_reg_181_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1___i109_stall_local;
wire local_bb1___i109;

assign local_bb1___i109 = (local_bb1_cmp8_i105 & local_bb1_cmp13_i108);

// This section implements an unregistered operation.
// 
wire local_bb1_and_i1_stall_local;
wire [31:0] local_bb1_and_i1;

assign local_bb1_and_i1 = (rnode_180to181_bb1_var__u17_0_NO_SHIFT_REG >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_and10_i_stall_local;
wire [31:0] local_bb1_and10_i;

assign local_bb1_and10_i = (rnode_180to181_bb1_var__u17_1_NO_SHIFT_REG & 32'hFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1__21_i110_stall_local;
wire local_bb1__21_i110;

assign local_bb1__21_i110 = (local_bb1_cmp_i104 | local_bb1___i109);

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i2_stall_local;
wire [31:0] local_bb1_shr_i2;

assign local_bb1_shr_i2 = (local_bb1_and_i1 & 32'h7FFF);

// This section implements an unregistered operation.
// 
wire local_bb1__22_i111_stall_local;
wire [31:0] local_bb1__22_i111;

assign local_bb1__22_i111 = (local_bb1__21_i110 ? rnode_173to174_bb1_var__u15_2_NO_SHIFT_REG : rnode_173to174_bb1_var__u16_2_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1__22_i111_valid_out;
wire local_bb1__22_i111_stall_in;
 reg local_bb1__22_i111_consumed_0_NO_SHIFT_REG;
wire local_bb1__23_i112_valid_out;
wire local_bb1__23_i112_stall_in;
 reg local_bb1__23_i112_consumed_0_NO_SHIFT_REG;
wire local_bb1__23_i112_inputs_ready;
wire local_bb1__23_i112_stall_local;
wire [31:0] local_bb1__23_i112;

assign local_bb1__23_i112_inputs_ready = (rnode_173to174_bb1_var__u15_0_valid_out_0_NO_SHIFT_REG & rnode_173to174_bb1_var__u16_0_valid_out_0_NO_SHIFT_REG & rnode_173to174_bb1_var__u15_0_valid_out_1_NO_SHIFT_REG & rnode_173to174_bb1_var__u16_0_valid_out_1_NO_SHIFT_REG & rnode_173to174_bb1_var__u15_0_valid_out_2_NO_SHIFT_REG & rnode_173to174_bb1_var__u16_0_valid_out_2_NO_SHIFT_REG & rnode_173to174_bb1_var__u16_0_valid_out_3_NO_SHIFT_REG & rnode_173to174_bb1_var__u15_0_valid_out_3_NO_SHIFT_REG);
assign local_bb1__23_i112 = (local_bb1__21_i110 ? rnode_173to174_bb1_var__u16_3_NO_SHIFT_REG : rnode_173to174_bb1_var__u15_3_NO_SHIFT_REG);
assign local_bb1__22_i111_valid_out = 1'b1;
assign local_bb1__23_i112_valid_out = 1'b1;
assign rnode_173to174_bb1_var__u15_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u16_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u15_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u16_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u15_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u16_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u16_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u15_0_stall_in_3_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__22_i111_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__23_i112_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__22_i111_consumed_0_NO_SHIFT_REG <= (local_bb1__23_i112_inputs_ready & (local_bb1__22_i111_consumed_0_NO_SHIFT_REG | ~(local_bb1__22_i111_stall_in)) & local_bb1__23_i112_stall_local);
		local_bb1__23_i112_consumed_0_NO_SHIFT_REG <= (local_bb1__23_i112_inputs_ready & (local_bb1__23_i112_consumed_0_NO_SHIFT_REG | ~(local_bb1__23_i112_stall_in)) & local_bb1__23_i112_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb1__22_i111_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1__22_i111_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__22_i111_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1__22_i111_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_174to175_bb1__22_i111_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__22_i111_1_NO_SHIFT_REG;
 logic rnode_174to175_bb1__22_i111_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__22_i111_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__22_i111_0_valid_out_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__22_i111_0_stall_in_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__22_i111_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb1__22_i111_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb1__22_i111_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb1__22_i111_0_stall_in_0_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb1__22_i111_0_valid_out_0_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb1__22_i111_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb1__22_i111),
	.data_out(rnode_174to175_bb1__22_i111_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb1__22_i111_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb1__22_i111_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb1__22_i111_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb1__22_i111_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb1__22_i111_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__22_i111_stall_in = 1'b0;
assign rnode_174to175_bb1__22_i111_0_stall_in_0_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1__22_i111_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1__22_i111_0_NO_SHIFT_REG = rnode_174to175_bb1__22_i111_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb1__22_i111_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1__22_i111_1_NO_SHIFT_REG = rnode_174to175_bb1__22_i111_0_reg_175_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_174to175_bb1__23_i112_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1__23_i112_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__23_i112_0_NO_SHIFT_REG;
 logic rnode_174to175_bb1__23_i112_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_174to175_bb1__23_i112_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__23_i112_1_NO_SHIFT_REG;
 logic rnode_174to175_bb1__23_i112_0_reg_175_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_174to175_bb1__23_i112_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__23_i112_0_valid_out_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__23_i112_0_stall_in_0_reg_175_NO_SHIFT_REG;
 logic rnode_174to175_bb1__23_i112_0_stall_out_reg_175_NO_SHIFT_REG;

acl_data_fifo rnode_174to175_bb1__23_i112_0_reg_175_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_174to175_bb1__23_i112_0_reg_175_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_174to175_bb1__23_i112_0_stall_in_0_reg_175_NO_SHIFT_REG),
	.valid_out(rnode_174to175_bb1__23_i112_0_valid_out_0_reg_175_NO_SHIFT_REG),
	.stall_out(rnode_174to175_bb1__23_i112_0_stall_out_reg_175_NO_SHIFT_REG),
	.data_in(local_bb1__23_i112),
	.data_out(rnode_174to175_bb1__23_i112_0_reg_175_NO_SHIFT_REG)
);

defparam rnode_174to175_bb1__23_i112_0_reg_175_fifo.DEPTH = 1;
defparam rnode_174to175_bb1__23_i112_0_reg_175_fifo.DATA_WIDTH = 32;
defparam rnode_174to175_bb1__23_i112_0_reg_175_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_174to175_bb1__23_i112_0_reg_175_fifo.IMPL = "shift_reg";

assign rnode_174to175_bb1__23_i112_0_reg_175_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__23_i112_stall_in = 1'b0;
assign rnode_174to175_bb1__23_i112_0_stall_in_0_reg_175_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1__23_i112_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1__23_i112_0_NO_SHIFT_REG = rnode_174to175_bb1__23_i112_0_reg_175_NO_SHIFT_REG;
assign rnode_174to175_bb1__23_i112_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1__23_i112_1_NO_SHIFT_REG = rnode_174to175_bb1__23_i112_0_reg_175_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr18_i115_stall_local;
wire [31:0] local_bb1_shr18_i115;

assign local_bb1_shr18_i115 = (rnode_174to175_bb1__22_i111_0_NO_SHIFT_REG >> 32'h17);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1__22_i111_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1__22_i111_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1__22_i111_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1__22_i111_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1__22_i111_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1__22_i111_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1__22_i111_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1__22_i111_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1__22_i111_0_valid_out_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1__22_i111_0_stall_in_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1__22_i111_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1__22_i111_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1__22_i111_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1__22_i111_0_stall_in_0_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1__22_i111_0_valid_out_0_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1__22_i111_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(rnode_174to175_bb1__22_i111_1_NO_SHIFT_REG),
	.data_out(rnode_175to176_bb1__22_i111_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1__22_i111_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1__22_i111_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb1__22_i111_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1__22_i111_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1__22_i111_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1__22_i111_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1__22_i111_0_stall_in_0_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1__22_i111_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1__22_i111_0_NO_SHIFT_REG = rnode_175to176_bb1__22_i111_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1__22_i111_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1__22_i111_1_NO_SHIFT_REG = rnode_175to176_bb1__22_i111_0_reg_176_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr16_i113_stall_local;
wire [31:0] local_bb1_shr16_i113;

assign local_bb1_shr16_i113 = (rnode_174to175_bb1__23_i112_0_NO_SHIFT_REG >> 32'h17);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1__23_i112_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1__23_i112_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1__23_i112_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1__23_i112_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1__23_i112_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1__23_i112_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1__23_i112_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_175to176_bb1__23_i112_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1__23_i112_2_NO_SHIFT_REG;
 logic rnode_175to176_bb1__23_i112_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1__23_i112_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1__23_i112_0_valid_out_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1__23_i112_0_stall_in_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1__23_i112_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1__23_i112_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1__23_i112_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1__23_i112_0_stall_in_0_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1__23_i112_0_valid_out_0_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1__23_i112_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(rnode_174to175_bb1__23_i112_1_NO_SHIFT_REG),
	.data_out(rnode_175to176_bb1__23_i112_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1__23_i112_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1__23_i112_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb1__23_i112_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1__23_i112_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1__23_i112_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_174to175_bb1__23_i112_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1__23_i112_0_stall_in_0_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1__23_i112_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1__23_i112_0_NO_SHIFT_REG = rnode_175to176_bb1__23_i112_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1__23_i112_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1__23_i112_1_NO_SHIFT_REG = rnode_175to176_bb1__23_i112_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1__23_i112_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1__23_i112_2_NO_SHIFT_REG = rnode_175to176_bb1__23_i112_0_reg_176_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and19_i116_stall_local;
wire [31:0] local_bb1_and19_i116;

assign local_bb1_and19_i116 = (local_bb1_shr18_i115 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and21_i118_stall_local;
wire [31:0] local_bb1_and21_i118;

assign local_bb1_and21_i118 = (rnode_175to176_bb1__22_i111_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_sub_i145_stall_local;
wire [31:0] local_bb1_sub_i145;

assign local_bb1_sub_i145 = (local_bb1_shr16_i113 - local_bb1_shr18_i115);

// This section implements an unregistered operation.
// 
wire local_bb1_and20_i117_stall_local;
wire [31:0] local_bb1_and20_i117;

assign local_bb1_and20_i117 = (rnode_175to176_bb1__23_i112_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and35_i123_valid_out;
wire local_bb1_and35_i123_stall_in;
wire local_bb1_and35_i123_inputs_ready;
wire local_bb1_and35_i123_stall_local;
wire [31:0] local_bb1_and35_i123;

assign local_bb1_and35_i123_inputs_ready = rnode_175to176_bb1__23_i112_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_and35_i123 = (rnode_175to176_bb1__23_i112_1_NO_SHIFT_REG & 32'h80000000);
assign local_bb1_and35_i123_valid_out = 1'b1;
assign rnode_175to176_bb1__23_i112_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_xor_i124_stall_local;
wire [31:0] local_bb1_xor_i124;

assign local_bb1_xor_i124 = (rnode_175to176_bb1__23_i112_2_NO_SHIFT_REG ^ rnode_175to176_bb1__22_i111_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot23_i120_stall_local;
wire local_bb1_lnot23_i120;

assign local_bb1_lnot23_i120 = (local_bb1_and19_i116 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp27_i122_stall_local;
wire local_bb1_cmp27_i122;

assign local_bb1_cmp27_i122 = (local_bb1_and19_i116 == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot33_not_i129_stall_local;
wire local_bb1_lnot33_not_i129;

assign local_bb1_lnot33_not_i129 = (local_bb1_and21_i118 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or64_i142_stall_local;
wire [31:0] local_bb1_or64_i142;

assign local_bb1_or64_i142 = (local_bb1_and21_i118 << 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb1_and68_i146_stall_local;
wire [31:0] local_bb1_and68_i146;

assign local_bb1_and68_i146 = (local_bb1_sub_i145 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot30_i127_stall_local;
wire local_bb1_lnot30_i127;

assign local_bb1_lnot30_i127 = (local_bb1_and20_i117 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i139_stall_local;
wire [31:0] local_bb1_or_i139;

assign local_bb1_or_i139 = (local_bb1_and20_i117 << 32'h3);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_176to177_bb1_and35_i123_0_valid_out_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and35_i123_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_and35_i123_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and35_i123_0_reg_177_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_and35_i123_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and35_i123_0_valid_out_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and35_i123_0_stall_in_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_and35_i123_0_stall_out_reg_177_NO_SHIFT_REG;

acl_data_fifo rnode_176to177_bb1_and35_i123_0_reg_177_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to177_bb1_and35_i123_0_reg_177_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to177_bb1_and35_i123_0_stall_in_reg_177_NO_SHIFT_REG),
	.valid_out(rnode_176to177_bb1_and35_i123_0_valid_out_reg_177_NO_SHIFT_REG),
	.stall_out(rnode_176to177_bb1_and35_i123_0_stall_out_reg_177_NO_SHIFT_REG),
	.data_in(local_bb1_and35_i123),
	.data_out(rnode_176to177_bb1_and35_i123_0_reg_177_NO_SHIFT_REG)
);

defparam rnode_176to177_bb1_and35_i123_0_reg_177_fifo.DEPTH = 1;
defparam rnode_176to177_bb1_and35_i123_0_reg_177_fifo.DATA_WIDTH = 32;
defparam rnode_176to177_bb1_and35_i123_0_reg_177_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to177_bb1_and35_i123_0_reg_177_fifo.IMPL = "shift_reg";

assign rnode_176to177_bb1_and35_i123_0_reg_177_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and35_i123_stall_in = 1'b0;
assign rnode_176to177_bb1_and35_i123_0_NO_SHIFT_REG = rnode_176to177_bb1_and35_i123_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_and35_i123_0_stall_in_reg_177_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_and35_i123_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp37_i125_stall_local;
wire local_bb1_cmp37_i125;

assign local_bb1_cmp37_i125 = ($signed(local_bb1_xor_i124) < $signed(32'h0));

// This section implements an unregistered operation.
// 
wire local_bb1_xor_lobit_i198_stall_local;
wire [31:0] local_bb1_xor_lobit_i198;

assign local_bb1_xor_lobit_i198 = ($signed(local_bb1_xor_i124) >>> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb1_and36_lobit_i200_stall_local;
wire [31:0] local_bb1_and36_lobit_i200;

assign local_bb1_and36_lobit_i200 = (local_bb1_xor_i124 >> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb1_shl65_i143_stall_local;
wire [31:0] local_bb1_shl65_i143;

assign local_bb1_shl65_i143 = (local_bb1_or64_i142 | 32'h4000000);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp69_i147_stall_local;
wire local_bb1_cmp69_i147;

assign local_bb1_cmp69_i147 = (local_bb1_and68_i146 > 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot30_not_i131_stall_local;
wire local_bb1_lnot30_not_i131;

assign local_bb1_lnot30_not_i131 = (local_bb1_lnot30_i127 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i140_stall_local;
wire [31:0] local_bb1_shl_i140;

assign local_bb1_shl_i140 = (local_bb1_or_i139 | 32'h4000000);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_bb1_and35_i123_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and35_i123_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and35_i123_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and35_i123_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and35_i123_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and35_i123_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and35_i123_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and35_i123_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_bb1_and35_i123_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_bb1_and35_i123_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_bb1_and35_i123_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_bb1_and35_i123_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_bb1_and35_i123_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(rnode_176to177_bb1_and35_i123_0_NO_SHIFT_REG),
	.data_out(rnode_177to178_bb1_and35_i123_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_bb1_and35_i123_0_reg_178_fifo.DEPTH = 1;
defparam rnode_177to178_bb1_and35_i123_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_177to178_bb1_and35_i123_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to178_bb1_and35_i123_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_177to178_bb1_and35_i123_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_and35_i123_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and35_i123_0_NO_SHIFT_REG = rnode_177to178_bb1_and35_i123_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1_and35_i123_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and35_i123_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr16_i113_valid_out_1;
wire local_bb1_shr16_i113_stall_in_1;
 reg local_bb1_shr16_i113_consumed_1_NO_SHIFT_REG;
wire local_bb1_lnot23_i120_valid_out;
wire local_bb1_lnot23_i120_stall_in;
 reg local_bb1_lnot23_i120_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp27_i122_valid_out;
wire local_bb1_cmp27_i122_stall_in;
 reg local_bb1_cmp27_i122_consumed_0_NO_SHIFT_REG;
wire local_bb1_align_0_i148_valid_out;
wire local_bb1_align_0_i148_stall_in;
 reg local_bb1_align_0_i148_consumed_0_NO_SHIFT_REG;
wire local_bb1_align_0_i148_inputs_ready;
wire local_bb1_align_0_i148_stall_local;
wire [31:0] local_bb1_align_0_i148;

assign local_bb1_align_0_i148_inputs_ready = (rnode_174to175_bb1__22_i111_0_valid_out_0_NO_SHIFT_REG & rnode_174to175_bb1__23_i112_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_align_0_i148 = (local_bb1_cmp69_i147 ? 32'h1F : local_bb1_and68_i146);
assign local_bb1_shr16_i113_valid_out_1 = 1'b1;
assign local_bb1_lnot23_i120_valid_out = 1'b1;
assign local_bb1_cmp27_i122_valid_out = 1'b1;
assign local_bb1_align_0_i148_valid_out = 1'b1;
assign rnode_174to175_bb1__22_i111_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_174to175_bb1__23_i112_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_shr16_i113_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_lnot23_i120_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp27_i122_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_align_0_i148_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_shr16_i113_consumed_1_NO_SHIFT_REG <= (local_bb1_align_0_i148_inputs_ready & (local_bb1_shr16_i113_consumed_1_NO_SHIFT_REG | ~(local_bb1_shr16_i113_stall_in_1)) & local_bb1_align_0_i148_stall_local);
		local_bb1_lnot23_i120_consumed_0_NO_SHIFT_REG <= (local_bb1_align_0_i148_inputs_ready & (local_bb1_lnot23_i120_consumed_0_NO_SHIFT_REG | ~(local_bb1_lnot23_i120_stall_in)) & local_bb1_align_0_i148_stall_local);
		local_bb1_cmp27_i122_consumed_0_NO_SHIFT_REG <= (local_bb1_align_0_i148_inputs_ready & (local_bb1_cmp27_i122_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp27_i122_stall_in)) & local_bb1_align_0_i148_stall_local);
		local_bb1_align_0_i148_consumed_0_NO_SHIFT_REG <= (local_bb1_align_0_i148_inputs_ready & (local_bb1_align_0_i148_consumed_0_NO_SHIFT_REG | ~(local_bb1_align_0_i148_stall_in)) & local_bb1_align_0_i148_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_and35_i123_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and35_i123_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_and35_i123_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and35_i123_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_and35_i123_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and35_i123_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and35_i123_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and35_i123_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_and35_i123_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_and35_i123_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_and35_i123_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_and35_i123_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_and35_i123_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_177to178_bb1_and35_i123_0_NO_SHIFT_REG),
	.data_out(rnode_178to179_bb1_and35_i123_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_and35_i123_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_and35_i123_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_bb1_and35_i123_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_and35_i123_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_and35_i123_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_177to178_bb1_and35_i123_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_and35_i123_0_NO_SHIFT_REG = rnode_178to179_bb1_and35_i123_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_and35_i123_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_and35_i123_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_shr16_i113_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_shr16_i113_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_shr16_i113_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_shr16_i113_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1_shr16_i113_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_shr16_i113_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1_shr16_i113_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_shr16_i113_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_shr16_i113_0_valid_out_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_shr16_i113_0_stall_in_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_shr16_i113_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_shr16_i113_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_shr16_i113_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_shr16_i113_0_stall_in_0_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_shr16_i113_0_valid_out_0_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_shr16_i113_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(local_bb1_shr16_i113),
	.data_out(rnode_175to176_bb1_shr16_i113_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_shr16_i113_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1_shr16_i113_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb1_shr16_i113_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1_shr16_i113_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1_shr16_i113_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr16_i113_stall_in_1 = 1'b0;
assign rnode_175to176_bb1_shr16_i113_0_stall_in_0_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_shr16_i113_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_shr16_i113_0_NO_SHIFT_REG = rnode_175to176_bb1_shr16_i113_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_shr16_i113_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_shr16_i113_1_NO_SHIFT_REG = rnode_175to176_bb1_shr16_i113_0_reg_176_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_lnot23_i120_0_valid_out_NO_SHIFT_REG;
 logic rnode_175to176_bb1_lnot23_i120_0_stall_in_NO_SHIFT_REG;
 logic rnode_175to176_bb1_lnot23_i120_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_lnot23_i120_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic rnode_175to176_bb1_lnot23_i120_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_lnot23_i120_0_valid_out_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_lnot23_i120_0_stall_in_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_lnot23_i120_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_lnot23_i120_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_lnot23_i120_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_lnot23_i120_0_stall_in_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_lnot23_i120_0_valid_out_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_lnot23_i120_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(local_bb1_lnot23_i120),
	.data_out(rnode_175to176_bb1_lnot23_i120_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_lnot23_i120_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1_lnot23_i120_0_reg_176_fifo.DATA_WIDTH = 1;
defparam rnode_175to176_bb1_lnot23_i120_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1_lnot23_i120_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1_lnot23_i120_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lnot23_i120_stall_in = 1'b0;
assign rnode_175to176_bb1_lnot23_i120_0_NO_SHIFT_REG = rnode_175to176_bb1_lnot23_i120_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_lnot23_i120_0_stall_in_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_lnot23_i120_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_cmp27_i122_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_2_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_valid_out_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_stall_in_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_cmp27_i122_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_cmp27_i122_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_cmp27_i122_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_cmp27_i122_0_stall_in_0_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_cmp27_i122_0_valid_out_0_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_cmp27_i122_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(local_bb1_cmp27_i122),
	.data_out(rnode_175to176_bb1_cmp27_i122_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_cmp27_i122_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1_cmp27_i122_0_reg_176_fifo.DATA_WIDTH = 1;
defparam rnode_175to176_bb1_cmp27_i122_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1_cmp27_i122_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1_cmp27_i122_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp27_i122_stall_in = 1'b0;
assign rnode_175to176_bb1_cmp27_i122_0_stall_in_0_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_cmp27_i122_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_cmp27_i122_0_NO_SHIFT_REG = rnode_175to176_bb1_cmp27_i122_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_cmp27_i122_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_cmp27_i122_1_NO_SHIFT_REG = rnode_175to176_bb1_cmp27_i122_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_cmp27_i122_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_cmp27_i122_2_NO_SHIFT_REG = rnode_175to176_bb1_cmp27_i122_0_reg_176_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_175to176_bb1_align_0_i148_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_align_0_i148_0_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_align_0_i148_1_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_align_0_i148_2_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_align_0_i148_3_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_stall_in_4_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_align_0_i148_4_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_reg_176_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_175to176_bb1_align_0_i148_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_valid_out_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_stall_in_0_reg_176_NO_SHIFT_REG;
 logic rnode_175to176_bb1_align_0_i148_0_stall_out_reg_176_NO_SHIFT_REG;

acl_data_fifo rnode_175to176_bb1_align_0_i148_0_reg_176_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_175to176_bb1_align_0_i148_0_reg_176_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_175to176_bb1_align_0_i148_0_stall_in_0_reg_176_NO_SHIFT_REG),
	.valid_out(rnode_175to176_bb1_align_0_i148_0_valid_out_0_reg_176_NO_SHIFT_REG),
	.stall_out(rnode_175to176_bb1_align_0_i148_0_stall_out_reg_176_NO_SHIFT_REG),
	.data_in(local_bb1_align_0_i148),
	.data_out(rnode_175to176_bb1_align_0_i148_0_reg_176_NO_SHIFT_REG)
);

defparam rnode_175to176_bb1_align_0_i148_0_reg_176_fifo.DEPTH = 1;
defparam rnode_175to176_bb1_align_0_i148_0_reg_176_fifo.DATA_WIDTH = 32;
defparam rnode_175to176_bb1_align_0_i148_0_reg_176_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_175to176_bb1_align_0_i148_0_reg_176_fifo.IMPL = "shift_reg";

assign rnode_175to176_bb1_align_0_i148_0_reg_176_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_align_0_i148_stall_in = 1'b0;
assign rnode_175to176_bb1_align_0_i148_0_stall_in_0_reg_176_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_align_0_i148_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_align_0_i148_0_NO_SHIFT_REG = rnode_175to176_bb1_align_0_i148_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_align_0_i148_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_align_0_i148_1_NO_SHIFT_REG = rnode_175to176_bb1_align_0_i148_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_align_0_i148_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_align_0_i148_2_NO_SHIFT_REG = rnode_175to176_bb1_align_0_i148_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_align_0_i148_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_align_0_i148_3_NO_SHIFT_REG = rnode_175to176_bb1_align_0_i148_0_reg_176_NO_SHIFT_REG;
assign rnode_175to176_bb1_align_0_i148_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_align_0_i148_4_NO_SHIFT_REG = rnode_175to176_bb1_align_0_i148_0_reg_176_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and17_i114_stall_local;
wire [31:0] local_bb1_and17_i114;

assign local_bb1_and17_i114 = (rnode_175to176_bb1_shr16_i113_0_NO_SHIFT_REG & 32'hFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_176to178_bb1_shr16_i113_0_valid_out_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr16_i113_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_176to178_bb1_shr16_i113_0_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr16_i113_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_176to178_bb1_shr16_i113_0_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr16_i113_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr16_i113_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_shr16_i113_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_176to178_bb1_shr16_i113_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to178_bb1_shr16_i113_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to178_bb1_shr16_i113_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_176to178_bb1_shr16_i113_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_176to178_bb1_shr16_i113_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(rnode_175to176_bb1_shr16_i113_1_NO_SHIFT_REG),
	.data_out(rnode_176to178_bb1_shr16_i113_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_176to178_bb1_shr16_i113_0_reg_178_fifo.DEPTH = 2;
defparam rnode_176to178_bb1_shr16_i113_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_176to178_bb1_shr16_i113_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to178_bb1_shr16_i113_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_176to178_bb1_shr16_i113_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_175to176_bb1_shr16_i113_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_176to178_bb1_shr16_i113_0_NO_SHIFT_REG = rnode_176to178_bb1_shr16_i113_0_reg_178_NO_SHIFT_REG;
assign rnode_176to178_bb1_shr16_i113_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_176to178_bb1_shr16_i113_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__28_i144_stall_local;
wire [31:0] local_bb1__28_i144;

assign local_bb1__28_i144 = (rnode_175to176_bb1_lnot23_i120_0_NO_SHIFT_REG ? 32'h0 : local_bb1_shl65_i143);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge_not_i130_stall_local;
wire local_bb1_brmerge_not_i130;

assign local_bb1_brmerge_not_i130 = (rnode_175to176_bb1_cmp27_i122_0_NO_SHIFT_REG & local_bb1_lnot33_not_i129);

// This section implements an unregistered operation.
// 
wire local_bb1_and93_i156_stall_local;
wire [31:0] local_bb1_and93_i156;

assign local_bb1_and93_i156 = (rnode_175to176_bb1_align_0_i148_0_NO_SHIFT_REG & 32'h1C);

// This section implements an unregistered operation.
// 
wire local_bb1_and95_i158_stall_local;
wire [31:0] local_bb1_and95_i158;

assign local_bb1_and95_i158 = (rnode_175to176_bb1_align_0_i148_1_NO_SHIFT_REG & 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_and115_i174_stall_local;
wire [31:0] local_bb1_and115_i174;

assign local_bb1_and115_i174 = (rnode_175to176_bb1_align_0_i148_2_NO_SHIFT_REG & 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb1_and130_i180_stall_local;
wire [31:0] local_bb1_and130_i180;

assign local_bb1_and130_i180 = (rnode_175to176_bb1_align_0_i148_3_NO_SHIFT_REG & 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb1_and149_i185_stall_local;
wire [31:0] local_bb1_and149_i185;

assign local_bb1_and149_i185 = (rnode_175to176_bb1_align_0_i148_4_NO_SHIFT_REG & 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_i119_stall_local;
wire local_bb1_lnot_i119;

assign local_bb1_lnot_i119 = (local_bb1_and17_i114 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp25_i121_stall_local;
wire local_bb1_cmp25_i121;

assign local_bb1_cmp25_i121 = (local_bb1_and17_i114 == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and72_i149_stall_local;
wire [31:0] local_bb1_and72_i149;

assign local_bb1_and72_i149 = (local_bb1__28_i144 >> 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb1_and75_i152_stall_local;
wire [31:0] local_bb1_and75_i152;

assign local_bb1_and75_i152 = (local_bb1__28_i144 & 32'hF0);

// This section implements an unregistered operation.
// 
wire local_bb1_and78_i154_stall_local;
wire [31:0] local_bb1_and78_i154;

assign local_bb1_and78_i154 = (local_bb1__28_i144 & 32'hF00);

// This section implements an unregistered operation.
// 
wire local_bb1_and90_i160_stall_local;
wire [31:0] local_bb1_and90_i160;

assign local_bb1_and90_i160 = (local_bb1__28_i144 & 32'h7000000);

// This section implements an unregistered operation.
// 
wire local_bb1_and87_i161_stall_local;
wire [31:0] local_bb1_and87_i161;

assign local_bb1_and87_i161 = (local_bb1__28_i144 & 32'hF00000);

// This section implements an unregistered operation.
// 
wire local_bb1_and84_i162_stall_local;
wire [31:0] local_bb1_and84_i162;

assign local_bb1_and84_i162 = (local_bb1__28_i144 & 32'hF0000);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u18_stall_local;
wire [31:0] local_bb1_var__u18;

assign local_bb1_var__u18 = (local_bb1__28_i144 & 32'hFFF8);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge_not_not_i134_stall_local;
wire local_bb1_brmerge_not_not_i134;

assign local_bb1_brmerge_not_not_i134 = (local_bb1_brmerge_not_i130 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_shr94_i157_stall_local;
wire [31:0] local_bb1_shr94_i157;

assign local_bb1_shr94_i157 = (local_bb1__28_i144 >> local_bb1_and93_i156);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp96_i159_stall_local;
wire local_bb1_cmp96_i159;

assign local_bb1_cmp96_i159 = (local_bb1_and95_i158 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp116_i175_stall_local;
wire local_bb1_cmp116_i175;

assign local_bb1_cmp116_i175 = (local_bb1_and115_i174 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp131_not_i182_stall_local;
wire local_bb1_cmp131_not_i182;

assign local_bb1_cmp131_not_i182 = (local_bb1_and130_i180 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_Pivot20_i187_stall_local;
wire local_bb1_Pivot20_i187;

assign local_bb1_Pivot20_i187 = (local_bb1_and149_i185 < 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_SwitchLeaf_i188_stall_local;
wire local_bb1_SwitchLeaf_i188;

assign local_bb1_SwitchLeaf_i188 = (local_bb1_and149_i185 == 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__27_i141_stall_local;
wire [31:0] local_bb1__27_i141;

assign local_bb1__27_i141 = (local_bb1_lnot_i119 ? 32'h0 : local_bb1_shl_i140);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp25_not_i126_stall_local;
wire local_bb1_cmp25_not_i126;

assign local_bb1_cmp25_not_i126 = (local_bb1_cmp25_i121 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_or_cond_not_i132_stall_local;
wire local_bb1_or_cond_not_i132;

assign local_bb1_or_cond_not_i132 = (local_bb1_cmp25_i121 & local_bb1_lnot30_not_i131);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u19_stall_local;
wire local_bb1_var__u19;

assign local_bb1_var__u19 = (local_bb1_cmp25_i121 | rnode_175to176_bb1_cmp27_i122_2_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_and72_tr_i150_stall_local;
wire [7:0] local_bb1_and72_tr_i150;

assign local_bb1_and72_tr_i150 = local_bb1_and72_i149[7:0];

// This section implements an unregistered operation.
// 
wire local_bb1_cmp76_i153_stall_local;
wire local_bb1_cmp76_i153;

assign local_bb1_cmp76_i153 = (local_bb1_and75_i152 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp79_i155_stall_local;
wire local_bb1_cmp79_i155;

assign local_bb1_cmp79_i155 = (local_bb1_and78_i154 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp91_i163_stall_local;
wire local_bb1_cmp91_i163;

assign local_bb1_cmp91_i163 = (local_bb1_and90_i160 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp88_i164_stall_local;
wire local_bb1_cmp88_i164;

assign local_bb1_cmp88_i164 = (local_bb1_and87_i161 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp85_i165_stall_local;
wire local_bb1_cmp85_i165;

assign local_bb1_cmp85_i165 = (local_bb1_and84_i162 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u20_stall_local;
wire local_bb1_var__u20;

assign local_bb1_var__u20 = (local_bb1_var__u18 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_7_i135_stall_local;
wire local_bb1_reduction_7_i135;

assign local_bb1_reduction_7_i135 = (local_bb1_cmp25_i121 & local_bb1_brmerge_not_not_i134);

// This section implements an unregistered operation.
// 
wire local_bb1_and142_i184_stall_local;
wire [31:0] local_bb1_and142_i184;

assign local_bb1_and142_i184 = (local_bb1_shr94_i157 >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_shr150_i186_stall_local;
wire [31:0] local_bb1_shr150_i186;

assign local_bb1_shr150_i186 = (local_bb1_shr94_i157 >> local_bb1_and149_i185);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u21_stall_local;
wire [31:0] local_bb1_var__u21;

assign local_bb1_var__u21 = (local_bb1_shr94_i157 & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_and146_i189_stall_local;
wire [31:0] local_bb1_and146_i189;

assign local_bb1_and146_i189 = (local_bb1_shr94_i157 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_add_i201_stall_local;
wire [31:0] local_bb1_add_i201;

assign local_bb1_add_i201 = (local_bb1__27_i141 | local_bb1_and36_lobit_i200);

// This section implements an unregistered operation.
// 
wire local_bb1_or_cond_i128_stall_local;
wire local_bb1_or_cond_i128;

assign local_bb1_or_cond_i128 = (local_bb1_lnot30_i127 | local_bb1_cmp25_not_i126);

// This section implements an unregistered operation.
// 
wire local_bb1__24_i133_stall_local;
wire local_bb1__24_i133;

assign local_bb1__24_i133 = (local_bb1_or_cond_not_i132 | local_bb1_brmerge_not_i130);

// This section implements an unregistered operation.
// 
wire local_bb1_frombool74_i151_stall_local;
wire [7:0] local_bb1_frombool74_i151;

assign local_bb1_frombool74_i151 = (local_bb1_and72_tr_i150 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__31_v_i171_stall_local;
wire local_bb1__31_v_i171;

assign local_bb1__31_v_i171 = (local_bb1_cmp96_i159 ? local_bb1_cmp79_i155 : local_bb1_cmp91_i163);

// This section implements an unregistered operation.
// 
wire local_bb1__30_v_i169_stall_local;
wire local_bb1__30_v_i169;

assign local_bb1__30_v_i169 = (local_bb1_cmp96_i159 ? local_bb1_cmp76_i153 : local_bb1_cmp88_i164);

// This section implements an unregistered operation.
// 
wire local_bb1_frombool109_i167_stall_local;
wire [7:0] local_bb1_frombool109_i167;

assign local_bb1_frombool109_i167[7:1] = 7'h0;
assign local_bb1_frombool109_i167[0] = local_bb1_cmp85_i165;

// This section implements an unregistered operation.
// 
wire local_bb1_or107_i166_stall_local;
wire [31:0] local_bb1_or107_i166;

assign local_bb1_or107_i166[31:1] = 31'h0;
assign local_bb1_or107_i166[0] = local_bb1_var__u20;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u22_stall_local;
wire [31:0] local_bb1_var__u22;

assign local_bb1_var__u22 = (local_bb1_and146_i189 | local_bb1_shr94_i157);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_8_i136_stall_local;
wire local_bb1_reduction_8_i136;

assign local_bb1_reduction_8_i136 = (rnode_175to176_bb1_cmp27_i122_1_NO_SHIFT_REG & local_bb1_or_cond_i128);

// This section implements an unregistered operation.
// 
wire local_bb1__31_i172_stall_local;
wire [7:0] local_bb1__31_i172;

assign local_bb1__31_i172[7:1] = 7'h0;
assign local_bb1__31_i172[0] = local_bb1__31_v_i171;

// This section implements an unregistered operation.
// 
wire local_bb1__30_i170_stall_local;
wire [7:0] local_bb1__30_i170;

assign local_bb1__30_i170[7:1] = 7'h0;
assign local_bb1__30_i170[0] = local_bb1__30_v_i169;

// This section implements an unregistered operation.
// 
wire local_bb1__29_i168_stall_local;
wire [7:0] local_bb1__29_i168;

assign local_bb1__29_i168 = (local_bb1_cmp96_i159 ? local_bb1_frombool74_i151 : local_bb1_frombool109_i167);

// This section implements an unregistered operation.
// 
wire local_bb1__32_i173_stall_local;
wire [31:0] local_bb1__32_i173;

assign local_bb1__32_i173 = (local_bb1_cmp96_i159 ? 32'h0 : local_bb1_or107_i166);

// This section implements an unregistered operation.
// 
wire local_bb1_or1596_i190_stall_local;
wire [31:0] local_bb1_or1596_i190;

assign local_bb1_or1596_i190 = (local_bb1_var__u22 | local_bb1_and142_i184);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_9_i137_stall_local;
wire local_bb1_reduction_9_i137;

assign local_bb1_reduction_9_i137 = (local_bb1_reduction_7_i135 & local_bb1_reduction_8_i136);

// This section implements an unregistered operation.
// 
wire local_bb1_or1237_i176_stall_local;
wire [7:0] local_bb1_or1237_i176;

assign local_bb1_or1237_i176 = (local_bb1__30_i170 | local_bb1__29_i168);

// This section implements an unregistered operation.
// 
wire local_bb1__33_i178_stall_local;
wire [7:0] local_bb1__33_i178;

assign local_bb1__33_i178 = (local_bb1_cmp116_i175 ? local_bb1__29_i168 : local_bb1__31_i172);

// This section implements an unregistered operation.
// 
wire local_bb1_or162_i191_stall_local;
wire [31:0] local_bb1_or162_i191;

assign local_bb1_or162_i191 = (local_bb1_or1596_i190 & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__26_i138_stall_local;
wire local_bb1__26_i138;

assign local_bb1__26_i138 = (local_bb1_reduction_9_i137 ? local_bb1_cmp37_i125 : local_bb1__24_i133);

// This section implements an unregistered operation.
// 
wire local_bb1_or123_i177_stall_local;
wire [31:0] local_bb1_or123_i177;

assign local_bb1_or123_i177[31:8] = 24'h0;
assign local_bb1_or123_i177[7:0] = local_bb1_or1237_i176;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u23_stall_local;
wire [7:0] local_bb1_var__u23;

assign local_bb1_var__u23 = (local_bb1__33_i178 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__37_v_i192_stall_local;
wire [31:0] local_bb1__37_v_i192;

assign local_bb1__37_v_i192 = (local_bb1_Pivot20_i187 ? 32'h0 : local_bb1_or162_i191);

// This section implements an unregistered operation.
// 
wire local_bb1_or124_i179_stall_local;
wire [31:0] local_bb1_or124_i179;

assign local_bb1_or124_i179 = (local_bb1_cmp116_i175 ? 32'h0 : local_bb1_or123_i177);

// This section implements an unregistered operation.
// 
wire local_bb1_conv135_i181_stall_local;
wire [31:0] local_bb1_conv135_i181;

assign local_bb1_conv135_i181[31:8] = 24'h0;
assign local_bb1_conv135_i181[7:0] = local_bb1_var__u23;

// This section implements an unregistered operation.
// 
wire local_bb1__39_v_i193_stall_local;
wire [31:0] local_bb1__39_v_i193;

assign local_bb1__39_v_i193 = (local_bb1_SwitchLeaf_i188 ? local_bb1_var__u21 : local_bb1__37_v_i192);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_3_i194_stall_local;
wire [31:0] local_bb1_reduction_3_i194;

assign local_bb1_reduction_3_i194 = (local_bb1__32_i173 | local_bb1_or124_i179);

// This section implements an unregistered operation.
// 
wire local_bb1_or136_i183_stall_local;
wire [31:0] local_bb1_or136_i183;

assign local_bb1_or136_i183 = (local_bb1_cmp131_not_i182 ? local_bb1_conv135_i181 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_5_i196_stall_local;
wire [31:0] local_bb1_reduction_5_i196;

assign local_bb1_reduction_5_i196 = (local_bb1_shr150_i186 | local_bb1_reduction_3_i194);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_4_i195_stall_local;
wire [31:0] local_bb1_reduction_4_i195;

assign local_bb1_reduction_4_i195 = (local_bb1_or136_i183 | local_bb1__39_v_i193);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_6_i197_stall_local;
wire [31:0] local_bb1_reduction_6_i197;

assign local_bb1_reduction_6_i197 = (local_bb1_reduction_4_i195 | local_bb1_reduction_5_i196);

// This section implements an unregistered operation.
// 
wire local_bb1_xor188_i199_stall_local;
wire [31:0] local_bb1_xor188_i199;

assign local_bb1_xor188_i199 = (local_bb1_reduction_6_i197 ^ local_bb1_xor_lobit_i198);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp37_i125_valid_out_1;
wire local_bb1_cmp37_i125_stall_in_1;
 reg local_bb1_cmp37_i125_consumed_1_NO_SHIFT_REG;
wire local_bb1__26_i138_valid_out;
wire local_bb1__26_i138_stall_in;
 reg local_bb1__26_i138_consumed_0_NO_SHIFT_REG;
wire local_bb1_add192_i202_valid_out;
wire local_bb1_add192_i202_stall_in;
 reg local_bb1_add192_i202_consumed_0_NO_SHIFT_REG;
wire local_bb1_and17_i114_valid_out_2;
wire local_bb1_and17_i114_stall_in_2;
 reg local_bb1_and17_i114_consumed_2_NO_SHIFT_REG;
wire local_bb1_var__u19_valid_out;
wire local_bb1_var__u19_stall_in;
 reg local_bb1_var__u19_consumed_0_NO_SHIFT_REG;
wire local_bb1_add192_i202_inputs_ready;
wire local_bb1_add192_i202_stall_local;
wire [31:0] local_bb1_add192_i202;

assign local_bb1_add192_i202_inputs_ready = (rnode_175to176_bb1__22_i111_0_valid_out_0_NO_SHIFT_REG & rnode_175to176_bb1_cmp27_i122_0_valid_out_0_NO_SHIFT_REG & rnode_175to176_bb1_lnot23_i120_0_valid_out_NO_SHIFT_REG & rnode_175to176_bb1__22_i111_0_valid_out_1_NO_SHIFT_REG & rnode_175to176_bb1__23_i112_0_valid_out_2_NO_SHIFT_REG & rnode_175to176_bb1__23_i112_0_valid_out_0_NO_SHIFT_REG & rnode_175to176_bb1_cmp27_i122_0_valid_out_1_NO_SHIFT_REG & rnode_175to176_bb1_shr16_i113_0_valid_out_0_NO_SHIFT_REG & rnode_175to176_bb1_cmp27_i122_0_valid_out_2_NO_SHIFT_REG & rnode_175to176_bb1_align_0_i148_0_valid_out_0_NO_SHIFT_REG & rnode_175to176_bb1_align_0_i148_0_valid_out_4_NO_SHIFT_REG & rnode_175to176_bb1_align_0_i148_0_valid_out_1_NO_SHIFT_REG & rnode_175to176_bb1_align_0_i148_0_valid_out_2_NO_SHIFT_REG & rnode_175to176_bb1_align_0_i148_0_valid_out_3_NO_SHIFT_REG);
assign local_bb1_add192_i202 = (local_bb1_add_i201 + local_bb1_xor188_i199);
assign local_bb1_cmp37_i125_valid_out_1 = 1'b1;
assign local_bb1__26_i138_valid_out = 1'b1;
assign local_bb1_add192_i202_valid_out = 1'b1;
assign local_bb1_and17_i114_valid_out_2 = 1'b1;
assign local_bb1_var__u19_valid_out = 1'b1;
assign rnode_175to176_bb1__22_i111_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_cmp27_i122_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_lnot23_i120_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1__22_i111_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1__23_i112_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1__23_i112_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_cmp27_i122_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_shr16_i113_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_cmp27_i122_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_align_0_i148_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_align_0_i148_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_align_0_i148_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_align_0_i148_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_175to176_bb1_align_0_i148_0_stall_in_3_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_cmp37_i125_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1__26_i138_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_add192_i202_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and17_i114_consumed_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_var__u19_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_cmp37_i125_consumed_1_NO_SHIFT_REG <= (local_bb1_add192_i202_inputs_ready & (local_bb1_cmp37_i125_consumed_1_NO_SHIFT_REG | ~(local_bb1_cmp37_i125_stall_in_1)) & local_bb1_add192_i202_stall_local);
		local_bb1__26_i138_consumed_0_NO_SHIFT_REG <= (local_bb1_add192_i202_inputs_ready & (local_bb1__26_i138_consumed_0_NO_SHIFT_REG | ~(local_bb1__26_i138_stall_in)) & local_bb1_add192_i202_stall_local);
		local_bb1_add192_i202_consumed_0_NO_SHIFT_REG <= (local_bb1_add192_i202_inputs_ready & (local_bb1_add192_i202_consumed_0_NO_SHIFT_REG | ~(local_bb1_add192_i202_stall_in)) & local_bb1_add192_i202_stall_local);
		local_bb1_and17_i114_consumed_2_NO_SHIFT_REG <= (local_bb1_add192_i202_inputs_ready & (local_bb1_and17_i114_consumed_2_NO_SHIFT_REG | ~(local_bb1_and17_i114_stall_in_2)) & local_bb1_add192_i202_stall_local);
		local_bb1_var__u19_consumed_0_NO_SHIFT_REG <= (local_bb1_add192_i202_inputs_ready & (local_bb1_var__u19_consumed_0_NO_SHIFT_REG | ~(local_bb1_var__u19_stall_in)) & local_bb1_add192_i202_stall_local);
	end
end


// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_176to178_bb1_cmp37_i125_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_1_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_2_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_valid_out_0_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_stall_in_0_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_cmp37_i125_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_176to178_bb1_cmp37_i125_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to178_bb1_cmp37_i125_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to178_bb1_cmp37_i125_0_stall_in_0_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_176to178_bb1_cmp37_i125_0_valid_out_0_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_176to178_bb1_cmp37_i125_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1_cmp37_i125),
	.data_out(rnode_176to178_bb1_cmp37_i125_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_176to178_bb1_cmp37_i125_0_reg_178_fifo.DEPTH = 2;
defparam rnode_176to178_bb1_cmp37_i125_0_reg_178_fifo.DATA_WIDTH = 1;
defparam rnode_176to178_bb1_cmp37_i125_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to178_bb1_cmp37_i125_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_176to178_bb1_cmp37_i125_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp37_i125_stall_in_1 = 1'b0;
assign rnode_176to178_bb1_cmp37_i125_0_stall_in_0_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_176to178_bb1_cmp37_i125_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_176to178_bb1_cmp37_i125_0_NO_SHIFT_REG = rnode_176to178_bb1_cmp37_i125_0_reg_178_NO_SHIFT_REG;
assign rnode_176to178_bb1_cmp37_i125_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_176to178_bb1_cmp37_i125_1_NO_SHIFT_REG = rnode_176to178_bb1_cmp37_i125_0_reg_178_NO_SHIFT_REG;
assign rnode_176to178_bb1_cmp37_i125_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_176to178_bb1_cmp37_i125_2_NO_SHIFT_REG = rnode_176to178_bb1_cmp37_i125_0_reg_178_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_176to177_bb1__26_i138_0_valid_out_NO_SHIFT_REG;
 logic rnode_176to177_bb1__26_i138_0_stall_in_NO_SHIFT_REG;
 logic rnode_176to177_bb1__26_i138_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1__26_i138_0_reg_177_inputs_ready_NO_SHIFT_REG;
 logic rnode_176to177_bb1__26_i138_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1__26_i138_0_valid_out_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1__26_i138_0_stall_in_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1__26_i138_0_stall_out_reg_177_NO_SHIFT_REG;

acl_data_fifo rnode_176to177_bb1__26_i138_0_reg_177_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to177_bb1__26_i138_0_reg_177_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to177_bb1__26_i138_0_stall_in_reg_177_NO_SHIFT_REG),
	.valid_out(rnode_176to177_bb1__26_i138_0_valid_out_reg_177_NO_SHIFT_REG),
	.stall_out(rnode_176to177_bb1__26_i138_0_stall_out_reg_177_NO_SHIFT_REG),
	.data_in(local_bb1__26_i138),
	.data_out(rnode_176to177_bb1__26_i138_0_reg_177_NO_SHIFT_REG)
);

defparam rnode_176to177_bb1__26_i138_0_reg_177_fifo.DEPTH = 1;
defparam rnode_176to177_bb1__26_i138_0_reg_177_fifo.DATA_WIDTH = 1;
defparam rnode_176to177_bb1__26_i138_0_reg_177_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to177_bb1__26_i138_0_reg_177_fifo.IMPL = "shift_reg";

assign rnode_176to177_bb1__26_i138_0_reg_177_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__26_i138_stall_in = 1'b0;
assign rnode_176to177_bb1__26_i138_0_NO_SHIFT_REG = rnode_176to177_bb1__26_i138_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1__26_i138_0_stall_in_reg_177_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1__26_i138_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_176to177_bb1_add192_i202_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_add192_i202_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_add192_i202_1_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_add192_i202_2_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_add192_i202_3_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_reg_177_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_176to177_bb1_add192_i202_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_valid_out_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_stall_in_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_add192_i202_0_stall_out_reg_177_NO_SHIFT_REG;

acl_data_fifo rnode_176to177_bb1_add192_i202_0_reg_177_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to177_bb1_add192_i202_0_reg_177_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to177_bb1_add192_i202_0_stall_in_0_reg_177_NO_SHIFT_REG),
	.valid_out(rnode_176to177_bb1_add192_i202_0_valid_out_0_reg_177_NO_SHIFT_REG),
	.stall_out(rnode_176to177_bb1_add192_i202_0_stall_out_reg_177_NO_SHIFT_REG),
	.data_in(local_bb1_add192_i202),
	.data_out(rnode_176to177_bb1_add192_i202_0_reg_177_NO_SHIFT_REG)
);

defparam rnode_176to177_bb1_add192_i202_0_reg_177_fifo.DEPTH = 1;
defparam rnode_176to177_bb1_add192_i202_0_reg_177_fifo.DATA_WIDTH = 32;
defparam rnode_176to177_bb1_add192_i202_0_reg_177_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to177_bb1_add192_i202_0_reg_177_fifo.IMPL = "shift_reg";

assign rnode_176to177_bb1_add192_i202_0_reg_177_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add192_i202_stall_in = 1'b0;
assign rnode_176to177_bb1_add192_i202_0_stall_in_0_reg_177_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_add192_i202_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_add192_i202_0_NO_SHIFT_REG = rnode_176to177_bb1_add192_i202_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_add192_i202_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_add192_i202_1_NO_SHIFT_REG = rnode_176to177_bb1_add192_i202_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_add192_i202_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_add192_i202_2_NO_SHIFT_REG = rnode_176to177_bb1_add192_i202_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_add192_i202_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_add192_i202_3_NO_SHIFT_REG = rnode_176to177_bb1_add192_i202_0_reg_177_NO_SHIFT_REG;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_176to178_bb1_and17_i114_0_valid_out_NO_SHIFT_REG;
 logic rnode_176to178_bb1_and17_i114_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_176to178_bb1_and17_i114_0_NO_SHIFT_REG;
 logic rnode_176to178_bb1_and17_i114_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_176to178_bb1_and17_i114_0_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_and17_i114_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_and17_i114_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_176to178_bb1_and17_i114_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_176to178_bb1_and17_i114_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to178_bb1_and17_i114_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to178_bb1_and17_i114_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_176to178_bb1_and17_i114_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_176to178_bb1_and17_i114_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1_and17_i114),
	.data_out(rnode_176to178_bb1_and17_i114_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_176to178_bb1_and17_i114_0_reg_178_fifo.DEPTH = 2;
defparam rnode_176to178_bb1_and17_i114_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_176to178_bb1_and17_i114_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to178_bb1_and17_i114_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_176to178_bb1_and17_i114_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and17_i114_stall_in_2 = 1'b0;
assign rnode_176to178_bb1_and17_i114_0_NO_SHIFT_REG = rnode_176to178_bb1_and17_i114_0_reg_178_NO_SHIFT_REG;
assign rnode_176to178_bb1_and17_i114_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_176to178_bb1_and17_i114_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_176to177_bb1_var__u19_0_valid_out_NO_SHIFT_REG;
 logic rnode_176to177_bb1_var__u19_0_stall_in_NO_SHIFT_REG;
 logic rnode_176to177_bb1_var__u19_0_NO_SHIFT_REG;
 logic rnode_176to177_bb1_var__u19_0_reg_177_inputs_ready_NO_SHIFT_REG;
 logic rnode_176to177_bb1_var__u19_0_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_var__u19_0_valid_out_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_var__u19_0_stall_in_reg_177_NO_SHIFT_REG;
 logic rnode_176to177_bb1_var__u19_0_stall_out_reg_177_NO_SHIFT_REG;

acl_data_fifo rnode_176to177_bb1_var__u19_0_reg_177_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_176to177_bb1_var__u19_0_reg_177_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_176to177_bb1_var__u19_0_stall_in_reg_177_NO_SHIFT_REG),
	.valid_out(rnode_176to177_bb1_var__u19_0_valid_out_reg_177_NO_SHIFT_REG),
	.stall_out(rnode_176to177_bb1_var__u19_0_stall_out_reg_177_NO_SHIFT_REG),
	.data_in(local_bb1_var__u19),
	.data_out(rnode_176to177_bb1_var__u19_0_reg_177_NO_SHIFT_REG)
);

defparam rnode_176to177_bb1_var__u19_0_reg_177_fifo.DEPTH = 1;
defparam rnode_176to177_bb1_var__u19_0_reg_177_fifo.DATA_WIDTH = 1;
defparam rnode_176to177_bb1_var__u19_0_reg_177_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_176to177_bb1_var__u19_0_reg_177_fifo.IMPL = "shift_reg";

assign rnode_176to177_bb1_var__u19_0_reg_177_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u19_stall_in = 1'b0;
assign rnode_176to177_bb1_var__u19_0_NO_SHIFT_REG = rnode_176to177_bb1_var__u19_0_reg_177_NO_SHIFT_REG;
assign rnode_176to177_bb1_var__u19_0_stall_in_reg_177_NO_SHIFT_REG = 1'b0;
assign rnode_176to177_bb1_var__u19_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp37_i231_stall_local;
wire local_bb1_not_cmp37_i231;

assign local_bb1_not_cmp37_i231 = (rnode_176to178_bb1_cmp37_i125_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_bb1__26_i138_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to178_bb1__26_i138_0_stall_in_NO_SHIFT_REG;
 logic rnode_177to178_bb1__26_i138_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1__26_i138_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic rnode_177to178_bb1__26_i138_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1__26_i138_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1__26_i138_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1__26_i138_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_bb1__26_i138_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_bb1__26_i138_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_bb1__26_i138_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_bb1__26_i138_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_bb1__26_i138_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(rnode_176to177_bb1__26_i138_0_NO_SHIFT_REG),
	.data_out(rnode_177to178_bb1__26_i138_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_bb1__26_i138_0_reg_178_fifo.DEPTH = 1;
defparam rnode_177to178_bb1__26_i138_0_reg_178_fifo.DATA_WIDTH = 1;
defparam rnode_177to178_bb1__26_i138_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to178_bb1__26_i138_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_177to178_bb1__26_i138_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1__26_i138_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1__26_i138_0_NO_SHIFT_REG = rnode_177to178_bb1__26_i138_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1__26_i138_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1__26_i138_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_and193_i203_valid_out;
wire local_bb1_and193_i203_stall_in;
wire local_bb1_and193_i203_inputs_ready;
wire local_bb1_and193_i203_stall_local;
wire [31:0] local_bb1_and193_i203;

assign local_bb1_and193_i203_inputs_ready = rnode_176to177_bb1_add192_i202_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_and193_i203 = (rnode_176to177_bb1_add192_i202_0_NO_SHIFT_REG & 32'hFFFFFFF);
assign local_bb1_and193_i203_valid_out = 1'b1;
assign rnode_176to177_bb1_add192_i202_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_and195_i204_valid_out;
wire local_bb1_and195_i204_stall_in;
wire local_bb1_and195_i204_inputs_ready;
wire local_bb1_and195_i204_stall_local;
wire [31:0] local_bb1_and195_i204;

assign local_bb1_and195_i204_inputs_ready = rnode_176to177_bb1_add192_i202_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_and195_i204 = (rnode_176to177_bb1_add192_i202_1_NO_SHIFT_REG >> 32'h1B);
assign local_bb1_and195_i204_valid_out = 1'b1;
assign rnode_176to177_bb1_add192_i202_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_and198_i205_valid_out;
wire local_bb1_and198_i205_stall_in;
wire local_bb1_and198_i205_inputs_ready;
wire local_bb1_and198_i205_stall_local;
wire [31:0] local_bb1_and198_i205;

assign local_bb1_and198_i205_inputs_ready = rnode_176to177_bb1_add192_i202_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1_and198_i205 = (rnode_176to177_bb1_add192_i202_2_NO_SHIFT_REG & 32'h1);
assign local_bb1_and198_i205_valid_out = 1'b1;
assign rnode_176to177_bb1_add192_i202_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_and201_i206_stall_local;
wire [31:0] local_bb1_and201_i206;

assign local_bb1_and201_i206 = (rnode_176to177_bb1_add192_i202_3_NO_SHIFT_REG & 32'h7FFFFFF);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_bb1_var__u19_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to178_bb1_var__u19_0_stall_in_NO_SHIFT_REG;
 logic rnode_177to178_bb1_var__u19_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1_var__u19_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic rnode_177to178_bb1_var__u19_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_var__u19_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_var__u19_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_var__u19_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_bb1_var__u19_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_bb1_var__u19_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_bb1_var__u19_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_bb1_var__u19_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_bb1_var__u19_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(rnode_176to177_bb1_var__u19_0_NO_SHIFT_REG),
	.data_out(rnode_177to178_bb1_var__u19_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_bb1_var__u19_0_reg_178_fifo.DEPTH = 1;
defparam rnode_177to178_bb1_var__u19_0_reg_178_fifo.DATA_WIDTH = 1;
defparam rnode_177to178_bb1_var__u19_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to178_bb1_var__u19_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_177to178_bb1_var__u19_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_176to177_bb1_var__u19_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_var__u19_0_NO_SHIFT_REG = rnode_177to178_bb1_var__u19_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1_var__u19_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_var__u19_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1__26_i138_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_2_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_valid_out_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_stall_in_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1__26_i138_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1__26_i138_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1__26_i138_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1__26_i138_0_stall_in_0_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1__26_i138_0_valid_out_0_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1__26_i138_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_177to178_bb1__26_i138_0_NO_SHIFT_REG),
	.data_out(rnode_178to179_bb1__26_i138_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1__26_i138_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1__26_i138_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_178to179_bb1__26_i138_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1__26_i138_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1__26_i138_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_177to178_bb1__26_i138_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1__26_i138_0_stall_in_0_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1__26_i138_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1__26_i138_0_NO_SHIFT_REG = rnode_178to179_bb1__26_i138_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1__26_i138_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1__26_i138_1_NO_SHIFT_REG = rnode_178to179_bb1__26_i138_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1__26_i138_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1__26_i138_2_NO_SHIFT_REG = rnode_178to179_bb1__26_i138_0_reg_179_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_bb1_and193_i203_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and193_i203_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and193_i203_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and193_i203_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and193_i203_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and193_i203_1_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and193_i203_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and193_i203_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and193_i203_2_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and193_i203_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and193_i203_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and193_i203_0_valid_out_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and193_i203_0_stall_in_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and193_i203_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_bb1_and193_i203_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_bb1_and193_i203_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_bb1_and193_i203_0_stall_in_0_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_bb1_and193_i203_0_valid_out_0_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_bb1_and193_i203_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1_and193_i203),
	.data_out(rnode_177to178_bb1_and193_i203_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_bb1_and193_i203_0_reg_178_fifo.DEPTH = 1;
defparam rnode_177to178_bb1_and193_i203_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_177to178_bb1_and193_i203_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to178_bb1_and193_i203_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_177to178_bb1_and193_i203_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and193_i203_stall_in = 1'b0;
assign rnode_177to178_bb1_and193_i203_0_stall_in_0_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and193_i203_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_177to178_bb1_and193_i203_0_NO_SHIFT_REG = rnode_177to178_bb1_and193_i203_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1_and193_i203_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_177to178_bb1_and193_i203_1_NO_SHIFT_REG = rnode_177to178_bb1_and193_i203_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1_and193_i203_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_177to178_bb1_and193_i203_2_NO_SHIFT_REG = rnode_177to178_bb1_and193_i203_0_reg_178_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_bb1_and195_i204_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and195_i204_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and195_i204_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and195_i204_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and195_i204_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and195_i204_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and195_i204_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and195_i204_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_bb1_and195_i204_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_bb1_and195_i204_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_bb1_and195_i204_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_bb1_and195_i204_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_bb1_and195_i204_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1_and195_i204),
	.data_out(rnode_177to178_bb1_and195_i204_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_bb1_and195_i204_0_reg_178_fifo.DEPTH = 1;
defparam rnode_177to178_bb1_and195_i204_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_177to178_bb1_and195_i204_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to178_bb1_and195_i204_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_177to178_bb1_and195_i204_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and195_i204_stall_in = 1'b0;
assign rnode_177to178_bb1_and195_i204_0_NO_SHIFT_REG = rnode_177to178_bb1_and195_i204_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1_and195_i204_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and195_i204_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_bb1_and198_i205_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and198_i205_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and198_i205_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and198_i205_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1_and198_i205_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and198_i205_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and198_i205_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1_and198_i205_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_bb1_and198_i205_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_bb1_and198_i205_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_bb1_and198_i205_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_bb1_and198_i205_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_bb1_and198_i205_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1_and198_i205),
	.data_out(rnode_177to178_bb1_and198_i205_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_bb1_and198_i205_0_reg_178_fifo.DEPTH = 1;
defparam rnode_177to178_bb1_and198_i205_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_177to178_bb1_and198_i205_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to178_bb1_and198_i205_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_177to178_bb1_and198_i205_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and198_i205_stall_in = 1'b0;
assign rnode_177to178_bb1_and198_i205_0_NO_SHIFT_REG = rnode_177to178_bb1_and198_i205_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1_and198_i205_0_stall_in_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and198_i205_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_i207_stall_local;
wire [31:0] local_bb1_shr_i_i207;

assign local_bb1_shr_i_i207 = (local_bb1_and201_i206 >> 32'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_var__u19_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_var__u19_0_stall_in_NO_SHIFT_REG;
 logic rnode_178to179_bb1_var__u19_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_var__u19_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_178to179_bb1_var__u19_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_var__u19_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_var__u19_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_var__u19_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_var__u19_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_var__u19_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_var__u19_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_var__u19_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_var__u19_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_177to178_bb1_var__u19_0_NO_SHIFT_REG),
	.data_out(rnode_178to179_bb1_var__u19_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_var__u19_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_var__u19_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_178to179_bb1_var__u19_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_var__u19_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_var__u19_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_177to178_bb1_var__u19_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_var__u19_0_NO_SHIFT_REG = rnode_178to179_bb1_var__u19_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_var__u19_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_var__u19_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_cond292_i265_stall_local;
wire [31:0] local_bb1_cond292_i265;

assign local_bb1_cond292_i265 = (rnode_178to179_bb1__26_i138_1_NO_SHIFT_REG ? 32'h400000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u24_stall_local;
wire [31:0] local_bb1_var__u24;

assign local_bb1_var__u24[31:1] = 31'h0;
assign local_bb1_var__u24[0] = rnode_178to179_bb1__26_i138_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr216_i228_stall_local;
wire [31:0] local_bb1_shr216_i228;

assign local_bb1_shr216_i228 = (rnode_177to178_bb1_and193_i203_1_NO_SHIFT_REG >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__pre_i226_stall_local;
wire [31:0] local_bb1__pre_i226;

assign local_bb1__pre_i226 = (rnode_177to178_bb1_and195_i204_0_NO_SHIFT_REG & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i_i208_stall_local;
wire [31:0] local_bb1_or_i_i208;

assign local_bb1_or_i_i208 = (local_bb1_shr_i_i207 | local_bb1_and201_i206);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_ext_i275_stall_local;
wire [31:0] local_bb1_lnot_ext_i275;

assign local_bb1_lnot_ext_i275 = (local_bb1_var__u24 ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_or219_i229_stall_local;
wire [31:0] local_bb1_or219_i229;

assign local_bb1_or219_i229 = (local_bb1_shr216_i228 | rnode_177to178_bb1_and198_i205_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool213_i227_stall_local;
wire local_bb1_tobool213_i227;

assign local_bb1_tobool213_i227 = (local_bb1__pre_i226 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_shr1_i_i209_stall_local;
wire [31:0] local_bb1_shr1_i_i209;

assign local_bb1_shr1_i_i209 = (local_bb1_or_i_i208 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1__40_demorgan_i230_stall_local;
wire local_bb1__40_demorgan_i230;

assign local_bb1__40_demorgan_i230 = (rnode_176to178_bb1_cmp37_i125_0_NO_SHIFT_REG | local_bb1_tobool213_i227);

// This section implements an unregistered operation.
// 
wire local_bb1__42_i232_stall_local;
wire local_bb1__42_i232;

assign local_bb1__42_i232 = (local_bb1_tobool213_i227 & local_bb1_not_cmp37_i231);

// This section implements an unregistered operation.
// 
wire local_bb1_or2_i_i210_stall_local;
wire [31:0] local_bb1_or2_i_i210;

assign local_bb1_or2_i_i210 = (local_bb1_shr1_i_i209 | local_bb1_or_i_i208);

// This section implements an unregistered operation.
// 
wire local_bb1__43_i233_stall_local;
wire [31:0] local_bb1__43_i233;

assign local_bb1__43_i233 = (local_bb1__42_i232 ? 32'h0 : local_bb1__pre_i226);

// This section implements an unregistered operation.
// 
wire local_bb1_shr3_i_i211_stall_local;
wire [31:0] local_bb1_shr3_i_i211;

assign local_bb1_shr3_i_i211 = (local_bb1_or2_i_i210 >> 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb1_or4_i_i212_stall_local;
wire [31:0] local_bb1_or4_i_i212;

assign local_bb1_or4_i_i212 = (local_bb1_shr3_i_i211 | local_bb1_or2_i_i210);

// This section implements an unregistered operation.
// 
wire local_bb1_shr5_i_i213_stall_local;
wire [31:0] local_bb1_shr5_i_i213;

assign local_bb1_shr5_i_i213 = (local_bb1_or4_i_i212 >> 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb1_or6_i_i214_stall_local;
wire [31:0] local_bb1_or6_i_i214;

assign local_bb1_or6_i_i214 = (local_bb1_shr5_i_i213 | local_bb1_or4_i_i212);

// This section implements an unregistered operation.
// 
wire local_bb1_shr7_i_i215_stall_local;
wire [31:0] local_bb1_shr7_i_i215;

assign local_bb1_shr7_i_i215 = (local_bb1_or6_i_i214 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_or6_masked_i_i216_stall_local;
wire [31:0] local_bb1_or6_masked_i_i216;

assign local_bb1_or6_masked_i_i216 = (local_bb1_or6_i_i214 & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_neg_i_i217_stall_local;
wire [31:0] local_bb1_neg_i_i217;

assign local_bb1_neg_i_i217 = (local_bb1_or6_masked_i_i216 | local_bb1_shr7_i_i215);

// This section implements an unregistered operation.
// 
wire local_bb1_and_i_i218_stall_local;
wire [31:0] local_bb1_and_i_i218;

assign local_bb1_and_i_i218 = (local_bb1_neg_i_i217 ^ 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1__and_i_i218_valid_out;
wire local_bb1__and_i_i218_stall_in;
wire local_bb1__and_i_i218_inputs_ready;
wire local_bb1__and_i_i218_stall_local;
wire [31:0] local_bb1__and_i_i218;

thirtysix_six_comp local_bb1__and_i_i218_popcnt_instance (
	.data(local_bb1_and_i_i218),
	.sum(local_bb1__and_i_i218)
);


assign local_bb1__and_i_i218_inputs_ready = rnode_176to177_bb1_add192_i202_0_valid_out_3_NO_SHIFT_REG;
assign local_bb1__and_i_i218_valid_out = 1'b1;
assign rnode_176to177_bb1_add192_i202_0_stall_in_3_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_bb1__and_i_i218_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1__and_i_i218_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1__and_i_i218_0_NO_SHIFT_REG;
 logic rnode_177to178_bb1__and_i_i218_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_177to178_bb1__and_i_i218_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1__and_i_i218_1_NO_SHIFT_REG;
 logic rnode_177to178_bb1__and_i_i218_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_177to178_bb1__and_i_i218_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1__and_i_i218_2_NO_SHIFT_REG;
 logic rnode_177to178_bb1__and_i_i218_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_177to178_bb1__and_i_i218_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1__and_i_i218_0_valid_out_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1__and_i_i218_0_stall_in_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_bb1__and_i_i218_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_bb1__and_i_i218_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_bb1__and_i_i218_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_bb1__and_i_i218_0_stall_in_0_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_bb1__and_i_i218_0_valid_out_0_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_bb1__and_i_i218_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1__and_i_i218),
	.data_out(rnode_177to178_bb1__and_i_i218_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_bb1__and_i_i218_0_reg_178_fifo.DEPTH = 1;
defparam rnode_177to178_bb1__and_i_i218_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_177to178_bb1__and_i_i218_0_reg_178_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_177to178_bb1__and_i_i218_0_reg_178_fifo.IMPL = "shift_reg";

assign rnode_177to178_bb1__and_i_i218_0_reg_178_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__and_i_i218_stall_in = 1'b0;
assign rnode_177to178_bb1__and_i_i218_0_stall_in_0_reg_178_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1__and_i_i218_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_177to178_bb1__and_i_i218_0_NO_SHIFT_REG = rnode_177to178_bb1__and_i_i218_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1__and_i_i218_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_177to178_bb1__and_i_i218_1_NO_SHIFT_REG = rnode_177to178_bb1__and_i_i218_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_bb1__and_i_i218_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_177to178_bb1__and_i_i218_2_NO_SHIFT_REG = rnode_177to178_bb1__and_i_i218_0_reg_178_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and9_i_i219_stall_local;
wire [31:0] local_bb1_and9_i_i219;

assign local_bb1_and9_i_i219 = (rnode_177to178_bb1__and_i_i218_0_NO_SHIFT_REG & 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb1_and203_i220_stall_local;
wire [31:0] local_bb1_and203_i220;

assign local_bb1_and203_i220 = (rnode_177to178_bb1__and_i_i218_1_NO_SHIFT_REG & 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_and206_i222_stall_local;
wire [31:0] local_bb1_and206_i222;

assign local_bb1_and206_i222 = (rnode_177to178_bb1__and_i_i218_2_NO_SHIFT_REG & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_sub239_i241_stall_local;
wire [31:0] local_bb1_sub239_i241;

assign local_bb1_sub239_i241 = (32'h0 - local_bb1_and9_i_i219);

// This section implements an unregistered operation.
// 
wire local_bb1_shl204_i221_stall_local;
wire [31:0] local_bb1_shl204_i221;

assign local_bb1_shl204_i221 = (rnode_177to178_bb1_and193_i203_0_NO_SHIFT_REG << local_bb1_and203_i220);

// This section implements an unregistered operation.
// 
wire local_bb1_cond244_i242_stall_local;
wire [31:0] local_bb1_cond244_i242;

assign local_bb1_cond244_i242 = (rnode_176to178_bb1_cmp37_i125_2_NO_SHIFT_REG ? local_bb1_sub239_i241 : local_bb1__43_i233);

// This section implements an unregistered operation.
// 
wire local_bb1_and205_i223_stall_local;
wire [31:0] local_bb1_and205_i223;

assign local_bb1_and205_i223 = (local_bb1_shl204_i221 & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_add245_i243_stall_local;
wire [31:0] local_bb1_add245_i243;

assign local_bb1_add245_i243 = (local_bb1_cond244_i242 + rnode_176to178_bb1_and17_i114_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_fold_i245_stall_local;
wire [31:0] local_bb1_fold_i245;

assign local_bb1_fold_i245 = (local_bb1_cond244_i242 + rnode_176to178_bb1_shr16_i113_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_shl207_i224_stall_local;
wire [31:0] local_bb1_shl207_i224;

assign local_bb1_shl207_i224 = (local_bb1_and205_i223 << local_bb1_and206_i222);

// This section implements an unregistered operation.
// 
wire local_bb1_and250_i246_stall_local;
wire [31:0] local_bb1_and250_i246;

assign local_bb1_and250_i246 = (local_bb1_fold_i245 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and269_i257_stall_local;
wire [31:0] local_bb1_and269_i257;

assign local_bb1_and269_i257 = (local_bb1_fold_i245 << 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_and208_i225_stall_local;
wire [31:0] local_bb1_and208_i225;

assign local_bb1_and208_i225 = (local_bb1_shl207_i224 & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_notrhs_i248_stall_local;
wire local_bb1_notrhs_i248;

assign local_bb1_notrhs_i248 = (local_bb1_and250_i246 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__44_i234_stall_local;
wire [31:0] local_bb1__44_i234;

assign local_bb1__44_i234 = (local_bb1__40_demorgan_i230 ? local_bb1_and208_i225 : local_bb1_or219_i229);

// This section implements an unregistered operation.
// 
wire local_bb1__45_i235_stall_local;
wire [31:0] local_bb1__45_i235;

assign local_bb1__45_i235 = (local_bb1__42_i232 ? rnode_177to178_bb1_and193_i203_2_NO_SHIFT_REG : local_bb1__44_i234);

// This section implements an unregistered operation.
// 
wire local_bb1_and225_i236_stall_local;
wire [31:0] local_bb1_and225_i236;

assign local_bb1_and225_i236 = (local_bb1__45_i235 & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and270_i254_stall_local;
wire [31:0] local_bb1_and270_i254;

assign local_bb1_and270_i254 = (local_bb1__45_i235 & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_shr271_i255_stall_local;
wire [31:0] local_bb1_shr271_i255;

assign local_bb1_shr271_i255 = (local_bb1__45_i235 >> 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp226_i237_stall_local;
wire local_bb1_cmp226_i237;

assign local_bb1_cmp226_i237 = (local_bb1_and225_i236 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp296_i269_stall_local;
wire local_bb1_cmp296_i269;

assign local_bb1_cmp296_i269 = (local_bb1_and270_i254 > 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb1_and269_i257_valid_out;
wire local_bb1_and269_i257_stall_in;
 reg local_bb1_and269_i257_consumed_0_NO_SHIFT_REG;
wire local_bb1_add245_i243_valid_out;
wire local_bb1_add245_i243_stall_in;
 reg local_bb1_add245_i243_consumed_0_NO_SHIFT_REG;
wire local_bb1_notrhs_i248_valid_out;
wire local_bb1_notrhs_i248_stall_in;
 reg local_bb1_notrhs_i248_consumed_0_NO_SHIFT_REG;
wire local_bb1_not_cmp37_i231_valid_out_1;
wire local_bb1_not_cmp37_i231_stall_in_1;
 reg local_bb1_not_cmp37_i231_consumed_1_NO_SHIFT_REG;
wire local_bb1_shr271_i255_valid_out;
wire local_bb1_shr271_i255_stall_in;
 reg local_bb1_shr271_i255_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp226_i237_valid_out;
wire local_bb1_cmp226_i237_stall_in;
 reg local_bb1_cmp226_i237_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp296_i269_valid_out;
wire local_bb1_cmp296_i269_stall_in;
 reg local_bb1_cmp296_i269_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp299_i270_valid_out;
wire local_bb1_cmp299_i270_stall_in;
 reg local_bb1_cmp299_i270_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp299_i270_inputs_ready;
wire local_bb1_cmp299_i270_stall_local;
wire local_bb1_cmp299_i270;

assign local_bb1_cmp299_i270_inputs_ready = (rnode_176to178_bb1_shr16_i113_0_valid_out_NO_SHIFT_REG & rnode_176to178_bb1_cmp37_i125_0_valid_out_2_NO_SHIFT_REG & rnode_176to178_bb1_and17_i114_0_valid_out_NO_SHIFT_REG & rnode_176to178_bb1_cmp37_i125_0_valid_out_0_NO_SHIFT_REG & rnode_177to178_bb1_and193_i203_0_valid_out_2_NO_SHIFT_REG & rnode_176to178_bb1_cmp37_i125_0_valid_out_1_NO_SHIFT_REG & rnode_177to178_bb1_and195_i204_0_valid_out_NO_SHIFT_REG & rnode_177to178_bb1_and193_i203_0_valid_out_1_NO_SHIFT_REG & rnode_177to178_bb1_and198_i205_0_valid_out_NO_SHIFT_REG & rnode_177to178_bb1_and193_i203_0_valid_out_0_NO_SHIFT_REG & rnode_177to178_bb1__and_i_i218_0_valid_out_1_NO_SHIFT_REG & rnode_177to178_bb1__and_i_i218_0_valid_out_2_NO_SHIFT_REG & rnode_177to178_bb1__and_i_i218_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_cmp299_i270 = (local_bb1_and270_i254 == 32'h4);
assign local_bb1_and269_i257_valid_out = 1'b1;
assign local_bb1_add245_i243_valid_out = 1'b1;
assign local_bb1_notrhs_i248_valid_out = 1'b1;
assign local_bb1_not_cmp37_i231_valid_out_1 = 1'b1;
assign local_bb1_shr271_i255_valid_out = 1'b1;
assign local_bb1_cmp226_i237_valid_out = 1'b1;
assign local_bb1_cmp296_i269_valid_out = 1'b1;
assign local_bb1_cmp299_i270_valid_out = 1'b1;
assign rnode_176to178_bb1_shr16_i113_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_176to178_bb1_cmp37_i125_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_176to178_bb1_and17_i114_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_176to178_bb1_cmp37_i125_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and193_i203_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_176to178_bb1_cmp37_i125_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and195_i204_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and193_i203_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and198_i205_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1_and193_i203_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1__and_i_i218_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1__and_i_i218_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_177to178_bb1__and_i_i218_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_and269_i257_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_add245_i243_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_notrhs_i248_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_not_cmp37_i231_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_shr271_i255_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp226_i237_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp296_i269_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp299_i270_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_and269_i257_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i270_inputs_ready & (local_bb1_and269_i257_consumed_0_NO_SHIFT_REG | ~(local_bb1_and269_i257_stall_in)) & local_bb1_cmp299_i270_stall_local);
		local_bb1_add245_i243_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i270_inputs_ready & (local_bb1_add245_i243_consumed_0_NO_SHIFT_REG | ~(local_bb1_add245_i243_stall_in)) & local_bb1_cmp299_i270_stall_local);
		local_bb1_notrhs_i248_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i270_inputs_ready & (local_bb1_notrhs_i248_consumed_0_NO_SHIFT_REG | ~(local_bb1_notrhs_i248_stall_in)) & local_bb1_cmp299_i270_stall_local);
		local_bb1_not_cmp37_i231_consumed_1_NO_SHIFT_REG <= (local_bb1_cmp299_i270_inputs_ready & (local_bb1_not_cmp37_i231_consumed_1_NO_SHIFT_REG | ~(local_bb1_not_cmp37_i231_stall_in_1)) & local_bb1_cmp299_i270_stall_local);
		local_bb1_shr271_i255_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i270_inputs_ready & (local_bb1_shr271_i255_consumed_0_NO_SHIFT_REG | ~(local_bb1_shr271_i255_stall_in)) & local_bb1_cmp299_i270_stall_local);
		local_bb1_cmp226_i237_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i270_inputs_ready & (local_bb1_cmp226_i237_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp226_i237_stall_in)) & local_bb1_cmp299_i270_stall_local);
		local_bb1_cmp296_i269_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i270_inputs_ready & (local_bb1_cmp296_i269_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp296_i269_stall_in)) & local_bb1_cmp299_i270_stall_local);
		local_bb1_cmp299_i270_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i270_inputs_ready & (local_bb1_cmp299_i270_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp299_i270_stall_in)) & local_bb1_cmp299_i270_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_and269_i257_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and269_i257_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_and269_i257_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and269_i257_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_and269_i257_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and269_i257_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and269_i257_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_and269_i257_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_and269_i257_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_and269_i257_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_and269_i257_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_and269_i257_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_and269_i257_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_and269_i257),
	.data_out(rnode_178to179_bb1_and269_i257_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_and269_i257_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_and269_i257_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_bb1_and269_i257_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_and269_i257_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_and269_i257_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and269_i257_stall_in = 1'b0;
assign rnode_178to179_bb1_and269_i257_0_NO_SHIFT_REG = rnode_178to179_bb1_and269_i257_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_and269_i257_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_and269_i257_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_add245_i243_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add245_i243_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_add245_i243_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add245_i243_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add245_i243_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_add245_i243_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add245_i243_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_add245_i243_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add245_i243_0_valid_out_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add245_i243_0_stall_in_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_add245_i243_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_add245_i243_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_add245_i243_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_add245_i243_0_stall_in_0_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_add245_i243_0_valid_out_0_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_add245_i243_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_add245_i243),
	.data_out(rnode_178to179_bb1_add245_i243_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_add245_i243_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_add245_i243_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_bb1_add245_i243_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_add245_i243_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_add245_i243_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add245_i243_stall_in = 1'b0;
assign rnode_178to179_bb1_add245_i243_0_stall_in_0_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_add245_i243_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1_add245_i243_0_NO_SHIFT_REG = rnode_178to179_bb1_add245_i243_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_add245_i243_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1_add245_i243_1_NO_SHIFT_REG = rnode_178to179_bb1_add245_i243_0_reg_179_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_notrhs_i248_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_notrhs_i248_0_stall_in_NO_SHIFT_REG;
 logic rnode_178to179_bb1_notrhs_i248_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_notrhs_i248_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_178to179_bb1_notrhs_i248_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_notrhs_i248_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_notrhs_i248_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_notrhs_i248_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_notrhs_i248_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_notrhs_i248_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_notrhs_i248_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_notrhs_i248_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_notrhs_i248_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_notrhs_i248),
	.data_out(rnode_178to179_bb1_notrhs_i248_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_notrhs_i248_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_notrhs_i248_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_178to179_bb1_notrhs_i248_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_notrhs_i248_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_notrhs_i248_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_notrhs_i248_stall_in = 1'b0;
assign rnode_178to179_bb1_notrhs_i248_0_NO_SHIFT_REG = rnode_178to179_bb1_notrhs_i248_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_notrhs_i248_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_notrhs_i248_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_not_cmp37_i231_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_not_cmp37_i231_0_stall_in_NO_SHIFT_REG;
 logic rnode_178to179_bb1_not_cmp37_i231_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_not_cmp37_i231_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_178to179_bb1_not_cmp37_i231_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_not_cmp37_i231_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_not_cmp37_i231_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_not_cmp37_i231_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_not_cmp37_i231_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_not_cmp37_i231_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_not_cmp37_i231_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_not_cmp37_i231_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_not_cmp37_i231_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_not_cmp37_i231),
	.data_out(rnode_178to179_bb1_not_cmp37_i231_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_not_cmp37_i231_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_not_cmp37_i231_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_178to179_bb1_not_cmp37_i231_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_not_cmp37_i231_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_not_cmp37_i231_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_not_cmp37_i231_stall_in_1 = 1'b0;
assign rnode_178to179_bb1_not_cmp37_i231_0_NO_SHIFT_REG = rnode_178to179_bb1_not_cmp37_i231_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_not_cmp37_i231_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_not_cmp37_i231_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_shr271_i255_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_shr271_i255_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_shr271_i255_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_shr271_i255_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_shr271_i255_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_shr271_i255_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_shr271_i255_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_shr271_i255_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_shr271_i255_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_shr271_i255_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_shr271_i255_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_shr271_i255_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_shr271_i255_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_shr271_i255),
	.data_out(rnode_178to179_bb1_shr271_i255_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_shr271_i255_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_shr271_i255_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_bb1_shr271_i255_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_shr271_i255_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_shr271_i255_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr271_i255_stall_in = 1'b0;
assign rnode_178to179_bb1_shr271_i255_0_NO_SHIFT_REG = rnode_178to179_bb1_shr271_i255_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_shr271_i255_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_shr271_i255_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_cmp226_i237_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_0_valid_out_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_0_stall_in_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp226_i237_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_cmp226_i237_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_cmp226_i237_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_cmp226_i237_0_stall_in_0_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_cmp226_i237_0_valid_out_0_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_cmp226_i237_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_cmp226_i237),
	.data_out(rnode_178to179_bb1_cmp226_i237_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_cmp226_i237_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_cmp226_i237_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_178to179_bb1_cmp226_i237_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_cmp226_i237_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_cmp226_i237_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp226_i237_stall_in = 1'b0;
assign rnode_178to179_bb1_cmp226_i237_0_stall_in_0_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_cmp226_i237_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1_cmp226_i237_0_NO_SHIFT_REG = rnode_178to179_bb1_cmp226_i237_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_cmp226_i237_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_178to179_bb1_cmp226_i237_1_NO_SHIFT_REG = rnode_178to179_bb1_cmp226_i237_0_reg_179_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_cmp296_i269_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp296_i269_0_stall_in_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp296_i269_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp296_i269_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp296_i269_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp296_i269_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp296_i269_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp296_i269_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_cmp296_i269_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_cmp296_i269_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_cmp296_i269_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_cmp296_i269_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_cmp296_i269_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_cmp296_i269),
	.data_out(rnode_178to179_bb1_cmp296_i269_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_cmp296_i269_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_cmp296_i269_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_178to179_bb1_cmp296_i269_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_cmp296_i269_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_cmp296_i269_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp296_i269_stall_in = 1'b0;
assign rnode_178to179_bb1_cmp296_i269_0_NO_SHIFT_REG = rnode_178to179_bb1_cmp296_i269_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_cmp296_i269_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_cmp296_i269_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_cmp299_i270_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp299_i270_0_stall_in_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp299_i270_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp299_i270_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp299_i270_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp299_i270_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp299_i270_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_cmp299_i270_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_cmp299_i270_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_cmp299_i270_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_cmp299_i270_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_cmp299_i270_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_cmp299_i270_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_cmp299_i270),
	.data_out(rnode_178to179_bb1_cmp299_i270_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_cmp299_i270_0_reg_179_fifo.DEPTH = 1;
defparam rnode_178to179_bb1_cmp299_i270_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_178to179_bb1_cmp299_i270_0_reg_179_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_178to179_bb1_cmp299_i270_0_reg_179_fifo.IMPL = "shift_reg";

assign rnode_178to179_bb1_cmp299_i270_0_reg_179_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp299_i270_stall_in = 1'b0;
assign rnode_178to179_bb1_cmp299_i270_0_NO_SHIFT_REG = rnode_178to179_bb1_cmp299_i270_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_cmp299_i270_0_stall_in_reg_179_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_cmp299_i270_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shl273_i258_stall_local;
wire [31:0] local_bb1_shl273_i258;

assign local_bb1_shl273_i258 = (rnode_178to179_bb1_and269_i257_0_NO_SHIFT_REG & 32'h7F800000);

// This section implements an unregistered operation.
// 
wire local_bb1_and247_i244_stall_local;
wire [31:0] local_bb1_and247_i244;

assign local_bb1_and247_i244 = (rnode_178to179_bb1_add245_i243_0_NO_SHIFT_REG & 32'h100);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp258_i251_stall_local;
wire local_bb1_cmp258_i251;

assign local_bb1_cmp258_i251 = ($signed(rnode_178to179_bb1_add245_i243_1_NO_SHIFT_REG) > $signed(32'hFE));

// This section implements an unregistered operation.
// 
wire local_bb1_and272_i256_stall_local;
wire [31:0] local_bb1_and272_i256;

assign local_bb1_and272_i256 = (rnode_178to179_bb1_shr271_i255_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp226_not_i238_stall_local;
wire local_bb1_cmp226_not_i238;

assign local_bb1_cmp226_not_i238 = (rnode_178to179_bb1_cmp226_i237_0_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp29649_i273_stall_local;
wire [31:0] local_bb1_cmp29649_i273;

assign local_bb1_cmp29649_i273[31:1] = 31'h0;
assign local_bb1_cmp29649_i273[0] = rnode_178to179_bb1_cmp296_i269_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_conv300_i271_stall_local;
wire [31:0] local_bb1_conv300_i271;

assign local_bb1_conv300_i271[31:1] = 31'h0;
assign local_bb1_conv300_i271[0] = rnode_178to179_bb1_cmp299_i270_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_notlhs_i247_stall_local;
wire local_bb1_notlhs_i247;

assign local_bb1_notlhs_i247 = (local_bb1_and247_i244 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or274_i259_stall_local;
wire [31:0] local_bb1_or274_i259;

assign local_bb1_or274_i259 = (local_bb1_and272_i256 | local_bb1_shl273_i258);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge12_i239_stall_local;
wire local_bb1_brmerge12_i239;

assign local_bb1_brmerge12_i239 = (local_bb1_cmp226_not_i238 | rnode_178to179_bb1_not_cmp37_i231_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot262__i252_stall_local;
wire local_bb1_lnot262__i252;

assign local_bb1_lnot262__i252 = (local_bb1_cmp258_i251 & local_bb1_cmp226_not_i238);

// This section implements an unregistered operation.
// 
wire local_bb1_not__46_i249_stall_local;
wire local_bb1_not__46_i249;

assign local_bb1_not__46_i249 = (rnode_178to179_bb1_notrhs_i248_0_NO_SHIFT_REG | local_bb1_notlhs_i247);

// This section implements an unregistered operation.
// 
wire local_bb1_resultSign_0_i240_stall_local;
wire [31:0] local_bb1_resultSign_0_i240;

assign local_bb1_resultSign_0_i240 = (local_bb1_brmerge12_i239 ? rnode_178to179_bb1_and35_i123_0_NO_SHIFT_REG : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or2662_i253_stall_local;
wire local_bb1_or2662_i253;

assign local_bb1_or2662_i253 = (rnode_178to179_bb1_var__u19_0_NO_SHIFT_REG | local_bb1_lnot262__i252);

// This section implements an unregistered operation.
// 
wire local_bb1__47_i250_stall_local;
wire local_bb1__47_i250;

assign local_bb1__47_i250 = (rnode_178to179_bb1_cmp226_i237_1_NO_SHIFT_REG | local_bb1_not__46_i249);

// This section implements an unregistered operation.
// 
wire local_bb1_or275_i260_stall_local;
wire [31:0] local_bb1_or275_i260;

assign local_bb1_or275_i260 = (local_bb1_or274_i259 | local_bb1_resultSign_0_i240);

// This section implements an unregistered operation.
// 
wire local_bb1_or2875_i263_stall_local;
wire local_bb1_or2875_i263;

assign local_bb1_or2875_i263 = (local_bb1_or2662_i253 | rnode_178to179_bb1__26_i138_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u25_stall_local;
wire [31:0] local_bb1_var__u25;

assign local_bb1_var__u25[31:1] = 31'h0;
assign local_bb1_var__u25[0] = local_bb1_or2662_i253;

// This section implements an unregistered operation.
// 
wire local_bb1_or2804_i261_stall_local;
wire local_bb1_or2804_i261;

assign local_bb1_or2804_i261 = (local_bb1__47_i250 | local_bb1_or2662_i253);

// This section implements an unregistered operation.
// 
wire local_bb1_cond289_i264_stall_local;
wire [31:0] local_bb1_cond289_i264;

assign local_bb1_cond289_i264 = (local_bb1_or2875_i263 ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_ext310_i276_stall_local;
wire [31:0] local_bb1_lnot_ext310_i276;

assign local_bb1_lnot_ext310_i276 = (local_bb1_var__u25 ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cond282_i262_stall_local;
wire [31:0] local_bb1_cond282_i262;

assign local_bb1_cond282_i262 = (local_bb1_or2804_i261 ? 32'h80000000 : 32'hFFFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_or294_i267_stall_local;
wire [31:0] local_bb1_or294_i267;

assign local_bb1_or294_i267 = (local_bb1_cond289_i264 | local_bb1_cond292_i265);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_0_i278_stall_local;
wire [31:0] local_bb1_reduction_0_i278;

assign local_bb1_reduction_0_i278 = (local_bb1_lnot_ext310_i276 & local_bb1_lnot_ext_i275);

// This section implements an unregistered operation.
// 
wire local_bb1_and293_i266_stall_local;
wire [31:0] local_bb1_and293_i266;

assign local_bb1_and293_i266 = (local_bb1_cond282_i262 & local_bb1_or275_i260);

// This section implements an unregistered operation.
// 
wire local_bb1_or295_i268_stall_local;
wire [31:0] local_bb1_or295_i268;

assign local_bb1_or295_i268 = (local_bb1_or294_i267 | local_bb1_and293_i266);

// This section implements an unregistered operation.
// 
wire local_bb1_and302_i272_stall_local;
wire [31:0] local_bb1_and302_i272;

assign local_bb1_and302_i272 = (local_bb1_conv300_i271 & local_bb1_and293_i266);

// This section implements an unregistered operation.
// 
wire local_bb1_or295_i268_valid_out;
wire local_bb1_or295_i268_stall_in;
 reg local_bb1_or295_i268_consumed_0_NO_SHIFT_REG;
wire local_bb1__47_i250_valid_out_1;
wire local_bb1__47_i250_stall_in_1;
 reg local_bb1__47_i250_consumed_1_NO_SHIFT_REG;
wire local_bb1_lor_ext_i274_valid_out;
wire local_bb1_lor_ext_i274_stall_in;
 reg local_bb1_lor_ext_i274_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_0_i278_valid_out;
wire local_bb1_reduction_0_i278_stall_in;
 reg local_bb1_reduction_0_i278_consumed_0_NO_SHIFT_REG;
wire local_bb1_lor_ext_i274_inputs_ready;
wire local_bb1_lor_ext_i274_stall_local;
wire [31:0] local_bb1_lor_ext_i274;

assign local_bb1_lor_ext_i274_inputs_ready = (rnode_178to179_bb1_and35_i123_0_valid_out_NO_SHIFT_REG & rnode_178to179_bb1_not_cmp37_i231_0_valid_out_NO_SHIFT_REG & rnode_178to179_bb1_and269_i257_0_valid_out_NO_SHIFT_REG & rnode_178to179_bb1_add245_i243_0_valid_out_1_NO_SHIFT_REG & rnode_178to179_bb1_var__u19_0_valid_out_NO_SHIFT_REG & rnode_178to179_bb1__26_i138_0_valid_out_0_NO_SHIFT_REG & rnode_178to179_bb1__26_i138_0_valid_out_1_NO_SHIFT_REG & rnode_178to179_bb1_add245_i243_0_valid_out_0_NO_SHIFT_REG & rnode_178to179_bb1_notrhs_i248_0_valid_out_NO_SHIFT_REG & rnode_178to179_bb1_cmp226_i237_0_valid_out_1_NO_SHIFT_REG & rnode_178to179_bb1_shr271_i255_0_valid_out_NO_SHIFT_REG & rnode_178to179_bb1__26_i138_0_valid_out_2_NO_SHIFT_REG & rnode_178to179_bb1_cmp226_i237_0_valid_out_0_NO_SHIFT_REG & rnode_178to179_bb1_cmp296_i269_0_valid_out_NO_SHIFT_REG & rnode_178to179_bb1_cmp299_i270_0_valid_out_NO_SHIFT_REG);
assign local_bb1_lor_ext_i274 = (local_bb1_cmp29649_i273 | local_bb1_and302_i272);
assign local_bb1_or295_i268_valid_out = 1'b1;
assign local_bb1__47_i250_valid_out_1 = 1'b1;
assign local_bb1_lor_ext_i274_valid_out = 1'b1;
assign local_bb1_reduction_0_i278_valid_out = 1'b1;
assign rnode_178to179_bb1_and35_i123_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_not_cmp37_i231_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_and269_i257_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_add245_i243_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_var__u19_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1__26_i138_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1__26_i138_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_add245_i243_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_notrhs_i248_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_cmp226_i237_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_shr271_i255_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1__26_i138_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_cmp226_i237_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_cmp296_i269_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_178to179_bb1_cmp299_i270_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_or295_i268_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__47_i250_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_lor_ext_i274_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_0_i278_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_or295_i268_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i274_inputs_ready & (local_bb1_or295_i268_consumed_0_NO_SHIFT_REG | ~(local_bb1_or295_i268_stall_in)) & local_bb1_lor_ext_i274_stall_local);
		local_bb1__47_i250_consumed_1_NO_SHIFT_REG <= (local_bb1_lor_ext_i274_inputs_ready & (local_bb1__47_i250_consumed_1_NO_SHIFT_REG | ~(local_bb1__47_i250_stall_in_1)) & local_bb1_lor_ext_i274_stall_local);
		local_bb1_lor_ext_i274_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i274_inputs_ready & (local_bb1_lor_ext_i274_consumed_0_NO_SHIFT_REG | ~(local_bb1_lor_ext_i274_stall_in)) & local_bb1_lor_ext_i274_stall_local);
		local_bb1_reduction_0_i278_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i274_inputs_ready & (local_bb1_reduction_0_i278_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_0_i278_stall_in)) & local_bb1_lor_ext_i274_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_or295_i268_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_or295_i268_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_or295_i268_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_or295_i268_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_or295_i268_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_or295_i268_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_or295_i268_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_or295_i268_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_or295_i268_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_or295_i268_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_or295_i268_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_or295_i268_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_or295_i268_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1_or295_i268),
	.data_out(rnode_179to180_bb1_or295_i268_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_or295_i268_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_or295_i268_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_or295_i268_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_or295_i268_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_or295_i268_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_or295_i268_stall_in = 1'b0;
assign rnode_179to180_bb1_or295_i268_0_NO_SHIFT_REG = rnode_179to180_bb1_or295_i268_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_or295_i268_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_or295_i268_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1__47_i250_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1__47_i250_0_stall_in_NO_SHIFT_REG;
 logic rnode_179to180_bb1__47_i250_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1__47_i250_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic rnode_179to180_bb1__47_i250_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__47_i250_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__47_i250_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1__47_i250_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1__47_i250_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1__47_i250_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1__47_i250_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1__47_i250_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1__47_i250_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1__47_i250),
	.data_out(rnode_179to180_bb1__47_i250_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1__47_i250_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1__47_i250_0_reg_180_fifo.DATA_WIDTH = 1;
defparam rnode_179to180_bb1__47_i250_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1__47_i250_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1__47_i250_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__47_i250_stall_in_1 = 1'b0;
assign rnode_179to180_bb1__47_i250_0_NO_SHIFT_REG = rnode_179to180_bb1__47_i250_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1__47_i250_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1__47_i250_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_lor_ext_i274_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lor_ext_i274_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_lor_ext_i274_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lor_ext_i274_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_lor_ext_i274_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lor_ext_i274_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lor_ext_i274_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_lor_ext_i274_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_lor_ext_i274_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_lor_ext_i274_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_lor_ext_i274_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_lor_ext_i274_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_lor_ext_i274_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1_lor_ext_i274),
	.data_out(rnode_179to180_bb1_lor_ext_i274_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_lor_ext_i274_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_lor_ext_i274_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_lor_ext_i274_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_lor_ext_i274_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_lor_ext_i274_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lor_ext_i274_stall_in = 1'b0;
assign rnode_179to180_bb1_lor_ext_i274_0_NO_SHIFT_REG = rnode_179to180_bb1_lor_ext_i274_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_lor_ext_i274_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_lor_ext_i274_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_179to180_bb1_reduction_0_i278_0_valid_out_NO_SHIFT_REG;
 logic rnode_179to180_bb1_reduction_0_i278_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_reduction_0_i278_0_NO_SHIFT_REG;
 logic rnode_179to180_bb1_reduction_0_i278_0_reg_180_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_179to180_bb1_reduction_0_i278_0_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_reduction_0_i278_0_valid_out_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_reduction_0_i278_0_stall_in_reg_180_NO_SHIFT_REG;
 logic rnode_179to180_bb1_reduction_0_i278_0_stall_out_reg_180_NO_SHIFT_REG;

acl_data_fifo rnode_179to180_bb1_reduction_0_i278_0_reg_180_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_179to180_bb1_reduction_0_i278_0_reg_180_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_179to180_bb1_reduction_0_i278_0_stall_in_reg_180_NO_SHIFT_REG),
	.valid_out(rnode_179to180_bb1_reduction_0_i278_0_valid_out_reg_180_NO_SHIFT_REG),
	.stall_out(rnode_179to180_bb1_reduction_0_i278_0_stall_out_reg_180_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_0_i278),
	.data_out(rnode_179to180_bb1_reduction_0_i278_0_reg_180_NO_SHIFT_REG)
);

defparam rnode_179to180_bb1_reduction_0_i278_0_reg_180_fifo.DEPTH = 1;
defparam rnode_179to180_bb1_reduction_0_i278_0_reg_180_fifo.DATA_WIDTH = 32;
defparam rnode_179to180_bb1_reduction_0_i278_0_reg_180_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_179to180_bb1_reduction_0_i278_0_reg_180_fifo.IMPL = "shift_reg";

assign rnode_179to180_bb1_reduction_0_i278_0_reg_180_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_0_i278_stall_in = 1'b0;
assign rnode_179to180_bb1_reduction_0_i278_0_NO_SHIFT_REG = rnode_179to180_bb1_reduction_0_i278_0_reg_180_NO_SHIFT_REG;
assign rnode_179to180_bb1_reduction_0_i278_0_stall_in_reg_180_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_reduction_0_i278_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u26_stall_local;
wire [31:0] local_bb1_var__u26;

assign local_bb1_var__u26[31:1] = 31'h0;
assign local_bb1_var__u26[0] = rnode_179to180_bb1__47_i250_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_ext314_i277_stall_local;
wire [31:0] local_bb1_lnot_ext314_i277;

assign local_bb1_lnot_ext314_i277 = (local_bb1_var__u26 ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_1_i279_stall_local;
wire [31:0] local_bb1_reduction_1_i279;

assign local_bb1_reduction_1_i279 = (local_bb1_lnot_ext314_i277 & rnode_179to180_bb1_lor_ext_i274_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_2_i280_stall_local;
wire [31:0] local_bb1_reduction_2_i280;

assign local_bb1_reduction_2_i280 = (rnode_179to180_bb1_reduction_0_i278_0_NO_SHIFT_REG & local_bb1_reduction_1_i279);

// This section implements an unregistered operation.
// 
wire local_bb1_add320_i281_valid_out;
wire local_bb1_add320_i281_stall_in;
wire local_bb1_add320_i281_inputs_ready;
wire local_bb1_add320_i281_stall_local;
wire [31:0] local_bb1_add320_i281;

assign local_bb1_add320_i281_inputs_ready = (rnode_179to180_bb1__47_i250_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_lor_ext_i274_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_or295_i268_0_valid_out_NO_SHIFT_REG & rnode_179to180_bb1_reduction_0_i278_0_valid_out_NO_SHIFT_REG);
assign local_bb1_add320_i281 = (local_bb1_reduction_2_i280 + rnode_179to180_bb1_or295_i268_0_NO_SHIFT_REG);
assign local_bb1_add320_i281_valid_out = 1'b1;
assign rnode_179to180_bb1__47_i250_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_lor_ext_i274_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_or295_i268_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_179to180_bb1_reduction_0_i278_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_180to181_bb1_add320_i281_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_add320_i281_0_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_add320_i281_1_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_add320_i281_2_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_add320_i281_3_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_reg_181_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_180to181_bb1_add320_i281_0_reg_181_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_valid_out_0_reg_181_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_stall_in_0_reg_181_NO_SHIFT_REG;
 logic rnode_180to181_bb1_add320_i281_0_stall_out_reg_181_NO_SHIFT_REG;

acl_data_fifo rnode_180to181_bb1_add320_i281_0_reg_181_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_180to181_bb1_add320_i281_0_reg_181_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_180to181_bb1_add320_i281_0_stall_in_0_reg_181_NO_SHIFT_REG),
	.valid_out(rnode_180to181_bb1_add320_i281_0_valid_out_0_reg_181_NO_SHIFT_REG),
	.stall_out(rnode_180to181_bb1_add320_i281_0_stall_out_reg_181_NO_SHIFT_REG),
	.data_in(local_bb1_add320_i281),
	.data_out(rnode_180to181_bb1_add320_i281_0_reg_181_NO_SHIFT_REG)
);

defparam rnode_180to181_bb1_add320_i281_0_reg_181_fifo.DEPTH = 1;
defparam rnode_180to181_bb1_add320_i281_0_reg_181_fifo.DATA_WIDTH = 32;
defparam rnode_180to181_bb1_add320_i281_0_reg_181_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_180to181_bb1_add320_i281_0_reg_181_fifo.IMPL = "shift_reg";

assign rnode_180to181_bb1_add320_i281_0_reg_181_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add320_i281_stall_in = 1'b0;
assign rnode_180to181_bb1_add320_i281_0_stall_in_0_reg_181_NO_SHIFT_REG = 1'b0;
assign rnode_180to181_bb1_add320_i281_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_180to181_bb1_add320_i281_0_NO_SHIFT_REG = rnode_180to181_bb1_add320_i281_0_reg_181_NO_SHIFT_REG;
assign rnode_180to181_bb1_add320_i281_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_180to181_bb1_add320_i281_1_NO_SHIFT_REG = rnode_180to181_bb1_add320_i281_0_reg_181_NO_SHIFT_REG;
assign rnode_180to181_bb1_add320_i281_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_180to181_bb1_add320_i281_2_NO_SHIFT_REG = rnode_180to181_bb1_add320_i281_0_reg_181_NO_SHIFT_REG;
assign rnode_180to181_bb1_add320_i281_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_180to181_bb1_add320_i281_3_NO_SHIFT_REG = rnode_180to181_bb1_add320_i281_0_reg_181_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and2_i_stall_local;
wire [31:0] local_bb1_and2_i;

assign local_bb1_and2_i = (rnode_180to181_bb1_add320_i281_0_NO_SHIFT_REG >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_and12_i_stall_local;
wire [31:0] local_bb1_and12_i;

assign local_bb1_and12_i = (rnode_180to181_bb1_add320_i281_1_NO_SHIFT_REG & 32'hFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_shr3_i_stall_local;
wire [31:0] local_bb1_shr3_i;

assign local_bb1_shr3_i = (local_bb1_and2_i & 32'h7FFF);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp13_i_stall_local;
wire local_bb1_cmp13_i;

assign local_bb1_cmp13_i = (local_bb1_and10_i > local_bb1_and12_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_i3_stall_local;
wire local_bb1_cmp_i3;

assign local_bb1_cmp_i3 = (local_bb1_shr_i2 > local_bb1_shr3_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp8_i_stall_local;
wire local_bb1_cmp8_i;

assign local_bb1_cmp8_i = (local_bb1_shr_i2 == local_bb1_shr3_i);

// This section implements an unregistered operation.
// 
wire local_bb1___i_stall_local;
wire local_bb1___i;

assign local_bb1___i = (local_bb1_cmp8_i & local_bb1_cmp13_i);

// This section implements an unregistered operation.
// 
wire local_bb1__21_i_stall_local;
wire local_bb1__21_i;

assign local_bb1__21_i = (local_bb1_cmp_i3 | local_bb1___i);

// This section implements an unregistered operation.
// 
wire local_bb1__22_i_stall_local;
wire [31:0] local_bb1__22_i;

assign local_bb1__22_i = (local_bb1__21_i ? rnode_180to181_bb1_add320_i281_2_NO_SHIFT_REG : rnode_180to181_bb1_var__u17_2_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1__22_i_valid_out;
wire local_bb1__22_i_stall_in;
 reg local_bb1__22_i_consumed_0_NO_SHIFT_REG;
wire local_bb1__23_i_valid_out;
wire local_bb1__23_i_stall_in;
 reg local_bb1__23_i_consumed_0_NO_SHIFT_REG;
wire local_bb1__23_i_inputs_ready;
wire local_bb1__23_i_stall_local;
wire [31:0] local_bb1__23_i;

assign local_bb1__23_i_inputs_ready = (rnode_180to181_bb1_var__u17_0_valid_out_0_NO_SHIFT_REG & rnode_180to181_bb1_var__u17_0_valid_out_1_NO_SHIFT_REG & rnode_180to181_bb1_add320_i281_0_valid_out_2_NO_SHIFT_REG & rnode_180to181_bb1_var__u17_0_valid_out_2_NO_SHIFT_REG & rnode_180to181_bb1_var__u17_0_valid_out_3_NO_SHIFT_REG & rnode_180to181_bb1_add320_i281_0_valid_out_3_NO_SHIFT_REG & rnode_180to181_bb1_add320_i281_0_valid_out_1_NO_SHIFT_REG & rnode_180to181_bb1_add320_i281_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1__23_i = (local_bb1__21_i ? rnode_180to181_bb1_var__u17_3_NO_SHIFT_REG : rnode_180to181_bb1_add320_i281_3_NO_SHIFT_REG);
assign local_bb1__22_i_valid_out = 1'b1;
assign local_bb1__23_i_valid_out = 1'b1;
assign rnode_180to181_bb1_var__u17_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_180to181_bb1_var__u17_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_180to181_bb1_add320_i281_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_180to181_bb1_var__u17_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_180to181_bb1_var__u17_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign rnode_180to181_bb1_add320_i281_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign rnode_180to181_bb1_add320_i281_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_180to181_bb1_add320_i281_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1__22_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__23_i_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1__22_i_consumed_0_NO_SHIFT_REG <= (local_bb1__23_i_inputs_ready & (local_bb1__22_i_consumed_0_NO_SHIFT_REG | ~(local_bb1__22_i_stall_in)) & local_bb1__23_i_stall_local);
		local_bb1__23_i_consumed_0_NO_SHIFT_REG <= (local_bb1__23_i_inputs_ready & (local_bb1__23_i_consumed_0_NO_SHIFT_REG | ~(local_bb1__23_i_stall_in)) & local_bb1__23_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_181to182_bb1__22_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_181to182_bb1__22_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_181to182_bb1__22_i_0_NO_SHIFT_REG;
 logic rnode_181to182_bb1__22_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_181to182_bb1__22_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_181to182_bb1__22_i_1_NO_SHIFT_REG;
 logic rnode_181to182_bb1__22_i_0_reg_182_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_181to182_bb1__22_i_0_reg_182_NO_SHIFT_REG;
 logic rnode_181to182_bb1__22_i_0_valid_out_0_reg_182_NO_SHIFT_REG;
 logic rnode_181to182_bb1__22_i_0_stall_in_0_reg_182_NO_SHIFT_REG;
 logic rnode_181to182_bb1__22_i_0_stall_out_reg_182_NO_SHIFT_REG;

acl_data_fifo rnode_181to182_bb1__22_i_0_reg_182_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_181to182_bb1__22_i_0_reg_182_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_181to182_bb1__22_i_0_stall_in_0_reg_182_NO_SHIFT_REG),
	.valid_out(rnode_181to182_bb1__22_i_0_valid_out_0_reg_182_NO_SHIFT_REG),
	.stall_out(rnode_181to182_bb1__22_i_0_stall_out_reg_182_NO_SHIFT_REG),
	.data_in(local_bb1__22_i),
	.data_out(rnode_181to182_bb1__22_i_0_reg_182_NO_SHIFT_REG)
);

defparam rnode_181to182_bb1__22_i_0_reg_182_fifo.DEPTH = 1;
defparam rnode_181to182_bb1__22_i_0_reg_182_fifo.DATA_WIDTH = 32;
defparam rnode_181to182_bb1__22_i_0_reg_182_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_181to182_bb1__22_i_0_reg_182_fifo.IMPL = "shift_reg";

assign rnode_181to182_bb1__22_i_0_reg_182_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__22_i_stall_in = 1'b0;
assign rnode_181to182_bb1__22_i_0_stall_in_0_reg_182_NO_SHIFT_REG = 1'b0;
assign rnode_181to182_bb1__22_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_181to182_bb1__22_i_0_NO_SHIFT_REG = rnode_181to182_bb1__22_i_0_reg_182_NO_SHIFT_REG;
assign rnode_181to182_bb1__22_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_181to182_bb1__22_i_1_NO_SHIFT_REG = rnode_181to182_bb1__22_i_0_reg_182_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_181to182_bb1__23_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_181to182_bb1__23_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_181to182_bb1__23_i_0_NO_SHIFT_REG;
 logic rnode_181to182_bb1__23_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_181to182_bb1__23_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_181to182_bb1__23_i_1_NO_SHIFT_REG;
 logic rnode_181to182_bb1__23_i_0_reg_182_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_181to182_bb1__23_i_0_reg_182_NO_SHIFT_REG;
 logic rnode_181to182_bb1__23_i_0_valid_out_0_reg_182_NO_SHIFT_REG;
 logic rnode_181to182_bb1__23_i_0_stall_in_0_reg_182_NO_SHIFT_REG;
 logic rnode_181to182_bb1__23_i_0_stall_out_reg_182_NO_SHIFT_REG;

acl_data_fifo rnode_181to182_bb1__23_i_0_reg_182_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_181to182_bb1__23_i_0_reg_182_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_181to182_bb1__23_i_0_stall_in_0_reg_182_NO_SHIFT_REG),
	.valid_out(rnode_181to182_bb1__23_i_0_valid_out_0_reg_182_NO_SHIFT_REG),
	.stall_out(rnode_181to182_bb1__23_i_0_stall_out_reg_182_NO_SHIFT_REG),
	.data_in(local_bb1__23_i),
	.data_out(rnode_181to182_bb1__23_i_0_reg_182_NO_SHIFT_REG)
);

defparam rnode_181to182_bb1__23_i_0_reg_182_fifo.DEPTH = 1;
defparam rnode_181to182_bb1__23_i_0_reg_182_fifo.DATA_WIDTH = 32;
defparam rnode_181to182_bb1__23_i_0_reg_182_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_181to182_bb1__23_i_0_reg_182_fifo.IMPL = "shift_reg";

assign rnode_181to182_bb1__23_i_0_reg_182_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__23_i_stall_in = 1'b0;
assign rnode_181to182_bb1__23_i_0_stall_in_0_reg_182_NO_SHIFT_REG = 1'b0;
assign rnode_181to182_bb1__23_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_181to182_bb1__23_i_0_NO_SHIFT_REG = rnode_181to182_bb1__23_i_0_reg_182_NO_SHIFT_REG;
assign rnode_181to182_bb1__23_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_181to182_bb1__23_i_1_NO_SHIFT_REG = rnode_181to182_bb1__23_i_0_reg_182_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr18_i_stall_local;
wire [31:0] local_bb1_shr18_i;

assign local_bb1_shr18_i = (rnode_181to182_bb1__22_i_0_NO_SHIFT_REG >> 32'h17);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_182to183_bb1__22_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1__22_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1__22_i_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1__22_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1__22_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1__22_i_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1__22_i_0_reg_183_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1__22_i_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1__22_i_0_valid_out_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1__22_i_0_stall_in_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1__22_i_0_stall_out_reg_183_NO_SHIFT_REG;

acl_data_fifo rnode_182to183_bb1__22_i_0_reg_183_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_182to183_bb1__22_i_0_reg_183_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_182to183_bb1__22_i_0_stall_in_0_reg_183_NO_SHIFT_REG),
	.valid_out(rnode_182to183_bb1__22_i_0_valid_out_0_reg_183_NO_SHIFT_REG),
	.stall_out(rnode_182to183_bb1__22_i_0_stall_out_reg_183_NO_SHIFT_REG),
	.data_in(rnode_181to182_bb1__22_i_1_NO_SHIFT_REG),
	.data_out(rnode_182to183_bb1__22_i_0_reg_183_NO_SHIFT_REG)
);

defparam rnode_182to183_bb1__22_i_0_reg_183_fifo.DEPTH = 1;
defparam rnode_182to183_bb1__22_i_0_reg_183_fifo.DATA_WIDTH = 32;
defparam rnode_182to183_bb1__22_i_0_reg_183_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_182to183_bb1__22_i_0_reg_183_fifo.IMPL = "shift_reg";

assign rnode_182to183_bb1__22_i_0_reg_183_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_181to182_bb1__22_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1__22_i_0_stall_in_0_reg_183_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1__22_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1__22_i_0_NO_SHIFT_REG = rnode_182to183_bb1__22_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1__22_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1__22_i_1_NO_SHIFT_REG = rnode_182to183_bb1__22_i_0_reg_183_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr16_i_stall_local;
wire [31:0] local_bb1_shr16_i;

assign local_bb1_shr16_i = (rnode_181to182_bb1__23_i_0_NO_SHIFT_REG >> 32'h17);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_182to183_bb1__23_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1__23_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1__23_i_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1__23_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1__23_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1__23_i_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1__23_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_182to183_bb1__23_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1__23_i_2_NO_SHIFT_REG;
 logic rnode_182to183_bb1__23_i_0_reg_183_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1__23_i_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1__23_i_0_valid_out_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1__23_i_0_stall_in_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1__23_i_0_stall_out_reg_183_NO_SHIFT_REG;

acl_data_fifo rnode_182to183_bb1__23_i_0_reg_183_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_182to183_bb1__23_i_0_reg_183_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_182to183_bb1__23_i_0_stall_in_0_reg_183_NO_SHIFT_REG),
	.valid_out(rnode_182to183_bb1__23_i_0_valid_out_0_reg_183_NO_SHIFT_REG),
	.stall_out(rnode_182to183_bb1__23_i_0_stall_out_reg_183_NO_SHIFT_REG),
	.data_in(rnode_181to182_bb1__23_i_1_NO_SHIFT_REG),
	.data_out(rnode_182to183_bb1__23_i_0_reg_183_NO_SHIFT_REG)
);

defparam rnode_182to183_bb1__23_i_0_reg_183_fifo.DEPTH = 1;
defparam rnode_182to183_bb1__23_i_0_reg_183_fifo.DATA_WIDTH = 32;
defparam rnode_182to183_bb1__23_i_0_reg_183_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_182to183_bb1__23_i_0_reg_183_fifo.IMPL = "shift_reg";

assign rnode_182to183_bb1__23_i_0_reg_183_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_181to182_bb1__23_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1__23_i_0_stall_in_0_reg_183_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1__23_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1__23_i_0_NO_SHIFT_REG = rnode_182to183_bb1__23_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1__23_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1__23_i_1_NO_SHIFT_REG = rnode_182to183_bb1__23_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1__23_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1__23_i_2_NO_SHIFT_REG = rnode_182to183_bb1__23_i_0_reg_183_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and19_i_stall_local;
wire [31:0] local_bb1_and19_i;

assign local_bb1_and19_i = (local_bb1_shr18_i & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and21_i_stall_local;
wire [31:0] local_bb1_and21_i;

assign local_bb1_and21_i = (rnode_182to183_bb1__22_i_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_sub_i11_stall_local;
wire [31:0] local_bb1_sub_i11;

assign local_bb1_sub_i11 = (local_bb1_shr16_i - local_bb1_shr18_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and20_i_stall_local;
wire [31:0] local_bb1_and20_i;

assign local_bb1_and20_i = (rnode_182to183_bb1__23_i_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and35_i_valid_out;
wire local_bb1_and35_i_stall_in;
wire local_bb1_and35_i_inputs_ready;
wire local_bb1_and35_i_stall_local;
wire [31:0] local_bb1_and35_i;

assign local_bb1_and35_i_inputs_ready = rnode_182to183_bb1__23_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_and35_i = (rnode_182to183_bb1__23_i_1_NO_SHIFT_REG & 32'h80000000);
assign local_bb1_and35_i_valid_out = 1'b1;
assign rnode_182to183_bb1__23_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_xor_i5_stall_local;
wire [31:0] local_bb1_xor_i5;

assign local_bb1_xor_i5 = (rnode_182to183_bb1__23_i_2_NO_SHIFT_REG ^ rnode_182to183_bb1__22_i_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot23_i_stall_local;
wire local_bb1_lnot23_i;

assign local_bb1_lnot23_i = (local_bb1_and19_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp27_i_stall_local;
wire local_bb1_cmp27_i;

assign local_bb1_cmp27_i = (local_bb1_and19_i == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot33_not_i_stall_local;
wire local_bb1_lnot33_not_i;

assign local_bb1_lnot33_not_i = (local_bb1_and21_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or64_i_stall_local;
wire [31:0] local_bb1_or64_i;

assign local_bb1_or64_i = (local_bb1_and21_i << 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb1_and68_i_stall_local;
wire [31:0] local_bb1_and68_i;

assign local_bb1_and68_i = (local_bb1_sub_i11 & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot30_i_stall_local;
wire local_bb1_lnot30_i;

assign local_bb1_lnot30_i = (local_bb1_and20_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i7_stall_local;
wire [31:0] local_bb1_or_i7;

assign local_bb1_or_i7 = (local_bb1_and20_i << 32'h3);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_183to184_bb1_and35_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_183to184_bb1_and35_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_183to184_bb1_and35_i_0_NO_SHIFT_REG;
 logic rnode_183to184_bb1_and35_i_0_reg_184_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_183to184_bb1_and35_i_0_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1_and35_i_0_valid_out_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1_and35_i_0_stall_in_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1_and35_i_0_stall_out_reg_184_NO_SHIFT_REG;

acl_data_fifo rnode_183to184_bb1_and35_i_0_reg_184_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_183to184_bb1_and35_i_0_reg_184_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_183to184_bb1_and35_i_0_stall_in_reg_184_NO_SHIFT_REG),
	.valid_out(rnode_183to184_bb1_and35_i_0_valid_out_reg_184_NO_SHIFT_REG),
	.stall_out(rnode_183to184_bb1_and35_i_0_stall_out_reg_184_NO_SHIFT_REG),
	.data_in(local_bb1_and35_i),
	.data_out(rnode_183to184_bb1_and35_i_0_reg_184_NO_SHIFT_REG)
);

defparam rnode_183to184_bb1_and35_i_0_reg_184_fifo.DEPTH = 1;
defparam rnode_183to184_bb1_and35_i_0_reg_184_fifo.DATA_WIDTH = 32;
defparam rnode_183to184_bb1_and35_i_0_reg_184_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_183to184_bb1_and35_i_0_reg_184_fifo.IMPL = "shift_reg";

assign rnode_183to184_bb1_and35_i_0_reg_184_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and35_i_stall_in = 1'b0;
assign rnode_183to184_bb1_and35_i_0_NO_SHIFT_REG = rnode_183to184_bb1_and35_i_0_reg_184_NO_SHIFT_REG;
assign rnode_183to184_bb1_and35_i_0_stall_in_reg_184_NO_SHIFT_REG = 1'b0;
assign rnode_183to184_bb1_and35_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp37_i_stall_local;
wire local_bb1_cmp37_i;

assign local_bb1_cmp37_i = ($signed(local_bb1_xor_i5) < $signed(32'h0));

// This section implements an unregistered operation.
// 
wire local_bb1_xor_lobit_i_stall_local;
wire [31:0] local_bb1_xor_lobit_i;

assign local_bb1_xor_lobit_i = ($signed(local_bb1_xor_i5) >>> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb1_and36_lobit_i_stall_local;
wire [31:0] local_bb1_and36_lobit_i;

assign local_bb1_and36_lobit_i = (local_bb1_xor_i5 >> 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb1_shl65_i_stall_local;
wire [31:0] local_bb1_shl65_i;

assign local_bb1_shl65_i = (local_bb1_or64_i | 32'h4000000);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp69_i_stall_local;
wire local_bb1_cmp69_i;

assign local_bb1_cmp69_i = (local_bb1_and68_i > 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot30_not_i_stall_local;
wire local_bb1_lnot30_not_i;

assign local_bb1_lnot30_not_i = (local_bb1_lnot30_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i8_stall_local;
wire [31:0] local_bb1_shl_i8;

assign local_bb1_shl_i8 = (local_bb1_or_i7 | 32'h4000000);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_184to185_bb1_and35_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and35_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and35_i_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and35_i_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and35_i_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and35_i_0_valid_out_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and35_i_0_stall_in_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and35_i_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_184to185_bb1_and35_i_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_184to185_bb1_and35_i_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_184to185_bb1_and35_i_0_stall_in_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_184to185_bb1_and35_i_0_valid_out_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_184to185_bb1_and35_i_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(rnode_183to184_bb1_and35_i_0_NO_SHIFT_REG),
	.data_out(rnode_184to185_bb1_and35_i_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_184to185_bb1_and35_i_0_reg_185_fifo.DEPTH = 1;
defparam rnode_184to185_bb1_and35_i_0_reg_185_fifo.DATA_WIDTH = 32;
defparam rnode_184to185_bb1_and35_i_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_184to185_bb1_and35_i_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_184to185_bb1_and35_i_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_183to184_bb1_and35_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and35_i_0_NO_SHIFT_REG = rnode_184to185_bb1_and35_i_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_and35_i_0_stall_in_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and35_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr16_i_valid_out_1;
wire local_bb1_shr16_i_stall_in_1;
 reg local_bb1_shr16_i_consumed_1_NO_SHIFT_REG;
wire local_bb1_lnot23_i_valid_out;
wire local_bb1_lnot23_i_stall_in;
 reg local_bb1_lnot23_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp27_i_valid_out;
wire local_bb1_cmp27_i_stall_in;
 reg local_bb1_cmp27_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_align_0_i_valid_out;
wire local_bb1_align_0_i_stall_in;
 reg local_bb1_align_0_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_align_0_i_inputs_ready;
wire local_bb1_align_0_i_stall_local;
wire [31:0] local_bb1_align_0_i;

assign local_bb1_align_0_i_inputs_ready = (rnode_181to182_bb1__22_i_0_valid_out_0_NO_SHIFT_REG & rnode_181to182_bb1__23_i_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_align_0_i = (local_bb1_cmp69_i ? 32'h1F : local_bb1_and68_i);
assign local_bb1_shr16_i_valid_out_1 = 1'b1;
assign local_bb1_lnot23_i_valid_out = 1'b1;
assign local_bb1_cmp27_i_valid_out = 1'b1;
assign local_bb1_align_0_i_valid_out = 1'b1;
assign rnode_181to182_bb1__22_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_181to182_bb1__23_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_shr16_i_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_lnot23_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp27_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_align_0_i_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_shr16_i_consumed_1_NO_SHIFT_REG <= (local_bb1_align_0_i_inputs_ready & (local_bb1_shr16_i_consumed_1_NO_SHIFT_REG | ~(local_bb1_shr16_i_stall_in_1)) & local_bb1_align_0_i_stall_local);
		local_bb1_lnot23_i_consumed_0_NO_SHIFT_REG <= (local_bb1_align_0_i_inputs_ready & (local_bb1_lnot23_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_lnot23_i_stall_in)) & local_bb1_align_0_i_stall_local);
		local_bb1_cmp27_i_consumed_0_NO_SHIFT_REG <= (local_bb1_align_0_i_inputs_ready & (local_bb1_cmp27_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp27_i_stall_in)) & local_bb1_align_0_i_stall_local);
		local_bb1_align_0_i_consumed_0_NO_SHIFT_REG <= (local_bb1_align_0_i_inputs_ready & (local_bb1_align_0_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_align_0_i_stall_in)) & local_bb1_align_0_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_and35_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and35_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_185to186_bb1_and35_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and35_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_185to186_bb1_and35_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and35_i_0_valid_out_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and35_i_0_stall_in_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and35_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_and35_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_and35_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_and35_i_0_stall_in_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_and35_i_0_valid_out_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_and35_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(rnode_184to185_bb1_and35_i_0_NO_SHIFT_REG),
	.data_out(rnode_185to186_bb1_and35_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_and35_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_and35_i_0_reg_186_fifo.DATA_WIDTH = 32;
defparam rnode_185to186_bb1_and35_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_and35_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_and35_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_184to185_bb1_and35_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_and35_i_0_NO_SHIFT_REG = rnode_185to186_bb1_and35_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_and35_i_0_stall_in_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_and35_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_182to183_bb1_shr16_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1_shr16_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1_shr16_i_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1_shr16_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1_shr16_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1_shr16_i_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1_shr16_i_0_reg_183_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1_shr16_i_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_shr16_i_0_valid_out_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_shr16_i_0_stall_in_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_shr16_i_0_stall_out_reg_183_NO_SHIFT_REG;

acl_data_fifo rnode_182to183_bb1_shr16_i_0_reg_183_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_182to183_bb1_shr16_i_0_reg_183_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_182to183_bb1_shr16_i_0_stall_in_0_reg_183_NO_SHIFT_REG),
	.valid_out(rnode_182to183_bb1_shr16_i_0_valid_out_0_reg_183_NO_SHIFT_REG),
	.stall_out(rnode_182to183_bb1_shr16_i_0_stall_out_reg_183_NO_SHIFT_REG),
	.data_in(local_bb1_shr16_i),
	.data_out(rnode_182to183_bb1_shr16_i_0_reg_183_NO_SHIFT_REG)
);

defparam rnode_182to183_bb1_shr16_i_0_reg_183_fifo.DEPTH = 1;
defparam rnode_182to183_bb1_shr16_i_0_reg_183_fifo.DATA_WIDTH = 32;
defparam rnode_182to183_bb1_shr16_i_0_reg_183_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_182to183_bb1_shr16_i_0_reg_183_fifo.IMPL = "shift_reg";

assign rnode_182to183_bb1_shr16_i_0_reg_183_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr16_i_stall_in_1 = 1'b0;
assign rnode_182to183_bb1_shr16_i_0_stall_in_0_reg_183_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_shr16_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_shr16_i_0_NO_SHIFT_REG = rnode_182to183_bb1_shr16_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1_shr16_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_shr16_i_1_NO_SHIFT_REG = rnode_182to183_bb1_shr16_i_0_reg_183_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_182to183_bb1_lnot23_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_182to183_bb1_lnot23_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_182to183_bb1_lnot23_i_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1_lnot23_i_0_reg_183_inputs_ready_NO_SHIFT_REG;
 logic rnode_182to183_bb1_lnot23_i_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_lnot23_i_0_valid_out_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_lnot23_i_0_stall_in_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_lnot23_i_0_stall_out_reg_183_NO_SHIFT_REG;

acl_data_fifo rnode_182to183_bb1_lnot23_i_0_reg_183_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_182to183_bb1_lnot23_i_0_reg_183_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_182to183_bb1_lnot23_i_0_stall_in_reg_183_NO_SHIFT_REG),
	.valid_out(rnode_182to183_bb1_lnot23_i_0_valid_out_reg_183_NO_SHIFT_REG),
	.stall_out(rnode_182to183_bb1_lnot23_i_0_stall_out_reg_183_NO_SHIFT_REG),
	.data_in(local_bb1_lnot23_i),
	.data_out(rnode_182to183_bb1_lnot23_i_0_reg_183_NO_SHIFT_REG)
);

defparam rnode_182to183_bb1_lnot23_i_0_reg_183_fifo.DEPTH = 1;
defparam rnode_182to183_bb1_lnot23_i_0_reg_183_fifo.DATA_WIDTH = 1;
defparam rnode_182to183_bb1_lnot23_i_0_reg_183_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_182to183_bb1_lnot23_i_0_reg_183_fifo.IMPL = "shift_reg";

assign rnode_182to183_bb1_lnot23_i_0_reg_183_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lnot23_i_stall_in = 1'b0;
assign rnode_182to183_bb1_lnot23_i_0_NO_SHIFT_REG = rnode_182to183_bb1_lnot23_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1_lnot23_i_0_stall_in_reg_183_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_lnot23_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_182to183_bb1_cmp27_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_2_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_reg_183_inputs_ready_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_valid_out_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_stall_in_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_cmp27_i_0_stall_out_reg_183_NO_SHIFT_REG;

acl_data_fifo rnode_182to183_bb1_cmp27_i_0_reg_183_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_182to183_bb1_cmp27_i_0_reg_183_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_182to183_bb1_cmp27_i_0_stall_in_0_reg_183_NO_SHIFT_REG),
	.valid_out(rnode_182to183_bb1_cmp27_i_0_valid_out_0_reg_183_NO_SHIFT_REG),
	.stall_out(rnode_182to183_bb1_cmp27_i_0_stall_out_reg_183_NO_SHIFT_REG),
	.data_in(local_bb1_cmp27_i),
	.data_out(rnode_182to183_bb1_cmp27_i_0_reg_183_NO_SHIFT_REG)
);

defparam rnode_182to183_bb1_cmp27_i_0_reg_183_fifo.DEPTH = 1;
defparam rnode_182to183_bb1_cmp27_i_0_reg_183_fifo.DATA_WIDTH = 1;
defparam rnode_182to183_bb1_cmp27_i_0_reg_183_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_182to183_bb1_cmp27_i_0_reg_183_fifo.IMPL = "shift_reg";

assign rnode_182to183_bb1_cmp27_i_0_reg_183_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp27_i_stall_in = 1'b0;
assign rnode_182to183_bb1_cmp27_i_0_stall_in_0_reg_183_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_cmp27_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_cmp27_i_0_NO_SHIFT_REG = rnode_182to183_bb1_cmp27_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1_cmp27_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_cmp27_i_1_NO_SHIFT_REG = rnode_182to183_bb1_cmp27_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1_cmp27_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_cmp27_i_2_NO_SHIFT_REG = rnode_182to183_bb1_cmp27_i_0_reg_183_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_182to183_bb1_align_0_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1_align_0_i_0_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1_align_0_i_1_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1_align_0_i_2_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1_align_0_i_3_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_valid_out_4_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_stall_in_4_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1_align_0_i_4_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_reg_183_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_182to183_bb1_align_0_i_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_valid_out_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_stall_in_0_reg_183_NO_SHIFT_REG;
 logic rnode_182to183_bb1_align_0_i_0_stall_out_reg_183_NO_SHIFT_REG;

acl_data_fifo rnode_182to183_bb1_align_0_i_0_reg_183_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_182to183_bb1_align_0_i_0_reg_183_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_182to183_bb1_align_0_i_0_stall_in_0_reg_183_NO_SHIFT_REG),
	.valid_out(rnode_182to183_bb1_align_0_i_0_valid_out_0_reg_183_NO_SHIFT_REG),
	.stall_out(rnode_182to183_bb1_align_0_i_0_stall_out_reg_183_NO_SHIFT_REG),
	.data_in(local_bb1_align_0_i),
	.data_out(rnode_182to183_bb1_align_0_i_0_reg_183_NO_SHIFT_REG)
);

defparam rnode_182to183_bb1_align_0_i_0_reg_183_fifo.DEPTH = 1;
defparam rnode_182to183_bb1_align_0_i_0_reg_183_fifo.DATA_WIDTH = 32;
defparam rnode_182to183_bb1_align_0_i_0_reg_183_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_182to183_bb1_align_0_i_0_reg_183_fifo.IMPL = "shift_reg";

assign rnode_182to183_bb1_align_0_i_0_reg_183_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_align_0_i_stall_in = 1'b0;
assign rnode_182to183_bb1_align_0_i_0_stall_in_0_reg_183_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_align_0_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_align_0_i_0_NO_SHIFT_REG = rnode_182to183_bb1_align_0_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1_align_0_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_align_0_i_1_NO_SHIFT_REG = rnode_182to183_bb1_align_0_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1_align_0_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_align_0_i_2_NO_SHIFT_REG = rnode_182to183_bb1_align_0_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1_align_0_i_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_align_0_i_3_NO_SHIFT_REG = rnode_182to183_bb1_align_0_i_0_reg_183_NO_SHIFT_REG;
assign rnode_182to183_bb1_align_0_i_0_valid_out_4_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_align_0_i_4_NO_SHIFT_REG = rnode_182to183_bb1_align_0_i_0_reg_183_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and17_i_stall_local;
wire [31:0] local_bb1_and17_i;

assign local_bb1_and17_i = (rnode_182to183_bb1_shr16_i_0_NO_SHIFT_REG & 32'hFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_183to185_bb1_shr16_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_183to185_bb1_shr16_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_183to185_bb1_shr16_i_0_NO_SHIFT_REG;
 logic rnode_183to185_bb1_shr16_i_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_183to185_bb1_shr16_i_0_reg_185_NO_SHIFT_REG;
 logic rnode_183to185_bb1_shr16_i_0_valid_out_reg_185_NO_SHIFT_REG;
 logic rnode_183to185_bb1_shr16_i_0_stall_in_reg_185_NO_SHIFT_REG;
 logic rnode_183to185_bb1_shr16_i_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_183to185_bb1_shr16_i_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_183to185_bb1_shr16_i_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_183to185_bb1_shr16_i_0_stall_in_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_183to185_bb1_shr16_i_0_valid_out_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_183to185_bb1_shr16_i_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(rnode_182to183_bb1_shr16_i_1_NO_SHIFT_REG),
	.data_out(rnode_183to185_bb1_shr16_i_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_183to185_bb1_shr16_i_0_reg_185_fifo.DEPTH = 2;
defparam rnode_183to185_bb1_shr16_i_0_reg_185_fifo.DATA_WIDTH = 32;
defparam rnode_183to185_bb1_shr16_i_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_183to185_bb1_shr16_i_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_183to185_bb1_shr16_i_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_182to183_bb1_shr16_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_183to185_bb1_shr16_i_0_NO_SHIFT_REG = rnode_183to185_bb1_shr16_i_0_reg_185_NO_SHIFT_REG;
assign rnode_183to185_bb1_shr16_i_0_stall_in_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_183to185_bb1_shr16_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__28_i10_stall_local;
wire [31:0] local_bb1__28_i10;

assign local_bb1__28_i10 = (rnode_182to183_bb1_lnot23_i_0_NO_SHIFT_REG ? 32'h0 : local_bb1_shl65_i);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge_not_i_stall_local;
wire local_bb1_brmerge_not_i;

assign local_bb1_brmerge_not_i = (rnode_182to183_bb1_cmp27_i_0_NO_SHIFT_REG & local_bb1_lnot33_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and93_i_stall_local;
wire [31:0] local_bb1_and93_i;

assign local_bb1_and93_i = (rnode_182to183_bb1_align_0_i_0_NO_SHIFT_REG & 32'h1C);

// This section implements an unregistered operation.
// 
wire local_bb1_and95_i_stall_local;
wire [31:0] local_bb1_and95_i;

assign local_bb1_and95_i = (rnode_182to183_bb1_align_0_i_1_NO_SHIFT_REG & 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_and115_i_stall_local;
wire [31:0] local_bb1_and115_i;

assign local_bb1_and115_i = (rnode_182to183_bb1_align_0_i_2_NO_SHIFT_REG & 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb1_and130_i_stall_local;
wire [31:0] local_bb1_and130_i;

assign local_bb1_and130_i = (rnode_182to183_bb1_align_0_i_3_NO_SHIFT_REG & 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb1_and149_i_stall_local;
wire [31:0] local_bb1_and149_i;

assign local_bb1_and149_i = (rnode_182to183_bb1_align_0_i_4_NO_SHIFT_REG & 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_i4_stall_local;
wire local_bb1_lnot_i4;

assign local_bb1_lnot_i4 = (local_bb1_and17_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp25_i_stall_local;
wire local_bb1_cmp25_i;

assign local_bb1_cmp25_i = (local_bb1_and17_i == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and72_i_stall_local;
wire [31:0] local_bb1_and72_i;

assign local_bb1_and72_i = (local_bb1__28_i10 >> 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb1_and75_i12_stall_local;
wire [31:0] local_bb1_and75_i12;

assign local_bb1_and75_i12 = (local_bb1__28_i10 & 32'hF0);

// This section implements an unregistered operation.
// 
wire local_bb1_and78_i_stall_local;
wire [31:0] local_bb1_and78_i;

assign local_bb1_and78_i = (local_bb1__28_i10 & 32'hF00);

// This section implements an unregistered operation.
// 
wire local_bb1_and90_i13_stall_local;
wire [31:0] local_bb1_and90_i13;

assign local_bb1_and90_i13 = (local_bb1__28_i10 & 32'h7000000);

// This section implements an unregistered operation.
// 
wire local_bb1_and87_i_stall_local;
wire [31:0] local_bb1_and87_i;

assign local_bb1_and87_i = (local_bb1__28_i10 & 32'hF00000);

// This section implements an unregistered operation.
// 
wire local_bb1_and84_i_stall_local;
wire [31:0] local_bb1_and84_i;

assign local_bb1_and84_i = (local_bb1__28_i10 & 32'hF0000);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u27_stall_local;
wire [31:0] local_bb1_var__u27;

assign local_bb1_var__u27 = (local_bb1__28_i10 & 32'hFFF8);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge_not_not_i_stall_local;
wire local_bb1_brmerge_not_not_i;

assign local_bb1_brmerge_not_not_i = (local_bb1_brmerge_not_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_shr94_i_stall_local;
wire [31:0] local_bb1_shr94_i;

assign local_bb1_shr94_i = (local_bb1__28_i10 >> local_bb1_and93_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp96_i_stall_local;
wire local_bb1_cmp96_i;

assign local_bb1_cmp96_i = (local_bb1_and95_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp116_i_stall_local;
wire local_bb1_cmp116_i;

assign local_bb1_cmp116_i = (local_bb1_and115_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp131_not_i_stall_local;
wire local_bb1_cmp131_not_i;

assign local_bb1_cmp131_not_i = (local_bb1_and130_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_Pivot20_i_stall_local;
wire local_bb1_Pivot20_i;

assign local_bb1_Pivot20_i = (local_bb1_and149_i < 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_SwitchLeaf_i_stall_local;
wire local_bb1_SwitchLeaf_i;

assign local_bb1_SwitchLeaf_i = (local_bb1_and149_i == 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__27_i9_stall_local;
wire [31:0] local_bb1__27_i9;

assign local_bb1__27_i9 = (local_bb1_lnot_i4 ? 32'h0 : local_bb1_shl_i8);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp25_not_i_stall_local;
wire local_bb1_cmp25_not_i;

assign local_bb1_cmp25_not_i = (local_bb1_cmp25_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_or_cond_not_i_stall_local;
wire local_bb1_or_cond_not_i;

assign local_bb1_or_cond_not_i = (local_bb1_cmp25_i & local_bb1_lnot30_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u28_stall_local;
wire local_bb1_var__u28;

assign local_bb1_var__u28 = (local_bb1_cmp25_i | rnode_182to183_bb1_cmp27_i_2_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_and72_tr_i_stall_local;
wire [7:0] local_bb1_and72_tr_i;

assign local_bb1_and72_tr_i = local_bb1_and72_i[7:0];

// This section implements an unregistered operation.
// 
wire local_bb1_cmp76_i_stall_local;
wire local_bb1_cmp76_i;

assign local_bb1_cmp76_i = (local_bb1_and75_i12 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp79_i_stall_local;
wire local_bb1_cmp79_i;

assign local_bb1_cmp79_i = (local_bb1_and78_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp91_i14_stall_local;
wire local_bb1_cmp91_i14;

assign local_bb1_cmp91_i14 = (local_bb1_and90_i13 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp88_i_stall_local;
wire local_bb1_cmp88_i;

assign local_bb1_cmp88_i = (local_bb1_and87_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp85_i_stall_local;
wire local_bb1_cmp85_i;

assign local_bb1_cmp85_i = (local_bb1_and84_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u29_stall_local;
wire local_bb1_var__u29;

assign local_bb1_var__u29 = (local_bb1_var__u27 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_7_i_stall_local;
wire local_bb1_reduction_7_i;

assign local_bb1_reduction_7_i = (local_bb1_cmp25_i & local_bb1_brmerge_not_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and142_i_stall_local;
wire [31:0] local_bb1_and142_i;

assign local_bb1_and142_i = (local_bb1_shr94_i >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_shr150_i_stall_local;
wire [31:0] local_bb1_shr150_i;

assign local_bb1_shr150_i = (local_bb1_shr94_i >> local_bb1_and149_i);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u30_stall_local;
wire [31:0] local_bb1_var__u30;

assign local_bb1_var__u30 = (local_bb1_shr94_i & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_and146_i_stall_local;
wire [31:0] local_bb1_and146_i;

assign local_bb1_and146_i = (local_bb1_shr94_i >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_add_i21_stall_local;
wire [31:0] local_bb1_add_i21;

assign local_bb1_add_i21 = (local_bb1__27_i9 | local_bb1_and36_lobit_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or_cond_i_stall_local;
wire local_bb1_or_cond_i;

assign local_bb1_or_cond_i = (local_bb1_lnot30_i | local_bb1_cmp25_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1__24_i6_stall_local;
wire local_bb1__24_i6;

assign local_bb1__24_i6 = (local_bb1_or_cond_not_i | local_bb1_brmerge_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_frombool74_i_stall_local;
wire [7:0] local_bb1_frombool74_i;

assign local_bb1_frombool74_i = (local_bb1_and72_tr_i & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__31_v_i_stall_local;
wire local_bb1__31_v_i;

assign local_bb1__31_v_i = (local_bb1_cmp96_i ? local_bb1_cmp79_i : local_bb1_cmp91_i14);

// This section implements an unregistered operation.
// 
wire local_bb1__30_v_i_stall_local;
wire local_bb1__30_v_i;

assign local_bb1__30_v_i = (local_bb1_cmp96_i ? local_bb1_cmp76_i : local_bb1_cmp88_i);

// This section implements an unregistered operation.
// 
wire local_bb1_frombool109_i_stall_local;
wire [7:0] local_bb1_frombool109_i;

assign local_bb1_frombool109_i[7:1] = 7'h0;
assign local_bb1_frombool109_i[0] = local_bb1_cmp85_i;

// This section implements an unregistered operation.
// 
wire local_bb1_or107_i_stall_local;
wire [31:0] local_bb1_or107_i;

assign local_bb1_or107_i[31:1] = 31'h0;
assign local_bb1_or107_i[0] = local_bb1_var__u29;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u31_stall_local;
wire [31:0] local_bb1_var__u31;

assign local_bb1_var__u31 = (local_bb1_and146_i | local_bb1_shr94_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_8_i_stall_local;
wire local_bb1_reduction_8_i;

assign local_bb1_reduction_8_i = (rnode_182to183_bb1_cmp27_i_1_NO_SHIFT_REG & local_bb1_or_cond_i);

// This section implements an unregistered operation.
// 
wire local_bb1__31_i16_stall_local;
wire [7:0] local_bb1__31_i16;

assign local_bb1__31_i16[7:1] = 7'h0;
assign local_bb1__31_i16[0] = local_bb1__31_v_i;

// This section implements an unregistered operation.
// 
wire local_bb1__30_i_stall_local;
wire [7:0] local_bb1__30_i;

assign local_bb1__30_i[7:1] = 7'h0;
assign local_bb1__30_i[0] = local_bb1__30_v_i;

// This section implements an unregistered operation.
// 
wire local_bb1__29_i15_stall_local;
wire [7:0] local_bb1__29_i15;

assign local_bb1__29_i15 = (local_bb1_cmp96_i ? local_bb1_frombool74_i : local_bb1_frombool109_i);

// This section implements an unregistered operation.
// 
wire local_bb1__32_i17_stall_local;
wire [31:0] local_bb1__32_i17;

assign local_bb1__32_i17 = (local_bb1_cmp96_i ? 32'h0 : local_bb1_or107_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or1596_i_stall_local;
wire [31:0] local_bb1_or1596_i;

assign local_bb1_or1596_i = (local_bb1_var__u31 | local_bb1_and142_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_9_i_stall_local;
wire local_bb1_reduction_9_i;

assign local_bb1_reduction_9_i = (local_bb1_reduction_7_i & local_bb1_reduction_8_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or1237_i_stall_local;
wire [7:0] local_bb1_or1237_i;

assign local_bb1_or1237_i = (local_bb1__30_i | local_bb1__29_i15);

// This section implements an unregistered operation.
// 
wire local_bb1__33_i18_stall_local;
wire [7:0] local_bb1__33_i18;

assign local_bb1__33_i18 = (local_bb1_cmp116_i ? local_bb1__29_i15 : local_bb1__31_i16);

// This section implements an unregistered operation.
// 
wire local_bb1_or162_i_stall_local;
wire [31:0] local_bb1_or162_i;

assign local_bb1_or162_i = (local_bb1_or1596_i & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__26_i_stall_local;
wire local_bb1__26_i;

assign local_bb1__26_i = (local_bb1_reduction_9_i ? local_bb1_cmp37_i : local_bb1__24_i6);

// This section implements an unregistered operation.
// 
wire local_bb1_or123_i_stall_local;
wire [31:0] local_bb1_or123_i;

assign local_bb1_or123_i[31:8] = 24'h0;
assign local_bb1_or123_i[7:0] = local_bb1_or1237_i;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u32_stall_local;
wire [7:0] local_bb1_var__u32;

assign local_bb1_var__u32 = (local_bb1__33_i18 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__37_v_i_stall_local;
wire [31:0] local_bb1__37_v_i;

assign local_bb1__37_v_i = (local_bb1_Pivot20_i ? 32'h0 : local_bb1_or162_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or124_i_stall_local;
wire [31:0] local_bb1_or124_i;

assign local_bb1_or124_i = (local_bb1_cmp116_i ? 32'h0 : local_bb1_or123_i);

// This section implements an unregistered operation.
// 
wire local_bb1_conv135_i_stall_local;
wire [31:0] local_bb1_conv135_i;

assign local_bb1_conv135_i[31:8] = 24'h0;
assign local_bb1_conv135_i[7:0] = local_bb1_var__u32;

// This section implements an unregistered operation.
// 
wire local_bb1__39_v_i_stall_local;
wire [31:0] local_bb1__39_v_i;

assign local_bb1__39_v_i = (local_bb1_SwitchLeaf_i ? local_bb1_var__u30 : local_bb1__37_v_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_3_i_stall_local;
wire [31:0] local_bb1_reduction_3_i;

assign local_bb1_reduction_3_i = (local_bb1__32_i17 | local_bb1_or124_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or136_i_stall_local;
wire [31:0] local_bb1_or136_i;

assign local_bb1_or136_i = (local_bb1_cmp131_not_i ? local_bb1_conv135_i : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_5_i19_stall_local;
wire [31:0] local_bb1_reduction_5_i19;

assign local_bb1_reduction_5_i19 = (local_bb1_shr150_i | local_bb1_reduction_3_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_4_i_stall_local;
wire [31:0] local_bb1_reduction_4_i;

assign local_bb1_reduction_4_i = (local_bb1_or136_i | local_bb1__39_v_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_6_i20_stall_local;
wire [31:0] local_bb1_reduction_6_i20;

assign local_bb1_reduction_6_i20 = (local_bb1_reduction_4_i | local_bb1_reduction_5_i19);

// This section implements an unregistered operation.
// 
wire local_bb1_xor188_i_stall_local;
wire [31:0] local_bb1_xor188_i;

assign local_bb1_xor188_i = (local_bb1_reduction_6_i20 ^ local_bb1_xor_lobit_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp37_i_valid_out_1;
wire local_bb1_cmp37_i_stall_in_1;
 reg local_bb1_cmp37_i_consumed_1_NO_SHIFT_REG;
wire local_bb1__26_i_valid_out;
wire local_bb1__26_i_stall_in;
 reg local_bb1__26_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_add192_i_valid_out;
wire local_bb1_add192_i_stall_in;
 reg local_bb1_add192_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_and17_i_valid_out_2;
wire local_bb1_and17_i_stall_in_2;
 reg local_bb1_and17_i_consumed_2_NO_SHIFT_REG;
wire local_bb1_var__u28_valid_out;
wire local_bb1_var__u28_stall_in;
 reg local_bb1_var__u28_consumed_0_NO_SHIFT_REG;
wire local_bb1_add192_i_inputs_ready;
wire local_bb1_add192_i_stall_local;
wire [31:0] local_bb1_add192_i;

assign local_bb1_add192_i_inputs_ready = (rnode_182to183_bb1__22_i_0_valid_out_0_NO_SHIFT_REG & rnode_182to183_bb1_cmp27_i_0_valid_out_0_NO_SHIFT_REG & rnode_182to183_bb1_lnot23_i_0_valid_out_NO_SHIFT_REG & rnode_182to183_bb1__22_i_0_valid_out_1_NO_SHIFT_REG & rnode_182to183_bb1__23_i_0_valid_out_2_NO_SHIFT_REG & rnode_182to183_bb1__23_i_0_valid_out_0_NO_SHIFT_REG & rnode_182to183_bb1_cmp27_i_0_valid_out_1_NO_SHIFT_REG & rnode_182to183_bb1_shr16_i_0_valid_out_0_NO_SHIFT_REG & rnode_182to183_bb1_cmp27_i_0_valid_out_2_NO_SHIFT_REG & rnode_182to183_bb1_align_0_i_0_valid_out_0_NO_SHIFT_REG & rnode_182to183_bb1_align_0_i_0_valid_out_4_NO_SHIFT_REG & rnode_182to183_bb1_align_0_i_0_valid_out_1_NO_SHIFT_REG & rnode_182to183_bb1_align_0_i_0_valid_out_2_NO_SHIFT_REG & rnode_182to183_bb1_align_0_i_0_valid_out_3_NO_SHIFT_REG);
assign local_bb1_add192_i = (local_bb1_add_i21 + local_bb1_xor188_i);
assign local_bb1_cmp37_i_valid_out_1 = 1'b1;
assign local_bb1__26_i_valid_out = 1'b1;
assign local_bb1_add192_i_valid_out = 1'b1;
assign local_bb1_and17_i_valid_out_2 = 1'b1;
assign local_bb1_var__u28_valid_out = 1'b1;
assign rnode_182to183_bb1__22_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_cmp27_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_lnot23_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1__22_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1__23_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1__23_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_cmp27_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_shr16_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_cmp27_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_align_0_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_align_0_i_0_stall_in_4_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_align_0_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_align_0_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_182to183_bb1_align_0_i_0_stall_in_3_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_cmp37_i_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1__26_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_add192_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and17_i_consumed_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_var__u28_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_cmp37_i_consumed_1_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1_cmp37_i_consumed_1_NO_SHIFT_REG | ~(local_bb1_cmp37_i_stall_in_1)) & local_bb1_add192_i_stall_local);
		local_bb1__26_i_consumed_0_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1__26_i_consumed_0_NO_SHIFT_REG | ~(local_bb1__26_i_stall_in)) & local_bb1_add192_i_stall_local);
		local_bb1_add192_i_consumed_0_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1_add192_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_add192_i_stall_in)) & local_bb1_add192_i_stall_local);
		local_bb1_and17_i_consumed_2_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1_and17_i_consumed_2_NO_SHIFT_REG | ~(local_bb1_and17_i_stall_in_2)) & local_bb1_add192_i_stall_local);
		local_bb1_var__u28_consumed_0_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1_var__u28_consumed_0_NO_SHIFT_REG | ~(local_bb1_var__u28_stall_in)) & local_bb1_add192_i_stall_local);
	end
end


// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_183to185_bb1_cmp37_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_1_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_2_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_reg_185_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_valid_out_0_reg_185_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_stall_in_0_reg_185_NO_SHIFT_REG;
 logic rnode_183to185_bb1_cmp37_i_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_183to185_bb1_cmp37_i_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_183to185_bb1_cmp37_i_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_183to185_bb1_cmp37_i_0_stall_in_0_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_183to185_bb1_cmp37_i_0_valid_out_0_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_183to185_bb1_cmp37_i_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(local_bb1_cmp37_i),
	.data_out(rnode_183to185_bb1_cmp37_i_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_183to185_bb1_cmp37_i_0_reg_185_fifo.DEPTH = 2;
defparam rnode_183to185_bb1_cmp37_i_0_reg_185_fifo.DATA_WIDTH = 1;
defparam rnode_183to185_bb1_cmp37_i_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_183to185_bb1_cmp37_i_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_183to185_bb1_cmp37_i_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp37_i_stall_in_1 = 1'b0;
assign rnode_183to185_bb1_cmp37_i_0_stall_in_0_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_183to185_bb1_cmp37_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_183to185_bb1_cmp37_i_0_NO_SHIFT_REG = rnode_183to185_bb1_cmp37_i_0_reg_185_NO_SHIFT_REG;
assign rnode_183to185_bb1_cmp37_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_183to185_bb1_cmp37_i_1_NO_SHIFT_REG = rnode_183to185_bb1_cmp37_i_0_reg_185_NO_SHIFT_REG;
assign rnode_183to185_bb1_cmp37_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_183to185_bb1_cmp37_i_2_NO_SHIFT_REG = rnode_183to185_bb1_cmp37_i_0_reg_185_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_183to184_bb1__26_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_183to184_bb1__26_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_183to184_bb1__26_i_0_NO_SHIFT_REG;
 logic rnode_183to184_bb1__26_i_0_reg_184_inputs_ready_NO_SHIFT_REG;
 logic rnode_183to184_bb1__26_i_0_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1__26_i_0_valid_out_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1__26_i_0_stall_in_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1__26_i_0_stall_out_reg_184_NO_SHIFT_REG;

acl_data_fifo rnode_183to184_bb1__26_i_0_reg_184_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_183to184_bb1__26_i_0_reg_184_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_183to184_bb1__26_i_0_stall_in_reg_184_NO_SHIFT_REG),
	.valid_out(rnode_183to184_bb1__26_i_0_valid_out_reg_184_NO_SHIFT_REG),
	.stall_out(rnode_183to184_bb1__26_i_0_stall_out_reg_184_NO_SHIFT_REG),
	.data_in(local_bb1__26_i),
	.data_out(rnode_183to184_bb1__26_i_0_reg_184_NO_SHIFT_REG)
);

defparam rnode_183to184_bb1__26_i_0_reg_184_fifo.DEPTH = 1;
defparam rnode_183to184_bb1__26_i_0_reg_184_fifo.DATA_WIDTH = 1;
defparam rnode_183to184_bb1__26_i_0_reg_184_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_183to184_bb1__26_i_0_reg_184_fifo.IMPL = "shift_reg";

assign rnode_183to184_bb1__26_i_0_reg_184_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__26_i_stall_in = 1'b0;
assign rnode_183to184_bb1__26_i_0_NO_SHIFT_REG = rnode_183to184_bb1__26_i_0_reg_184_NO_SHIFT_REG;
assign rnode_183to184_bb1__26_i_0_stall_in_reg_184_NO_SHIFT_REG = 1'b0;
assign rnode_183to184_bb1__26_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_183to184_bb1_add192_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_183to184_bb1_add192_i_0_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_183to184_bb1_add192_i_1_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_183to184_bb1_add192_i_2_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_183to184_bb1_add192_i_3_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_reg_184_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_183to184_bb1_add192_i_0_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_valid_out_0_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_stall_in_0_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1_add192_i_0_stall_out_reg_184_NO_SHIFT_REG;

acl_data_fifo rnode_183to184_bb1_add192_i_0_reg_184_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_183to184_bb1_add192_i_0_reg_184_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_183to184_bb1_add192_i_0_stall_in_0_reg_184_NO_SHIFT_REG),
	.valid_out(rnode_183to184_bb1_add192_i_0_valid_out_0_reg_184_NO_SHIFT_REG),
	.stall_out(rnode_183to184_bb1_add192_i_0_stall_out_reg_184_NO_SHIFT_REG),
	.data_in(local_bb1_add192_i),
	.data_out(rnode_183to184_bb1_add192_i_0_reg_184_NO_SHIFT_REG)
);

defparam rnode_183to184_bb1_add192_i_0_reg_184_fifo.DEPTH = 1;
defparam rnode_183to184_bb1_add192_i_0_reg_184_fifo.DATA_WIDTH = 32;
defparam rnode_183to184_bb1_add192_i_0_reg_184_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_183to184_bb1_add192_i_0_reg_184_fifo.IMPL = "shift_reg";

assign rnode_183to184_bb1_add192_i_0_reg_184_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add192_i_stall_in = 1'b0;
assign rnode_183to184_bb1_add192_i_0_stall_in_0_reg_184_NO_SHIFT_REG = 1'b0;
assign rnode_183to184_bb1_add192_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_183to184_bb1_add192_i_0_NO_SHIFT_REG = rnode_183to184_bb1_add192_i_0_reg_184_NO_SHIFT_REG;
assign rnode_183to184_bb1_add192_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_183to184_bb1_add192_i_1_NO_SHIFT_REG = rnode_183to184_bb1_add192_i_0_reg_184_NO_SHIFT_REG;
assign rnode_183to184_bb1_add192_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_183to184_bb1_add192_i_2_NO_SHIFT_REG = rnode_183to184_bb1_add192_i_0_reg_184_NO_SHIFT_REG;
assign rnode_183to184_bb1_add192_i_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_183to184_bb1_add192_i_3_NO_SHIFT_REG = rnode_183to184_bb1_add192_i_0_reg_184_NO_SHIFT_REG;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_183to185_bb1_and17_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_183to185_bb1_and17_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_183to185_bb1_and17_i_0_NO_SHIFT_REG;
 logic rnode_183to185_bb1_and17_i_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_183to185_bb1_and17_i_0_reg_185_NO_SHIFT_REG;
 logic rnode_183to185_bb1_and17_i_0_valid_out_reg_185_NO_SHIFT_REG;
 logic rnode_183to185_bb1_and17_i_0_stall_in_reg_185_NO_SHIFT_REG;
 logic rnode_183to185_bb1_and17_i_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_183to185_bb1_and17_i_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_183to185_bb1_and17_i_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_183to185_bb1_and17_i_0_stall_in_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_183to185_bb1_and17_i_0_valid_out_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_183to185_bb1_and17_i_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(local_bb1_and17_i),
	.data_out(rnode_183to185_bb1_and17_i_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_183to185_bb1_and17_i_0_reg_185_fifo.DEPTH = 2;
defparam rnode_183to185_bb1_and17_i_0_reg_185_fifo.DATA_WIDTH = 32;
defparam rnode_183to185_bb1_and17_i_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_183to185_bb1_and17_i_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_183to185_bb1_and17_i_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and17_i_stall_in_2 = 1'b0;
assign rnode_183to185_bb1_and17_i_0_NO_SHIFT_REG = rnode_183to185_bb1_and17_i_0_reg_185_NO_SHIFT_REG;
assign rnode_183to185_bb1_and17_i_0_stall_in_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_183to185_bb1_and17_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_183to184_bb1_var__u28_0_valid_out_NO_SHIFT_REG;
 logic rnode_183to184_bb1_var__u28_0_stall_in_NO_SHIFT_REG;
 logic rnode_183to184_bb1_var__u28_0_NO_SHIFT_REG;
 logic rnode_183to184_bb1_var__u28_0_reg_184_inputs_ready_NO_SHIFT_REG;
 logic rnode_183to184_bb1_var__u28_0_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1_var__u28_0_valid_out_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1_var__u28_0_stall_in_reg_184_NO_SHIFT_REG;
 logic rnode_183to184_bb1_var__u28_0_stall_out_reg_184_NO_SHIFT_REG;

acl_data_fifo rnode_183to184_bb1_var__u28_0_reg_184_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_183to184_bb1_var__u28_0_reg_184_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_183to184_bb1_var__u28_0_stall_in_reg_184_NO_SHIFT_REG),
	.valid_out(rnode_183to184_bb1_var__u28_0_valid_out_reg_184_NO_SHIFT_REG),
	.stall_out(rnode_183to184_bb1_var__u28_0_stall_out_reg_184_NO_SHIFT_REG),
	.data_in(local_bb1_var__u28),
	.data_out(rnode_183to184_bb1_var__u28_0_reg_184_NO_SHIFT_REG)
);

defparam rnode_183to184_bb1_var__u28_0_reg_184_fifo.DEPTH = 1;
defparam rnode_183to184_bb1_var__u28_0_reg_184_fifo.DATA_WIDTH = 1;
defparam rnode_183to184_bb1_var__u28_0_reg_184_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_183to184_bb1_var__u28_0_reg_184_fifo.IMPL = "shift_reg";

assign rnode_183to184_bb1_var__u28_0_reg_184_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u28_stall_in = 1'b0;
assign rnode_183to184_bb1_var__u28_0_NO_SHIFT_REG = rnode_183to184_bb1_var__u28_0_reg_184_NO_SHIFT_REG;
assign rnode_183to184_bb1_var__u28_0_stall_in_reg_184_NO_SHIFT_REG = 1'b0;
assign rnode_183to184_bb1_var__u28_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp37_i_stall_local;
wire local_bb1_not_cmp37_i;

assign local_bb1_not_cmp37_i = (rnode_183to185_bb1_cmp37_i_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_184to185_bb1__26_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_184to185_bb1__26_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_184to185_bb1__26_i_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1__26_i_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic rnode_184to185_bb1__26_i_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1__26_i_0_valid_out_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1__26_i_0_stall_in_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1__26_i_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_184to185_bb1__26_i_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_184to185_bb1__26_i_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_184to185_bb1__26_i_0_stall_in_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_184to185_bb1__26_i_0_valid_out_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_184to185_bb1__26_i_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(rnode_183to184_bb1__26_i_0_NO_SHIFT_REG),
	.data_out(rnode_184to185_bb1__26_i_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_184to185_bb1__26_i_0_reg_185_fifo.DEPTH = 1;
defparam rnode_184to185_bb1__26_i_0_reg_185_fifo.DATA_WIDTH = 1;
defparam rnode_184to185_bb1__26_i_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_184to185_bb1__26_i_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_184to185_bb1__26_i_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_183to184_bb1__26_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1__26_i_0_NO_SHIFT_REG = rnode_184to185_bb1__26_i_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1__26_i_0_stall_in_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1__26_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_and193_i_valid_out;
wire local_bb1_and193_i_stall_in;
wire local_bb1_and193_i_inputs_ready;
wire local_bb1_and193_i_stall_local;
wire [31:0] local_bb1_and193_i;

assign local_bb1_and193_i_inputs_ready = rnode_183to184_bb1_add192_i_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_and193_i = (rnode_183to184_bb1_add192_i_0_NO_SHIFT_REG & 32'hFFFFFFF);
assign local_bb1_and193_i_valid_out = 1'b1;
assign rnode_183to184_bb1_add192_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_and195_i_valid_out;
wire local_bb1_and195_i_stall_in;
wire local_bb1_and195_i_inputs_ready;
wire local_bb1_and195_i_stall_local;
wire [31:0] local_bb1_and195_i;

assign local_bb1_and195_i_inputs_ready = rnode_183to184_bb1_add192_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_and195_i = (rnode_183to184_bb1_add192_i_1_NO_SHIFT_REG >> 32'h1B);
assign local_bb1_and195_i_valid_out = 1'b1;
assign rnode_183to184_bb1_add192_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_and198_i_valid_out;
wire local_bb1_and198_i_stall_in;
wire local_bb1_and198_i_inputs_ready;
wire local_bb1_and198_i_stall_local;
wire [31:0] local_bb1_and198_i;

assign local_bb1_and198_i_inputs_ready = rnode_183to184_bb1_add192_i_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1_and198_i = (rnode_183to184_bb1_add192_i_2_NO_SHIFT_REG & 32'h1);
assign local_bb1_and198_i_valid_out = 1'b1;
assign rnode_183to184_bb1_add192_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_and201_i_stall_local;
wire [31:0] local_bb1_and201_i;

assign local_bb1_and201_i = (rnode_183to184_bb1_add192_i_3_NO_SHIFT_REG & 32'h7FFFFFF);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_184to185_bb1_var__u28_0_valid_out_NO_SHIFT_REG;
 logic rnode_184to185_bb1_var__u28_0_stall_in_NO_SHIFT_REG;
 logic rnode_184to185_bb1_var__u28_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1_var__u28_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic rnode_184to185_bb1_var__u28_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_var__u28_0_valid_out_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_var__u28_0_stall_in_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_var__u28_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_184to185_bb1_var__u28_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_184to185_bb1_var__u28_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_184to185_bb1_var__u28_0_stall_in_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_184to185_bb1_var__u28_0_valid_out_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_184to185_bb1_var__u28_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(rnode_183to184_bb1_var__u28_0_NO_SHIFT_REG),
	.data_out(rnode_184to185_bb1_var__u28_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_184to185_bb1_var__u28_0_reg_185_fifo.DEPTH = 1;
defparam rnode_184to185_bb1_var__u28_0_reg_185_fifo.DATA_WIDTH = 1;
defparam rnode_184to185_bb1_var__u28_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_184to185_bb1_var__u28_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_184to185_bb1_var__u28_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_183to184_bb1_var__u28_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_var__u28_0_NO_SHIFT_REG = rnode_184to185_bb1_var__u28_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_var__u28_0_stall_in_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_var__u28_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1__26_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_1_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_2_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_valid_out_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_stall_in_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1__26_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1__26_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1__26_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1__26_i_0_stall_in_0_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1__26_i_0_valid_out_0_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1__26_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(rnode_184to185_bb1__26_i_0_NO_SHIFT_REG),
	.data_out(rnode_185to186_bb1__26_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1__26_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1__26_i_0_reg_186_fifo.DATA_WIDTH = 1;
defparam rnode_185to186_bb1__26_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1__26_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1__26_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_184to185_bb1__26_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1__26_i_0_stall_in_0_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1__26_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_185to186_bb1__26_i_0_NO_SHIFT_REG = rnode_185to186_bb1__26_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1__26_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_185to186_bb1__26_i_1_NO_SHIFT_REG = rnode_185to186_bb1__26_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1__26_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_185to186_bb1__26_i_2_NO_SHIFT_REG = rnode_185to186_bb1__26_i_0_reg_186_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_184to185_bb1_and193_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and193_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and193_i_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and193_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and193_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and193_i_1_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and193_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and193_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and193_i_2_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and193_i_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and193_i_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and193_i_0_valid_out_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and193_i_0_stall_in_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and193_i_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_184to185_bb1_and193_i_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_184to185_bb1_and193_i_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_184to185_bb1_and193_i_0_stall_in_0_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_184to185_bb1_and193_i_0_valid_out_0_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_184to185_bb1_and193_i_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(local_bb1_and193_i),
	.data_out(rnode_184to185_bb1_and193_i_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_184to185_bb1_and193_i_0_reg_185_fifo.DEPTH = 1;
defparam rnode_184to185_bb1_and193_i_0_reg_185_fifo.DATA_WIDTH = 32;
defparam rnode_184to185_bb1_and193_i_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_184to185_bb1_and193_i_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_184to185_bb1_and193_i_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and193_i_stall_in = 1'b0;
assign rnode_184to185_bb1_and193_i_0_stall_in_0_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and193_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_184to185_bb1_and193_i_0_NO_SHIFT_REG = rnode_184to185_bb1_and193_i_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_and193_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_184to185_bb1_and193_i_1_NO_SHIFT_REG = rnode_184to185_bb1_and193_i_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_and193_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_184to185_bb1_and193_i_2_NO_SHIFT_REG = rnode_184to185_bb1_and193_i_0_reg_185_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_184to185_bb1_and195_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and195_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and195_i_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and195_i_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and195_i_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and195_i_0_valid_out_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and195_i_0_stall_in_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and195_i_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_184to185_bb1_and195_i_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_184to185_bb1_and195_i_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_184to185_bb1_and195_i_0_stall_in_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_184to185_bb1_and195_i_0_valid_out_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_184to185_bb1_and195_i_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(local_bb1_and195_i),
	.data_out(rnode_184to185_bb1_and195_i_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_184to185_bb1_and195_i_0_reg_185_fifo.DEPTH = 1;
defparam rnode_184to185_bb1_and195_i_0_reg_185_fifo.DATA_WIDTH = 32;
defparam rnode_184to185_bb1_and195_i_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_184to185_bb1_and195_i_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_184to185_bb1_and195_i_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and195_i_stall_in = 1'b0;
assign rnode_184to185_bb1_and195_i_0_NO_SHIFT_REG = rnode_184to185_bb1_and195_i_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_and195_i_0_stall_in_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and195_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_184to185_bb1_and198_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and198_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and198_i_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and198_i_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1_and198_i_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and198_i_0_valid_out_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and198_i_0_stall_in_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1_and198_i_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_184to185_bb1_and198_i_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_184to185_bb1_and198_i_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_184to185_bb1_and198_i_0_stall_in_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_184to185_bb1_and198_i_0_valid_out_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_184to185_bb1_and198_i_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(local_bb1_and198_i),
	.data_out(rnode_184to185_bb1_and198_i_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_184to185_bb1_and198_i_0_reg_185_fifo.DEPTH = 1;
defparam rnode_184to185_bb1_and198_i_0_reg_185_fifo.DATA_WIDTH = 32;
defparam rnode_184to185_bb1_and198_i_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_184to185_bb1_and198_i_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_184to185_bb1_and198_i_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and198_i_stall_in = 1'b0;
assign rnode_184to185_bb1_and198_i_0_NO_SHIFT_REG = rnode_184to185_bb1_and198_i_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1_and198_i_0_stall_in_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and198_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_i22_stall_local;
wire [31:0] local_bb1_shr_i_i22;

assign local_bb1_shr_i_i22 = (local_bb1_and201_i >> 32'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_var__u28_0_valid_out_NO_SHIFT_REG;
 logic rnode_185to186_bb1_var__u28_0_stall_in_NO_SHIFT_REG;
 logic rnode_185to186_bb1_var__u28_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_var__u28_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic rnode_185to186_bb1_var__u28_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_var__u28_0_valid_out_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_var__u28_0_stall_in_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_var__u28_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_var__u28_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_var__u28_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_var__u28_0_stall_in_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_var__u28_0_valid_out_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_var__u28_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(rnode_184to185_bb1_var__u28_0_NO_SHIFT_REG),
	.data_out(rnode_185to186_bb1_var__u28_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_var__u28_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_var__u28_0_reg_186_fifo.DATA_WIDTH = 1;
defparam rnode_185to186_bb1_var__u28_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_var__u28_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_var__u28_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_184to185_bb1_var__u28_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_var__u28_0_NO_SHIFT_REG = rnode_185to186_bb1_var__u28_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_var__u28_0_stall_in_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_var__u28_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_cond292_i_stall_local;
wire [31:0] local_bb1_cond292_i;

assign local_bb1_cond292_i = (rnode_185to186_bb1__26_i_1_NO_SHIFT_REG ? 32'h400000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u33_stall_local;
wire [31:0] local_bb1_var__u33;

assign local_bb1_var__u33[31:1] = 31'h0;
assign local_bb1_var__u33[0] = rnode_185to186_bb1__26_i_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr216_i_stall_local;
wire [31:0] local_bb1_shr216_i;

assign local_bb1_shr216_i = (rnode_184to185_bb1_and193_i_1_NO_SHIFT_REG >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__pre_i_stall_local;
wire [31:0] local_bb1__pre_i;

assign local_bb1__pre_i = (rnode_184to185_bb1_and195_i_0_NO_SHIFT_REG & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i_i23_stall_local;
wire [31:0] local_bb1_or_i_i23;

assign local_bb1_or_i_i23 = (local_bb1_shr_i_i22 | local_bb1_and201_i);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_ext_i_stall_local;
wire [31:0] local_bb1_lnot_ext_i;

assign local_bb1_lnot_ext_i = (local_bb1_var__u33 ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_or219_i_stall_local;
wire [31:0] local_bb1_or219_i;

assign local_bb1_or219_i = (local_bb1_shr216_i | rnode_184to185_bb1_and198_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool213_i_stall_local;
wire local_bb1_tobool213_i;

assign local_bb1_tobool213_i = (local_bb1__pre_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_shr1_i_i_stall_local;
wire [31:0] local_bb1_shr1_i_i;

assign local_bb1_shr1_i_i = (local_bb1_or_i_i23 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1__40_demorgan_i_stall_local;
wire local_bb1__40_demorgan_i;

assign local_bb1__40_demorgan_i = (rnode_183to185_bb1_cmp37_i_0_NO_SHIFT_REG | local_bb1_tobool213_i);

// This section implements an unregistered operation.
// 
wire local_bb1__42_i_stall_local;
wire local_bb1__42_i;

assign local_bb1__42_i = (local_bb1_tobool213_i & local_bb1_not_cmp37_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or2_i_i_stall_local;
wire [31:0] local_bb1_or2_i_i;

assign local_bb1_or2_i_i = (local_bb1_shr1_i_i | local_bb1_or_i_i23);

// This section implements an unregistered operation.
// 
wire local_bb1__43_i_stall_local;
wire [31:0] local_bb1__43_i;

assign local_bb1__43_i = (local_bb1__42_i ? 32'h0 : local_bb1__pre_i);

// This section implements an unregistered operation.
// 
wire local_bb1_shr3_i_i_stall_local;
wire [31:0] local_bb1_shr3_i_i;

assign local_bb1_shr3_i_i = (local_bb1_or2_i_i >> 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb1_or4_i_i_stall_local;
wire [31:0] local_bb1_or4_i_i;

assign local_bb1_or4_i_i = (local_bb1_shr3_i_i | local_bb1_or2_i_i);

// This section implements an unregistered operation.
// 
wire local_bb1_shr5_i_i_stall_local;
wire [31:0] local_bb1_shr5_i_i;

assign local_bb1_shr5_i_i = (local_bb1_or4_i_i >> 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb1_or6_i_i_stall_local;
wire [31:0] local_bb1_or6_i_i;

assign local_bb1_or6_i_i = (local_bb1_shr5_i_i | local_bb1_or4_i_i);

// This section implements an unregistered operation.
// 
wire local_bb1_shr7_i_i_stall_local;
wire [31:0] local_bb1_shr7_i_i;

assign local_bb1_shr7_i_i = (local_bb1_or6_i_i >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_or6_masked_i_i_stall_local;
wire [31:0] local_bb1_or6_masked_i_i;

assign local_bb1_or6_masked_i_i = (local_bb1_or6_i_i & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_neg_i_i_stall_local;
wire [31:0] local_bb1_neg_i_i;

assign local_bb1_neg_i_i = (local_bb1_or6_masked_i_i | local_bb1_shr7_i_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and_i_i_stall_local;
wire [31:0] local_bb1_and_i_i;

assign local_bb1_and_i_i = (local_bb1_neg_i_i ^ 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1__and_i_i_valid_out;
wire local_bb1__and_i_i_stall_in;
wire local_bb1__and_i_i_inputs_ready;
wire local_bb1__and_i_i_stall_local;
wire [31:0] local_bb1__and_i_i;

thirtysix_six_comp local_bb1__and_i_i_popcnt_instance (
	.data(local_bb1_and_i_i),
	.sum(local_bb1__and_i_i)
);


assign local_bb1__and_i_i_inputs_ready = rnode_183to184_bb1_add192_i_0_valid_out_3_NO_SHIFT_REG;
assign local_bb1__and_i_i_valid_out = 1'b1;
assign rnode_183to184_bb1_add192_i_0_stall_in_3_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_184to185_bb1__and_i_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1__and_i_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1__and_i_i_0_NO_SHIFT_REG;
 logic rnode_184to185_bb1__and_i_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_184to185_bb1__and_i_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1__and_i_i_1_NO_SHIFT_REG;
 logic rnode_184to185_bb1__and_i_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_184to185_bb1__and_i_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1__and_i_i_2_NO_SHIFT_REG;
 logic rnode_184to185_bb1__and_i_i_0_reg_185_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_184to185_bb1__and_i_i_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1__and_i_i_0_valid_out_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1__and_i_i_0_stall_in_0_reg_185_NO_SHIFT_REG;
 logic rnode_184to185_bb1__and_i_i_0_stall_out_reg_185_NO_SHIFT_REG;

acl_data_fifo rnode_184to185_bb1__and_i_i_0_reg_185_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_184to185_bb1__and_i_i_0_reg_185_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_184to185_bb1__and_i_i_0_stall_in_0_reg_185_NO_SHIFT_REG),
	.valid_out(rnode_184to185_bb1__and_i_i_0_valid_out_0_reg_185_NO_SHIFT_REG),
	.stall_out(rnode_184to185_bb1__and_i_i_0_stall_out_reg_185_NO_SHIFT_REG),
	.data_in(local_bb1__and_i_i),
	.data_out(rnode_184to185_bb1__and_i_i_0_reg_185_NO_SHIFT_REG)
);

defparam rnode_184to185_bb1__and_i_i_0_reg_185_fifo.DEPTH = 1;
defparam rnode_184to185_bb1__and_i_i_0_reg_185_fifo.DATA_WIDTH = 32;
defparam rnode_184to185_bb1__and_i_i_0_reg_185_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_184to185_bb1__and_i_i_0_reg_185_fifo.IMPL = "shift_reg";

assign rnode_184to185_bb1__and_i_i_0_reg_185_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__and_i_i_stall_in = 1'b0;
assign rnode_184to185_bb1__and_i_i_0_stall_in_0_reg_185_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1__and_i_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_184to185_bb1__and_i_i_0_NO_SHIFT_REG = rnode_184to185_bb1__and_i_i_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1__and_i_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_184to185_bb1__and_i_i_1_NO_SHIFT_REG = rnode_184to185_bb1__and_i_i_0_reg_185_NO_SHIFT_REG;
assign rnode_184to185_bb1__and_i_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_184to185_bb1__and_i_i_2_NO_SHIFT_REG = rnode_184to185_bb1__and_i_i_0_reg_185_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and9_i_i_stall_local;
wire [31:0] local_bb1_and9_i_i;

assign local_bb1_and9_i_i = (rnode_184to185_bb1__and_i_i_0_NO_SHIFT_REG & 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb1_and203_i_stall_local;
wire [31:0] local_bb1_and203_i;

assign local_bb1_and203_i = (rnode_184to185_bb1__and_i_i_1_NO_SHIFT_REG & 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_and206_i_stall_local;
wire [31:0] local_bb1_and206_i;

assign local_bb1_and206_i = (rnode_184to185_bb1__and_i_i_2_NO_SHIFT_REG & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_sub239_i_stall_local;
wire [31:0] local_bb1_sub239_i;

assign local_bb1_sub239_i = (32'h0 - local_bb1_and9_i_i);

// This section implements an unregistered operation.
// 
wire local_bb1_shl204_i_stall_local;
wire [31:0] local_bb1_shl204_i;

assign local_bb1_shl204_i = (rnode_184to185_bb1_and193_i_0_NO_SHIFT_REG << local_bb1_and203_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cond244_i_stall_local;
wire [31:0] local_bb1_cond244_i;

assign local_bb1_cond244_i = (rnode_183to185_bb1_cmp37_i_2_NO_SHIFT_REG ? local_bb1_sub239_i : local_bb1__43_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and205_i_stall_local;
wire [31:0] local_bb1_and205_i;

assign local_bb1_and205_i = (local_bb1_shl204_i & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_add245_i_stall_local;
wire [31:0] local_bb1_add245_i;

assign local_bb1_add245_i = (local_bb1_cond244_i + rnode_183to185_bb1_and17_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_fold_i_stall_local;
wire [31:0] local_bb1_fold_i;

assign local_bb1_fold_i = (local_bb1_cond244_i + rnode_183to185_bb1_shr16_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_shl207_i_stall_local;
wire [31:0] local_bb1_shl207_i;

assign local_bb1_shl207_i = (local_bb1_and205_i << local_bb1_and206_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and250_i_stall_local;
wire [31:0] local_bb1_and250_i;

assign local_bb1_and250_i = (local_bb1_fold_i & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and269_i_stall_local;
wire [31:0] local_bb1_and269_i;

assign local_bb1_and269_i = (local_bb1_fold_i << 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_and208_i_stall_local;
wire [31:0] local_bb1_and208_i;

assign local_bb1_and208_i = (local_bb1_shl207_i & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_notrhs_i_stall_local;
wire local_bb1_notrhs_i;

assign local_bb1_notrhs_i = (local_bb1_and250_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__44_i_stall_local;
wire [31:0] local_bb1__44_i;

assign local_bb1__44_i = (local_bb1__40_demorgan_i ? local_bb1_and208_i : local_bb1_or219_i);

// This section implements an unregistered operation.
// 
wire local_bb1__45_i_stall_local;
wire [31:0] local_bb1__45_i;

assign local_bb1__45_i = (local_bb1__42_i ? rnode_184to185_bb1_and193_i_2_NO_SHIFT_REG : local_bb1__44_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and225_i_stall_local;
wire [31:0] local_bb1_and225_i;

assign local_bb1_and225_i = (local_bb1__45_i & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and270_i_stall_local;
wire [31:0] local_bb1_and270_i;

assign local_bb1_and270_i = (local_bb1__45_i & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_shr271_i_stall_local;
wire [31:0] local_bb1_shr271_i;

assign local_bb1_shr271_i = (local_bb1__45_i >> 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp226_i_stall_local;
wire local_bb1_cmp226_i;

assign local_bb1_cmp226_i = (local_bb1_and225_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp296_i_stall_local;
wire local_bb1_cmp296_i;

assign local_bb1_cmp296_i = (local_bb1_and270_i > 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb1_and269_i_valid_out;
wire local_bb1_and269_i_stall_in;
 reg local_bb1_and269_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_add245_i_valid_out;
wire local_bb1_add245_i_stall_in;
 reg local_bb1_add245_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_notrhs_i_valid_out;
wire local_bb1_notrhs_i_stall_in;
 reg local_bb1_notrhs_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_not_cmp37_i_valid_out_1;
wire local_bb1_not_cmp37_i_stall_in_1;
 reg local_bb1_not_cmp37_i_consumed_1_NO_SHIFT_REG;
wire local_bb1_shr271_i_valid_out;
wire local_bb1_shr271_i_stall_in;
 reg local_bb1_shr271_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp226_i_valid_out;
wire local_bb1_cmp226_i_stall_in;
 reg local_bb1_cmp226_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp296_i_valid_out;
wire local_bb1_cmp296_i_stall_in;
 reg local_bb1_cmp296_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp299_i_valid_out;
wire local_bb1_cmp299_i_stall_in;
 reg local_bb1_cmp299_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp299_i_inputs_ready;
wire local_bb1_cmp299_i_stall_local;
wire local_bb1_cmp299_i;

assign local_bb1_cmp299_i_inputs_ready = (rnode_183to185_bb1_shr16_i_0_valid_out_NO_SHIFT_REG & rnode_183to185_bb1_cmp37_i_0_valid_out_2_NO_SHIFT_REG & rnode_183to185_bb1_and17_i_0_valid_out_NO_SHIFT_REG & rnode_183to185_bb1_cmp37_i_0_valid_out_0_NO_SHIFT_REG & rnode_184to185_bb1_and193_i_0_valid_out_2_NO_SHIFT_REG & rnode_183to185_bb1_cmp37_i_0_valid_out_1_NO_SHIFT_REG & rnode_184to185_bb1_and195_i_0_valid_out_NO_SHIFT_REG & rnode_184to185_bb1_and193_i_0_valid_out_1_NO_SHIFT_REG & rnode_184to185_bb1_and198_i_0_valid_out_NO_SHIFT_REG & rnode_184to185_bb1_and193_i_0_valid_out_0_NO_SHIFT_REG & rnode_184to185_bb1__and_i_i_0_valid_out_1_NO_SHIFT_REG & rnode_184to185_bb1__and_i_i_0_valid_out_2_NO_SHIFT_REG & rnode_184to185_bb1__and_i_i_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_cmp299_i = (local_bb1_and270_i == 32'h4);
assign local_bb1_and269_i_valid_out = 1'b1;
assign local_bb1_add245_i_valid_out = 1'b1;
assign local_bb1_notrhs_i_valid_out = 1'b1;
assign local_bb1_not_cmp37_i_valid_out_1 = 1'b1;
assign local_bb1_shr271_i_valid_out = 1'b1;
assign local_bb1_cmp226_i_valid_out = 1'b1;
assign local_bb1_cmp296_i_valid_out = 1'b1;
assign local_bb1_cmp299_i_valid_out = 1'b1;
assign rnode_183to185_bb1_shr16_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_183to185_bb1_cmp37_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_183to185_bb1_and17_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_183to185_bb1_cmp37_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and193_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_183to185_bb1_cmp37_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and195_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and193_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and198_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1_and193_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1__and_i_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1__and_i_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_184to185_bb1__and_i_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_and269_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_add245_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_notrhs_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_not_cmp37_i_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_shr271_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp226_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp296_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp299_i_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_and269_i_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i_inputs_ready & (local_bb1_and269_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and269_i_stall_in)) & local_bb1_cmp299_i_stall_local);
		local_bb1_add245_i_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i_inputs_ready & (local_bb1_add245_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_add245_i_stall_in)) & local_bb1_cmp299_i_stall_local);
		local_bb1_notrhs_i_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i_inputs_ready & (local_bb1_notrhs_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_notrhs_i_stall_in)) & local_bb1_cmp299_i_stall_local);
		local_bb1_not_cmp37_i_consumed_1_NO_SHIFT_REG <= (local_bb1_cmp299_i_inputs_ready & (local_bb1_not_cmp37_i_consumed_1_NO_SHIFT_REG | ~(local_bb1_not_cmp37_i_stall_in_1)) & local_bb1_cmp299_i_stall_local);
		local_bb1_shr271_i_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i_inputs_ready & (local_bb1_shr271_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_shr271_i_stall_in)) & local_bb1_cmp299_i_stall_local);
		local_bb1_cmp226_i_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i_inputs_ready & (local_bb1_cmp226_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp226_i_stall_in)) & local_bb1_cmp299_i_stall_local);
		local_bb1_cmp296_i_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i_inputs_ready & (local_bb1_cmp296_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp296_i_stall_in)) & local_bb1_cmp299_i_stall_local);
		local_bb1_cmp299_i_consumed_0_NO_SHIFT_REG <= (local_bb1_cmp299_i_inputs_ready & (local_bb1_cmp299_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp299_i_stall_in)) & local_bb1_cmp299_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_and269_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and269_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_185to186_bb1_and269_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and269_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_185to186_bb1_and269_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and269_i_0_valid_out_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and269_i_0_stall_in_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_and269_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_and269_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_and269_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_and269_i_0_stall_in_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_and269_i_0_valid_out_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_and269_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(local_bb1_and269_i),
	.data_out(rnode_185to186_bb1_and269_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_and269_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_and269_i_0_reg_186_fifo.DATA_WIDTH = 32;
defparam rnode_185to186_bb1_and269_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_and269_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_and269_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and269_i_stall_in = 1'b0;
assign rnode_185to186_bb1_and269_i_0_NO_SHIFT_REG = rnode_185to186_bb1_and269_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_and269_i_0_stall_in_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_and269_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_add245_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_add245_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_185to186_bb1_add245_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_add245_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_185to186_bb1_add245_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_185to186_bb1_add245_i_1_NO_SHIFT_REG;
 logic rnode_185to186_bb1_add245_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_185to186_bb1_add245_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_add245_i_0_valid_out_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_add245_i_0_stall_in_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_add245_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_add245_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_add245_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_add245_i_0_stall_in_0_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_add245_i_0_valid_out_0_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_add245_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(local_bb1_add245_i),
	.data_out(rnode_185to186_bb1_add245_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_add245_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_add245_i_0_reg_186_fifo.DATA_WIDTH = 32;
defparam rnode_185to186_bb1_add245_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_add245_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_add245_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add245_i_stall_in = 1'b0;
assign rnode_185to186_bb1_add245_i_0_stall_in_0_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_add245_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_185to186_bb1_add245_i_0_NO_SHIFT_REG = rnode_185to186_bb1_add245_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_add245_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_185to186_bb1_add245_i_1_NO_SHIFT_REG = rnode_185to186_bb1_add245_i_0_reg_186_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_notrhs_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_185to186_bb1_notrhs_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_185to186_bb1_notrhs_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_notrhs_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic rnode_185to186_bb1_notrhs_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_notrhs_i_0_valid_out_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_notrhs_i_0_stall_in_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_notrhs_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_notrhs_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_notrhs_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_notrhs_i_0_stall_in_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_notrhs_i_0_valid_out_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_notrhs_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(local_bb1_notrhs_i),
	.data_out(rnode_185to186_bb1_notrhs_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_notrhs_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_notrhs_i_0_reg_186_fifo.DATA_WIDTH = 1;
defparam rnode_185to186_bb1_notrhs_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_notrhs_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_notrhs_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_notrhs_i_stall_in = 1'b0;
assign rnode_185to186_bb1_notrhs_i_0_NO_SHIFT_REG = rnode_185to186_bb1_notrhs_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_notrhs_i_0_stall_in_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_notrhs_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_not_cmp37_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_185to186_bb1_not_cmp37_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_185to186_bb1_not_cmp37_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_not_cmp37_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic rnode_185to186_bb1_not_cmp37_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_not_cmp37_i_0_valid_out_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_not_cmp37_i_0_stall_in_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_not_cmp37_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_not_cmp37_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_not_cmp37_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_not_cmp37_i_0_stall_in_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_not_cmp37_i_0_valid_out_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_not_cmp37_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(local_bb1_not_cmp37_i),
	.data_out(rnode_185to186_bb1_not_cmp37_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_not_cmp37_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_not_cmp37_i_0_reg_186_fifo.DATA_WIDTH = 1;
defparam rnode_185to186_bb1_not_cmp37_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_not_cmp37_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_not_cmp37_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_not_cmp37_i_stall_in_1 = 1'b0;
assign rnode_185to186_bb1_not_cmp37_i_0_NO_SHIFT_REG = rnode_185to186_bb1_not_cmp37_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_not_cmp37_i_0_stall_in_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_not_cmp37_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_shr271_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_185to186_bb1_shr271_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_185to186_bb1_shr271_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_shr271_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_185to186_bb1_shr271_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_shr271_i_0_valid_out_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_shr271_i_0_stall_in_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_shr271_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_shr271_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_shr271_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_shr271_i_0_stall_in_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_shr271_i_0_valid_out_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_shr271_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(local_bb1_shr271_i),
	.data_out(rnode_185to186_bb1_shr271_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_shr271_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_shr271_i_0_reg_186_fifo.DATA_WIDTH = 32;
defparam rnode_185to186_bb1_shr271_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_shr271_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_shr271_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr271_i_stall_in = 1'b0;
assign rnode_185to186_bb1_shr271_i_0_NO_SHIFT_REG = rnode_185to186_bb1_shr271_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_shr271_i_0_stall_in_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_shr271_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_cmp226_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_1_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_0_valid_out_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_0_stall_in_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp226_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_cmp226_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_cmp226_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_cmp226_i_0_stall_in_0_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_cmp226_i_0_valid_out_0_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_cmp226_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(local_bb1_cmp226_i),
	.data_out(rnode_185to186_bb1_cmp226_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_cmp226_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_cmp226_i_0_reg_186_fifo.DATA_WIDTH = 1;
defparam rnode_185to186_bb1_cmp226_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_cmp226_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_cmp226_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp226_i_stall_in = 1'b0;
assign rnode_185to186_bb1_cmp226_i_0_stall_in_0_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_cmp226_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_185to186_bb1_cmp226_i_0_NO_SHIFT_REG = rnode_185to186_bb1_cmp226_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_cmp226_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_185to186_bb1_cmp226_i_1_NO_SHIFT_REG = rnode_185to186_bb1_cmp226_i_0_reg_186_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_cmp296_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp296_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp296_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp296_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp296_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp296_i_0_valid_out_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp296_i_0_stall_in_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp296_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_cmp296_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_cmp296_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_cmp296_i_0_stall_in_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_cmp296_i_0_valid_out_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_cmp296_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(local_bb1_cmp296_i),
	.data_out(rnode_185to186_bb1_cmp296_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_cmp296_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_cmp296_i_0_reg_186_fifo.DATA_WIDTH = 1;
defparam rnode_185to186_bb1_cmp296_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_cmp296_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_cmp296_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp296_i_stall_in = 1'b0;
assign rnode_185to186_bb1_cmp296_i_0_NO_SHIFT_REG = rnode_185to186_bb1_cmp296_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_cmp296_i_0_stall_in_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_cmp296_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_185to186_bb1_cmp299_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp299_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp299_i_0_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp299_i_0_reg_186_inputs_ready_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp299_i_0_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp299_i_0_valid_out_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp299_i_0_stall_in_reg_186_NO_SHIFT_REG;
 logic rnode_185to186_bb1_cmp299_i_0_stall_out_reg_186_NO_SHIFT_REG;

acl_data_fifo rnode_185to186_bb1_cmp299_i_0_reg_186_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_185to186_bb1_cmp299_i_0_reg_186_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_185to186_bb1_cmp299_i_0_stall_in_reg_186_NO_SHIFT_REG),
	.valid_out(rnode_185to186_bb1_cmp299_i_0_valid_out_reg_186_NO_SHIFT_REG),
	.stall_out(rnode_185to186_bb1_cmp299_i_0_stall_out_reg_186_NO_SHIFT_REG),
	.data_in(local_bb1_cmp299_i),
	.data_out(rnode_185to186_bb1_cmp299_i_0_reg_186_NO_SHIFT_REG)
);

defparam rnode_185to186_bb1_cmp299_i_0_reg_186_fifo.DEPTH = 1;
defparam rnode_185to186_bb1_cmp299_i_0_reg_186_fifo.DATA_WIDTH = 1;
defparam rnode_185to186_bb1_cmp299_i_0_reg_186_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_185to186_bb1_cmp299_i_0_reg_186_fifo.IMPL = "shift_reg";

assign rnode_185to186_bb1_cmp299_i_0_reg_186_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp299_i_stall_in = 1'b0;
assign rnode_185to186_bb1_cmp299_i_0_NO_SHIFT_REG = rnode_185to186_bb1_cmp299_i_0_reg_186_NO_SHIFT_REG;
assign rnode_185to186_bb1_cmp299_i_0_stall_in_reg_186_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_cmp299_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shl273_i_stall_local;
wire [31:0] local_bb1_shl273_i;

assign local_bb1_shl273_i = (rnode_185to186_bb1_and269_i_0_NO_SHIFT_REG & 32'h7F800000);

// This section implements an unregistered operation.
// 
wire local_bb1_and247_i_stall_local;
wire [31:0] local_bb1_and247_i;

assign local_bb1_and247_i = (rnode_185to186_bb1_add245_i_0_NO_SHIFT_REG & 32'h100);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp258_i_stall_local;
wire local_bb1_cmp258_i;

assign local_bb1_cmp258_i = ($signed(rnode_185to186_bb1_add245_i_1_NO_SHIFT_REG) > $signed(32'hFE));

// This section implements an unregistered operation.
// 
wire local_bb1_and272_i_stall_local;
wire [31:0] local_bb1_and272_i;

assign local_bb1_and272_i = (rnode_185to186_bb1_shr271_i_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp226_not_i_stall_local;
wire local_bb1_cmp226_not_i;

assign local_bb1_cmp226_not_i = (rnode_185to186_bb1_cmp226_i_0_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp29649_i_stall_local;
wire [31:0] local_bb1_cmp29649_i;

assign local_bb1_cmp29649_i[31:1] = 31'h0;
assign local_bb1_cmp29649_i[0] = rnode_185to186_bb1_cmp296_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_conv300_i_stall_local;
wire [31:0] local_bb1_conv300_i;

assign local_bb1_conv300_i[31:1] = 31'h0;
assign local_bb1_conv300_i[0] = rnode_185to186_bb1_cmp299_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_notlhs_i_stall_local;
wire local_bb1_notlhs_i;

assign local_bb1_notlhs_i = (local_bb1_and247_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or274_i_stall_local;
wire [31:0] local_bb1_or274_i;

assign local_bb1_or274_i = (local_bb1_and272_i | local_bb1_shl273_i);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge12_i_stall_local;
wire local_bb1_brmerge12_i;

assign local_bb1_brmerge12_i = (local_bb1_cmp226_not_i | rnode_185to186_bb1_not_cmp37_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot262__i_stall_local;
wire local_bb1_lnot262__i;

assign local_bb1_lnot262__i = (local_bb1_cmp258_i & local_bb1_cmp226_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_not__46_i_stall_local;
wire local_bb1_not__46_i;

assign local_bb1_not__46_i = (rnode_185to186_bb1_notrhs_i_0_NO_SHIFT_REG | local_bb1_notlhs_i);

// This section implements an unregistered operation.
// 
wire local_bb1_resultSign_0_i_stall_local;
wire [31:0] local_bb1_resultSign_0_i;

assign local_bb1_resultSign_0_i = (local_bb1_brmerge12_i ? rnode_185to186_bb1_and35_i_0_NO_SHIFT_REG : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or2662_i_stall_local;
wire local_bb1_or2662_i;

assign local_bb1_or2662_i = (rnode_185to186_bb1_var__u28_0_NO_SHIFT_REG | local_bb1_lnot262__i);

// This section implements an unregistered operation.
// 
wire local_bb1__47_i_stall_local;
wire local_bb1__47_i;

assign local_bb1__47_i = (rnode_185to186_bb1_cmp226_i_1_NO_SHIFT_REG | local_bb1_not__46_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or275_i_stall_local;
wire [31:0] local_bb1_or275_i;

assign local_bb1_or275_i = (local_bb1_or274_i | local_bb1_resultSign_0_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or2875_i_stall_local;
wire local_bb1_or2875_i;

assign local_bb1_or2875_i = (local_bb1_or2662_i | rnode_185to186_bb1__26_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u34_stall_local;
wire [31:0] local_bb1_var__u34;

assign local_bb1_var__u34[31:1] = 31'h0;
assign local_bb1_var__u34[0] = local_bb1_or2662_i;

// This section implements an unregistered operation.
// 
wire local_bb1_or2804_i_stall_local;
wire local_bb1_or2804_i;

assign local_bb1_or2804_i = (local_bb1__47_i | local_bb1_or2662_i);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u35_stall_local;
wire [31:0] local_bb1_var__u35;

assign local_bb1_var__u35[31:1] = 31'h0;
assign local_bb1_var__u35[0] = local_bb1__47_i;

// This section implements an unregistered operation.
// 
wire local_bb1_cond289_i_stall_local;
wire [31:0] local_bb1_cond289_i;

assign local_bb1_cond289_i = (local_bb1_or2875_i ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_ext310_i_stall_local;
wire [31:0] local_bb1_lnot_ext310_i;

assign local_bb1_lnot_ext310_i = (local_bb1_var__u34 ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cond282_i_stall_local;
wire [31:0] local_bb1_cond282_i;

assign local_bb1_cond282_i = (local_bb1_or2804_i ? 32'h80000000 : 32'hFFFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_or294_i_stall_local;
wire [31:0] local_bb1_or294_i;

assign local_bb1_or294_i = (local_bb1_cond289_i | local_bb1_cond292_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_0_i24_stall_local;
wire [31:0] local_bb1_reduction_0_i24;

assign local_bb1_reduction_0_i24 = (local_bb1_lnot_ext310_i & local_bb1_lnot_ext_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and293_i_stall_local;
wire [31:0] local_bb1_and293_i;

assign local_bb1_and293_i = (local_bb1_cond282_i & local_bb1_or275_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or295_i_stall_local;
wire [31:0] local_bb1_or295_i;

assign local_bb1_or295_i = (local_bb1_or294_i | local_bb1_and293_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and302_i_stall_local;
wire [31:0] local_bb1_and302_i;

assign local_bb1_and302_i = (local_bb1_conv300_i & local_bb1_and293_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or295_i_valid_out;
wire local_bb1_or295_i_stall_in;
 reg local_bb1_or295_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_var__u35_valid_out;
wire local_bb1_var__u35_stall_in;
 reg local_bb1_var__u35_consumed_0_NO_SHIFT_REG;
wire local_bb1_lor_ext_i_valid_out;
wire local_bb1_lor_ext_i_stall_in;
 reg local_bb1_lor_ext_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_0_i24_valid_out;
wire local_bb1_reduction_0_i24_stall_in;
 reg local_bb1_reduction_0_i24_consumed_0_NO_SHIFT_REG;
wire local_bb1_lor_ext_i_inputs_ready;
wire local_bb1_lor_ext_i_stall_local;
wire [31:0] local_bb1_lor_ext_i;

assign local_bb1_lor_ext_i_inputs_ready = (rnode_185to186_bb1_and35_i_0_valid_out_NO_SHIFT_REG & rnode_185to186_bb1_not_cmp37_i_0_valid_out_NO_SHIFT_REG & rnode_185to186_bb1_and269_i_0_valid_out_NO_SHIFT_REG & rnode_185to186_bb1_add245_i_0_valid_out_1_NO_SHIFT_REG & rnode_185to186_bb1_var__u28_0_valid_out_NO_SHIFT_REG & rnode_185to186_bb1__26_i_0_valid_out_0_NO_SHIFT_REG & rnode_185to186_bb1__26_i_0_valid_out_1_NO_SHIFT_REG & rnode_185to186_bb1_add245_i_0_valid_out_0_NO_SHIFT_REG & rnode_185to186_bb1_notrhs_i_0_valid_out_NO_SHIFT_REG & rnode_185to186_bb1_cmp226_i_0_valid_out_1_NO_SHIFT_REG & rnode_185to186_bb1_shr271_i_0_valid_out_NO_SHIFT_REG & rnode_185to186_bb1__26_i_0_valid_out_2_NO_SHIFT_REG & rnode_185to186_bb1_cmp226_i_0_valid_out_0_NO_SHIFT_REG & rnode_185to186_bb1_cmp296_i_0_valid_out_NO_SHIFT_REG & rnode_185to186_bb1_cmp299_i_0_valid_out_NO_SHIFT_REG);
assign local_bb1_lor_ext_i = (local_bb1_cmp29649_i | local_bb1_and302_i);
assign local_bb1_or295_i_valid_out = 1'b1;
assign local_bb1_var__u35_valid_out = 1'b1;
assign local_bb1_lor_ext_i_valid_out = 1'b1;
assign local_bb1_reduction_0_i24_valid_out = 1'b1;
assign rnode_185to186_bb1_and35_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_not_cmp37_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_and269_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_add245_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_var__u28_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1__26_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1__26_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_add245_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_notrhs_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_cmp226_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_shr271_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1__26_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_cmp226_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_cmp296_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_185to186_bb1_cmp299_i_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_or295_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_var__u35_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_lor_ext_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_0_i24_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_or295_i_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i_inputs_ready & (local_bb1_or295_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_or295_i_stall_in)) & local_bb1_lor_ext_i_stall_local);
		local_bb1_var__u35_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i_inputs_ready & (local_bb1_var__u35_consumed_0_NO_SHIFT_REG | ~(local_bb1_var__u35_stall_in)) & local_bb1_lor_ext_i_stall_local);
		local_bb1_lor_ext_i_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i_inputs_ready & (local_bb1_lor_ext_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_lor_ext_i_stall_in)) & local_bb1_lor_ext_i_stall_local);
		local_bb1_reduction_0_i24_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i_inputs_ready & (local_bb1_reduction_0_i24_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_0_i24_stall_in)) & local_bb1_lor_ext_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_186to187_bb1_or295_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_186to187_bb1_or295_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_186to187_bb1_or295_i_0_NO_SHIFT_REG;
 logic rnode_186to187_bb1_or295_i_0_reg_187_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_186to187_bb1_or295_i_0_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_or295_i_0_valid_out_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_or295_i_0_stall_in_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_or295_i_0_stall_out_reg_187_NO_SHIFT_REG;

acl_data_fifo rnode_186to187_bb1_or295_i_0_reg_187_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_186to187_bb1_or295_i_0_reg_187_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_186to187_bb1_or295_i_0_stall_in_reg_187_NO_SHIFT_REG),
	.valid_out(rnode_186to187_bb1_or295_i_0_valid_out_reg_187_NO_SHIFT_REG),
	.stall_out(rnode_186to187_bb1_or295_i_0_stall_out_reg_187_NO_SHIFT_REG),
	.data_in(local_bb1_or295_i),
	.data_out(rnode_186to187_bb1_or295_i_0_reg_187_NO_SHIFT_REG)
);

defparam rnode_186to187_bb1_or295_i_0_reg_187_fifo.DEPTH = 1;
defparam rnode_186to187_bb1_or295_i_0_reg_187_fifo.DATA_WIDTH = 32;
defparam rnode_186to187_bb1_or295_i_0_reg_187_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_186to187_bb1_or295_i_0_reg_187_fifo.IMPL = "shift_reg";

assign rnode_186to187_bb1_or295_i_0_reg_187_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_or295_i_stall_in = 1'b0;
assign rnode_186to187_bb1_or295_i_0_NO_SHIFT_REG = rnode_186to187_bb1_or295_i_0_reg_187_NO_SHIFT_REG;
assign rnode_186to187_bb1_or295_i_0_stall_in_reg_187_NO_SHIFT_REG = 1'b0;
assign rnode_186to187_bb1_or295_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_186to187_bb1_var__u35_0_valid_out_NO_SHIFT_REG;
 logic rnode_186to187_bb1_var__u35_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_186to187_bb1_var__u35_0_NO_SHIFT_REG;
 logic rnode_186to187_bb1_var__u35_0_reg_187_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_186to187_bb1_var__u35_0_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_var__u35_0_valid_out_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_var__u35_0_stall_in_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_var__u35_0_stall_out_reg_187_NO_SHIFT_REG;

acl_data_fifo rnode_186to187_bb1_var__u35_0_reg_187_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_186to187_bb1_var__u35_0_reg_187_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_186to187_bb1_var__u35_0_stall_in_reg_187_NO_SHIFT_REG),
	.valid_out(rnode_186to187_bb1_var__u35_0_valid_out_reg_187_NO_SHIFT_REG),
	.stall_out(rnode_186to187_bb1_var__u35_0_stall_out_reg_187_NO_SHIFT_REG),
	.data_in(local_bb1_var__u35),
	.data_out(rnode_186to187_bb1_var__u35_0_reg_187_NO_SHIFT_REG)
);

defparam rnode_186to187_bb1_var__u35_0_reg_187_fifo.DEPTH = 1;
defparam rnode_186to187_bb1_var__u35_0_reg_187_fifo.DATA_WIDTH = 32;
defparam rnode_186to187_bb1_var__u35_0_reg_187_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_186to187_bb1_var__u35_0_reg_187_fifo.IMPL = "shift_reg";

assign rnode_186to187_bb1_var__u35_0_reg_187_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u35_stall_in = 1'b0;
assign rnode_186to187_bb1_var__u35_0_NO_SHIFT_REG = rnode_186to187_bb1_var__u35_0_reg_187_NO_SHIFT_REG;
assign rnode_186to187_bb1_var__u35_0_stall_in_reg_187_NO_SHIFT_REG = 1'b0;
assign rnode_186to187_bb1_var__u35_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_186to187_bb1_lor_ext_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_186to187_bb1_lor_ext_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_186to187_bb1_lor_ext_i_0_NO_SHIFT_REG;
 logic rnode_186to187_bb1_lor_ext_i_0_reg_187_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_186to187_bb1_lor_ext_i_0_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_lor_ext_i_0_valid_out_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_lor_ext_i_0_stall_in_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_lor_ext_i_0_stall_out_reg_187_NO_SHIFT_REG;

acl_data_fifo rnode_186to187_bb1_lor_ext_i_0_reg_187_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_186to187_bb1_lor_ext_i_0_reg_187_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_186to187_bb1_lor_ext_i_0_stall_in_reg_187_NO_SHIFT_REG),
	.valid_out(rnode_186to187_bb1_lor_ext_i_0_valid_out_reg_187_NO_SHIFT_REG),
	.stall_out(rnode_186to187_bb1_lor_ext_i_0_stall_out_reg_187_NO_SHIFT_REG),
	.data_in(local_bb1_lor_ext_i),
	.data_out(rnode_186to187_bb1_lor_ext_i_0_reg_187_NO_SHIFT_REG)
);

defparam rnode_186to187_bb1_lor_ext_i_0_reg_187_fifo.DEPTH = 1;
defparam rnode_186to187_bb1_lor_ext_i_0_reg_187_fifo.DATA_WIDTH = 32;
defparam rnode_186to187_bb1_lor_ext_i_0_reg_187_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_186to187_bb1_lor_ext_i_0_reg_187_fifo.IMPL = "shift_reg";

assign rnode_186to187_bb1_lor_ext_i_0_reg_187_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lor_ext_i_stall_in = 1'b0;
assign rnode_186to187_bb1_lor_ext_i_0_NO_SHIFT_REG = rnode_186to187_bb1_lor_ext_i_0_reg_187_NO_SHIFT_REG;
assign rnode_186to187_bb1_lor_ext_i_0_stall_in_reg_187_NO_SHIFT_REG = 1'b0;
assign rnode_186to187_bb1_lor_ext_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_186to187_bb1_reduction_0_i24_0_valid_out_NO_SHIFT_REG;
 logic rnode_186to187_bb1_reduction_0_i24_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_186to187_bb1_reduction_0_i24_0_NO_SHIFT_REG;
 logic rnode_186to187_bb1_reduction_0_i24_0_reg_187_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_186to187_bb1_reduction_0_i24_0_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_reduction_0_i24_0_valid_out_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_reduction_0_i24_0_stall_in_reg_187_NO_SHIFT_REG;
 logic rnode_186to187_bb1_reduction_0_i24_0_stall_out_reg_187_NO_SHIFT_REG;

acl_data_fifo rnode_186to187_bb1_reduction_0_i24_0_reg_187_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_186to187_bb1_reduction_0_i24_0_reg_187_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_186to187_bb1_reduction_0_i24_0_stall_in_reg_187_NO_SHIFT_REG),
	.valid_out(rnode_186to187_bb1_reduction_0_i24_0_valid_out_reg_187_NO_SHIFT_REG),
	.stall_out(rnode_186to187_bb1_reduction_0_i24_0_stall_out_reg_187_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_0_i24),
	.data_out(rnode_186to187_bb1_reduction_0_i24_0_reg_187_NO_SHIFT_REG)
);

defparam rnode_186to187_bb1_reduction_0_i24_0_reg_187_fifo.DEPTH = 1;
defparam rnode_186to187_bb1_reduction_0_i24_0_reg_187_fifo.DATA_WIDTH = 32;
defparam rnode_186to187_bb1_reduction_0_i24_0_reg_187_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_186to187_bb1_reduction_0_i24_0_reg_187_fifo.IMPL = "shift_reg";

assign rnode_186to187_bb1_reduction_0_i24_0_reg_187_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_0_i24_stall_in = 1'b0;
assign rnode_186to187_bb1_reduction_0_i24_0_NO_SHIFT_REG = rnode_186to187_bb1_reduction_0_i24_0_reg_187_NO_SHIFT_REG;
assign rnode_186to187_bb1_reduction_0_i24_0_stall_in_reg_187_NO_SHIFT_REG = 1'b0;
assign rnode_186to187_bb1_reduction_0_i24_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_ext314_i_stall_local;
wire [31:0] local_bb1_lnot_ext314_i;

assign local_bb1_lnot_ext314_i = (rnode_186to187_bb1_var__u35_0_NO_SHIFT_REG ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_1_i_stall_local;
wire [31:0] local_bb1_reduction_1_i;

assign local_bb1_reduction_1_i = (local_bb1_lnot_ext314_i & rnode_186to187_bb1_lor_ext_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_2_i25_stall_local;
wire [31:0] local_bb1_reduction_2_i25;

assign local_bb1_reduction_2_i25 = (rnode_186to187_bb1_reduction_0_i24_0_NO_SHIFT_REG & local_bb1_reduction_1_i);

// This section implements an unregistered operation.
// 
wire local_bb1_add320_i_stall_local;
wire [31:0] local_bb1_add320_i;

assign local_bb1_add320_i = (local_bb1_reduction_2_i25 + rnode_186to187_bb1_or295_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u36_valid_out;
wire local_bb1_var__u36_stall_in;
wire local_bb1_var__u36_inputs_ready;
wire local_bb1_var__u36_stall_local;
wire [31:0] local_bb1_var__u36;

assign local_bb1_var__u36_inputs_ready = (rnode_186to187_bb1_or295_i_0_valid_out_NO_SHIFT_REG & rnode_186to187_bb1_reduction_0_i24_0_valid_out_NO_SHIFT_REG & rnode_186to187_bb1_var__u35_0_valid_out_NO_SHIFT_REG & rnode_186to187_bb1_lor_ext_i_0_valid_out_NO_SHIFT_REG);
assign local_bb1_var__u36 = local_bb1_add320_i;
assign local_bb1_var__u36_valid_out = 1'b1;
assign rnode_186to187_bb1_or295_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_186to187_bb1_reduction_0_i24_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_186to187_bb1_var__u35_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_186to187_bb1_lor_ext_i_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_conv19_i32_inputs_ready;
 reg local_bb1_conv19_i32_valid_out_NO_SHIFT_REG;
wire local_bb1_conv19_i32_stall_in;
wire local_bb1_conv19_i32_output_regs_ready;
wire [31:0] local_bb1_conv19_i32;
 reg local_bb1_conv19_i32_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_conv19_i32_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_conv19_i32_causedstall;

acl_fp_fptoui fp_module_local_bb1_conv19_i32 (
	.clock(clock),
	.resetn(resetn),
	.dataa(local_bb1_var__u36),
	.enable(local_bb1_conv19_i32_output_regs_ready),
	.result(local_bb1_conv19_i32)
);


assign local_bb1_conv19_i32_inputs_ready = 1'b1;
assign local_bb1_conv19_i32_output_regs_ready = 1'b1;
assign local_bb1_var__u36_stall_in = 1'b0;
assign local_bb1_conv19_i32_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv19_i32_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv19_i32_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv19_i32_output_regs_ready)
		begin
			local_bb1_conv19_i32_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_conv19_i32_valid_pipe_1_NO_SHIFT_REG <= local_bb1_conv19_i32_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_conv19_i32_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_conv19_i32_output_regs_ready)
		begin
			local_bb1_conv19_i32_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_conv19_i32_stall_in))
			begin
				local_bb1_conv19_i32_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_conv19_i32_trunc_stall_local;
wire [7:0] local_bb1_conv19_i32_trunc;

assign local_bb1_conv19_i32_trunc = local_bb1_conv19_i32[7:0];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi1_valid_out;
wire local_bb1_c0_exi1_stall_in;
wire local_bb1_c0_exi1_inputs_ready;
wire local_bb1_c0_exi1_stall_local;
wire [15:0] local_bb1_c0_exi1;

assign local_bb1_c0_exi1_inputs_ready = local_bb1_conv19_i32_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_exi1[7:0] = 8'bxxxxxxxx;
assign local_bb1_c0_exi1[15:8] = local_bb1_conv19_i32_trunc;
assign local_bb1_c0_exi1_valid_out = 1'b1;
assign local_bb1_conv19_i32_stall_in = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_c0_exit_c0_exi1_inputs_ready;
 reg local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi1_stall_in;
 reg [15:0] local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG;
wire [15:0] local_bb1_c0_exit_c0_exi1_in;
wire local_bb1_c0_exit_c0_exi1_valid;
wire local_bb1_c0_exit_c0_exi1_causedstall;

acl_stall_free_sink local_bb1_c0_exit_c0_exi1_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb1_c0_exi1),
	.data_out(local_bb1_c0_exit_c0_exi1_in),
	.input_accepted(local_bb1_c0_enter_c0_eni1_input_accepted),
	.valid_out(local_bb1_c0_exit_c0_exi1_valid),
	.stall_in(~(local_bb1_c0_exit_c0_exi1_output_regs_ready)),
	.stall_entry(local_bb1_c0_exit_c0_exi1_entry_stall),
	.valids(local_bb1_c0_exit_c0_exi1_valid_bits),
	.IIphases(local_bb1_c0_exit_c0_exi1_phases),
	.inc_pipelined_thread(local_bb1_c0_enter_c0_eni1_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb1_c0_enter_c0_eni1_dec_pipelined_thread)
);

defparam local_bb1_c0_exit_c0_exi1_instance.DATA_WIDTH = 16;
defparam local_bb1_c0_exit_c0_exi1_instance.PIPELINE_DEPTH = 33;
defparam local_bb1_c0_exit_c0_exi1_instance.SHARINGII = 1;
defparam local_bb1_c0_exit_c0_exi1_instance.SCHEDULEII = 1;

assign local_bb1_c0_exit_c0_exi1_inputs_ready = 1'b1;
assign local_bb1_c0_exit_c0_exi1_output_regs_ready = (&(~(local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi1_stall_in)));
assign local_bb1_c0_exi1_stall_in = 1'b0;
assign local_bb1_c0_exit_c0_exi1_causedstall = (1'b1 && (1'b0 && !(~(local_bb1_c0_exit_c0_exi1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG <= 'x;
		local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_exit_c0_exi1_output_regs_ready)
		begin
			local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi1_in;
			local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi1_valid;
		end
		else
		begin
			if (~(local_bb1_c0_exit_c0_exi1_stall_in))
			begin
				local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe1_valid_out;
wire local_bb1_c0_exe1_stall_in;
wire local_bb1_c0_exe1_inputs_ready;
wire local_bb1_c0_exe1_stall_local;
wire [7:0] local_bb1_c0_exe1;

assign local_bb1_c0_exe1_inputs_ready = local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_exe1 = local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG[15:8];
assign local_bb1_c0_exe1_valid_out = local_bb1_c0_exe1_inputs_ready;
assign local_bb1_c0_exe1_stall_local = local_bb1_c0_exe1_stall_in;
assign local_bb1_c0_exit_c0_exi1_stall_in = (|local_bb1_c0_exe1_stall_local);

// This section implements a registered operation.
// 
wire local_bb1_st_c0_exe1_inputs_ready;
 reg local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG;
wire local_bb1_st_c0_exe1_stall_in;
wire local_bb1_st_c0_exe1_output_regs_ready;
wire local_bb1_st_c0_exe1_fu_stall_out;
wire local_bb1_st_c0_exe1_fu_valid_out;
wire local_bb1_st_c0_exe1_causedstall;

lsu_top lsu_local_bb1_st_c0_exe1 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(local_bb1_arrayidx21),
	.stream_size(input_global_size_0),
	.stream_reset(valid_in),
	.o_stall(local_bb1_st_c0_exe1_fu_stall_out),
	.i_valid(local_bb1_st_c0_exe1_inputs_ready),
	.i_address(local_bb1_arrayidx21),
	.i_writedata(local_bb1_c0_exe1),
	.i_cmpdata(),
	.i_predicate(1'b0),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_st_c0_exe1_output_regs_ready)),
	.o_valid(local_bb1_st_c0_exe1_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_st_c0_exe1_active),
	.avm_address(avm_local_bb1_st_c0_exe1_address),
	.avm_read(avm_local_bb1_st_c0_exe1_read),
	.avm_readdata(avm_local_bb1_st_c0_exe1_readdata),
	.avm_write(avm_local_bb1_st_c0_exe1_write),
	.avm_writeack(avm_local_bb1_st_c0_exe1_writeack),
	.avm_burstcount(avm_local_bb1_st_c0_exe1_burstcount),
	.avm_writedata(avm_local_bb1_st_c0_exe1_writedata),
	.avm_byteenable(avm_local_bb1_st_c0_exe1_byteenable),
	.avm_waitrequest(avm_local_bb1_st_c0_exe1_waitrequest),
	.avm_readdatavalid(avm_local_bb1_st_c0_exe1_readdatavalid),
	.profile_bw(profile_lsu_local_bb1_st_c0_exe1_profile_bw_cntl),
	.profile_bw_incr(profile_lsu_local_bb1_st_c0_exe1_profile_bw_incr),
	.profile_total_ivalid(profile_lsu_local_bb1_st_c0_exe1_profile_total_ivalid_cntl),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(profile_lsu_local_bb1_st_c0_exe1_profile_avm_readwrite_count_cntl),
	.profile_avm_burstcount_total(profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_cntl),
	.profile_avm_burstcount_total_incr(profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_incr),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall(profile_lsu_local_bb1_st_c0_exe1_profile_avm_stall_cntl)
);

defparam lsu_local_bb1_st_c0_exe1.AWIDTH = 30;
defparam lsu_local_bb1_st_c0_exe1.WIDTH_BYTES = 1;
defparam lsu_local_bb1_st_c0_exe1.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_st_c0_exe1.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_st_c0_exe1.ALIGNMENT_BYTES = 1;
defparam lsu_local_bb1_st_c0_exe1.READ = 0;
defparam lsu_local_bb1_st_c0_exe1.ATOMIC = 0;
defparam lsu_local_bb1_st_c0_exe1.WIDTH = 8;
defparam lsu_local_bb1_st_c0_exe1.MWIDTH = 256;
defparam lsu_local_bb1_st_c0_exe1.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_st_c0_exe1.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_st_c0_exe1.KERNEL_SIDE_MEM_LATENCY = 2;
defparam lsu_local_bb1_st_c0_exe1.MEMORY_SIDE_MEM_LATENCY = 0;
defparam lsu_local_bb1_st_c0_exe1.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_st_c0_exe1.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_st_c0_exe1.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_st_c0_exe1.NUMBER_BANKS = 1;
defparam lsu_local_bb1_st_c0_exe1.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_st_c0_exe1.USEINPUTFIFO = 0;
defparam lsu_local_bb1_st_c0_exe1.USECACHING = 0;
defparam lsu_local_bb1_st_c0_exe1.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_st_c0_exe1.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_st_c0_exe1.HIGH_FMAX = 1;
defparam lsu_local_bb1_st_c0_exe1.ACL_PROFILE = 1;
defparam lsu_local_bb1_st_c0_exe1.ACL_PROFILE_INCREMENT_WIDTH = 32;
defparam lsu_local_bb1_st_c0_exe1.ADDRSPACE = 1;
defparam lsu_local_bb1_st_c0_exe1.STYLE = "STREAMING";
defparam lsu_local_bb1_st_c0_exe1.USE_BYTE_EN = 0;

assign local_bb1_st_c0_exe1_inputs_ready = (local_bb1_c0_exe1_valid_out & local_bb1_arrayidx21_valid_out);
assign local_bb1_st_c0_exe1_output_regs_ready = (&(~(local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG) | ~(local_bb1_st_c0_exe1_stall_in)));
assign local_bb1_c0_exe1_stall_in = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign local_bb1_arrayidx21_stall_in = (local_bb1_st_c0_exe1_fu_stall_out | ~(local_bb1_st_c0_exe1_inputs_ready));
assign local_bb1_st_c0_exe1_causedstall = (local_bb1_st_c0_exe1_inputs_ready && (local_bb1_st_c0_exe1_fu_stall_out && !(~(local_bb1_st_c0_exe1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_st_c0_exe1_output_regs_ready)
		begin
			local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= local_bb1_st_c0_exe1_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_st_c0_exe1_stall_in))
			begin
				local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_197to197_bb1_st_c0_exe1_valid_out;
wire rstag_197to197_bb1_st_c0_exe1_stall_in;
wire rstag_197to197_bb1_st_c0_exe1_inputs_ready;
wire rstag_197to197_bb1_st_c0_exe1_stall_local;
 reg rstag_197to197_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG;
wire rstag_197to197_bb1_st_c0_exe1_combined_valid;

assign rstag_197to197_bb1_st_c0_exe1_inputs_ready = local_bb1_st_c0_exe1_valid_out_NO_SHIFT_REG;
assign rstag_197to197_bb1_st_c0_exe1_combined_valid = (rstag_197to197_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG | rstag_197to197_bb1_st_c0_exe1_inputs_ready);
assign rstag_197to197_bb1_st_c0_exe1_valid_out = rstag_197to197_bb1_st_c0_exe1_combined_valid;
assign rstag_197to197_bb1_st_c0_exe1_stall_local = rstag_197to197_bb1_st_c0_exe1_stall_in;
assign local_bb1_st_c0_exe1_stall_in = (|rstag_197to197_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_197to197_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_197to197_bb1_st_c0_exe1_stall_local)
		begin
			if (~(rstag_197to197_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG))
			begin
				rstag_197to197_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= rstag_197to197_bb1_st_c0_exe1_inputs_ready;
			end
		end
		else
		begin
			rstag_197to197_bb1_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = rstag_197to197_bb1_st_c0_exe1_valid_out;
assign branch_var__output_regs_ready = ~(stall_in);
assign rstag_197to197_bb1_st_c0_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out = branch_var__inputs_ready;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module GreyScale_function
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_global_id_0,
		output 		stall_out,
		input 		valid_in,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input [255:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdata,
		input 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdatavalid,
		input 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_waitrequest,
		output [29:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_address,
		output 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_read,
		output 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_write,
		input 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writeack,
		output [255:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writedata,
		output [31:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_byteenable,
		output [4:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_burstcount,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_incr,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_extra_unaligned_reqs_cntl,
		output 		profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_stall_cntl,
		input [255:0] 		avm_local_bb1_st_c0_exe1_readdata,
		input 		avm_local_bb1_st_c0_exe1_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_waitrequest,
		output [29:0] 		avm_local_bb1_st_c0_exe1_address,
		output 		avm_local_bb1_st_c0_exe1_read,
		output 		avm_local_bb1_st_c0_exe1_write,
		input 		avm_local_bb1_st_c0_exe1_writeack,
		output [255:0] 		avm_local_bb1_st_c0_exe1_writedata,
		output [31:0] 		avm_local_bb1_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_burstcount,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb1_st_c0_exe1_profile_bw_incr,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb1_st_c0_exe1_profile_avm_stall_cntl,
		input 		start,
		input 		clock2x,
		input [63:0] 		input_grayImage,
		input [63:0] 		input_rgbImage,
		input [31:0] 		input_global_size_0,
		output 		profile_clock,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire [31:0] bb_0_lvb_input_global_id_0;
wire bb_1_stall_out;
wire bb_1_valid_out;
wire bb_1_local_bb1_ld_memcoalesce_rgbImage_load_0_active;
wire bb_1_local_bb1_st_c0_exe1_active;
wire writes_pending;
wire [1:0] lsus_active;

GreyScale_basic_block_0 GreyScale_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.input_global_id_0(input_global_id_0),
	.valid_out(bb_0_valid_out),
	.stall_in(bb_1_stall_out),
	.lvb_input_global_id_0(bb_0_lvb_input_global_id_0),
	.workgroup_size(workgroup_size)
);


GreyScale_basic_block_1 GreyScale_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_grayImage(input_grayImage),
	.input_rgbImage(input_rgbImage),
	.input_global_size_0(input_global_size_0),
	.valid_in(bb_0_valid_out),
	.stall_out(bb_1_stall_out),
	.input_global_id_0(bb_0_lvb_input_global_id_0),
	.valid_out(bb_1_valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdata(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdata),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdatavalid(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdatavalid),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_waitrequest(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_waitrequest),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_address(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_address),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_read(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_read),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_write(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_write),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writeack(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writeack),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writedata(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writedata),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_byteenable(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_byteenable),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_burstcount(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_burstcount),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_cntl),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_incr(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_incr),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_total_ivalid_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_total_ivalid_cntl),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_readwrite_count_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_readwrite_count_cntl),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_cntl),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_incr(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_incr),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_extra_unaligned_reqs_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_extra_unaligned_reqs_cntl),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_stall_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_stall_cntl),
	.local_bb1_ld_memcoalesce_rgbImage_load_0_active(bb_1_local_bb1_ld_memcoalesce_rgbImage_load_0_active),
	.clock2x(clock2x),
	.avm_local_bb1_st_c0_exe1_readdata(avm_local_bb1_st_c0_exe1_readdata),
	.avm_local_bb1_st_c0_exe1_readdatavalid(avm_local_bb1_st_c0_exe1_readdatavalid),
	.avm_local_bb1_st_c0_exe1_waitrequest(avm_local_bb1_st_c0_exe1_waitrequest),
	.avm_local_bb1_st_c0_exe1_address(avm_local_bb1_st_c0_exe1_address),
	.avm_local_bb1_st_c0_exe1_read(avm_local_bb1_st_c0_exe1_read),
	.avm_local_bb1_st_c0_exe1_write(avm_local_bb1_st_c0_exe1_write),
	.avm_local_bb1_st_c0_exe1_writeack(avm_local_bb1_st_c0_exe1_writeack),
	.avm_local_bb1_st_c0_exe1_writedata(avm_local_bb1_st_c0_exe1_writedata),
	.avm_local_bb1_st_c0_exe1_byteenable(avm_local_bb1_st_c0_exe1_byteenable),
	.avm_local_bb1_st_c0_exe1_burstcount(avm_local_bb1_st_c0_exe1_burstcount),
	.profile_lsu_local_bb1_st_c0_exe1_profile_bw_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_bw_cntl),
	.profile_lsu_local_bb1_st_c0_exe1_profile_bw_incr(profile_lsu_local_bb1_st_c0_exe1_profile_bw_incr),
	.profile_lsu_local_bb1_st_c0_exe1_profile_total_ivalid_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_total_ivalid_cntl),
	.profile_lsu_local_bb1_st_c0_exe1_profile_avm_readwrite_count_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_avm_readwrite_count_cntl),
	.profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_cntl),
	.profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_incr(profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_incr),
	.profile_lsu_local_bb1_st_c0_exe1_profile_avm_stall_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_avm_stall_cntl),
	.local_bb1_st_c0_exe1_active(bb_1_local_bb1_st_c0_exe1_active)
);


GreyScale_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign valid_out = bb_1_valid_out;
assign stall_out = bb_0_stall_out;
assign profile_clock = 1'b1;
assign writes_pending = bb_1_local_bb1_st_c0_exe1_active;
assign lsus_active[0] = bb_1_local_bb1_ld_memcoalesce_rgbImage_load_0_active;
assign lsus_active[1] = bb_1_local_bb1_st_c0_exe1_active;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		has_a_write_pending <= 1'b0;
		has_a_lsu_active <= 1'b0;
	end
	else
	begin
		has_a_write_pending <= (|writes_pending);
		has_a_lsu_active <= (|lsus_active);
	end
end

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module GreyScale_function_wrapper
	(
		input 		clock,
		input 		resetn,
		input 		clock2x,
		input 		local_router_hang,
		input 		profile_extmem_GreyScale_function_bank0_port0_read_data_inc_en,
		input 		profile_extmem_GreyScale_function_bank0_port0_read_burst_count_en,
		input 		profile_extmem_GreyScale_function_bank0_port0_write_data_inc_en,
		input 		profile_extmem_GreyScale_function_bank0_port0_write_burst_count_en,
		input 		avs_cra_read,
		input 		avs_cra_write,
		input [3:0] 		avs_cra_address,
		input [63:0] 		avs_cra_writedata,
		input [7:0] 		avs_cra_byteenable,
		output reg [63:0] 		avs_cra_readdata,
		output reg 		avs_cra_readdatavalid,
		output 		cra_irq,
		input [255:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_readdata,
		input 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_readdatavalid,
		input 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_waitrequest,
		output [29:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_address,
		output 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_read,
		output 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_write,
		input 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_writeack,
		output [255:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_writedata,
		output [31:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_byteenable,
		output [4:0] 		avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_burstcount,
		input [255:0] 		avm_local_bb1_st_c0_exe1_inst0_readdata,
		input 		avm_local_bb1_st_c0_exe1_inst0_readdatavalid,
		input 		avm_local_bb1_st_c0_exe1_inst0_waitrequest,
		output [29:0] 		avm_local_bb1_st_c0_exe1_inst0_address,
		output 		avm_local_bb1_st_c0_exe1_inst0_read,
		output 		avm_local_bb1_st_c0_exe1_inst0_write,
		input 		avm_local_bb1_st_c0_exe1_inst0_writeack,
		output [255:0] 		avm_local_bb1_st_c0_exe1_inst0_writedata,
		output [31:0] 		avm_local_bb1_st_c0_exe1_inst0_byteenable,
		output [4:0] 		avm_local_bb1_st_c0_exe1_inst0_burstcount
	);

// Responsible for interfacing a kernel with the outside world. It comprises a
// slave interface to specify the kernel arguments and retain kernel status. 

// This section of the wrapper implements the slave interface.
// twoXclock_consumer uses clock2x, even if nobody inside the kernel does. Keeps interface to acl_iface consistent for all kernels.
 reg start_NO_SHIFT_REG;
 reg started_NO_SHIFT_REG;
wire finish;
 reg [31:0] status_NO_SHIFT_REG;
wire has_a_write_pending;
wire has_a_lsu_active;
 reg [127:0] kernel_arguments_NO_SHIFT_REG;
 reg twoXclock_consumer_NO_SHIFT_REG /* synthesis  preserve  noprune  */;
 reg [31:0] workgroup_size_NO_SHIFT_REG;
 reg [31:0] global_size_NO_SHIFT_REG[2:0];
 reg [31:0] num_groups_NO_SHIFT_REG[2:0];
 reg [31:0] local_size_NO_SHIFT_REG[2:0];
 reg [31:0] work_dim_NO_SHIFT_REG;
 reg [31:0] global_offset_NO_SHIFT_REG[2:0];
 reg [63:0] profile_data_NO_SHIFT_REG;
 reg [31:0] profile_ctrl_NO_SHIFT_REG;
 reg [63:0] profile_start_cycle_NO_SHIFT_REG;
 reg [63:0] profile_stop_cycle_NO_SHIFT_REG;
wire dispatched_all_groups;
wire [31:0] group_id_tmp[2:0];
wire [31:0] global_id_base_out[2:0];
wire start_out;
wire [31:0] local_id[0:0][2:0];
wire [31:0] global_id[0:0][2:0];
wire [31:0] group_id[0:0][2:0];
wire iter_valid_in;
wire iter_stall_out;
wire stall_in;
wire stall_out;
wire valid_in;
wire valid_out;

always @(posedge clock2x or negedge resetn)
begin
	if (~(resetn))
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b1;
	end
end


// Profiling IP for various signals.
 reg profile_reset_reg_NO_SHIFT_REG;
 reg [63:0] profile_cycle_counter_NO_SHIFT_REG;
 reg profile_cycle_count_in_range_reg_NO_SHIFT_REG;
wire [63:0] profile_data_wire;
wire profile_shift_wire;
wire profile_reset_n_wire;
wire profile_enable_wire;
wire [15:0] profile_increment_cntl;
wire [511:0] profile_increment_val;

acl_profiler profiler_inst (
	.clock(clock),
	.profile_shift(profile_shift_wire),
	.incr_cntl(profile_increment_cntl),
	.incr_val(profile_increment_val),
	.daisy_out(profile_data_wire),
	.resetn(profile_reset_n_wire),
	.enable(profile_enable_wire)
);

defparam profiler_inst.COUNTER_WIDTH = 64;
defparam profiler_inst.INCREMENT_WIDTH = 32;
defparam profiler_inst.NUM_COUNTERS = 16;
defparam profiler_inst.DAISY_WIDTH = 64;


// Work group dispatcher is responsible for issuing work-groups to id iterator(s)
acl_work_group_dispatcher group_dispatcher (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.num_groups(num_groups_NO_SHIFT_REG),
	.local_size(local_size_NO_SHIFT_REG),
	.stall_in(iter_stall_out),
	.valid_out(iter_valid_in),
	.group_id_out(group_id_tmp),
	.global_id_base_out(global_id_base_out),
	.start_out(start_out),
	.dispatched_all_groups(dispatched_all_groups)
);

defparam group_dispatcher.NUM_COPIES = 1;
defparam group_dispatcher.RUN_FOREVER = 0;


// This section of the wrapper implements an Avalon Slave Interface used to configure a kernel invocation.
// The few words words contain the status and the workgroup size registers.
// The remaining addressable space is reserved for kernel arguments.
 reg [63:0] cra_readdata_st1_NO_SHIFT_REG;
 reg [3:0] cra_addr_st1_NO_SHIFT_REG;
 reg cra_read_st1_NO_SHIFT_REG;
wire [63:0] bitenable;

assign bitenable[7:0] = (avs_cra_byteenable[0] ? 8'hFF : 8'h0);
assign bitenable[15:8] = (avs_cra_byteenable[1] ? 8'hFF : 8'h0);
assign bitenable[23:16] = (avs_cra_byteenable[2] ? 8'hFF : 8'h0);
assign bitenable[31:24] = (avs_cra_byteenable[3] ? 8'hFF : 8'h0);
assign bitenable[39:32] = (avs_cra_byteenable[4] ? 8'hFF : 8'h0);
assign bitenable[47:40] = (avs_cra_byteenable[5] ? 8'hFF : 8'h0);
assign bitenable[55:48] = (avs_cra_byteenable[6] ? 8'hFF : 8'h0);
assign bitenable[63:56] = (avs_cra_byteenable[7] ? 8'hFF : 8'h0);
assign cra_irq = (status_NO_SHIFT_REG[1] | status_NO_SHIFT_REG[3]);
assign profile_enable_wire = (profile_cycle_count_in_range_reg_NO_SHIFT_REG & (started_NO_SHIFT_REG & profile_ctrl_NO_SHIFT_REG[2]));
assign profile_reset_n_wire = (resetn & ~(profile_reset_reg_NO_SHIFT_REG));
assign profile_shift_wire = profile_ctrl_NO_SHIFT_REG[0];

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		start_NO_SHIFT_REG <= 1'b0;
		started_NO_SHIFT_REG <= 1'b0;
		kernel_arguments_NO_SHIFT_REG <= 128'h0;
		status_NO_SHIFT_REG <= 32'h30000;
		profile_ctrl_NO_SHIFT_REG <= 32'h4;
		profile_start_cycle_NO_SHIFT_REG <= 64'h0;
		profile_stop_cycle_NO_SHIFT_REG <= 64'hFFFFFFFFFFFFFFFF;
		work_dim_NO_SHIFT_REG <= 32'h0;
		workgroup_size_NO_SHIFT_REG <= 32'h0;
		global_size_NO_SHIFT_REG[0] <= 32'h0;
		global_size_NO_SHIFT_REG[1] <= 32'h0;
		global_size_NO_SHIFT_REG[2] <= 32'h0;
		num_groups_NO_SHIFT_REG[0] <= 32'h0;
		num_groups_NO_SHIFT_REG[1] <= 32'h0;
		num_groups_NO_SHIFT_REG[2] <= 32'h0;
		local_size_NO_SHIFT_REG[0] <= 32'h0;
		local_size_NO_SHIFT_REG[1] <= 32'h0;
		local_size_NO_SHIFT_REG[2] <= 32'h0;
		global_offset_NO_SHIFT_REG[0] <= 32'h0;
		global_offset_NO_SHIFT_REG[1] <= 32'h0;
		global_offset_NO_SHIFT_REG[2] <= 32'h0;
		profile_reset_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (avs_cra_write)
		begin
			case (avs_cra_address)
				4'h0:
				begin
					status_NO_SHIFT_REG[31:16] <= 16'h3;
					status_NO_SHIFT_REG[15:0] <= ((status_NO_SHIFT_REG[15:0] & ~(bitenable[15:0])) | (avs_cra_writedata[15:0] & bitenable[15:0]));
				end

				4'h1:
				begin
					profile_ctrl_NO_SHIFT_REG <= ((profile_ctrl_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h3:
				begin
					profile_start_cycle_NO_SHIFT_REG[31:0] <= ((profile_start_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_start_cycle_NO_SHIFT_REG[63:32] <= ((profile_start_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h4:
				begin
					profile_stop_cycle_NO_SHIFT_REG[31:0] <= ((profile_stop_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_stop_cycle_NO_SHIFT_REG[63:32] <= ((profile_stop_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h5:
				begin
					work_dim_NO_SHIFT_REG <= ((work_dim_NO_SHIFT_REG & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					workgroup_size_NO_SHIFT_REG <= ((workgroup_size_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h6:
				begin
					global_size_NO_SHIFT_REG[0] <= ((global_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_size_NO_SHIFT_REG[1] <= ((global_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h7:
				begin
					global_size_NO_SHIFT_REG[2] <= ((global_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[0] <= ((num_groups_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h8:
				begin
					num_groups_NO_SHIFT_REG[1] <= ((num_groups_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[2] <= ((num_groups_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h9:
				begin
					local_size_NO_SHIFT_REG[0] <= ((local_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					local_size_NO_SHIFT_REG[1] <= ((local_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hA:
				begin
					local_size_NO_SHIFT_REG[2] <= ((local_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[0] <= ((global_offset_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hB:
				begin
					global_offset_NO_SHIFT_REG[1] <= ((global_offset_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[2] <= ((global_offset_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hC:
				begin
					kernel_arguments_NO_SHIFT_REG[31:0] <= ((kernel_arguments_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[63:32] <= ((kernel_arguments_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hD:
				begin
					kernel_arguments_NO_SHIFT_REG[95:64] <= ((kernel_arguments_NO_SHIFT_REG[95:64] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[127:96] <= ((kernel_arguments_NO_SHIFT_REG[127:96] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				default:
				begin
				end

			endcase
		end
		else
		begin
			if (profile_ctrl_NO_SHIFT_REG[1])
			begin
				if (profile_reset_reg_NO_SHIFT_REG)
				begin
					profile_ctrl_NO_SHIFT_REG[1] <= 1'b0;
				end
				else
				begin
					profile_reset_reg_NO_SHIFT_REG <= 1'b1;
				end
			end
			else
			begin
				profile_reset_reg_NO_SHIFT_REG <= 1'b0;
			end
			profile_ctrl_NO_SHIFT_REG[0] <= 1'b0;
			if (status_NO_SHIFT_REG[0])
			begin
				start_NO_SHIFT_REG <= 1'b1;
			end
			if (start_NO_SHIFT_REG)
			begin
				status_NO_SHIFT_REG[0] <= 1'b0;
				started_NO_SHIFT_REG <= 1'b1;
			end
			if (started_NO_SHIFT_REG)
			begin
				start_NO_SHIFT_REG <= 1'b0;
			end
			if (finish)
			begin
				status_NO_SHIFT_REG[1] <= 1'b1;
				started_NO_SHIFT_REG <= 1'b0;
			end
		end
		status_NO_SHIFT_REG[11] <= 1'b0;
		status_NO_SHIFT_REG[12] <= (|has_a_lsu_active);
		status_NO_SHIFT_REG[13] <= (|has_a_write_pending);
		status_NO_SHIFT_REG[14] <= (|valid_in);
		status_NO_SHIFT_REG[15] <= started_NO_SHIFT_REG;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cra_read_st1_NO_SHIFT_REG <= 1'b0;
		cra_addr_st1_NO_SHIFT_REG <= 4'h0;
		cra_readdata_st1_NO_SHIFT_REG <= 64'h0;
	end
	else
	begin
		cra_read_st1_NO_SHIFT_REG <= avs_cra_read;
		cra_addr_st1_NO_SHIFT_REG <= avs_cra_address;
		case (avs_cra_address)
			4'h0:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= status_NO_SHIFT_REG;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= 32'h0;
			end

			4'h1:
			begin
				cra_readdata_st1_NO_SHIFT_REG[31:0] <= 'x;
				cra_readdata_st1_NO_SHIFT_REG[63:32] <= profile_ctrl_NO_SHIFT_REG;
			end

			4'h2:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= profile_data_NO_SHIFT_REG;
			end

			4'h3:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= profile_start_cycle_NO_SHIFT_REG;
			end

			4'h4:
			begin
				cra_readdata_st1_NO_SHIFT_REG[63:0] <= profile_stop_cycle_NO_SHIFT_REG;
			end

			default:
			begin
				cra_readdata_st1_NO_SHIFT_REG <= status_NO_SHIFT_REG;
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdatavalid <= 1'b0;
		avs_cra_readdata <= 64'h0;
	end
	else
	begin
		avs_cra_readdatavalid <= cra_read_st1_NO_SHIFT_REG;
		case (cra_addr_st1_NO_SHIFT_REG)
			4'h2:
			begin
				avs_cra_readdata[63:0] <= profile_data_NO_SHIFT_REG;
			end

			default:
			begin
				avs_cra_readdata <= cra_readdata_st1_NO_SHIFT_REG;
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		profile_data_NO_SHIFT_REG <= 64'h0;
	end
	else
	begin
		if (profile_shift_wire)
		begin
			profile_data_NO_SHIFT_REG <= profile_data_wire;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		profile_cycle_counter_NO_SHIFT_REG <= 64'h0;
	end
	else
	begin
		if (started_NO_SHIFT_REG)
		begin
			profile_cycle_counter_NO_SHIFT_REG <= (profile_cycle_counter_NO_SHIFT_REG + 64'h1);
		end
		else
		begin
			profile_cycle_counter_NO_SHIFT_REG <= 64'h0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		profile_cycle_count_in_range_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		profile_cycle_count_in_range_reg_NO_SHIFT_REG <= ((profile_cycle_counter_NO_SHIFT_REG >= profile_start_cycle_NO_SHIFT_REG) & (profile_cycle_counter_NO_SHIFT_REG < profile_stop_cycle_NO_SHIFT_REG));
	end
end


// Handshaking signals used to control data through the pipeline

// Determine when the kernel is finished.
acl_kernel_finish_detector kernel_finish_detector (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.wg_size(workgroup_size_NO_SHIFT_REG),
	.wg_dispatch_valid_out(iter_valid_in),
	.wg_dispatch_stall_in(iter_stall_out),
	.dispatched_all_groups(dispatched_all_groups),
	.kernel_copy_valid_out(valid_out),
	.kernel_copy_stall_in(stall_in),
	.pending_writes(has_a_write_pending),
	.finish(finish)
);

defparam kernel_finish_detector.TESSELLATION_SIZE = 0;
defparam kernel_finish_detector.NUM_COPIES = 1;
defparam kernel_finish_detector.WG_SIZE_W = 32;

assign stall_in = 1'b0;

// Creating ID iterator and kernel instance for every requested kernel copy

// ID iterator is responsible for iterating over all local ids for given work-groups
acl_id_iterator id_iter_inst0 (
	.clock(clock),
	.resetn(resetn),
	.start(start_out),
	.valid_in(iter_valid_in),
	.stall_out(iter_stall_out),
	.stall_in(stall_out),
	.valid_out(valid_in),
	.group_id_in(group_id_tmp),
	.global_id_base_in(global_id_base_out),
	.local_size(local_size_NO_SHIFT_REG),
	.global_size(global_size_NO_SHIFT_REG),
	.local_id(local_id[0]),
	.global_id(global_id[0]),
	.group_id(group_id[0])
);



// This section instantiates a kernel function block
wire profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_incr_inst0_wire_0;
wire profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_total_ivalid_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_readwrite_count_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_incr_inst0_wire_0;
wire profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_extra_unaligned_reqs_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_stall_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_st_c0_exe1_profile_bw_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb1_st_c0_exe1_profile_bw_incr_inst0_wire_0;
wire profile_lsu_local_bb1_st_c0_exe1_profile_total_ivalid_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_st_c0_exe1_profile_avm_readwrite_count_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_incr_inst0_wire_0;
wire profile_lsu_local_bb1_st_c0_exe1_profile_avm_stall_cntl_inst0_wire_0;
wire profile_clock_inst0_wire_0;

GreyScale_function GreyScale_function_inst0 (
	.clock(clock),
	.resetn(resetn),
	.input_global_id_0(global_id[0][0]),
	.stall_out(stall_out),
	.valid_in(valid_in),
	.valid_out(valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size_NO_SHIFT_REG),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdata(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_readdata),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_readdatavalid(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_readdatavalid),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_waitrequest(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_waitrequest),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_address(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_address),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_read(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_read),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_write(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_write),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writeack(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_writeack),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_writedata(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_writedata),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_byteenable(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_byteenable),
	.avm_local_bb1_ld_memcoalesce_rgbImage_load_0_burstcount(avm_local_bb1_ld_memcoalesce_rgbImage_load_0_inst0_burstcount),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_incr(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_incr_inst0_wire_0),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_total_ivalid_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_total_ivalid_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_readwrite_count_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_readwrite_count_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_incr(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_incr_inst0_wire_0),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_extra_unaligned_reqs_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_extra_unaligned_reqs_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_stall_cntl(profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_stall_cntl_inst0_wire_0),
	.avm_local_bb1_st_c0_exe1_readdata(avm_local_bb1_st_c0_exe1_inst0_readdata),
	.avm_local_bb1_st_c0_exe1_readdatavalid(avm_local_bb1_st_c0_exe1_inst0_readdatavalid),
	.avm_local_bb1_st_c0_exe1_waitrequest(avm_local_bb1_st_c0_exe1_inst0_waitrequest),
	.avm_local_bb1_st_c0_exe1_address(avm_local_bb1_st_c0_exe1_inst0_address),
	.avm_local_bb1_st_c0_exe1_read(avm_local_bb1_st_c0_exe1_inst0_read),
	.avm_local_bb1_st_c0_exe1_write(avm_local_bb1_st_c0_exe1_inst0_write),
	.avm_local_bb1_st_c0_exe1_writeack(avm_local_bb1_st_c0_exe1_inst0_writeack),
	.avm_local_bb1_st_c0_exe1_writedata(avm_local_bb1_st_c0_exe1_inst0_writedata),
	.avm_local_bb1_st_c0_exe1_byteenable(avm_local_bb1_st_c0_exe1_inst0_byteenable),
	.avm_local_bb1_st_c0_exe1_burstcount(avm_local_bb1_st_c0_exe1_inst0_burstcount),
	.profile_lsu_local_bb1_st_c0_exe1_profile_bw_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_bw_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_st_c0_exe1_profile_bw_incr(profile_lsu_local_bb1_st_c0_exe1_profile_bw_incr_inst0_wire_0),
	.profile_lsu_local_bb1_st_c0_exe1_profile_total_ivalid_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_total_ivalid_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_st_c0_exe1_profile_avm_readwrite_count_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_avm_readwrite_count_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_incr(profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_incr_inst0_wire_0),
	.profile_lsu_local_bb1_st_c0_exe1_profile_avm_stall_cntl(profile_lsu_local_bb1_st_c0_exe1_profile_avm_stall_cntl_inst0_wire_0),
	.start(start_out),
	.clock2x(clock2x),
	.input_grayImage(kernel_arguments_NO_SHIFT_REG[63:0]),
	.input_rgbImage(kernel_arguments_NO_SHIFT_REG[127:64]),
	.input_global_size_0(global_size_NO_SHIFT_REG[0]),
	.profile_clock(profile_clock_inst0_wire_0),
	.has_a_write_pending(has_a_write_pending),
	.has_a_lsu_active(has_a_lsu_active)
);


assign profile_increment_cntl[0] = profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_cntl_inst0_wire_0;
assign profile_increment_val[31:0] = profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_bw_incr_inst0_wire_0;
assign profile_increment_cntl[1] = profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_total_ivalid_cntl_inst0_wire_0;
assign profile_increment_val[63:32] = 32'h1;
assign profile_increment_cntl[2] = profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_readwrite_count_cntl_inst0_wire_0;
assign profile_increment_val[95:64] = 32'h1;
assign profile_increment_cntl[3] = profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_cntl_inst0_wire_0;
assign profile_increment_val[127:96] = profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_burstcount_total_incr_inst0_wire_0;
assign profile_increment_cntl[4] = profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_extra_unaligned_reqs_cntl_inst0_wire_0;
assign profile_increment_val[159:128] = 32'h1;
assign profile_increment_cntl[5] = profile_lsu_local_bb1_ld_memcoalesce_rgbImage_load_0_profile_avm_stall_cntl_inst0_wire_0;
assign profile_increment_val[191:160] = 32'h1;
assign profile_increment_cntl[6] = profile_lsu_local_bb1_st_c0_exe1_profile_bw_cntl_inst0_wire_0;
assign profile_increment_val[223:192] = profile_lsu_local_bb1_st_c0_exe1_profile_bw_incr_inst0_wire_0;
assign profile_increment_cntl[7] = profile_lsu_local_bb1_st_c0_exe1_profile_total_ivalid_cntl_inst0_wire_0;
assign profile_increment_val[255:224] = 32'h1;
assign profile_increment_cntl[8] = profile_lsu_local_bb1_st_c0_exe1_profile_avm_readwrite_count_cntl_inst0_wire_0;
assign profile_increment_val[287:256] = 32'h1;
assign profile_increment_cntl[9] = profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_cntl_inst0_wire_0;
assign profile_increment_val[319:288] = profile_lsu_local_bb1_st_c0_exe1_profile_avm_burstcount_total_incr_inst0_wire_0;
assign profile_increment_cntl[10] = profile_lsu_local_bb1_st_c0_exe1_profile_avm_stall_cntl_inst0_wire_0;
assign profile_increment_val[351:320] = 32'h1;
assign profile_increment_cntl[11] = profile_clock_inst0_wire_0;
assign profile_increment_val[383:352] = 32'h1;
assign profile_increment_cntl[12] = profile_extmem_GreyScale_function_bank0_port0_read_data_inc_en;
assign profile_increment_val[415:384] = 32'h1;
assign profile_increment_cntl[13] = profile_extmem_GreyScale_function_bank0_port0_read_burst_count_en;
assign profile_increment_val[447:416] = 32'h1;
assign profile_increment_cntl[14] = profile_extmem_GreyScale_function_bank0_port0_write_data_inc_en;
assign profile_increment_val[479:448] = 32'h1;
assign profile_increment_cntl[15] = profile_extmem_GreyScale_function_bank0_port0_write_burst_count_en;
assign profile_increment_val[511:480] = 32'h1;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module GreyScale_sys_cycle_time
	(
		input 		clock,
		input 		resetn,
		output [31:0] 		cur_cycle
	);


 reg [31:0] cur_count_NO_SHIFT_REG;

assign cur_cycle = cur_count_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cur_count_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		cur_count_NO_SHIFT_REG <= (cur_count_NO_SHIFT_REG + 32'h1);
	end
end

endmodule

