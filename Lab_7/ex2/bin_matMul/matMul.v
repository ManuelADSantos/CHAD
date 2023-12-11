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
module matMul_basic_block_0
	(
		input 		clock,
		input 		resetn,
		input 		start,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_global_id_1,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_input_global_id_0,
		output [31:0] 		lvb_input_global_id_1,
		output [31:0] 		lvb_input_acl_hw_wg_id,
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
 reg [31:0] input_global_id_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_1_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
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
		input_global_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_global_id_0_staging_reg_NO_SHIFT_REG <= input_global_id_0;
				input_global_id_1_staging_reg_NO_SHIFT_REG <= input_global_id_1;
				input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id;
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
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id;
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
 reg [31:0] lvb_input_global_id_1_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_input_global_id_0 = lvb_input_global_id_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1 = lvb_input_global_id_1_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_input_global_id_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_1_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_input_global_id_0_reg_NO_SHIFT_REG <= local_lvm_input_global_id_0_NO_SHIFT_REG;
			lvb_input_global_id_1_reg_NO_SHIFT_REG <= local_lvm_input_global_id_1_NO_SHIFT_REG;
			lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
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
module matMul_basic_block_1
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_B,
		input [63:0] 		input_A,
		input 		valid_in_0,
		output 		stall_out_0,
		input [63:0] 		input_indvars_iv_0,
		input [31:0] 		input_sum_03_0,
		input [31:0] 		input_global_id_0_0,
		input [31:0] 		input_global_id_1_0,
		input [31:0] 		input_acl_hw_wg_id_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [63:0] 		input_indvars_iv_1,
		input [31:0] 		input_sum_03_1,
		input [31:0] 		input_global_id_0_1,
		input [31:0] 		input_global_id_1_1,
		input [31:0] 		input_acl_hw_wg_id_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output [31:0] 		lvb_bb1_mul_RM_0,
		output [63:0] 		lvb_bb1_indvars_iv_next_0,
		output 		lvb_bb1_or_cond_NEG_RM_0,
		output [31:0] 		lvb_bb1_c0_exe1_0,
		output [31:0] 		lvb_input_global_id_0_0,
		output [31:0] 		lvb_input_global_id_1_0,
		output [31:0] 		lvb_input_acl_hw_wg_id_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [31:0] 		lvb_bb1_mul_RM_1,
		output [63:0] 		lvb_bb1_indvars_iv_next_1,
		output 		lvb_bb1_or_cond_NEG_RM_1,
		output [31:0] 		lvb_bb1_c0_exe1_1,
		output [31:0] 		lvb_input_global_id_0_1,
		output [31:0] 		lvb_input_global_id_1_1,
		output [31:0] 		lvb_input_acl_hw_wg_id_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb1_ld__readdata,
		input 		avm_local_bb1_ld__readdatavalid,
		input 		avm_local_bb1_ld__waitrequest,
		output [29:0] 		avm_local_bb1_ld__address,
		output 		avm_local_bb1_ld__read,
		output 		avm_local_bb1_ld__write,
		input 		avm_local_bb1_ld__writeack,
		output [255:0] 		avm_local_bb1_ld__writedata,
		output [31:0] 		avm_local_bb1_ld__byteenable,
		output [4:0] 		avm_local_bb1_ld__burstcount,
		output 		profile_lsu_local_bb1_ld__profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld__profile_bw_incr,
		output 		profile_lsu_local_bb1_ld__profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb1_ld__profile_total_req_cntl,
		output 		profile_lsu_local_bb1_ld__profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb1_ld__profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld__profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb1_ld__profile_req_cache_hit_count_cntl,
		output 		profile_lsu_local_bb1_ld__profile_avm_stall_cntl,
		output 		local_bb1_ld__active,
		input 		clock2x,
		input [255:0] 		avm_local_bb1_ld__u4_readdata,
		input 		avm_local_bb1_ld__u4_readdatavalid,
		input 		avm_local_bb1_ld__u4_waitrequest,
		output [29:0] 		avm_local_bb1_ld__u4_address,
		output 		avm_local_bb1_ld__u4_read,
		output 		avm_local_bb1_ld__u4_write,
		input 		avm_local_bb1_ld__u4_writeack,
		output [255:0] 		avm_local_bb1_ld__u4_writedata,
		output [31:0] 		avm_local_bb1_ld__u4_byteenable,
		output [4:0] 		avm_local_bb1_ld__u4_burstcount,
		output 		profile_lsu_local_bb1_ld__u4_profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld__u4_profile_bw_incr,
		output 		profile_lsu_local_bb1_ld__u4_profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb1_ld__u4_profile_total_req_cntl,
		output 		profile_lsu_local_bb1_ld__u4_profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb1_ld__u4_profile_req_cache_hit_count_cntl,
		output 		profile_lsu_local_bb1_ld__u4_profile_avm_stall_cntl,
		output 		local_bb1_ld__u4_active
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
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
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_node_stall_in_5;
 reg merge_node_valid_out_5_NO_SHIFT_REG;
wire merge_node_stall_in_6;
 reg merge_node_valid_out_6_NO_SHIFT_REG;
wire merge_node_stall_in_7;
 reg merge_node_valid_out_7_NO_SHIFT_REG;
wire merge_node_stall_in_8;
 reg merge_node_valid_out_8_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_sum_03_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv_NO_SHIFT_REG;
 reg [31:0] local_lvm_sum_03_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_1_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_sum_03_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_1_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_indvars_iv_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_sum_03_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_0_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_1_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_indvars_iv_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_sum_03_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_0_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_1_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_indvars_iv_0_staging_reg_NO_SHIFT_REG <= input_indvars_iv_0;
				input_sum_03_0_staging_reg_NO_SHIFT_REG <= input_sum_03_0;
				input_global_id_0_0_staging_reg_NO_SHIFT_REG <= input_global_id_0_0;
				input_global_id_1_0_staging_reg_NO_SHIFT_REG <= input_global_id_1_0;
				input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_indvars_iv_1_staging_reg_NO_SHIFT_REG <= input_indvars_iv_1;
				input_sum_03_1_staging_reg_NO_SHIFT_REG <= input_sum_03_1;
				input_global_id_0_1_staging_reg_NO_SHIFT_REG <= input_global_id_0_1;
				input_global_id_1_1_staging_reg_NO_SHIFT_REG <= input_global_id_1_1;
				input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
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
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_indvars_iv_NO_SHIFT_REG <= input_indvars_iv_0_staging_reg_NO_SHIFT_REG;
					local_lvm_sum_03_NO_SHIFT_REG <= input_sum_03_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_indvars_iv_NO_SHIFT_REG <= input_indvars_iv_0;
					local_lvm_sum_03_NO_SHIFT_REG <= input_sum_03_0;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_0;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_indvars_iv_NO_SHIFT_REG <= input_indvars_iv_1_staging_reg_NO_SHIFT_REG;
					local_lvm_sum_03_NO_SHIFT_REG <= input_sum_03_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_indvars_iv_NO_SHIFT_REG <= input_indvars_iv_1;
					local_lvm_sum_03_NO_SHIFT_REG <= input_sum_03_1;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_1;
					local_lvm_input_global_id_1_NO_SHIFT_REG <= input_global_id_1_1;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
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
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_5_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_6_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_7_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_8_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
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
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_5))
			begin
				merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_6))
			begin
				merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_7))
			begin
				merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_8))
			begin
				merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
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
wire local_bb1_mul_RM_stall_local;
wire [31:0] local_bb1_mul_RM;

assign local_bb1_mul_RM = (local_lvm_input_global_id_1_NO_SHIFT_REG << 32'hA);

// This section implements an unregistered operation.
// 
wire local_bb1_var__stall_local;
wire [63:0] local_bb1_var_;

assign local_bb1_var_[32] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[33] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[34] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[35] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[36] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[37] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[38] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[39] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[40] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[41] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[42] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[43] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[44] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[45] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[46] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[47] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[48] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[49] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[50] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[51] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[52] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[53] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[54] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[55] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[56] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[57] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[58] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[59] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[60] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[61] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[62] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[63] = local_lvm_input_global_id_0_NO_SHIFT_REG[31];
assign local_bb1_var_[31:0] = local_lvm_input_global_id_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u0_stall_local;
wire [63:0] local_bb1_var__u0;

assign local_bb1_var__u0 = (local_lvm_indvars_iv_NO_SHIFT_REG << 64'hA);

// Register node:
//  * latency = 176
//  * capacity = 176
 logic rnode_1to177_indvars_iv_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to177_indvars_iv_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to177_indvars_iv_0_NO_SHIFT_REG;
 logic rnode_1to177_indvars_iv_0_reg_177_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to177_indvars_iv_0_reg_177_NO_SHIFT_REG;
 logic rnode_1to177_indvars_iv_0_valid_out_reg_177_NO_SHIFT_REG;
 logic rnode_1to177_indvars_iv_0_stall_in_reg_177_NO_SHIFT_REG;
 logic rnode_1to177_indvars_iv_0_stall_out_reg_177_NO_SHIFT_REG;

acl_data_fifo rnode_1to177_indvars_iv_0_reg_177_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to177_indvars_iv_0_reg_177_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to177_indvars_iv_0_stall_in_reg_177_NO_SHIFT_REG),
	.valid_out(rnode_1to177_indvars_iv_0_valid_out_reg_177_NO_SHIFT_REG),
	.stall_out(rnode_1to177_indvars_iv_0_stall_out_reg_177_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv_NO_SHIFT_REG),
	.data_out(rnode_1to177_indvars_iv_0_reg_177_NO_SHIFT_REG)
);

defparam rnode_1to177_indvars_iv_0_reg_177_fifo.DEPTH = 177;
defparam rnode_1to177_indvars_iv_0_reg_177_fifo.DATA_WIDTH = 64;
defparam rnode_1to177_indvars_iv_0_reg_177_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to177_indvars_iv_0_reg_177_fifo.IMPL = "ram";

assign rnode_1to177_indvars_iv_0_reg_177_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to177_indvars_iv_0_stall_out_reg_177_NO_SHIFT_REG;
assign rnode_1to177_indvars_iv_0_NO_SHIFT_REG = rnode_1to177_indvars_iv_0_reg_177_NO_SHIFT_REG;
assign rnode_1to177_indvars_iv_0_stall_in_reg_177_NO_SHIFT_REG = rnode_1to177_indvars_iv_0_stall_in_NO_SHIFT_REG;
assign rnode_1to177_indvars_iv_0_valid_out_NO_SHIFT_REG = rnode_1to177_indvars_iv_0_valid_out_reg_177_NO_SHIFT_REG;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_sum_03_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_sum_03_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_sum_03_0_NO_SHIFT_REG;
 logic rnode_1to161_sum_03_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_sum_03_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_sum_03_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_sum_03_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_sum_03_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_sum_03_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_sum_03_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_sum_03_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_sum_03_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_sum_03_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_sum_03_NO_SHIFT_REG),
	.data_out(rnode_1to161_sum_03_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_sum_03_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_sum_03_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_1to161_sum_03_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_sum_03_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_sum_03_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to161_sum_03_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_sum_03_0_NO_SHIFT_REG = rnode_1to161_sum_03_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_sum_03_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_sum_03_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_sum_03_0_valid_out_NO_SHIFT_REG = rnode_1to161_sum_03_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 177
//  * capacity = 177
 logic rnode_1to178_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to178_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to178_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to178_input_acl_hw_wg_id_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to178_input_acl_hw_wg_id_0_reg_178_NO_SHIFT_REG;
 logic rnode_1to178_input_acl_hw_wg_id_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_1to178_input_acl_hw_wg_id_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_1to178_input_acl_hw_wg_id_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_1to178_input_acl_hw_wg_id_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to178_input_acl_hw_wg_id_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to178_input_acl_hw_wg_id_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_1to178_input_acl_hw_wg_id_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_1to178_input_acl_hw_wg_id_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to178_input_acl_hw_wg_id_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_1to178_input_acl_hw_wg_id_0_reg_178_fifo.DEPTH = 178;
defparam rnode_1to178_input_acl_hw_wg_id_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_1to178_input_acl_hw_wg_id_0_reg_178_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to178_input_acl_hw_wg_id_0_reg_178_fifo.IMPL = "ram";

assign rnode_1to178_input_acl_hw_wg_id_0_reg_178_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to178_input_acl_hw_wg_id_0_stall_out_reg_178_NO_SHIFT_REG;
assign rnode_1to178_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to178_input_acl_hw_wg_id_0_reg_178_NO_SHIFT_REG;
assign rnode_1to178_input_acl_hw_wg_id_0_stall_in_reg_178_NO_SHIFT_REG = rnode_1to178_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to178_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to178_input_acl_hw_wg_id_0_valid_out_reg_178_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_input_global_id_0_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_0_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_global_id_0_0_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_0_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_0_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_global_id_0_1_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_0_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_global_id_0_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_0_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_0_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_0_0_stall_out_reg_2_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_global_id_0_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_input_global_id_0_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_input_global_id_0_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_input_global_id_0_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_input_global_id_0_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_input_global_id_0_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_input_global_id_0_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_input_global_id_0_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_input_global_id_0_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_input_global_id_0_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_input_global_id_0_0_reg_2_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_1to2_input_global_id_0_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_input_global_id_0_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_input_global_id_0_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_input_global_id_0_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_input_global_id_0_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_input_global_id_0_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_input_global_id_0_NO_SHIFT_REG),
	.data_out(rnode_1to2_input_global_id_0_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_input_global_id_0_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_input_global_id_0_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_input_global_id_0_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_input_global_id_0_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_input_global_id_0_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to2_input_global_id_0_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_input_global_id_0_0_NO_SHIFT_REG = rnode_1to2_input_global_id_0_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_input_global_id_0_1_NO_SHIFT_REG = rnode_1to2_input_global_id_0_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_input_global_id_1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_1_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_global_id_1_0_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_1_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_global_id_1_1_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_1_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_global_id_1_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_1_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_1_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_global_id_1_0_stall_out_reg_2_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_global_id_1_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_input_global_id_1_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_input_global_id_1_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_input_global_id_1_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_input_global_id_1_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_input_global_id_1_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_input_global_id_1_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_input_global_id_1_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_input_global_id_1_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_input_global_id_1_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_input_global_id_1_0_reg_2_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_1to2_input_global_id_1_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_input_global_id_1_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_input_global_id_1_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_input_global_id_1_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_input_global_id_1_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_input_global_id_1_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_input_global_id_1_NO_SHIFT_REG),
	.data_out(rnode_1to2_input_global_id_1_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_input_global_id_1_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_input_global_id_1_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_input_global_id_1_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_input_global_id_1_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_input_global_id_1_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to2_input_global_id_1_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_input_global_id_1_0_NO_SHIFT_REG = rnode_1to2_input_global_id_1_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_input_global_id_1_1_NO_SHIFT_REG = rnode_1to2_input_global_id_1_0_reg_2_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u1_stall_local;
wire [63:0] local_bb1_var__u1;

assign local_bb1_var__u1[32] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[33] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[34] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[35] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[36] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[37] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[38] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[39] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[40] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[41] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[42] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[43] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[44] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[45] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[46] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[47] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[48] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[49] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[50] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[51] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[52] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[53] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[54] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[55] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[56] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[57] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[58] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[59] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[60] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[61] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[62] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[63] = local_bb1_mul_RM[31];
assign local_bb1_var__u1[31:0] = local_bb1_mul_RM;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u2_valid_out;
wire local_bb1_var__u2_stall_in;
wire local_bb1_var__u2_inputs_ready;
wire local_bb1_var__u2_stall_local;
wire [63:0] local_bb1_var__u2;

assign local_bb1_var__u2_inputs_ready = (merge_node_valid_out_1_NO_SHIFT_REG & merge_node_valid_out_2_NO_SHIFT_REG);
assign local_bb1_var__u2 = (local_bb1_var__u0 + local_bb1_var_);
assign local_bb1_var__u2_valid_out = local_bb1_var__u2_inputs_ready;
assign local_bb1_var__u2_stall_local = local_bb1_var__u2_stall_in;
assign merge_node_stall_in_1 = (local_bb1_var__u2_stall_local | ~(local_bb1_var__u2_inputs_ready));
assign merge_node_stall_in_2 = (local_bb1_var__u2_stall_local | ~(local_bb1_var__u2_inputs_ready));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_177to178_indvars_iv_0_valid_out_NO_SHIFT_REG;
 logic rnode_177to178_indvars_iv_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_177to178_indvars_iv_0_NO_SHIFT_REG;
 logic rnode_177to178_indvars_iv_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_177to178_indvars_iv_0_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_indvars_iv_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_indvars_iv_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_177to178_indvars_iv_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_177to178_indvars_iv_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_177to178_indvars_iv_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_177to178_indvars_iv_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_177to178_indvars_iv_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_177to178_indvars_iv_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(rnode_1to177_indvars_iv_0_NO_SHIFT_REG),
	.data_out(rnode_177to178_indvars_iv_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_177to178_indvars_iv_0_reg_178_fifo.DEPTH = 2;
defparam rnode_177to178_indvars_iv_0_reg_178_fifo.DATA_WIDTH = 64;
defparam rnode_177to178_indvars_iv_0_reg_178_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_177to178_indvars_iv_0_reg_178_fifo.IMPL = "ll_reg";

assign rnode_177to178_indvars_iv_0_reg_178_inputs_ready_NO_SHIFT_REG = rnode_1to177_indvars_iv_0_valid_out_NO_SHIFT_REG;
assign rnode_1to177_indvars_iv_0_stall_in_NO_SHIFT_REG = rnode_177to178_indvars_iv_0_stall_out_reg_178_NO_SHIFT_REG;
assign rnode_177to178_indvars_iv_0_NO_SHIFT_REG = rnode_177to178_indvars_iv_0_reg_178_NO_SHIFT_REG;
assign rnode_177to178_indvars_iv_0_stall_in_reg_178_NO_SHIFT_REG = rnode_177to178_indvars_iv_0_stall_in_NO_SHIFT_REG;
assign rnode_177to178_indvars_iv_0_valid_out_NO_SHIFT_REG = rnode_177to178_indvars_iv_0_valid_out_reg_178_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_sum_03_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_sum_03_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_sum_03_0_NO_SHIFT_REG;
 logic rnode_161to162_sum_03_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_sum_03_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_sum_03_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_sum_03_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_sum_03_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_sum_03_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_sum_03_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_sum_03_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_sum_03_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_sum_03_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_sum_03_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_sum_03_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_sum_03_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_sum_03_0_reg_162_fifo.DATA_WIDTH = 32;
defparam rnode_161to162_sum_03_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_sum_03_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_sum_03_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_sum_03_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_sum_03_0_stall_in_NO_SHIFT_REG = rnode_161to162_sum_03_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_sum_03_0_NO_SHIFT_REG = rnode_161to162_sum_03_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_sum_03_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_sum_03_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_sum_03_0_valid_out_NO_SHIFT_REG = rnode_161to162_sum_03_0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_178to179_input_acl_hw_wg_id_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_input_acl_hw_wg_id_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_input_acl_hw_wg_id_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_input_acl_hw_wg_id_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_input_acl_hw_wg_id_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_input_acl_hw_wg_id_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_input_acl_hw_wg_id_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_input_acl_hw_wg_id_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_input_acl_hw_wg_id_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_input_acl_hw_wg_id_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_1to178_input_acl_hw_wg_id_0_NO_SHIFT_REG),
	.data_out(rnode_178to179_input_acl_hw_wg_id_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_input_acl_hw_wg_id_0_reg_179_fifo.DEPTH = 2;
defparam rnode_178to179_input_acl_hw_wg_id_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_input_acl_hw_wg_id_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_178to179_input_acl_hw_wg_id_0_reg_179_fifo.IMPL = "ll_reg";

assign rnode_178to179_input_acl_hw_wg_id_0_reg_179_inputs_ready_NO_SHIFT_REG = rnode_1to178_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
assign rnode_1to178_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = rnode_178to179_input_acl_hw_wg_id_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_178to179_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_178to179_input_acl_hw_wg_id_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_input_acl_hw_wg_id_0_stall_in_reg_179_NO_SHIFT_REG = rnode_178to179_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_178to179_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_178to179_input_acl_hw_wg_id_0_valid_out_reg_179_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_notrhs_RM_stall_local;
wire local_bb1_notrhs_RM;

assign local_bb1_notrhs_RM = ($signed(rnode_1to2_input_global_id_0_0_NO_SHIFT_REG) > $signed(32'h3FF));

// Register node:
//  * latency = 176
//  * capacity = 176
 logic rnode_2to178_input_global_id_0_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_0_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_2to178_input_global_id_0_0_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_0_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_2to178_input_global_id_0_0_reg_178_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_0_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_0_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_0_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_2to178_input_global_id_0_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to178_input_global_id_0_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to178_input_global_id_0_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_2to178_input_global_id_0_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_2to178_input_global_id_0_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(rnode_1to2_input_global_id_0_1_NO_SHIFT_REG),
	.data_out(rnode_2to178_input_global_id_0_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_2to178_input_global_id_0_0_reg_178_fifo.DEPTH = 177;
defparam rnode_2to178_input_global_id_0_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_2to178_input_global_id_0_0_reg_178_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to178_input_global_id_0_0_reg_178_fifo.IMPL = "ram";

assign rnode_2to178_input_global_id_0_0_reg_178_inputs_ready_NO_SHIFT_REG = rnode_1to2_input_global_id_0_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_input_global_id_0_0_stall_in_1_NO_SHIFT_REG = rnode_2to178_input_global_id_0_0_stall_out_reg_178_NO_SHIFT_REG;
assign rnode_2to178_input_global_id_0_0_NO_SHIFT_REG = rnode_2to178_input_global_id_0_0_reg_178_NO_SHIFT_REG;
assign rnode_2to178_input_global_id_0_0_stall_in_reg_178_NO_SHIFT_REG = rnode_2to178_input_global_id_0_0_stall_in_NO_SHIFT_REG;
assign rnode_2to178_input_global_id_0_0_valid_out_NO_SHIFT_REG = rnode_2to178_input_global_id_0_0_valid_out_reg_178_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_notlhs_RM_stall_local;
wire local_bb1_notlhs_RM;

assign local_bb1_notlhs_RM = ($signed(rnode_1to2_input_global_id_1_0_NO_SHIFT_REG) > $signed(32'h3FF));

// Register node:
//  * latency = 176
//  * capacity = 176
 logic rnode_2to178_input_global_id_1_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_2to178_input_global_id_1_0_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_1_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_2to178_input_global_id_1_0_reg_178_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_1_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_1_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_2to178_input_global_id_1_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_2to178_input_global_id_1_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to178_input_global_id_1_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to178_input_global_id_1_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_2to178_input_global_id_1_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_2to178_input_global_id_1_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(rnode_1to2_input_global_id_1_1_NO_SHIFT_REG),
	.data_out(rnode_2to178_input_global_id_1_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_2to178_input_global_id_1_0_reg_178_fifo.DEPTH = 177;
defparam rnode_2to178_input_global_id_1_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_2to178_input_global_id_1_0_reg_178_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to178_input_global_id_1_0_reg_178_fifo.IMPL = "ram";

assign rnode_2to178_input_global_id_1_0_reg_178_inputs_ready_NO_SHIFT_REG = rnode_1to2_input_global_id_1_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_input_global_id_1_0_stall_in_1_NO_SHIFT_REG = rnode_2to178_input_global_id_1_0_stall_out_reg_178_NO_SHIFT_REG;
assign rnode_2to178_input_global_id_1_0_NO_SHIFT_REG = rnode_2to178_input_global_id_1_0_reg_178_NO_SHIFT_REG;
assign rnode_2to178_input_global_id_1_0_stall_in_reg_178_NO_SHIFT_REG = rnode_2to178_input_global_id_1_0_stall_in_NO_SHIFT_REG;
assign rnode_2to178_input_global_id_1_0_valid_out_NO_SHIFT_REG = rnode_2to178_input_global_id_1_0_valid_out_reg_178_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_mul_RM_valid_out_1;
wire local_bb1_mul_RM_stall_in_1;
 reg local_bb1_mul_RM_consumed_1_NO_SHIFT_REG;
wire local_bb1_var__u3_valid_out;
wire local_bb1_var__u3_stall_in;
 reg local_bb1_var__u3_consumed_0_NO_SHIFT_REG;
wire local_bb1_var__u3_inputs_ready;
wire local_bb1_var__u3_stall_local;
wire [63:0] local_bb1_var__u3;

assign local_bb1_var__u3_inputs_ready = (merge_node_valid_out_0_NO_SHIFT_REG & merge_node_valid_out_3_NO_SHIFT_REG);
assign local_bb1_var__u3 = (local_lvm_indvars_iv_NO_SHIFT_REG + local_bb1_var__u1);
assign local_bb1_var__u3_stall_local = ((local_bb1_mul_RM_stall_in_1 & ~(local_bb1_mul_RM_consumed_1_NO_SHIFT_REG)) | (local_bb1_var__u3_stall_in & ~(local_bb1_var__u3_consumed_0_NO_SHIFT_REG)));
assign local_bb1_mul_RM_valid_out_1 = (local_bb1_var__u3_inputs_ready & ~(local_bb1_mul_RM_consumed_1_NO_SHIFT_REG));
assign local_bb1_var__u3_valid_out = (local_bb1_var__u3_inputs_ready & ~(local_bb1_var__u3_consumed_0_NO_SHIFT_REG));
assign merge_node_stall_in_0 = (local_bb1_var__u3_stall_local | ~(local_bb1_var__u3_inputs_ready));
assign merge_node_stall_in_3 = (local_bb1_var__u3_stall_local | ~(local_bb1_var__u3_inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_RM_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_var__u3_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_mul_RM_consumed_1_NO_SHIFT_REG <= (local_bb1_var__u3_inputs_ready & (local_bb1_mul_RM_consumed_1_NO_SHIFT_REG | ~(local_bb1_mul_RM_stall_in_1)) & local_bb1_var__u3_stall_local);
		local_bb1_var__u3_consumed_0_NO_SHIFT_REG <= (local_bb1_var__u3_inputs_ready & (local_bb1_var__u3_consumed_0_NO_SHIFT_REG | ~(local_bb1_var__u3_stall_in)) & local_bb1_var__u3_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb1_var__u2_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u2_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_bb1_var__u2_0_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u2_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_bb1_var__u2_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u2_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u2_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u2_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb1_var__u2_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb1_var__u2_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb1_var__u2_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb1_var__u2_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb1_var__u2_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb1_var__u2),
	.data_out(rnode_1to2_bb1_var__u2_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb1_var__u2_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb1_var__u2_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_bb1_var__u2_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb1_var__u2_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb1_var__u2_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb1_var__u2_valid_out;
assign local_bb1_var__u2_stall_in = rnode_1to2_bb1_var__u2_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_var__u2_0_NO_SHIFT_REG = rnode_1to2_bb1_var__u2_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_var__u2_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_bb1_var__u2_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_bb1_var__u2_0_valid_out_NO_SHIFT_REG = rnode_1to2_bb1_var__u2_0_valid_out_reg_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_indvars_iv_next_valid_out;
wire local_bb1_indvars_iv_next_stall_in;
wire local_bb1_indvars_iv_next_inputs_ready;
wire local_bb1_indvars_iv_next_stall_local;
wire [63:0] local_bb1_indvars_iv_next;

assign local_bb1_indvars_iv_next_inputs_ready = rnode_177to178_indvars_iv_0_valid_out_NO_SHIFT_REG;
assign local_bb1_indvars_iv_next = (rnode_177to178_indvars_iv_0_NO_SHIFT_REG + 64'h1);
assign local_bb1_indvars_iv_next_valid_out = local_bb1_indvars_iv_next_inputs_ready;
assign local_bb1_indvars_iv_next_stall_local = local_bb1_indvars_iv_next_stall_in;
assign rnode_177to178_indvars_iv_0_stall_in_NO_SHIFT_REG = (|local_bb1_indvars_iv_next_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_input_global_id_0_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_0_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_input_global_id_0_0_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_0_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_input_global_id_0_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_0_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_0_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_0_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_input_global_id_0_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_input_global_id_0_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_input_global_id_0_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_input_global_id_0_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_input_global_id_0_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_2to178_input_global_id_0_0_NO_SHIFT_REG),
	.data_out(rnode_178to179_input_global_id_0_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_input_global_id_0_0_reg_179_fifo.DEPTH = 2;
defparam rnode_178to179_input_global_id_0_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_input_global_id_0_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_178to179_input_global_id_0_0_reg_179_fifo.IMPL = "ll_reg";

assign rnode_178to179_input_global_id_0_0_reg_179_inputs_ready_NO_SHIFT_REG = rnode_2to178_input_global_id_0_0_valid_out_NO_SHIFT_REG;
assign rnode_2to178_input_global_id_0_0_stall_in_NO_SHIFT_REG = rnode_178to179_input_global_id_0_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_178to179_input_global_id_0_0_NO_SHIFT_REG = rnode_178to179_input_global_id_0_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_input_global_id_0_0_stall_in_reg_179_NO_SHIFT_REG = rnode_178to179_input_global_id_0_0_stall_in_NO_SHIFT_REG;
assign rnode_178to179_input_global_id_0_0_valid_out_NO_SHIFT_REG = rnode_178to179_input_global_id_0_0_valid_out_reg_179_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_or_cond_NEG_RM_valid_out;
wire local_bb1_or_cond_NEG_RM_stall_in;
wire local_bb1_or_cond_NEG_RM_inputs_ready;
wire local_bb1_or_cond_NEG_RM_stall_local;
wire local_bb1_or_cond_NEG_RM;

assign local_bb1_or_cond_NEG_RM_inputs_ready = (rnode_1to2_input_global_id_0_0_valid_out_0_NO_SHIFT_REG & rnode_1to2_input_global_id_1_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_or_cond_NEG_RM = (local_bb1_notrhs_RM | local_bb1_notlhs_RM);
assign local_bb1_or_cond_NEG_RM_valid_out = local_bb1_or_cond_NEG_RM_inputs_ready;
assign local_bb1_or_cond_NEG_RM_stall_local = local_bb1_or_cond_NEG_RM_stall_in;
assign rnode_1to2_input_global_id_0_0_stall_in_0_NO_SHIFT_REG = (local_bb1_or_cond_NEG_RM_stall_local | ~(local_bb1_or_cond_NEG_RM_inputs_ready));
assign rnode_1to2_input_global_id_1_0_stall_in_0_NO_SHIFT_REG = (local_bb1_or_cond_NEG_RM_stall_local | ~(local_bb1_or_cond_NEG_RM_inputs_ready));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_input_global_id_1_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_input_global_id_1_0_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_1_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_input_global_id_1_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_1_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_1_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_input_global_id_1_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_input_global_id_1_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_input_global_id_1_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_input_global_id_1_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_input_global_id_1_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_input_global_id_1_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_2to178_input_global_id_1_0_NO_SHIFT_REG),
	.data_out(rnode_178to179_input_global_id_1_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_input_global_id_1_0_reg_179_fifo.DEPTH = 2;
defparam rnode_178to179_input_global_id_1_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_input_global_id_1_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_178to179_input_global_id_1_0_reg_179_fifo.IMPL = "ll_reg";

assign rnode_178to179_input_global_id_1_0_reg_179_inputs_ready_NO_SHIFT_REG = rnode_2to178_input_global_id_1_0_valid_out_NO_SHIFT_REG;
assign rnode_2to178_input_global_id_1_0_stall_in_NO_SHIFT_REG = rnode_178to179_input_global_id_1_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_178to179_input_global_id_1_0_NO_SHIFT_REG = rnode_178to179_input_global_id_1_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_input_global_id_1_0_stall_in_reg_179_NO_SHIFT_REG = rnode_178to179_input_global_id_1_0_stall_in_NO_SHIFT_REG;
assign rnode_178to179_input_global_id_1_0_valid_out_NO_SHIFT_REG = rnode_178to179_input_global_id_1_0_valid_out_reg_179_NO_SHIFT_REG;

// Register node:
//  * latency = 177
//  * capacity = 177
 logic rnode_1to178_bb1_mul_RM_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to178_bb1_mul_RM_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to178_bb1_mul_RM_0_NO_SHIFT_REG;
 logic rnode_1to178_bb1_mul_RM_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to178_bb1_mul_RM_0_reg_178_NO_SHIFT_REG;
 logic rnode_1to178_bb1_mul_RM_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_1to178_bb1_mul_RM_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_1to178_bb1_mul_RM_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_1to178_bb1_mul_RM_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to178_bb1_mul_RM_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to178_bb1_mul_RM_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_1to178_bb1_mul_RM_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_1to178_bb1_mul_RM_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(local_bb1_mul_RM),
	.data_out(rnode_1to178_bb1_mul_RM_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_1to178_bb1_mul_RM_0_reg_178_fifo.DEPTH = 178;
defparam rnode_1to178_bb1_mul_RM_0_reg_178_fifo.DATA_WIDTH = 32;
defparam rnode_1to178_bb1_mul_RM_0_reg_178_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to178_bb1_mul_RM_0_reg_178_fifo.IMPL = "ram";

assign rnode_1to178_bb1_mul_RM_0_reg_178_inputs_ready_NO_SHIFT_REG = local_bb1_mul_RM_valid_out_1;
assign local_bb1_mul_RM_stall_in_1 = rnode_1to178_bb1_mul_RM_0_stall_out_reg_178_NO_SHIFT_REG;
assign rnode_1to178_bb1_mul_RM_0_NO_SHIFT_REG = rnode_1to178_bb1_mul_RM_0_reg_178_NO_SHIFT_REG;
assign rnode_1to178_bb1_mul_RM_0_stall_in_reg_178_NO_SHIFT_REG = rnode_1to178_bb1_mul_RM_0_stall_in_NO_SHIFT_REG;
assign rnode_1to178_bb1_mul_RM_0_valid_out_NO_SHIFT_REG = rnode_1to178_bb1_mul_RM_0_valid_out_reg_178_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb1_var__u3_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u3_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_bb1_var__u3_0_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u3_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_bb1_var__u3_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u3_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u3_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb1_var__u3_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb1_var__u3_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb1_var__u3_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb1_var__u3_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb1_var__u3_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb1_var__u3_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb1_var__u3),
	.data_out(rnode_1to2_bb1_var__u3_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb1_var__u3_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb1_var__u3_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_bb1_var__u3_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb1_var__u3_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb1_var__u3_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb1_var__u3_valid_out;
assign local_bb1_var__u3_stall_in = rnode_1to2_bb1_var__u3_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_var__u3_0_NO_SHIFT_REG = rnode_1to2_bb1_var__u3_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb1_var__u3_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_bb1_var__u3_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_bb1_var__u3_0_valid_out_NO_SHIFT_REG = rnode_1to2_bb1_var__u3_0_valid_out_reg_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx11_valid_out;
wire local_bb1_arrayidx11_stall_in;
wire local_bb1_arrayidx11_inputs_ready;
wire local_bb1_arrayidx11_stall_local;
wire [63:0] local_bb1_arrayidx11;

assign local_bb1_arrayidx11_inputs_ready = rnode_1to2_bb1_var__u2_0_valid_out_NO_SHIFT_REG;
assign local_bb1_arrayidx11 = (input_B + (rnode_1to2_bb1_var__u2_0_NO_SHIFT_REG << 6'h2));
assign local_bb1_arrayidx11_valid_out = local_bb1_arrayidx11_inputs_ready;
assign local_bb1_arrayidx11_stall_local = local_bb1_arrayidx11_stall_in;
assign rnode_1to2_bb1_var__u2_0_stall_in_NO_SHIFT_REG = (|local_bb1_arrayidx11_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_indvars_iv_next_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_indvars_iv_next_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_178to179_bb1_indvars_iv_next_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_indvars_iv_next_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_indvars_iv_next_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_178to179_bb1_indvars_iv_next_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_indvars_iv_next_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_178to179_bb1_indvars_iv_next_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_indvars_iv_next_0_valid_out_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_indvars_iv_next_0_stall_in_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_indvars_iv_next_0_stall_out_reg_179_NO_SHIFT_REG;
 logic [63:0] rnode_178to179_bb1_indvars_iv_next_0_reg_179_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_178to179_bb1_indvars_iv_next_0_reg_179_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_178to179_bb1_indvars_iv_next_0_reg_179_NO_SHIFT_REG),
	.valid_in(rnode_178to179_bb1_indvars_iv_next_0_valid_out_0_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_indvars_iv_next_0_stall_in_0_reg_179_NO_SHIFT_REG),
	.data_out(rnode_178to179_bb1_indvars_iv_next_0_reg_179_NO_SHIFT_REG_fa),
	.valid_out({rnode_178to179_bb1_indvars_iv_next_0_valid_out_0_NO_SHIFT_REG, rnode_178to179_bb1_indvars_iv_next_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_178to179_bb1_indvars_iv_next_0_stall_in_0_NO_SHIFT_REG, rnode_178to179_bb1_indvars_iv_next_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_178to179_bb1_indvars_iv_next_0_reg_179_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_178to179_bb1_indvars_iv_next_0_reg_179_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_178to179_bb1_indvars_iv_next_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_indvars_iv_next_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_indvars_iv_next_0_stall_in_0_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_indvars_iv_next_0_valid_out_0_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_indvars_iv_next_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(local_bb1_indvars_iv_next),
	.data_out(rnode_178to179_bb1_indvars_iv_next_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_indvars_iv_next_0_reg_179_fifo.DEPTH = 2;
defparam rnode_178to179_bb1_indvars_iv_next_0_reg_179_fifo.DATA_WIDTH = 64;
defparam rnode_178to179_bb1_indvars_iv_next_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_178to179_bb1_indvars_iv_next_0_reg_179_fifo.IMPL = "ll_reg";

assign rnode_178to179_bb1_indvars_iv_next_0_reg_179_inputs_ready_NO_SHIFT_REG = local_bb1_indvars_iv_next_valid_out;
assign local_bb1_indvars_iv_next_stall_in = rnode_178to179_bb1_indvars_iv_next_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_indvars_iv_next_0_NO_SHIFT_REG = rnode_178to179_bb1_indvars_iv_next_0_reg_179_NO_SHIFT_REG_fa;
assign rnode_178to179_bb1_indvars_iv_next_1_NO_SHIFT_REG = rnode_178to179_bb1_indvars_iv_next_0_reg_179_NO_SHIFT_REG_fa;

// This section implements a staging register.
// 
wire rstag_2to2_bb1_or_cond_NEG_RM_valid_out_0;
wire rstag_2to2_bb1_or_cond_NEG_RM_stall_in_0;
 reg rstag_2to2_bb1_or_cond_NEG_RM_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb1_or_cond_NEG_RM_valid_out_1;
wire rstag_2to2_bb1_or_cond_NEG_RM_stall_in_1;
 reg rstag_2to2_bb1_or_cond_NEG_RM_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb1_or_cond_NEG_RM_valid_out_2;
wire rstag_2to2_bb1_or_cond_NEG_RM_stall_in_2;
 reg rstag_2to2_bb1_or_cond_NEG_RM_consumed_2_NO_SHIFT_REG;
wire rstag_2to2_bb1_or_cond_NEG_RM_inputs_ready;
wire rstag_2to2_bb1_or_cond_NEG_RM_stall_local;
 reg rstag_2to2_bb1_or_cond_NEG_RM_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_or_cond_NEG_RM_combined_valid;
 reg rstag_2to2_bb1_or_cond_NEG_RM_staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb1_or_cond_NEG_RM;

assign rstag_2to2_bb1_or_cond_NEG_RM_inputs_ready = local_bb1_or_cond_NEG_RM_valid_out;
assign rstag_2to2_bb1_or_cond_NEG_RM = (rstag_2to2_bb1_or_cond_NEG_RM_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_or_cond_NEG_RM_staging_reg_NO_SHIFT_REG : local_bb1_or_cond_NEG_RM);
assign rstag_2to2_bb1_or_cond_NEG_RM_combined_valid = (rstag_2to2_bb1_or_cond_NEG_RM_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_or_cond_NEG_RM_inputs_ready);
assign rstag_2to2_bb1_or_cond_NEG_RM_stall_local = ((rstag_2to2_bb1_or_cond_NEG_RM_stall_in_0 & ~(rstag_2to2_bb1_or_cond_NEG_RM_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb1_or_cond_NEG_RM_stall_in_1 & ~(rstag_2to2_bb1_or_cond_NEG_RM_consumed_1_NO_SHIFT_REG)) | (rstag_2to2_bb1_or_cond_NEG_RM_stall_in_2 & ~(rstag_2to2_bb1_or_cond_NEG_RM_consumed_2_NO_SHIFT_REG)));
assign rstag_2to2_bb1_or_cond_NEG_RM_valid_out_0 = (rstag_2to2_bb1_or_cond_NEG_RM_combined_valid & ~(rstag_2to2_bb1_or_cond_NEG_RM_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_or_cond_NEG_RM_valid_out_1 = (rstag_2to2_bb1_or_cond_NEG_RM_combined_valid & ~(rstag_2to2_bb1_or_cond_NEG_RM_consumed_1_NO_SHIFT_REG));
assign rstag_2to2_bb1_or_cond_NEG_RM_valid_out_2 = (rstag_2to2_bb1_or_cond_NEG_RM_combined_valid & ~(rstag_2to2_bb1_or_cond_NEG_RM_consumed_2_NO_SHIFT_REG));
assign local_bb1_or_cond_NEG_RM_stall_in = (|rstag_2to2_bb1_or_cond_NEG_RM_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_or_cond_NEG_RM_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_or_cond_NEG_RM_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_or_cond_NEG_RM_stall_local)
		begin
			if (~(rstag_2to2_bb1_or_cond_NEG_RM_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_or_cond_NEG_RM_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_or_cond_NEG_RM_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_or_cond_NEG_RM_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_or_cond_NEG_RM_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_or_cond_NEG_RM_staging_reg_NO_SHIFT_REG <= local_bb1_or_cond_NEG_RM;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_or_cond_NEG_RM_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_or_cond_NEG_RM_consumed_1_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_or_cond_NEG_RM_consumed_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb1_or_cond_NEG_RM_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb1_or_cond_NEG_RM_combined_valid & (rstag_2to2_bb1_or_cond_NEG_RM_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb1_or_cond_NEG_RM_stall_in_0)) & rstag_2to2_bb1_or_cond_NEG_RM_stall_local);
		rstag_2to2_bb1_or_cond_NEG_RM_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb1_or_cond_NEG_RM_combined_valid & (rstag_2to2_bb1_or_cond_NEG_RM_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb1_or_cond_NEG_RM_stall_in_1)) & rstag_2to2_bb1_or_cond_NEG_RM_stall_local);
		rstag_2to2_bb1_or_cond_NEG_RM_consumed_2_NO_SHIFT_REG <= (rstag_2to2_bb1_or_cond_NEG_RM_combined_valid & (rstag_2to2_bb1_or_cond_NEG_RM_consumed_2_NO_SHIFT_REG | ~(rstag_2to2_bb1_or_cond_NEG_RM_stall_in_2)) & rstag_2to2_bb1_or_cond_NEG_RM_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_mul_RM_0_valid_out_NO_SHIFT_REG;
 logic rnode_178to179_bb1_mul_RM_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_mul_RM_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_mul_RM_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_178to179_bb1_mul_RM_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_mul_RM_0_valid_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_mul_RM_0_stall_in_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_mul_RM_0_stall_out_reg_179_NO_SHIFT_REG;

acl_data_fifo rnode_178to179_bb1_mul_RM_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_mul_RM_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_mul_RM_0_stall_in_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_mul_RM_0_valid_out_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_mul_RM_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_1to178_bb1_mul_RM_0_NO_SHIFT_REG),
	.data_out(rnode_178to179_bb1_mul_RM_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_mul_RM_0_reg_179_fifo.DEPTH = 2;
defparam rnode_178to179_bb1_mul_RM_0_reg_179_fifo.DATA_WIDTH = 32;
defparam rnode_178to179_bb1_mul_RM_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_178to179_bb1_mul_RM_0_reg_179_fifo.IMPL = "ll_reg";

assign rnode_178to179_bb1_mul_RM_0_reg_179_inputs_ready_NO_SHIFT_REG = rnode_1to178_bb1_mul_RM_0_valid_out_NO_SHIFT_REG;
assign rnode_1to178_bb1_mul_RM_0_stall_in_NO_SHIFT_REG = rnode_178to179_bb1_mul_RM_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_mul_RM_0_NO_SHIFT_REG = rnode_178to179_bb1_mul_RM_0_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_mul_RM_0_stall_in_reg_179_NO_SHIFT_REG = rnode_178to179_bb1_mul_RM_0_stall_in_NO_SHIFT_REG;
assign rnode_178to179_bb1_mul_RM_0_valid_out_NO_SHIFT_REG = rnode_178to179_bb1_mul_RM_0_valid_out_reg_179_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx_valid_out;
wire local_bb1_arrayidx_stall_in;
wire local_bb1_arrayidx_inputs_ready;
wire local_bb1_arrayidx_stall_local;
wire [63:0] local_bb1_arrayidx;

assign local_bb1_arrayidx_inputs_ready = rnode_1to2_bb1_var__u3_0_valid_out_NO_SHIFT_REG;
assign local_bb1_arrayidx = (input_A + (rnode_1to2_bb1_var__u3_0_NO_SHIFT_REG << 6'h2));
assign local_bb1_arrayidx_valid_out = local_bb1_arrayidx_inputs_ready;
assign local_bb1_arrayidx_stall_local = local_bb1_arrayidx_stall_in;
assign rnode_1to2_bb1_var__u3_0_stall_in_NO_SHIFT_REG = (|local_bb1_arrayidx_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_lftr_wideiv_stall_local;
wire [31:0] local_bb1_lftr_wideiv;

assign local_bb1_lftr_wideiv = rnode_178to179_bb1_indvars_iv_next_0_NO_SHIFT_REG[31:0];

// Register node:
//  * latency = 176
//  * capacity = 176
 logic rnode_2to178_bb1_or_cond_NEG_RM_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to178_bb1_or_cond_NEG_RM_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to178_bb1_or_cond_NEG_RM_0_NO_SHIFT_REG;
 logic rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_NO_SHIFT_REG;
 logic rnode_2to178_bb1_or_cond_NEG_RM_0_valid_out_reg_178_NO_SHIFT_REG;
 logic rnode_2to178_bb1_or_cond_NEG_RM_0_stall_in_reg_178_NO_SHIFT_REG;
 logic rnode_2to178_bb1_or_cond_NEG_RM_0_stall_out_reg_178_NO_SHIFT_REG;

acl_data_fifo rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to178_bb1_or_cond_NEG_RM_0_stall_in_reg_178_NO_SHIFT_REG),
	.valid_out(rnode_2to178_bb1_or_cond_NEG_RM_0_valid_out_reg_178_NO_SHIFT_REG),
	.stall_out(rnode_2to178_bb1_or_cond_NEG_RM_0_stall_out_reg_178_NO_SHIFT_REG),
	.data_in(rstag_2to2_bb1_or_cond_NEG_RM),
	.data_out(rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_NO_SHIFT_REG)
);

defparam rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_fifo.DEPTH = 177;
defparam rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_fifo.DATA_WIDTH = 1;
defparam rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_fifo.IMPL = "ram";

assign rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_inputs_ready_NO_SHIFT_REG = rstag_2to2_bb1_or_cond_NEG_RM_valid_out_0;
assign rstag_2to2_bb1_or_cond_NEG_RM_stall_in_0 = rnode_2to178_bb1_or_cond_NEG_RM_0_stall_out_reg_178_NO_SHIFT_REG;
assign rnode_2to178_bb1_or_cond_NEG_RM_0_NO_SHIFT_REG = rnode_2to178_bb1_or_cond_NEG_RM_0_reg_178_NO_SHIFT_REG;
assign rnode_2to178_bb1_or_cond_NEG_RM_0_stall_in_reg_178_NO_SHIFT_REG = rnode_2to178_bb1_or_cond_NEG_RM_0_stall_in_NO_SHIFT_REG;
assign rnode_2to178_bb1_or_cond_NEG_RM_0_valid_out_NO_SHIFT_REG = rnode_2to178_bb1_or_cond_NEG_RM_0_valid_out_reg_178_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_ld__inputs_ready;
 reg local_bb1_ld__valid_out_NO_SHIFT_REG;
wire local_bb1_ld__stall_in;
wire local_bb1_ld__output_regs_ready;
wire local_bb1_ld__fu_stall_out;
wire local_bb1_ld__fu_valid_out;
wire [31:0] local_bb1_ld__lsu_dataout;
 reg [31:0] local_bb1_ld__NO_SHIFT_REG;
wire local_bb1_ld__causedstall;

lsu_top lsu_local_bb1_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_ld__fu_stall_out),
	.i_valid(local_bb1_ld__inputs_ready),
	.i_address(local_bb1_arrayidx11),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_2to2_bb1_or_cond_NEG_RM),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_ld__output_regs_ready)),
	.o_valid(local_bb1_ld__fu_valid_out),
	.o_readdata(local_bb1_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_ld__active),
	.avm_address(avm_local_bb1_ld__address),
	.avm_read(avm_local_bb1_ld__read),
	.avm_readdata(avm_local_bb1_ld__readdata),
	.avm_write(avm_local_bb1_ld__write),
	.avm_writeack(avm_local_bb1_ld__writeack),
	.avm_burstcount(avm_local_bb1_ld__burstcount),
	.avm_writedata(avm_local_bb1_ld__writedata),
	.avm_byteenable(avm_local_bb1_ld__byteenable),
	.avm_waitrequest(avm_local_bb1_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb1_ld__readdatavalid),
	.profile_bw(profile_lsu_local_bb1_ld__profile_bw_cntl),
	.profile_bw_incr(profile_lsu_local_bb1_ld__profile_bw_incr),
	.profile_total_ivalid(profile_lsu_local_bb1_ld__profile_total_ivalid_cntl),
	.profile_total_req(profile_lsu_local_bb1_ld__profile_total_req_cntl),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(profile_lsu_local_bb1_ld__profile_avm_readwrite_count_cntl),
	.profile_avm_burstcount_total(profile_lsu_local_bb1_ld__profile_avm_burstcount_total_cntl),
	.profile_avm_burstcount_total_incr(profile_lsu_local_bb1_ld__profile_avm_burstcount_total_incr),
	.profile_req_cache_hit_count(profile_lsu_local_bb1_ld__profile_req_cache_hit_count_cntl),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall(profile_lsu_local_bb1_ld__profile_avm_stall_cntl)
);

defparam lsu_local_bb1_ld_.AWIDTH = 30;
defparam lsu_local_bb1_ld_.WIDTH_BYTES = 4;
defparam lsu_local_bb1_ld_.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb1_ld_.READ = 1;
defparam lsu_local_bb1_ld_.ATOMIC = 0;
defparam lsu_local_bb1_ld_.WIDTH = 32;
defparam lsu_local_bb1_ld_.MWIDTH = 256;
defparam lsu_local_bb1_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb1_ld_.MEMORY_SIDE_MEM_LATENCY = 89;
defparam lsu_local_bb1_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb1_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb1_ld_.USECACHING = 1;
defparam lsu_local_bb1_ld_.CACHESIZE = 256;
defparam lsu_local_bb1_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb1_ld_.ACL_PROFILE = 1;
defparam lsu_local_bb1_ld_.ACL_PROFILE_INCREMENT_WIDTH = 32;
defparam lsu_local_bb1_ld_.ADDRSPACE = 1;
defparam lsu_local_bb1_ld_.STYLE = "BURST-COALESCED";

assign local_bb1_ld__inputs_ready = (local_bb1_arrayidx11_valid_out & rstag_2to2_bb1_or_cond_NEG_RM_valid_out_2);
assign local_bb1_ld__output_regs_ready = (&(~(local_bb1_ld__valid_out_NO_SHIFT_REG) | ~(local_bb1_ld__stall_in)));
assign local_bb1_arrayidx11_stall_in = (local_bb1_ld__fu_stall_out | ~(local_bb1_ld__inputs_ready));
assign rstag_2to2_bb1_or_cond_NEG_RM_stall_in_2 = (local_bb1_ld__fu_stall_out | ~(local_bb1_ld__inputs_ready));
assign local_bb1_ld__causedstall = (local_bb1_ld__inputs_ready && (local_bb1_ld__fu_stall_out && !(~(local_bb1_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_ld__NO_SHIFT_REG <= 'x;
		local_bb1_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_ld__output_regs_ready)
		begin
			local_bb1_ld__NO_SHIFT_REG <= local_bb1_ld__lsu_dataout;
			local_bb1_ld__valid_out_NO_SHIFT_REG <= local_bb1_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_ld__stall_in))
			begin
				local_bb1_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_ld__u4_inputs_ready;
 reg local_bb1_ld__u4_valid_out_NO_SHIFT_REG;
wire local_bb1_ld__u4_stall_in;
wire local_bb1_ld__u4_output_regs_ready;
wire local_bb1_ld__u4_fu_stall_out;
wire local_bb1_ld__u4_fu_valid_out;
wire [31:0] local_bb1_ld__u4_lsu_dataout;
 reg [31:0] local_bb1_ld__u4_NO_SHIFT_REG;
wire local_bb1_ld__u4_causedstall;

lsu_top lsu_local_bb1_ld__u4 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_ld__u4_fu_stall_out),
	.i_valid(local_bb1_ld__u4_inputs_ready),
	.i_address(local_bb1_arrayidx),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_2to2_bb1_or_cond_NEG_RM),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_ld__u4_output_regs_ready)),
	.o_valid(local_bb1_ld__u4_fu_valid_out),
	.o_readdata(local_bb1_ld__u4_lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_ld__u4_active),
	.avm_address(avm_local_bb1_ld__u4_address),
	.avm_read(avm_local_bb1_ld__u4_read),
	.avm_readdata(avm_local_bb1_ld__u4_readdata),
	.avm_write(avm_local_bb1_ld__u4_write),
	.avm_writeack(avm_local_bb1_ld__u4_writeack),
	.avm_burstcount(avm_local_bb1_ld__u4_burstcount),
	.avm_writedata(avm_local_bb1_ld__u4_writedata),
	.avm_byteenable(avm_local_bb1_ld__u4_byteenable),
	.avm_waitrequest(avm_local_bb1_ld__u4_waitrequest),
	.avm_readdatavalid(avm_local_bb1_ld__u4_readdatavalid),
	.profile_bw(profile_lsu_local_bb1_ld__u4_profile_bw_cntl),
	.profile_bw_incr(profile_lsu_local_bb1_ld__u4_profile_bw_incr),
	.profile_total_ivalid(profile_lsu_local_bb1_ld__u4_profile_total_ivalid_cntl),
	.profile_total_req(profile_lsu_local_bb1_ld__u4_profile_total_req_cntl),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(profile_lsu_local_bb1_ld__u4_profile_avm_readwrite_count_cntl),
	.profile_avm_burstcount_total(profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_cntl),
	.profile_avm_burstcount_total_incr(profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_incr),
	.profile_req_cache_hit_count(profile_lsu_local_bb1_ld__u4_profile_req_cache_hit_count_cntl),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall(profile_lsu_local_bb1_ld__u4_profile_avm_stall_cntl)
);

defparam lsu_local_bb1_ld__u4.AWIDTH = 30;
defparam lsu_local_bb1_ld__u4.WIDTH_BYTES = 4;
defparam lsu_local_bb1_ld__u4.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld__u4.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld__u4.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb1_ld__u4.READ = 1;
defparam lsu_local_bb1_ld__u4.ATOMIC = 0;
defparam lsu_local_bb1_ld__u4.WIDTH = 32;
defparam lsu_local_bb1_ld__u4.MWIDTH = 256;
defparam lsu_local_bb1_ld__u4.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_ld__u4.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_ld__u4.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb1_ld__u4.MEMORY_SIDE_MEM_LATENCY = 89;
defparam lsu_local_bb1_ld__u4.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_ld__u4.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_ld__u4.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_ld__u4.NUMBER_BANKS = 1;
defparam lsu_local_bb1_ld__u4.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_ld__u4.USEINPUTFIFO = 0;
defparam lsu_local_bb1_ld__u4.USECACHING = 1;
defparam lsu_local_bb1_ld__u4.CACHESIZE = 256;
defparam lsu_local_bb1_ld__u4.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_ld__u4.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_ld__u4.HIGH_FMAX = 1;
defparam lsu_local_bb1_ld__u4.ACL_PROFILE = 1;
defparam lsu_local_bb1_ld__u4.ACL_PROFILE_INCREMENT_WIDTH = 32;
defparam lsu_local_bb1_ld__u4.ADDRSPACE = 1;
defparam lsu_local_bb1_ld__u4.STYLE = "BURST-COALESCED";

assign local_bb1_ld__u4_inputs_ready = (local_bb1_arrayidx_valid_out & rstag_2to2_bb1_or_cond_NEG_RM_valid_out_1);
assign local_bb1_ld__u4_output_regs_ready = (&(~(local_bb1_ld__u4_valid_out_NO_SHIFT_REG) | ~(local_bb1_ld__u4_stall_in)));
assign local_bb1_arrayidx_stall_in = (local_bb1_ld__u4_fu_stall_out | ~(local_bb1_ld__u4_inputs_ready));
assign rstag_2to2_bb1_or_cond_NEG_RM_stall_in_1 = (local_bb1_ld__u4_fu_stall_out | ~(local_bb1_ld__u4_inputs_ready));
assign local_bb1_ld__u4_causedstall = (local_bb1_ld__u4_inputs_ready && (local_bb1_ld__u4_fu_stall_out && !(~(local_bb1_ld__u4_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_ld__u4_NO_SHIFT_REG <= 'x;
		local_bb1_ld__u4_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_ld__u4_output_regs_ready)
		begin
			local_bb1_ld__u4_NO_SHIFT_REG <= local_bb1_ld__u4_lsu_dataout;
			local_bb1_ld__u4_valid_out_NO_SHIFT_REG <= local_bb1_ld__u4_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_ld__u4_stall_in))
			begin
				local_bb1_ld__u4_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_exitcond_stall_local;
wire local_bb1_exitcond;

assign local_bb1_exitcond = (local_bb1_lftr_wideiv == 32'h400);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_1_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_inputs_ready_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_valid_out_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_stall_in_0_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_stall_out_reg_179_NO_SHIFT_REG;
 logic rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_NO_SHIFT_REG),
	.valid_in(rnode_178to179_bb1_or_cond_NEG_RM_0_valid_out_0_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_or_cond_NEG_RM_0_stall_in_0_reg_179_NO_SHIFT_REG),
	.data_out(rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_NO_SHIFT_REG_fa),
	.valid_out({rnode_178to179_bb1_or_cond_NEG_RM_0_valid_out_0_NO_SHIFT_REG, rnode_178to179_bb1_or_cond_NEG_RM_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_178to179_bb1_or_cond_NEG_RM_0_stall_in_0_NO_SHIFT_REG, rnode_178to179_bb1_or_cond_NEG_RM_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_178to179_bb1_or_cond_NEG_RM_0_stall_in_0_reg_179_NO_SHIFT_REG),
	.valid_out(rnode_178to179_bb1_or_cond_NEG_RM_0_valid_out_0_reg_179_NO_SHIFT_REG),
	.stall_out(rnode_178to179_bb1_or_cond_NEG_RM_0_stall_out_reg_179_NO_SHIFT_REG),
	.data_in(rnode_2to178_bb1_or_cond_NEG_RM_0_NO_SHIFT_REG),
	.data_out(rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_NO_SHIFT_REG)
);

defparam rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_fifo.DEPTH = 2;
defparam rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_fifo.DATA_WIDTH = 1;
defparam rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_fifo.IMPL = "ll_reg";

assign rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_inputs_ready_NO_SHIFT_REG = rnode_2to178_bb1_or_cond_NEG_RM_0_valid_out_NO_SHIFT_REG;
assign rnode_2to178_bb1_or_cond_NEG_RM_0_stall_in_NO_SHIFT_REG = rnode_178to179_bb1_or_cond_NEG_RM_0_stall_out_reg_179_NO_SHIFT_REG;
assign rnode_178to179_bb1_or_cond_NEG_RM_0_NO_SHIFT_REG = rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_NO_SHIFT_REG_fa;
assign rnode_178to179_bb1_or_cond_NEG_RM_1_NO_SHIFT_REG = rnode_178to179_bb1_or_cond_NEG_RM_0_reg_179_NO_SHIFT_REG_fa;

// This section implements a staging register.
// 
wire rstag_162to162_bb1_ld__valid_out;
wire rstag_162to162_bb1_ld__stall_in;
wire rstag_162to162_bb1_ld__inputs_ready;
wire rstag_162to162_bb1_ld__stall_local;
 reg rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG;
wire rstag_162to162_bb1_ld__combined_valid;
 reg [31:0] rstag_162to162_bb1_ld__staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_162to162_bb1_ld_;

assign rstag_162to162_bb1_ld__inputs_ready = local_bb1_ld__valid_out_NO_SHIFT_REG;
assign rstag_162to162_bb1_ld_ = (rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG ? rstag_162to162_bb1_ld__staging_reg_NO_SHIFT_REG : local_bb1_ld__NO_SHIFT_REG);
assign rstag_162to162_bb1_ld__combined_valid = (rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG | rstag_162to162_bb1_ld__inputs_ready);
assign rstag_162to162_bb1_ld__valid_out = rstag_162to162_bb1_ld__combined_valid;
assign rstag_162to162_bb1_ld__stall_local = rstag_162to162_bb1_ld__stall_in;
assign local_bb1_ld__stall_in = (|rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb1_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_162to162_bb1_ld__stall_local)
		begin
			if (~(rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG <= rstag_162to162_bb1_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_162to162_bb1_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_162to162_bb1_ld__staging_reg_NO_SHIFT_REG <= local_bb1_ld__NO_SHIFT_REG;
		end
	end
end


// This section implements a staging register.
// 
wire rstag_162to162_bb1_ld__u4_valid_out;
wire rstag_162to162_bb1_ld__u4_stall_in;
wire rstag_162to162_bb1_ld__u4_inputs_ready;
wire rstag_162to162_bb1_ld__u4_stall_local;
 reg rstag_162to162_bb1_ld__u4_staging_valid_NO_SHIFT_REG;
wire rstag_162to162_bb1_ld__u4_combined_valid;
 reg [31:0] rstag_162to162_bb1_ld__u4_staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_162to162_bb1_ld__u4;

assign rstag_162to162_bb1_ld__u4_inputs_ready = local_bb1_ld__u4_valid_out_NO_SHIFT_REG;
assign rstag_162to162_bb1_ld__u4 = (rstag_162to162_bb1_ld__u4_staging_valid_NO_SHIFT_REG ? rstag_162to162_bb1_ld__u4_staging_reg_NO_SHIFT_REG : local_bb1_ld__u4_NO_SHIFT_REG);
assign rstag_162to162_bb1_ld__u4_combined_valid = (rstag_162to162_bb1_ld__u4_staging_valid_NO_SHIFT_REG | rstag_162to162_bb1_ld__u4_inputs_ready);
assign rstag_162to162_bb1_ld__u4_valid_out = rstag_162to162_bb1_ld__u4_combined_valid;
assign rstag_162to162_bb1_ld__u4_stall_local = rstag_162to162_bb1_ld__u4_stall_in;
assign local_bb1_ld__u4_stall_in = (|rstag_162to162_bb1_ld__u4_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb1_ld__u4_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb1_ld__u4_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_162to162_bb1_ld__u4_stall_local)
		begin
			if (~(rstag_162to162_bb1_ld__u4_staging_valid_NO_SHIFT_REG))
			begin
				rstag_162to162_bb1_ld__u4_staging_valid_NO_SHIFT_REG <= rstag_162to162_bb1_ld__u4_inputs_ready;
			end
		end
		else
		begin
			rstag_162to162_bb1_ld__u4_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_162to162_bb1_ld__u4_staging_valid_NO_SHIFT_REG))
		begin
			rstag_162to162_bb1_ld__u4_staging_reg_NO_SHIFT_REG <= local_bb1_ld__u4_NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_exitcond_GUARD_valid_out;
wire local_bb1_exitcond_GUARD_stall_in;
wire local_bb1_exitcond_GUARD_inputs_ready;
wire local_bb1_exitcond_GUARD_stall_local;
wire local_bb1_exitcond_GUARD;

assign local_bb1_exitcond_GUARD_inputs_ready = (rnode_178to179_bb1_indvars_iv_next_0_valid_out_0_NO_SHIFT_REG & rnode_178to179_bb1_or_cond_NEG_RM_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_exitcond_GUARD = (local_bb1_exitcond | rnode_178to179_bb1_or_cond_NEG_RM_0_NO_SHIFT_REG);
assign local_bb1_exitcond_GUARD_valid_out = local_bb1_exitcond_GUARD_inputs_ready;
assign local_bb1_exitcond_GUARD_stall_local = local_bb1_exitcond_GUARD_stall_in;
assign rnode_178to179_bb1_indvars_iv_next_0_stall_in_0_NO_SHIFT_REG = (local_bb1_exitcond_GUARD_stall_local | ~(local_bb1_exitcond_GUARD_inputs_ready));
assign rnode_178to179_bb1_or_cond_NEG_RM_0_stall_in_0_NO_SHIFT_REG = (local_bb1_exitcond_GUARD_stall_local | ~(local_bb1_exitcond_GUARD_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni1_stall_local;
wire [127:0] local_bb1_c0_eni1;

assign local_bb1_c0_eni1[31:0] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
assign local_bb1_c0_eni1[63:32] = rstag_162to162_bb1_ld__u4;
assign local_bb1_c0_eni1[127:64] = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni2_stall_local;
wire [127:0] local_bb1_c0_eni2;

assign local_bb1_c0_eni2[63:0] = local_bb1_c0_eni1[63:0];
assign local_bb1_c0_eni2[95:64] = rstag_162to162_bb1_ld_;
assign local_bb1_c0_eni2[127:96] = local_bb1_c0_eni1[127:96];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni3_valid_out;
wire local_bb1_c0_eni3_stall_in;
wire local_bb1_c0_eni3_inputs_ready;
wire local_bb1_c0_eni3_stall_local;
wire [127:0] local_bb1_c0_eni3;

assign local_bb1_c0_eni3_inputs_ready = (rnode_161to162_sum_03_0_valid_out_NO_SHIFT_REG & rstag_162to162_bb1_ld__u4_valid_out & rstag_162to162_bb1_ld__valid_out);
assign local_bb1_c0_eni3[95:0] = local_bb1_c0_eni2[95:0];
assign local_bb1_c0_eni3[127:96] = rnode_161to162_sum_03_0_NO_SHIFT_REG;
assign local_bb1_c0_eni3_valid_out = local_bb1_c0_eni3_inputs_ready;
assign local_bb1_c0_eni3_stall_local = local_bb1_c0_eni3_stall_in;
assign rnode_161to162_sum_03_0_stall_in_NO_SHIFT_REG = (local_bb1_c0_eni3_stall_local | ~(local_bb1_c0_eni3_inputs_ready));
assign rstag_162to162_bb1_ld__u4_stall_in = (local_bb1_c0_eni3_stall_local | ~(local_bb1_c0_eni3_inputs_ready));
assign rstag_162to162_bb1_ld__stall_in = (local_bb1_c0_eni3_stall_local | ~(local_bb1_c0_eni3_inputs_ready));

// This section implements a registered operation.
// 
wire local_bb1_c0_enter_c0_eni3_inputs_ready;
 reg local_bb1_c0_enter_c0_eni3_valid_out_0_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni3_stall_in_0;
 reg local_bb1_c0_enter_c0_eni3_valid_out_1_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni3_stall_in_1;
 reg local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni3_stall_in_2;
wire local_bb1_c0_enter_c0_eni3_output_regs_ready;
 reg [127:0] local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni3_input_accepted;
wire local_bb1_c0_exit_c0_exi1_entry_stall;
wire local_bb1_c0_exit_c0_exi1_output_regs_ready;
wire [12:0] local_bb1_c0_exit_c0_exi1_valid_bits;
wire local_bb1_c0_exit_c0_exi1_phases;
wire local_bb1_c0_enter_c0_eni3_inc_pipelined_thread;
wire local_bb1_c0_enter_c0_eni3_dec_pipelined_thread;
wire local_bb1_c0_enter_c0_eni3_causedstall;

assign local_bb1_c0_enter_c0_eni3_inputs_ready = local_bb1_c0_eni3_valid_out;
assign local_bb1_c0_enter_c0_eni3_output_regs_ready = 1'b1;
assign local_bb1_c0_enter_c0_eni3_input_accepted = (local_bb1_c0_enter_c0_eni3_inputs_ready && !(local_bb1_c0_exit_c0_exi1_entry_stall));
assign local_bb1_c0_enter_c0_eni3_inc_pipelined_thread = 1'b1;
assign local_bb1_c0_enter_c0_eni3_dec_pipelined_thread = ~(1'b0);
assign local_bb1_c0_eni3_stall_in = ((~(local_bb1_c0_enter_c0_eni3_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) | ~(1'b1));
assign local_bb1_c0_enter_c0_eni3_causedstall = (1'b1 && ((~(local_bb1_c0_enter_c0_eni3_inputs_ready) | local_bb1_c0_exit_c0_exi1_entry_stall) && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG <= 'x;
		local_bb1_c0_enter_c0_eni3_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_enter_c0_eni3_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_enter_c0_eni3_output_regs_ready)
		begin
			local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG <= local_bb1_c0_eni3;
			local_bb1_c0_enter_c0_eni3_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_enter_c0_eni3_valid_out_1_NO_SHIFT_REG <= 1'b1;
			local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_c0_enter_c0_eni3_stall_in_0))
			begin
				local_bb1_c0_enter_c0_eni3_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_enter_c0_eni3_stall_in_1))
			begin
				local_bb1_c0_enter_c0_eni3_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_enter_c0_eni3_stall_in_2))
			begin
				local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene1_stall_local;
wire [31:0] local_bb1_c0_ene1;

assign local_bb1_c0_ene1 = local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG[63:32];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene2_stall_local;
wire [31:0] local_bb1_c0_ene2;

assign local_bb1_c0_ene2 = local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG[95:64];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene3_valid_out;
wire local_bb1_c0_ene3_stall_in;
wire local_bb1_c0_ene3_inputs_ready;
wire local_bb1_c0_ene3_stall_local;
wire [31:0] local_bb1_c0_ene3;

assign local_bb1_c0_ene3_inputs_ready = local_bb1_c0_enter_c0_eni3_valid_out_2_NO_SHIFT_REG;
assign local_bb1_c0_ene3 = local_bb1_c0_enter_c0_eni3_NO_SHIFT_REG[127:96];
assign local_bb1_c0_ene3_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni3_stall_in_2 = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u5_stall_local;
wire [31:0] local_bb1_var__u5;

assign local_bb1_var__u5 = local_bb1_c0_ene1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u6_stall_local;
wire [31:0] local_bb1_var__u6;

assign local_bb1_var__u6 = local_bb1_c0_ene2;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_bb1_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_bb1_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_bb1_c0_ene3_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_c0_ene3_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_163to164_bb1_c0_ene3_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb1_c0_ene3_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb1_c0_ene3_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb1_c0_ene3_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb1_c0_ene3_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb1_c0_ene3),
	.data_out(rnode_163to164_bb1_c0_ene3_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb1_c0_ene3_0_reg_164_fifo.DEPTH = 1;
defparam rnode_163to164_bb1_c0_ene3_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_163to164_bb1_c0_ene3_0_reg_164_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_163to164_bb1_c0_ene3_0_reg_164_fifo.IMPL = "shift_reg";

assign rnode_163to164_bb1_c0_ene3_0_reg_164_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_c0_ene3_stall_in = 1'b0;
assign rnode_163to164_bb1_c0_ene3_0_NO_SHIFT_REG = rnode_163to164_bb1_c0_ene3_0_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb1_c0_ene3_0_stall_in_reg_164_NO_SHIFT_REG = 1'b0;
assign rnode_163to164_bb1_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_stall_local;
wire [31:0] local_bb1_shr_i;

assign local_bb1_shr_i = (local_bb1_var__u5 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_and5_i_stall_local;
wire [31:0] local_bb1_and5_i;

assign local_bb1_and5_i = (local_bb1_var__u5 & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_shr2_i_stall_local;
wire [31:0] local_bb1_shr2_i;

assign local_bb1_shr2_i = (local_bb1_var__u6 >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_xor_i_stall_local;
wire [31:0] local_bb1_xor_i;

assign local_bb1_xor_i = (local_bb1_var__u6 ^ local_bb1_var__u5);

// This section implements an unregistered operation.
// 
wire local_bb1_and6_i_stall_local;
wire [31:0] local_bb1_and6_i;

assign local_bb1_and6_i = (local_bb1_var__u6 & 32'h7FFFFF);

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_164to167_bb1_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to167_bb1_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to167_bb1_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_164to167_bb1_c0_ene3_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to167_bb1_c0_ene3_0_reg_167_NO_SHIFT_REG;
 logic rnode_164to167_bb1_c0_ene3_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_164to167_bb1_c0_ene3_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_164to167_bb1_c0_ene3_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_164to167_bb1_c0_ene3_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to167_bb1_c0_ene3_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to167_bb1_c0_ene3_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_164to167_bb1_c0_ene3_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_164to167_bb1_c0_ene3_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(rnode_163to164_bb1_c0_ene3_0_NO_SHIFT_REG),
	.data_out(rnode_164to167_bb1_c0_ene3_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_164to167_bb1_c0_ene3_0_reg_167_fifo.DEPTH = 3;
defparam rnode_164to167_bb1_c0_ene3_0_reg_167_fifo.DATA_WIDTH = 32;
defparam rnode_164to167_bb1_c0_ene3_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to167_bb1_c0_ene3_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_164to167_bb1_c0_ene3_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_163to164_bb1_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_164to167_bb1_c0_ene3_0_NO_SHIFT_REG = rnode_164to167_bb1_c0_ene3_0_reg_167_NO_SHIFT_REG;
assign rnode_164to167_bb1_c0_ene3_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_164to167_bb1_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_and_i_stall_local;
wire [31:0] local_bb1_and_i;

assign local_bb1_and_i = (local_bb1_shr_i & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot14_i_stall_local;
wire local_bb1_lnot14_i;

assign local_bb1_lnot14_i = (local_bb1_and5_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i_stall_local;
wire [31:0] local_bb1_or_i;

assign local_bb1_or_i = (local_bb1_and5_i | 32'h800000);

// This section implements an unregistered operation.
// 
wire local_bb1_and3_i_stall_local;
wire [31:0] local_bb1_and3_i;

assign local_bb1_and3_i = (local_bb1_shr2_i & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot17_i_stall_local;
wire local_bb1_lnot17_i;

assign local_bb1_lnot17_i = (local_bb1_and6_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or47_i_stall_local;
wire [31:0] local_bb1_or47_i;

assign local_bb1_or47_i = (local_bb1_and6_i | 32'h800000);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_c0_ene3_0_valid_out_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb1_c0_ene3_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene3_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb1_c0_ene3_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene3_0_valid_out_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene3_0_stall_in_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_c0_ene3_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_c0_ene3_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_c0_ene3_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_c0_ene3_0_stall_in_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_c0_ene3_0_valid_out_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_c0_ene3_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(rnode_164to167_bb1_c0_ene3_0_NO_SHIFT_REG),
	.data_out(rnode_167to168_bb1_c0_ene3_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_c0_ene3_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_c0_ene3_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb1_c0_ene3_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_c0_ene3_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_c0_ene3_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_164to167_bb1_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_c0_ene3_0_NO_SHIFT_REG = rnode_167to168_bb1_c0_ene3_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_c0_ene3_0_stall_in_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_c0_ene3_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_i_stall_local;
wire local_bb1_lnot_i;

assign local_bb1_lnot_i = (local_bb1_and_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_i_stall_local;
wire local_bb1_cmp_i;

assign local_bb1_cmp_i = (local_bb1_and_i == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u7_stall_local;
wire [31:0] local_bb1_var__u7;

assign local_bb1_var__u7 = (local_bb1_and6_i | local_bb1_and_i);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot14_not_i_stall_local;
wire local_bb1_lnot14_not_i;

assign local_bb1_lnot14_not_i = (local_bb1_lnot14_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_conv_i_i_stall_local;
wire [63:0] local_bb1_conv_i_i;

assign local_bb1_conv_i_i[63:32] = 32'h0;
assign local_bb1_conv_i_i[31:0] = local_bb1_or_i;

// This section implements an unregistered operation.
// 
wire local_bb1_lnot8_i_stall_local;
wire local_bb1_lnot8_i;

assign local_bb1_lnot8_i = (local_bb1_and3_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp11_i_stall_local;
wire local_bb1_cmp11_i;

assign local_bb1_cmp11_i = (local_bb1_and3_i == 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u8_stall_local;
wire [31:0] local_bb1_var__u8;

assign local_bb1_var__u8 = (local_bb1_and3_i | local_bb1_and6_i);

// This section implements an unregistered operation.
// 
wire local_bb1_add_i_stall_local;
wire [31:0] local_bb1_add_i;

assign local_bb1_add_i = (local_bb1_and3_i + local_bb1_and_i);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot17_not_i_stall_local;
wire local_bb1_lnot17_not_i;

assign local_bb1_lnot17_not_i = (local_bb1_lnot17_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_conv1_i_i_stall_local;
wire [63:0] local_bb1_conv1_i_i;

assign local_bb1_conv1_i_i[63:32] = 32'h0;
assign local_bb1_conv1_i_i[31:0] = local_bb1_or47_i;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u9_stall_local;
wire [31:0] local_bb1_var__u9;

assign local_bb1_var__u9 = rnode_167to168_bb1_c0_ene3_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u10_stall_local;
wire local_bb1_var__u10;

assign local_bb1_var__u10 = (local_bb1_var__u7 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1__28_i_stall_local;
wire local_bb1__28_i;

assign local_bb1__28_i = (local_bb1_cmp_i & local_bb1_lnot14_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_0_i_stall_local;
wire local_bb1_reduction_0_i;

assign local_bb1_reduction_0_i = (local_bb1_lnot_i | local_bb1_lnot8_i);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge8_demorgan_i_stall_local;
wire local_bb1_brmerge8_demorgan_i;

assign local_bb1_brmerge8_demorgan_i = (local_bb1_cmp11_i & local_bb1_lnot17_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp11_not_i_stall_local;
wire local_bb1_cmp11_not_i;

assign local_bb1_cmp11_not_i = (local_bb1_cmp11_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u11_stall_local;
wire local_bb1_var__u11;

assign local_bb1_var__u11 = (local_bb1_cmp_i | local_bb1_cmp11_i);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u12_stall_local;
wire local_bb1_var__u12;

assign local_bb1_var__u12 = (local_bb1_var__u8 == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_and2_i_stall_local;
wire [31:0] local_bb1_and2_i;

assign local_bb1_and2_i = (local_bb1_var__u9 >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_and12_i_stall_local;
wire [31:0] local_bb1_and12_i;

assign local_bb1_and12_i = (local_bb1_var__u9 & 32'hFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge10_demorgan_i_stall_local;
wire local_bb1_brmerge10_demorgan_i;

assign local_bb1_brmerge10_demorgan_i = (local_bb1_brmerge8_demorgan_i & local_bb1_lnot_i);

// This section implements an unregistered operation.
// 
wire local_bb1__mux9_mux_i_stall_local;
wire local_bb1__mux9_mux_i;

assign local_bb1__mux9_mux_i = (local_bb1_brmerge8_demorgan_i ^ local_bb1_cmp11_i);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge3_i_stall_local;
wire local_bb1_brmerge3_i;

assign local_bb1_brmerge3_i = (local_bb1_var__u12 | local_bb1_cmp11_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1__mux_mux_i_stall_local;
wire local_bb1__mux_mux_i;

assign local_bb1__mux_mux_i = (local_bb1_var__u12 | local_bb1_cmp11_i);

// This section implements an unregistered operation.
// 
wire local_bb1__not_i_stall_local;
wire local_bb1__not_i;

assign local_bb1__not_i = (local_bb1_var__u12 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_shr3_i_stall_local;
wire [31:0] local_bb1_shr3_i;

assign local_bb1_shr3_i = (local_bb1_and2_i & 32'h7FFF);

// This section implements an unregistered operation.
// 
wire local_bb1__26_demorgan_i_stall_local;
wire local_bb1__26_demorgan_i;

assign local_bb1__26_demorgan_i = (local_bb1_cmp_i | local_bb1_brmerge10_demorgan_i);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge5_i_stall_local;
wire local_bb1_brmerge5_i;

assign local_bb1_brmerge5_i = (local_bb1_brmerge3_i | local_bb1_lnot17_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_3_i_stall_local;
wire local_bb1_reduction_3_i;

assign local_bb1_reduction_3_i = (local_bb1_cmp11_i & local_bb1__not_i);

// This section implements an unregistered operation.
// 
wire local_bb1__mux_mux_mux_i_stall_local;
wire local_bb1__mux_mux_mux_i;

assign local_bb1__mux_mux_mux_i = (local_bb1_brmerge5_i & local_bb1__mux_mux_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_5_i_stall_local;
wire local_bb1_reduction_5_i;

assign local_bb1_reduction_5_i = (local_bb1_lnot14_i & local_bb1_reduction_3_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_6_i_stall_local;
wire local_bb1_reduction_6_i;

assign local_bb1_reduction_6_i = (local_bb1_var__u10 & local_bb1_reduction_5_i);

// This section implements an unregistered operation.
// 
wire local_bb1__24_i_stall_local;
wire local_bb1__24_i;

assign local_bb1__24_i = (local_bb1_cmp_i ? local_bb1_reduction_6_i : local_bb1_brmerge10_demorgan_i);

// This section implements an unregistered operation.
// 
wire local_bb1__25_i_stall_local;
wire local_bb1__25_i;

assign local_bb1__25_i = (local_bb1__24_i ? local_bb1_lnot14_i : local_bb1__mux_mux_mux_i);

// This section implements an unregistered operation.
// 
wire local_bb1__27_i_stall_local;
wire local_bb1__27_i;

assign local_bb1__27_i = (local_bb1__26_demorgan_i ? local_bb1__25_i : local_bb1__mux9_mux_i);

// This section implements an unregistered operation.
// 
wire local_bb1_xor_i_valid_out;
wire local_bb1_xor_i_stall_in;
 reg local_bb1_xor_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_add_i_valid_out;
wire local_bb1_add_i_stall_in;
 reg local_bb1_add_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv_i_i_valid_out;
wire local_bb1_conv_i_i_stall_in;
 reg local_bb1_conv_i_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_conv1_i_i_valid_out;
wire local_bb1_conv1_i_i_stall_in;
 reg local_bb1_conv1_i_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_0_i_valid_out;
wire local_bb1_reduction_0_i_stall_in;
 reg local_bb1_reduction_0_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_var__u11_valid_out;
wire local_bb1_var__u11_stall_in;
 reg local_bb1_var__u11_consumed_0_NO_SHIFT_REG;
wire local_bb1__29_i_valid_out;
wire local_bb1__29_i_stall_in;
 reg local_bb1__29_i_consumed_0_NO_SHIFT_REG;
wire local_bb1__29_i_inputs_ready;
wire local_bb1__29_i_stall_local;
wire local_bb1__29_i;

assign local_bb1__29_i_inputs_ready = (local_bb1_c0_enter_c0_eni3_valid_out_0_NO_SHIFT_REG & local_bb1_c0_enter_c0_eni3_valid_out_1_NO_SHIFT_REG);
assign local_bb1__29_i = (local_bb1__28_i | local_bb1__27_i);
assign local_bb1_xor_i_valid_out = 1'b1;
assign local_bb1_add_i_valid_out = 1'b1;
assign local_bb1_conv_i_i_valid_out = 1'b1;
assign local_bb1_conv1_i_i_valid_out = 1'b1;
assign local_bb1_reduction_0_i_valid_out = 1'b1;
assign local_bb1_var__u11_valid_out = 1'b1;
assign local_bb1__29_i_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni3_stall_in_0 = 1'b0;
assign local_bb1_c0_enter_c0_eni3_stall_in_1 = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_xor_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_add_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv_i_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_conv1_i_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_0_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_var__u11_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__29_i_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_xor_i_consumed_0_NO_SHIFT_REG <= (local_bb1__29_i_inputs_ready & (local_bb1_xor_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_xor_i_stall_in)) & local_bb1__29_i_stall_local);
		local_bb1_add_i_consumed_0_NO_SHIFT_REG <= (local_bb1__29_i_inputs_ready & (local_bb1_add_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_add_i_stall_in)) & local_bb1__29_i_stall_local);
		local_bb1_conv_i_i_consumed_0_NO_SHIFT_REG <= (local_bb1__29_i_inputs_ready & (local_bb1_conv_i_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_conv_i_i_stall_in)) & local_bb1__29_i_stall_local);
		local_bb1_conv1_i_i_consumed_0_NO_SHIFT_REG <= (local_bb1__29_i_inputs_ready & (local_bb1_conv1_i_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_conv1_i_i_stall_in)) & local_bb1__29_i_stall_local);
		local_bb1_reduction_0_i_consumed_0_NO_SHIFT_REG <= (local_bb1__29_i_inputs_ready & (local_bb1_reduction_0_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_0_i_stall_in)) & local_bb1__29_i_stall_local);
		local_bb1_var__u11_consumed_0_NO_SHIFT_REG <= (local_bb1__29_i_inputs_ready & (local_bb1_var__u11_consumed_0_NO_SHIFT_REG | ~(local_bb1_var__u11_stall_in)) & local_bb1__29_i_stall_local);
		local_bb1__29_i_consumed_0_NO_SHIFT_REG <= (local_bb1__29_i_inputs_ready & (local_bb1__29_i_consumed_0_NO_SHIFT_REG | ~(local_bb1__29_i_stall_in)) & local_bb1__29_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_bb1_xor_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_163to164_bb1_xor_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_bb1_xor_i_0_NO_SHIFT_REG;
 logic rnode_163to164_bb1_xor_i_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_bb1_xor_i_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_xor_i_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_xor_i_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_xor_i_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_163to164_bb1_xor_i_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb1_xor_i_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb1_xor_i_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb1_xor_i_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb1_xor_i_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb1_xor_i),
	.data_out(rnode_163to164_bb1_xor_i_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb1_xor_i_0_reg_164_fifo.DEPTH = 1;
defparam rnode_163to164_bb1_xor_i_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_163to164_bb1_xor_i_0_reg_164_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_163to164_bb1_xor_i_0_reg_164_fifo.IMPL = "shift_reg";

assign rnode_163to164_bb1_xor_i_0_reg_164_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_xor_i_stall_in = 1'b0;
assign rnode_163to164_bb1_xor_i_0_NO_SHIFT_REG = rnode_163to164_bb1_xor_i_0_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb1_xor_i_0_stall_in_reg_164_NO_SHIFT_REG = 1'b0;
assign rnode_163to164_bb1_xor_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_bb1_add_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_163to164_bb1_add_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_bb1_add_i_0_NO_SHIFT_REG;
 logic rnode_163to164_bb1_add_i_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_bb1_add_i_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_add_i_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_add_i_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_add_i_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_163to164_bb1_add_i_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb1_add_i_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb1_add_i_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb1_add_i_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb1_add_i_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb1_add_i),
	.data_out(rnode_163to164_bb1_add_i_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb1_add_i_0_reg_164_fifo.DEPTH = 1;
defparam rnode_163to164_bb1_add_i_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_163to164_bb1_add_i_0_reg_164_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_163to164_bb1_add_i_0_reg_164_fifo.IMPL = "shift_reg";

assign rnode_163to164_bb1_add_i_0_reg_164_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add_i_stall_in = 1'b0;
assign rnode_163to164_bb1_add_i_0_NO_SHIFT_REG = rnode_163to164_bb1_add_i_0_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb1_add_i_0_stall_in_reg_164_NO_SHIFT_REG = 1'b0;
assign rnode_163to164_bb1_add_i_0_valid_out_NO_SHIFT_REG = 1'b1;

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
	.dataa(local_bb1_conv1_i_i),
	.datab(local_bb1_conv_i_i),
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
assign local_bb1_conv1_i_i_stall_in = 1'b0;
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
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_bb1_reduction_0_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_163to164_bb1_reduction_0_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_163to164_bb1_reduction_0_i_0_NO_SHIFT_REG;
 logic rnode_163to164_bb1_reduction_0_i_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_163to164_bb1_reduction_0_i_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_reduction_0_i_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_reduction_0_i_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_reduction_0_i_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_163to164_bb1_reduction_0_i_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb1_reduction_0_i_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb1_reduction_0_i_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb1_reduction_0_i_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb1_reduction_0_i_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_0_i),
	.data_out(rnode_163to164_bb1_reduction_0_i_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb1_reduction_0_i_0_reg_164_fifo.DEPTH = 1;
defparam rnode_163to164_bb1_reduction_0_i_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_163to164_bb1_reduction_0_i_0_reg_164_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_163to164_bb1_reduction_0_i_0_reg_164_fifo.IMPL = "shift_reg";

assign rnode_163to164_bb1_reduction_0_i_0_reg_164_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_0_i_stall_in = 1'b0;
assign rnode_163to164_bb1_reduction_0_i_0_NO_SHIFT_REG = rnode_163to164_bb1_reduction_0_i_0_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb1_reduction_0_i_0_stall_in_reg_164_NO_SHIFT_REG = 1'b0;
assign rnode_163to164_bb1_reduction_0_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_bb1_var__u11_0_valid_out_NO_SHIFT_REG;
 logic rnode_163to164_bb1_var__u11_0_stall_in_NO_SHIFT_REG;
 logic rnode_163to164_bb1_var__u11_0_NO_SHIFT_REG;
 logic rnode_163to164_bb1_var__u11_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_163to164_bb1_var__u11_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_var__u11_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_var__u11_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1_var__u11_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_163to164_bb1_var__u11_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb1_var__u11_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb1_var__u11_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb1_var__u11_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb1_var__u11_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb1_var__u11),
	.data_out(rnode_163to164_bb1_var__u11_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb1_var__u11_0_reg_164_fifo.DEPTH = 1;
defparam rnode_163to164_bb1_var__u11_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_163to164_bb1_var__u11_0_reg_164_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_163to164_bb1_var__u11_0_reg_164_fifo.IMPL = "shift_reg";

assign rnode_163to164_bb1_var__u11_0_reg_164_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u11_stall_in = 1'b0;
assign rnode_163to164_bb1_var__u11_0_NO_SHIFT_REG = rnode_163to164_bb1_var__u11_0_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb1_var__u11_0_stall_in_reg_164_NO_SHIFT_REG = 1'b0;
assign rnode_163to164_bb1_var__u11_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_bb1__29_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_163to164_bb1__29_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_163to164_bb1__29_i_0_NO_SHIFT_REG;
 logic rnode_163to164_bb1__29_i_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_163to164_bb1__29_i_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1__29_i_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1__29_i_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb1__29_i_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_163to164_bb1__29_i_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb1__29_i_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb1__29_i_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb1__29_i_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb1__29_i_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb1__29_i),
	.data_out(rnode_163to164_bb1__29_i_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb1__29_i_0_reg_164_fifo.DEPTH = 1;
defparam rnode_163to164_bb1__29_i_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_163to164_bb1__29_i_0_reg_164_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_163to164_bb1__29_i_0_reg_164_fifo.IMPL = "shift_reg";

assign rnode_163to164_bb1__29_i_0_reg_164_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__29_i_stall_in = 1'b0;
assign rnode_163to164_bb1__29_i_0_NO_SHIFT_REG = rnode_163to164_bb1__29_i_0_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb1__29_i_0_stall_in_reg_164_NO_SHIFT_REG = 1'b0;
assign rnode_163to164_bb1__29_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_164to166_bb1_xor_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to166_bb1_xor_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to166_bb1_xor_i_0_NO_SHIFT_REG;
 logic rnode_164to166_bb1_xor_i_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to166_bb1_xor_i_0_reg_166_NO_SHIFT_REG;
 logic rnode_164to166_bb1_xor_i_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_164to166_bb1_xor_i_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_164to166_bb1_xor_i_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_164to166_bb1_xor_i_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to166_bb1_xor_i_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to166_bb1_xor_i_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_164to166_bb1_xor_i_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_164to166_bb1_xor_i_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(rnode_163to164_bb1_xor_i_0_NO_SHIFT_REG),
	.data_out(rnode_164to166_bb1_xor_i_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_164to166_bb1_xor_i_0_reg_166_fifo.DEPTH = 2;
defparam rnode_164to166_bb1_xor_i_0_reg_166_fifo.DATA_WIDTH = 32;
defparam rnode_164to166_bb1_xor_i_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to166_bb1_xor_i_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_164to166_bb1_xor_i_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_163to164_bb1_xor_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_164to166_bb1_xor_i_0_NO_SHIFT_REG = rnode_164to166_bb1_xor_i_0_reg_166_NO_SHIFT_REG;
assign rnode_164to166_bb1_xor_i_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_164to166_bb1_xor_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb1_add_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb1_add_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_bb1_add_i_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_add_i_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_bb1_add_i_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_add_i_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_add_i_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_add_i_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb1_add_i_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb1_add_i_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb1_add_i_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb1_add_i_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb1_add_i_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_163to164_bb1_add_i_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb1_add_i_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb1_add_i_0_reg_165_fifo.DEPTH = 1;
defparam rnode_164to165_bb1_add_i_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_bb1_add_i_0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to165_bb1_add_i_0_reg_165_fifo.IMPL = "shift_reg";

assign rnode_164to165_bb1_add_i_0_reg_165_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_163to164_bb1_add_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_add_i_0_NO_SHIFT_REG = rnode_164to165_bb1_add_i_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_add_i_0_stall_in_reg_165_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_add_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_conv3_i_i_stall_local;
wire [31:0] local_bb1_conv3_i_i;

assign local_bb1_conv3_i_i = local_bb1_mul_i_i[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_var__u13_stall_local;
wire [63:0] local_bb1_var__u13;

assign local_bb1_var__u13 = (local_bb1_mul_i_i >> 64'h18);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_164to166_bb1_reduction_0_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to166_bb1_reduction_0_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to166_bb1_reduction_0_i_0_NO_SHIFT_REG;
 logic rnode_164to166_bb1_reduction_0_i_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to166_bb1_reduction_0_i_0_reg_166_NO_SHIFT_REG;
 logic rnode_164to166_bb1_reduction_0_i_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_164to166_bb1_reduction_0_i_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_164to166_bb1_reduction_0_i_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_164to166_bb1_reduction_0_i_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to166_bb1_reduction_0_i_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to166_bb1_reduction_0_i_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_164to166_bb1_reduction_0_i_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_164to166_bb1_reduction_0_i_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(rnode_163to164_bb1_reduction_0_i_0_NO_SHIFT_REG),
	.data_out(rnode_164to166_bb1_reduction_0_i_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_164to166_bb1_reduction_0_i_0_reg_166_fifo.DEPTH = 2;
defparam rnode_164to166_bb1_reduction_0_i_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_164to166_bb1_reduction_0_i_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to166_bb1_reduction_0_i_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_164to166_bb1_reduction_0_i_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_163to164_bb1_reduction_0_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_164to166_bb1_reduction_0_i_0_NO_SHIFT_REG = rnode_164to166_bb1_reduction_0_i_0_reg_166_NO_SHIFT_REG;
assign rnode_164to166_bb1_reduction_0_i_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_164to166_bb1_reduction_0_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb1_var__u11_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb1_var__u11_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_bb1_var__u11_0_NO_SHIFT_REG;
 logic rnode_164to165_bb1_var__u11_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb1_var__u11_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_var__u11_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_var__u11_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb1_var__u11_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb1_var__u11_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb1_var__u11_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb1_var__u11_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb1_var__u11_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb1_var__u11_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_163to164_bb1_var__u11_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb1_var__u11_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb1_var__u11_0_reg_165_fifo.DEPTH = 1;
defparam rnode_164to165_bb1_var__u11_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb1_var__u11_0_reg_165_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to165_bb1_var__u11_0_reg_165_fifo.IMPL = "shift_reg";

assign rnode_164to165_bb1_var__u11_0_reg_165_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_163to164_bb1_var__u11_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_var__u11_0_NO_SHIFT_REG = rnode_164to165_bb1_var__u11_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb1_var__u11_0_stall_in_reg_165_NO_SHIFT_REG = 1'b0;
assign rnode_164to165_bb1_var__u11_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_164to166_bb1__29_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to166_bb1__29_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to166_bb1__29_i_0_NO_SHIFT_REG;
 logic rnode_164to166_bb1__29_i_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to166_bb1__29_i_0_reg_166_NO_SHIFT_REG;
 logic rnode_164to166_bb1__29_i_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_164to166_bb1__29_i_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_164to166_bb1__29_i_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_164to166_bb1__29_i_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to166_bb1__29_i_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to166_bb1__29_i_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_164to166_bb1__29_i_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_164to166_bb1__29_i_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(rnode_163to164_bb1__29_i_0_NO_SHIFT_REG),
	.data_out(rnode_164to166_bb1__29_i_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_164to166_bb1__29_i_0_reg_166_fifo.DEPTH = 2;
defparam rnode_164to166_bb1__29_i_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_164to166_bb1__29_i_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_164to166_bb1__29_i_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_164to166_bb1__29_i_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_163to164_bb1__29_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_164to166_bb1__29_i_0_NO_SHIFT_REG = rnode_164to166_bb1__29_i_0_reg_166_NO_SHIFT_REG;
assign rnode_164to166_bb1__29_i_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_164to166_bb1__29_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_xor_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_xor_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb1_xor_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_xor_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb1_xor_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_xor_i_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_xor_i_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_xor_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_xor_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_xor_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_xor_i_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_xor_i_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_xor_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(rnode_164to166_bb1_xor_i_0_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_xor_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_xor_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_xor_i_0_reg_167_fifo.DATA_WIDTH = 32;
defparam rnode_166to167_bb1_xor_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_xor_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_xor_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_164to166_bb1_xor_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_xor_i_0_NO_SHIFT_REG = rnode_166to167_bb1_xor_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_xor_i_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_xor_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_add_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_add_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_165to166_bb1_add_i_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_add_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_add_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_165to166_bb1_add_i_1_NO_SHIFT_REG;
 logic rnode_165to166_bb1_add_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_165to166_bb1_add_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_165to166_bb1_add_i_2_NO_SHIFT_REG;
 logic rnode_165to166_bb1_add_i_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_165to166_bb1_add_i_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_add_i_0_valid_out_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_add_i_0_stall_in_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_add_i_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_add_i_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_add_i_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_add_i_0_stall_in_0_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_add_i_0_valid_out_0_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_add_i_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(rnode_164to165_bb1_add_i_0_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_add_i_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_add_i_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_add_i_0_reg_166_fifo.DATA_WIDTH = 32;
defparam rnode_165to166_bb1_add_i_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_add_i_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_add_i_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_add_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_add_i_0_stall_in_0_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_add_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_add_i_0_NO_SHIFT_REG = rnode_165to166_bb1_add_i_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_add_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_add_i_1_NO_SHIFT_REG = rnode_165to166_bb1_add_i_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_add_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_165to166_bb1_add_i_2_NO_SHIFT_REG = rnode_165to166_bb1_add_i_0_reg_166_NO_SHIFT_REG;

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
wire local_bb1_var__u14_stall_local;
wire [31:0] local_bb1_var__u14;

assign local_bb1_var__u14 = (local_bb1_conv3_i_i >> 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_shl1_i_i_stall_local;
wire [31:0] local_bb1_shl1_i_i;

assign local_bb1_shl1_i_i = (local_bb1_conv3_i_i << 32'h9);

// This section implements an unregistered operation.
// 
wire local_bb1__tr_i_stall_local;
wire [31:0] local_bb1__tr_i;

assign local_bb1__tr_i = local_bb1_var__u13[31:0];

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_reduction_0_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_reduction_0_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_166to167_bb1_reduction_0_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_reduction_0_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_reduction_0_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_reduction_0_i_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_reduction_0_i_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_reduction_0_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_reduction_0_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_reduction_0_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_reduction_0_i_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_reduction_0_i_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_reduction_0_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(rnode_164to166_bb1_reduction_0_i_0_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1_reduction_0_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_reduction_0_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_reduction_0_i_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_reduction_0_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_reduction_0_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_reduction_0_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_164to166_bb1_reduction_0_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_reduction_0_i_0_NO_SHIFT_REG = rnode_166to167_bb1_reduction_0_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_reduction_0_i_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_reduction_0_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_var__u11_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_var__u11_0_stall_in_NO_SHIFT_REG;
 logic rnode_165to166_bb1_var__u11_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_var__u11_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_var__u11_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_var__u11_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_var__u11_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_var__u11_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_var__u11_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_var__u11_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_var__u11_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_var__u11_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_var__u11_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(rnode_164to165_bb1_var__u11_0_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_var__u11_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_var__u11_0_reg_166_fifo.DEPTH = 1;
defparam rnode_165to166_bb1_var__u11_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_var__u11_0_reg_166_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_165to166_bb1_var__u11_0_reg_166_fifo.IMPL = "shift_reg";

assign rnode_165to166_bb1_var__u11_0_reg_166_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_164to165_bb1_var__u11_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_var__u11_0_NO_SHIFT_REG = rnode_165to166_bb1_var__u11_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_var__u11_0_stall_in_reg_166_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_var__u11_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1__29_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1__29_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_166to167_bb1__29_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1__29_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1__29_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__29_i_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__29_i_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__29_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1__29_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1__29_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1__29_i_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1__29_i_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1__29_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(rnode_164to166_bb1__29_i_0_NO_SHIFT_REG),
	.data_out(rnode_166to167_bb1__29_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1__29_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1__29_i_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1__29_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1__29_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1__29_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_164to166_bb1__29_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1__29_i_0_NO_SHIFT_REG = rnode_166to167_bb1__29_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1__29_i_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1__29_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_and4_i_stall_local;
wire [31:0] local_bb1_and4_i;

assign local_bb1_and4_i = (rnode_166to167_bb1_xor_i_0_NO_SHIFT_REG & 32'h80000000);

// This section implements an unregistered operation.
// 
wire local_bb1_inc_i_stall_local;
wire [31:0] local_bb1_inc_i;

assign local_bb1_inc_i = (rnode_165to166_bb1_add_i_0_NO_SHIFT_REG + 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp50_not_i_stall_local;
wire local_bb1_cmp50_not_i;

assign local_bb1_cmp50_not_i = (rnode_165to166_bb1_add_i_1_NO_SHIFT_REG != 32'h7F);

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_i_stall_local;
wire [31:0] local_bb1_shr_i_i;

assign local_bb1_shr_i_i = (local_bb1_var__u14 & 32'h1);

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
wire local_bb1_shl_i_i_stall_local;
wire [31:0] local_bb1_shl_i_i;

assign local_bb1_shl_i_i = (local_bb1_or_i17_i << 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__31_i_stall_local;
wire local_bb1__31_i;

assign local_bb1__31_i = (local_bb1_tobool49_i & local_bb1_cmp50_not_i);

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

assign local_bb1__36_i = (local_bb1__31_i ? rnode_165to166_bb1_add_i_2_NO_SHIFT_REG : 32'h7F);

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
wire local_bb1_var__u15_stall_local;
wire local_bb1_var__u15;

assign local_bb1_var__u15 = ($signed(local_bb1__33_i) < $signed(32'h0));

// This section implements an unregistered operation.
// 
wire local_bb1_cmp53_i_stall_local;
wire local_bb1_cmp53_i;

assign local_bb1_cmp53_i = (local_bb1__37_i > 32'h17D);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp68_i_stall_local;
wire local_bb1_cmp68_i;

assign local_bb1_cmp68_i = (local_bb1__37_i < 32'h80);

// This section implements an unregistered operation.
// 
wire local_bb1_sub_i_stall_local;
wire [31:0] local_bb1_sub_i;

assign local_bb1_sub_i = (local_bb1__37_i << 32'h17);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp71_not_i_stall_local;
wire local_bb1_cmp71_not_i;

assign local_bb1_cmp71_not_i = (local_bb1__37_i != 32'h7F);

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
wire local_bb1_or581_i_stall_local;
wire local_bb1_or581_i;

assign local_bb1_or581_i = (rnode_165to166_bb1_var__u11_0_NO_SHIFT_REG | local_bb1_cmp53_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and74_i_stall_local;
wire [31:0] local_bb1_and74_i;

assign local_bb1_and74_i = (local_bb1_sub_i + 32'h40800000);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool84_i_stall_local;
wire local_bb1_tobool84_i;

assign local_bb1_tobool84_i = (local_bb1_and83_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_shl_i_stall_local;
wire [31:0] local_bb1_shl_i;

assign local_bb1_shl_i = (local_bb1_and74_i & 32'h7F800000);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp77_i_valid_out;
wire local_bb1_cmp77_i_stall_in;
 reg local_bb1_cmp77_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp68_i_valid_out;
wire local_bb1_cmp68_i_stall_in;
 reg local_bb1_cmp68_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp71_not_i_valid_out;
wire local_bb1_cmp71_not_i_stall_in;
 reg local_bb1_cmp71_not_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_and75_i_valid_out;
wire local_bb1_and75_i_stall_in;
 reg local_bb1_and75_i_consumed_0_NO_SHIFT_REG;
wire local_bb1__39_i_valid_out;
wire local_bb1__39_i_stall_in;
 reg local_bb1__39_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_or581_i_valid_out;
wire local_bb1_or581_i_stall_in;
 reg local_bb1_or581_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_shl_i_valid_out;
wire local_bb1_shl_i_stall_in;
 reg local_bb1_shl_i_consumed_0_NO_SHIFT_REG;
wire local_bb1__39_i_inputs_ready;
wire local_bb1__39_i_stall_local;
wire local_bb1__39_i;

assign local_bb1__39_i_inputs_ready = (local_bb1_mul_i_i_valid_out_0_NO_SHIFT_REG & local_bb1_mul_i_i_valid_out_1_NO_SHIFT_REG & rnode_165to166_bb1_add_i_0_valid_out_1_NO_SHIFT_REG & rnode_165to166_bb1_add_i_0_valid_out_0_NO_SHIFT_REG & rnode_165to166_bb1_add_i_0_valid_out_2_NO_SHIFT_REG & rnode_165to166_bb1_var__u11_0_valid_out_NO_SHIFT_REG);
assign local_bb1__39_i = (local_bb1_tobool84_i & local_bb1_var__u15);
assign local_bb1_cmp77_i_valid_out = 1'b1;
assign local_bb1_cmp68_i_valid_out = 1'b1;
assign local_bb1_cmp71_not_i_valid_out = 1'b1;
assign local_bb1_and75_i_valid_out = 1'b1;
assign local_bb1__39_i_valid_out = 1'b1;
assign local_bb1_or581_i_valid_out = 1'b1;
assign local_bb1_shl_i_valid_out = 1'b1;
assign local_bb1_mul_i_i_stall_in_0 = 1'b0;
assign local_bb1_mul_i_i_stall_in_1 = 1'b0;
assign rnode_165to166_bb1_add_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_add_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_add_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_165to166_bb1_var__u11_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_cmp77_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp68_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp71_not_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and75_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__39_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_or581_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_shl_i_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_cmp77_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1_cmp77_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp77_i_stall_in)) & local_bb1__39_i_stall_local);
		local_bb1_cmp68_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1_cmp68_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp68_i_stall_in)) & local_bb1__39_i_stall_local);
		local_bb1_cmp71_not_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1_cmp71_not_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp71_not_i_stall_in)) & local_bb1__39_i_stall_local);
		local_bb1_and75_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1_and75_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and75_i_stall_in)) & local_bb1__39_i_stall_local);
		local_bb1__39_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1__39_i_consumed_0_NO_SHIFT_REG | ~(local_bb1__39_i_stall_in)) & local_bb1__39_i_stall_local);
		local_bb1_or581_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1_or581_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_or581_i_stall_in)) & local_bb1__39_i_stall_local);
		local_bb1_shl_i_consumed_0_NO_SHIFT_REG <= (local_bb1__39_i_inputs_ready & (local_bb1_shl_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_shl_i_stall_in)) & local_bb1__39_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_cmp77_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp77_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp77_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp77_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp77_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp77_i_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp77_i_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp77_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_cmp77_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_cmp77_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_cmp77_i_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_cmp77_i_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_cmp77_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_cmp77_i),
	.data_out(rnode_166to167_bb1_cmp77_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_cmp77_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_cmp77_i_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_cmp77_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_cmp77_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_cmp77_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp77_i_stall_in = 1'b0;
assign rnode_166to167_bb1_cmp77_i_0_NO_SHIFT_REG = rnode_166to167_bb1_cmp77_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_cmp77_i_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp77_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_cmp68_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp68_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp68_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp68_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp68_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp68_i_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp68_i_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp68_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_cmp68_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_cmp68_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_cmp68_i_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_cmp68_i_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_cmp68_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_cmp68_i),
	.data_out(rnode_166to167_bb1_cmp68_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_cmp68_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_cmp68_i_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_cmp68_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_cmp68_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_cmp68_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp68_i_stall_in = 1'b0;
assign rnode_166to167_bb1_cmp68_i_0_NO_SHIFT_REG = rnode_166to167_bb1_cmp68_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_cmp68_i_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp68_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_cmp71_not_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp71_not_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp71_not_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp71_not_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp71_not_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp71_not_i_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp71_not_i_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_cmp71_not_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_cmp71_not_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_cmp71_not_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_cmp71_not_i_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_cmp71_not_i_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_cmp71_not_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_cmp71_not_i),
	.data_out(rnode_166to167_bb1_cmp71_not_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_cmp71_not_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_cmp71_not_i_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_cmp71_not_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_cmp71_not_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_cmp71_not_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp71_not_i_stall_in = 1'b0;
assign rnode_166to167_bb1_cmp71_not_i_0_NO_SHIFT_REG = rnode_166to167_bb1_cmp71_not_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_cmp71_not_i_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp71_not_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_and75_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_and75_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb1_and75_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_and75_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb1_and75_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_and75_i_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_and75_i_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_and75_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_and75_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_and75_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_and75_i_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_and75_i_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_and75_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_and75_i),
	.data_out(rnode_166to167_bb1_and75_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_and75_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_and75_i_0_reg_167_fifo.DATA_WIDTH = 32;
defparam rnode_166to167_bb1_and75_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_and75_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_and75_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and75_i_stall_in = 1'b0;
assign rnode_166to167_bb1_and75_i_0_NO_SHIFT_REG = rnode_166to167_bb1_and75_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_and75_i_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_and75_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1__39_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1__39_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_166to167_bb1__39_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1__39_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1__39_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__39_i_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__39_i_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1__39_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1__39_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1__39_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1__39_i_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1__39_i_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1__39_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1__39_i),
	.data_out(rnode_166to167_bb1__39_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1__39_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1__39_i_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1__39_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1__39_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1__39_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__39_i_stall_in = 1'b0;
assign rnode_166to167_bb1__39_i_0_NO_SHIFT_REG = rnode_166to167_bb1__39_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1__39_i_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1__39_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_or581_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_1_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_0_valid_out_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_0_stall_in_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_or581_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_or581_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_or581_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_or581_i_0_stall_in_0_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_or581_i_0_valid_out_0_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_or581_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_or581_i),
	.data_out(rnode_166to167_bb1_or581_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_or581_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_or581_i_0_reg_167_fifo.DATA_WIDTH = 1;
defparam rnode_166to167_bb1_or581_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_or581_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_or581_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_or581_i_stall_in = 1'b0;
assign rnode_166to167_bb1_or581_i_0_stall_in_0_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_or581_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_or581_i_0_NO_SHIFT_REG = rnode_166to167_bb1_or581_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_or581_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_166to167_bb1_or581_i_1_NO_SHIFT_REG = rnode_166to167_bb1_or581_i_0_reg_167_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_166to167_bb1_shl_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_166to167_bb1_shl_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb1_shl_i_0_NO_SHIFT_REG;
 logic rnode_166to167_bb1_shl_i_0_reg_167_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_166to167_bb1_shl_i_0_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_shl_i_0_valid_out_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_shl_i_0_stall_in_reg_167_NO_SHIFT_REG;
 logic rnode_166to167_bb1_shl_i_0_stall_out_reg_167_NO_SHIFT_REG;

acl_data_fifo rnode_166to167_bb1_shl_i_0_reg_167_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_166to167_bb1_shl_i_0_reg_167_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_166to167_bb1_shl_i_0_stall_in_reg_167_NO_SHIFT_REG),
	.valid_out(rnode_166to167_bb1_shl_i_0_valid_out_reg_167_NO_SHIFT_REG),
	.stall_out(rnode_166to167_bb1_shl_i_0_stall_out_reg_167_NO_SHIFT_REG),
	.data_in(local_bb1_shl_i),
	.data_out(rnode_166to167_bb1_shl_i_0_reg_167_NO_SHIFT_REG)
);

defparam rnode_166to167_bb1_shl_i_0_reg_167_fifo.DEPTH = 1;
defparam rnode_166to167_bb1_shl_i_0_reg_167_fifo.DATA_WIDTH = 32;
defparam rnode_166to167_bb1_shl_i_0_reg_167_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_166to167_bb1_shl_i_0_reg_167_fifo.IMPL = "shift_reg";

assign rnode_166to167_bb1_shl_i_0_reg_167_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shl_i_stall_in = 1'b0;
assign rnode_166to167_bb1_shl_i_0_NO_SHIFT_REG = rnode_166to167_bb1_shl_i_0_reg_167_NO_SHIFT_REG;
assign rnode_166to167_bb1_shl_i_0_stall_in_reg_167_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_shl_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u16_stall_local;
wire [31:0] local_bb1_var__u16;

assign local_bb1_var__u16[31:1] = 31'h0;
assign local_bb1_var__u16[0] = rnode_166to167_bb1_cmp68_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1__40_i_stall_local;
wire local_bb1__40_i;

assign local_bb1__40_i = (rnode_166to167_bb1_cmp77_i_0_NO_SHIFT_REG | rnode_166to167_bb1__39_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_2_i_stall_local;
wire local_bb1_reduction_2_i;

assign local_bb1_reduction_2_i = (rnode_166to167_bb1_reduction_0_i_0_NO_SHIFT_REG | rnode_166to167_bb1_or581_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_cond111_i_stall_local;
wire [31:0] local_bb1_cond111_i;

assign local_bb1_cond111_i = (rnode_166to167_bb1_or581_i_1_NO_SHIFT_REG ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or76_i_stall_local;
wire [31:0] local_bb1_or76_i;

assign local_bb1_or76_i = (rnode_166to167_bb1_shl_i_0_NO_SHIFT_REG | rnode_166to167_bb1_and75_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_cond_i_stall_local;
wire [31:0] local_bb1_cond_i;

assign local_bb1_cond_i[31:1] = 31'h0;
assign local_bb1_cond_i[0] = local_bb1__40_i;

// This section implements an unregistered operation.
// 
wire local_bb1_conv101_i_stall_local;
wire [31:0] local_bb1_conv101_i;

assign local_bb1_conv101_i[31:1] = 31'h0;
assign local_bb1_conv101_i[0] = local_bb1_reduction_2_i;

// This section implements an unregistered operation.
// 
wire local_bb1_add87_i_stall_local;
wire [31:0] local_bb1_add87_i;

assign local_bb1_add87_i = (local_bb1_cond_i + local_bb1_or76_i);

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
wire local_bb1_or89_i_stall_local;
wire [31:0] local_bb1_or89_i;

assign local_bb1_or89_i = (local_bb1_and88_i | local_bb1_and4_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp91_i_stall_local;
wire local_bb1_cmp91_i;

assign local_bb1_cmp91_i = (local_bb1_and90_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge14_i_stall_local;
wire local_bb1_brmerge14_i;

assign local_bb1_brmerge14_i = (local_bb1_cmp91_i | rnode_166to167_bb1_cmp71_not_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_conv99_i_stall_local;
wire [31:0] local_bb1_conv99_i;

assign local_bb1_conv99_i = (local_bb1_brmerge14_i ? local_bb1_var__u16 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_or102_i_stall_local;
wire [31:0] local_bb1_or102_i;

assign local_bb1_or102_i = (local_bb1_conv99_i | local_bb1_conv101_i);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool103_i_stall_local;
wire local_bb1_tobool103_i;

assign local_bb1_tobool103_i = (local_bb1_or102_i != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cond107_i_stall_local;
wire [31:0] local_bb1_cond107_i;

assign local_bb1_cond107_i = (local_bb1_tobool103_i ? local_bb1_and4_i : 32'hFFFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and108_i_stall_local;
wire [31:0] local_bb1_and108_i;

assign local_bb1_and108_i = (local_bb1_cond107_i & local_bb1_or89_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or112_i_stall_local;
wire [31:0] local_bb1_or112_i;

assign local_bb1_or112_i = (local_bb1_and108_i | local_bb1_cond111_i);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u17_valid_out;
wire local_bb1_var__u17_stall_in;
wire local_bb1_var__u17_inputs_ready;
wire local_bb1_var__u17_stall_local;
wire [31:0] local_bb1_var__u17;

assign local_bb1_var__u17_inputs_ready = (rnode_166to167_bb1_xor_i_0_valid_out_NO_SHIFT_REG & rnode_166to167_bb1__29_i_0_valid_out_NO_SHIFT_REG & rnode_166to167_bb1_or581_i_0_valid_out_1_NO_SHIFT_REG & rnode_166to167_bb1_or581_i_0_valid_out_0_NO_SHIFT_REG & rnode_166to167_bb1_reduction_0_i_0_valid_out_NO_SHIFT_REG & rnode_166to167_bb1_cmp68_i_0_valid_out_NO_SHIFT_REG & rnode_166to167_bb1_cmp71_not_i_0_valid_out_NO_SHIFT_REG & rnode_166to167_bb1_cmp77_i_0_valid_out_NO_SHIFT_REG & rnode_166to167_bb1__39_i_0_valid_out_NO_SHIFT_REG & rnode_166to167_bb1_shl_i_0_valid_out_NO_SHIFT_REG & rnode_166to167_bb1_and75_i_0_valid_out_NO_SHIFT_REG);
assign local_bb1_var__u17 = (rnode_166to167_bb1__29_i_0_NO_SHIFT_REG ? 32'h7FC00000 : local_bb1_or112_i);
assign local_bb1_var__u17_valid_out = 1'b1;
assign rnode_166to167_bb1_xor_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1__29_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_or581_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_or581_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_reduction_0_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp68_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp71_not_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_cmp77_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1__39_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_shl_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_166to167_bb1_and75_i_0_stall_in_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_167to168_bb1_var__u17_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb1_var__u17_0_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb1_var__u17_1_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb1_var__u17_2_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb1_var__u17_3_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_reg_168_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_167to168_bb1_var__u17_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_valid_out_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_stall_in_0_reg_168_NO_SHIFT_REG;
 logic rnode_167to168_bb1_var__u17_0_stall_out_reg_168_NO_SHIFT_REG;

acl_data_fifo rnode_167to168_bb1_var__u17_0_reg_168_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_167to168_bb1_var__u17_0_reg_168_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_167to168_bb1_var__u17_0_stall_in_0_reg_168_NO_SHIFT_REG),
	.valid_out(rnode_167to168_bb1_var__u17_0_valid_out_0_reg_168_NO_SHIFT_REG),
	.stall_out(rnode_167to168_bb1_var__u17_0_stall_out_reg_168_NO_SHIFT_REG),
	.data_in(local_bb1_var__u17),
	.data_out(rnode_167to168_bb1_var__u17_0_reg_168_NO_SHIFT_REG)
);

defparam rnode_167to168_bb1_var__u17_0_reg_168_fifo.DEPTH = 1;
defparam rnode_167to168_bb1_var__u17_0_reg_168_fifo.DATA_WIDTH = 32;
defparam rnode_167to168_bb1_var__u17_0_reg_168_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_167to168_bb1_var__u17_0_reg_168_fifo.IMPL = "shift_reg";

assign rnode_167to168_bb1_var__u17_0_reg_168_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u17_stall_in = 1'b0;
assign rnode_167to168_bb1_var__u17_0_stall_in_0_reg_168_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_var__u17_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_var__u17_0_NO_SHIFT_REG = rnode_167to168_bb1_var__u17_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_var__u17_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_var__u17_1_NO_SHIFT_REG = rnode_167to168_bb1_var__u17_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_var__u17_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_var__u17_2_NO_SHIFT_REG = rnode_167to168_bb1_var__u17_0_reg_168_NO_SHIFT_REG;
assign rnode_167to168_bb1_var__u17_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_167to168_bb1_var__u17_3_NO_SHIFT_REG = rnode_167to168_bb1_var__u17_0_reg_168_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and_i1_stall_local;
wire [31:0] local_bb1_and_i1;

assign local_bb1_and_i1 = (rnode_167to168_bb1_var__u17_0_NO_SHIFT_REG >> 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_and10_i_stall_local;
wire [31:0] local_bb1_and10_i;

assign local_bb1_and10_i = (rnode_167to168_bb1_var__u17_1_NO_SHIFT_REG & 32'hFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i2_stall_local;
wire [31:0] local_bb1_shr_i2;

assign local_bb1_shr_i2 = (local_bb1_and_i1 & 32'h7FFF);

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

assign local_bb1__22_i = (local_bb1__21_i ? local_bb1_var__u9 : rnode_167to168_bb1_var__u17_2_NO_SHIFT_REG);

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

assign local_bb1__23_i_inputs_ready = (rnode_167to168_bb1_c0_ene3_0_valid_out_NO_SHIFT_REG & rnode_167to168_bb1_var__u17_0_valid_out_2_NO_SHIFT_REG & rnode_167to168_bb1_var__u17_0_valid_out_3_NO_SHIFT_REG & rnode_167to168_bb1_var__u17_0_valid_out_1_NO_SHIFT_REG & rnode_167to168_bb1_var__u17_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1__23_i = (local_bb1__21_i ? rnode_167to168_bb1_var__u17_3_NO_SHIFT_REG : local_bb1_var__u9);
assign local_bb1__22_i_valid_out = 1'b1;
assign local_bb1__23_i_valid_out = 1'b1;
assign rnode_167to168_bb1_c0_ene3_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_var__u17_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_var__u17_0_stall_in_3_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_var__u17_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_167to168_bb1_var__u17_0_stall_in_0_NO_SHIFT_REG = 1'b0;

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
 logic rnode_168to169_bb1__22_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__22_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb1__22_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__22_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1__22_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb1__22_i_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1__22_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb1__22_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__22_i_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__22_i_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__22_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1__22_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1__22_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1__22_i_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1__22_i_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1__22_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1__22_i),
	.data_out(rnode_168to169_bb1__22_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1__22_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1__22_i_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb1__22_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1__22_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1__22_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__22_i_stall_in = 1'b0;
assign rnode_168to169_bb1__22_i_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__22_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__22_i_0_NO_SHIFT_REG = rnode_168to169_bb1__22_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1__22_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__22_i_1_NO_SHIFT_REG = rnode_168to169_bb1__22_i_0_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_168to169_bb1__23_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__23_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb1__23_i_0_NO_SHIFT_REG;
 logic rnode_168to169_bb1__23_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1__23_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb1__23_i_1_NO_SHIFT_REG;
 logic rnode_168to169_bb1__23_i_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_168to169_bb1__23_i_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__23_i_0_valid_out_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__23_i_0_stall_in_0_reg_169_NO_SHIFT_REG;
 logic rnode_168to169_bb1__23_i_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_168to169_bb1__23_i_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_168to169_bb1__23_i_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_168to169_bb1__23_i_0_stall_in_0_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_168to169_bb1__23_i_0_valid_out_0_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_168to169_bb1__23_i_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1__23_i),
	.data_out(rnode_168to169_bb1__23_i_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_168to169_bb1__23_i_0_reg_169_fifo.DEPTH = 1;
defparam rnode_168to169_bb1__23_i_0_reg_169_fifo.DATA_WIDTH = 32;
defparam rnode_168to169_bb1__23_i_0_reg_169_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_168to169_bb1__23_i_0_reg_169_fifo.IMPL = "shift_reg";

assign rnode_168to169_bb1__23_i_0_reg_169_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__23_i_stall_in = 1'b0;
assign rnode_168to169_bb1__23_i_0_stall_in_0_reg_169_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__23_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__23_i_0_NO_SHIFT_REG = rnode_168to169_bb1__23_i_0_reg_169_NO_SHIFT_REG;
assign rnode_168to169_bb1__23_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__23_i_1_NO_SHIFT_REG = rnode_168to169_bb1__23_i_0_reg_169_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr18_i_stall_local;
wire [31:0] local_bb1_shr18_i;

assign local_bb1_shr18_i = (rnode_168to169_bb1__22_i_0_NO_SHIFT_REG >> 32'h17);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1__22_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1__22_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1__22_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1__22_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1__22_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1__22_i_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1__22_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1__22_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__22_i_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__22_i_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__22_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1__22_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1__22_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1__22_i_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1__22_i_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1__22_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1__22_i_1_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1__22_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1__22_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1__22_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1__22_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1__22_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1__22_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__22_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__22_i_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__22_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1__22_i_0_NO_SHIFT_REG = rnode_169to170_bb1__22_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1__22_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1__22_i_1_NO_SHIFT_REG = rnode_169to170_bb1__22_i_0_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr16_i_stall_local;
wire [31:0] local_bb1_shr16_i;

assign local_bb1_shr16_i = (rnode_168to169_bb1__23_i_0_NO_SHIFT_REG >> 32'h17);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1__23_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1__23_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1__23_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1__23_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1__23_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1__23_i_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1__23_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1__23_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1__23_i_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1__23_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1__23_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__23_i_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__23_i_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1__23_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1__23_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1__23_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1__23_i_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1__23_i_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1__23_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_168to169_bb1__23_i_1_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1__23_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1__23_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1__23_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1__23_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1__23_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1__23_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_168to169_bb1__23_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__23_i_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__23_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1__23_i_0_NO_SHIFT_REG = rnode_169to170_bb1__23_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1__23_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1__23_i_1_NO_SHIFT_REG = rnode_169to170_bb1__23_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1__23_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1__23_i_2_NO_SHIFT_REG = rnode_169to170_bb1__23_i_0_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and19_i_stall_local;
wire [31:0] local_bb1_and19_i;

assign local_bb1_and19_i = (local_bb1_shr18_i & 32'hFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and21_i_stall_local;
wire [31:0] local_bb1_and21_i;

assign local_bb1_and21_i = (rnode_169to170_bb1__22_i_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_sub_i11_stall_local;
wire [31:0] local_bb1_sub_i11;

assign local_bb1_sub_i11 = (local_bb1_shr16_i - local_bb1_shr18_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and20_i_stall_local;
wire [31:0] local_bb1_and20_i;

assign local_bb1_and20_i = (rnode_169to170_bb1__23_i_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_and35_i_valid_out;
wire local_bb1_and35_i_stall_in;
wire local_bb1_and35_i_inputs_ready;
wire local_bb1_and35_i_stall_local;
wire [31:0] local_bb1_and35_i;

assign local_bb1_and35_i_inputs_ready = rnode_169to170_bb1__23_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_and35_i = (rnode_169to170_bb1__23_i_1_NO_SHIFT_REG & 32'h80000000);
assign local_bb1_and35_i_valid_out = 1'b1;
assign rnode_169to170_bb1__23_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_xor_i5_stall_local;
wire [31:0] local_bb1_xor_i5;

assign local_bb1_xor_i5 = (rnode_169to170_bb1__23_i_2_NO_SHIFT_REG ^ rnode_169to170_bb1__22_i_1_NO_SHIFT_REG);

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
 logic rnode_170to171_bb1_and35_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_and35_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb1_and35_i_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_and35_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb1_and35_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_and35_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_and35_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_and35_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_and35_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_and35_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_and35_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_and35_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_and35_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_and35_i),
	.data_out(rnode_170to171_bb1_and35_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_and35_i_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_and35_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb1_and35_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_and35_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_and35_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and35_i_stall_in = 1'b0;
assign rnode_170to171_bb1_and35_i_0_NO_SHIFT_REG = rnode_170to171_bb1_and35_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_and35_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_and35_i_0_valid_out_NO_SHIFT_REG = 1'b1;

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
 logic rnode_171to172_bb1_and35_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and35_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and35_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and35_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and35_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and35_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and35_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and35_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_and35_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_and35_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_and35_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_and35_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_and35_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_170to171_bb1_and35_i_0_NO_SHIFT_REG),
	.data_out(rnode_171to172_bb1_and35_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_and35_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_and35_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_and35_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_and35_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_and35_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_and35_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and35_i_0_NO_SHIFT_REG = rnode_171to172_bb1_and35_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_and35_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and35_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_align_0_i_stall_local;
wire [31:0] local_bb1_align_0_i;

assign local_bb1_align_0_i = (local_bb1_cmp69_i ? 32'h1F : local_bb1_and68_i);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_and35_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and35_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and35_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and35_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and35_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and35_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and35_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and35_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_and35_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_and35_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_and35_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_and35_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_and35_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_171to172_bb1_and35_i_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_and35_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_and35_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_and35_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_and35_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_and35_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_and35_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and35_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and35_i_0_NO_SHIFT_REG = rnode_172to173_bb1_and35_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_and35_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and35_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_and93_i_stall_local;
wire [31:0] local_bb1_and93_i;

assign local_bb1_and93_i = (local_bb1_align_0_i & 32'h1C);

// This section implements an unregistered operation.
// 
wire local_bb1_and95_i_stall_local;
wire [31:0] local_bb1_and95_i;

assign local_bb1_and95_i = (local_bb1_align_0_i & 32'h10);

// This section implements an unregistered operation.
// 
wire local_bb1_and115_i_stall_local;
wire [31:0] local_bb1_and115_i;

assign local_bb1_and115_i = (local_bb1_align_0_i & 32'h8);

// This section implements an unregistered operation.
// 
wire local_bb1_and130_i_stall_local;
wire [31:0] local_bb1_and130_i;

assign local_bb1_and130_i = (local_bb1_align_0_i & 32'h4);

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
wire local_bb1_and93_i_valid_out;
wire local_bb1_and93_i_stall_in;
 reg local_bb1_and93_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_and95_i_valid_out;
wire local_bb1_and95_i_stall_in;
 reg local_bb1_and95_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_and115_i_valid_out;
wire local_bb1_and115_i_stall_in;
 reg local_bb1_and115_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_and130_i_valid_out;
wire local_bb1_and130_i_stall_in;
 reg local_bb1_and130_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_and149_i_valid_out;
wire local_bb1_and149_i_stall_in;
 reg local_bb1_and149_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_and149_i_inputs_ready;
wire local_bb1_and149_i_stall_local;
wire [31:0] local_bb1_and149_i;

assign local_bb1_and149_i_inputs_ready = (rnode_168to169_bb1__22_i_0_valid_out_0_NO_SHIFT_REG & rnode_168to169_bb1__23_i_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_and149_i = (local_bb1_align_0_i & 32'h3);
assign local_bb1_shr16_i_valid_out_1 = 1'b1;
assign local_bb1_lnot23_i_valid_out = 1'b1;
assign local_bb1_cmp27_i_valid_out = 1'b1;
assign local_bb1_and93_i_valid_out = 1'b1;
assign local_bb1_and95_i_valid_out = 1'b1;
assign local_bb1_and115_i_valid_out = 1'b1;
assign local_bb1_and130_i_valid_out = 1'b1;
assign local_bb1_and149_i_valid_out = 1'b1;
assign rnode_168to169_bb1__22_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_168to169_bb1__23_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_shr16_i_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_lnot23_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp27_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and93_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and95_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and115_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and130_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and149_i_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_shr16_i_consumed_1_NO_SHIFT_REG <= (local_bb1_and149_i_inputs_ready & (local_bb1_shr16_i_consumed_1_NO_SHIFT_REG | ~(local_bb1_shr16_i_stall_in_1)) & local_bb1_and149_i_stall_local);
		local_bb1_lnot23_i_consumed_0_NO_SHIFT_REG <= (local_bb1_and149_i_inputs_ready & (local_bb1_lnot23_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_lnot23_i_stall_in)) & local_bb1_and149_i_stall_local);
		local_bb1_cmp27_i_consumed_0_NO_SHIFT_REG <= (local_bb1_and149_i_inputs_ready & (local_bb1_cmp27_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp27_i_stall_in)) & local_bb1_and149_i_stall_local);
		local_bb1_and93_i_consumed_0_NO_SHIFT_REG <= (local_bb1_and149_i_inputs_ready & (local_bb1_and93_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and93_i_stall_in)) & local_bb1_and149_i_stall_local);
		local_bb1_and95_i_consumed_0_NO_SHIFT_REG <= (local_bb1_and149_i_inputs_ready & (local_bb1_and95_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and95_i_stall_in)) & local_bb1_and149_i_stall_local);
		local_bb1_and115_i_consumed_0_NO_SHIFT_REG <= (local_bb1_and149_i_inputs_ready & (local_bb1_and115_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and115_i_stall_in)) & local_bb1_and149_i_stall_local);
		local_bb1_and130_i_consumed_0_NO_SHIFT_REG <= (local_bb1_and149_i_inputs_ready & (local_bb1_and130_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and130_i_stall_in)) & local_bb1_and149_i_stall_local);
		local_bb1_and149_i_consumed_0_NO_SHIFT_REG <= (local_bb1_and149_i_inputs_ready & (local_bb1_and149_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and149_i_stall_in)) & local_bb1_and149_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_shr16_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_shr16_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_shr16_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_shr16_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_shr16_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_shr16_i_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_shr16_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_shr16_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_shr16_i_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_shr16_i_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_shr16_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_shr16_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_shr16_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_shr16_i_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_shr16_i_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_shr16_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_shr16_i),
	.data_out(rnode_169to170_bb1_shr16_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_shr16_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_shr16_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1_shr16_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_shr16_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_shr16_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr16_i_stall_in_1 = 1'b0;
assign rnode_169to170_bb1_shr16_i_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_shr16_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_shr16_i_0_NO_SHIFT_REG = rnode_169to170_bb1_shr16_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_shr16_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_shr16_i_1_NO_SHIFT_REG = rnode_169to170_bb1_shr16_i_0_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_lnot23_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot23_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot23_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot23_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot23_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot23_i_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot23_i_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lnot23_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_lnot23_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_lnot23_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_lnot23_i_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_lnot23_i_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_lnot23_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_lnot23_i),
	.data_out(rnode_169to170_bb1_lnot23_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_lnot23_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_lnot23_i_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_lnot23_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_lnot23_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_lnot23_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lnot23_i_stall_in = 1'b0;
assign rnode_169to170_bb1_lnot23_i_0_NO_SHIFT_REG = rnode_169to170_bb1_lnot23_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_lnot23_i_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_lnot23_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_cmp27_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cmp27_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_cmp27_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_cmp27_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_cmp27_i_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_cmp27_i_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_cmp27_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_cmp27_i),
	.data_out(rnode_169to170_bb1_cmp27_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_cmp27_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_cmp27_i_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_cmp27_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_cmp27_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_cmp27_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp27_i_stall_in = 1'b0;
assign rnode_169to170_bb1_cmp27_i_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp27_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp27_i_0_NO_SHIFT_REG = rnode_169to170_bb1_cmp27_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cmp27_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp27_i_1_NO_SHIFT_REG = rnode_169to170_bb1_cmp27_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cmp27_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_cmp27_i_2_NO_SHIFT_REG = rnode_169to170_bb1_cmp27_i_0_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_and93_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and93_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and93_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and93_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and93_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and93_i_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and93_i_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and93_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_and93_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_and93_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_and93_i_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_and93_i_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_and93_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_and93_i),
	.data_out(rnode_169to170_bb1_and93_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_and93_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_and93_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1_and93_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_and93_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_and93_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and93_i_stall_in = 1'b0;
assign rnode_169to170_bb1_and93_i_0_NO_SHIFT_REG = rnode_169to170_bb1_and93_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_and93_i_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and93_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_and95_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and95_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and95_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and95_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and95_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and95_i_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and95_i_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and95_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_and95_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_and95_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_and95_i_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_and95_i_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_and95_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_and95_i),
	.data_out(rnode_169to170_bb1_and95_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_and95_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_and95_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1_and95_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_and95_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_and95_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and95_i_stall_in = 1'b0;
assign rnode_169to170_bb1_and95_i_0_NO_SHIFT_REG = rnode_169to170_bb1_and95_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_and95_i_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and95_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_and115_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and115_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and115_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and115_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and115_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and115_i_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and115_i_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and115_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_and115_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_and115_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_and115_i_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_and115_i_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_and115_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_and115_i),
	.data_out(rnode_169to170_bb1_and115_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_and115_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_and115_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1_and115_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_and115_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_and115_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and115_i_stall_in = 1'b0;
assign rnode_169to170_bb1_and115_i_0_NO_SHIFT_REG = rnode_169to170_bb1_and115_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_and115_i_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and115_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_and130_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and130_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and130_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and130_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and130_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and130_i_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and130_i_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and130_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_and130_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_and130_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_and130_i_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_and130_i_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_and130_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_and130_i),
	.data_out(rnode_169to170_bb1_and130_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_and130_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_and130_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1_and130_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_and130_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_and130_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and130_i_stall_in = 1'b0;
assign rnode_169to170_bb1_and130_i_0_NO_SHIFT_REG = rnode_169to170_bb1_and130_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_and130_i_0_stall_in_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and130_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_and149_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and149_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and149_i_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and149_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and149_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and149_i_1_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and149_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and149_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and149_i_2_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and149_i_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_169to170_bb1_and149_i_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and149_i_0_valid_out_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and149_i_0_stall_in_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_and149_i_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_and149_i_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_and149_i_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_and149_i_0_stall_in_0_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_and149_i_0_valid_out_0_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_and149_i_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(local_bb1_and149_i),
	.data_out(rnode_169to170_bb1_and149_i_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_and149_i_0_reg_170_fifo.DEPTH = 1;
defparam rnode_169to170_bb1_and149_i_0_reg_170_fifo.DATA_WIDTH = 32;
defparam rnode_169to170_bb1_and149_i_0_reg_170_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_169to170_bb1_and149_i_0_reg_170_fifo.IMPL = "shift_reg";

assign rnode_169to170_bb1_and149_i_0_reg_170_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and149_i_stall_in = 1'b0;
assign rnode_169to170_bb1_and149_i_0_stall_in_0_reg_170_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and149_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_and149_i_0_NO_SHIFT_REG = rnode_169to170_bb1_and149_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_and149_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_and149_i_1_NO_SHIFT_REG = rnode_169to170_bb1_and149_i_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_and149_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_and149_i_2_NO_SHIFT_REG = rnode_169to170_bb1_and149_i_0_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and17_i_stall_local;
wire [31:0] local_bb1_and17_i;

assign local_bb1_and17_i = (rnode_169to170_bb1_shr16_i_0_NO_SHIFT_REG & 32'hFF);

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_170to172_bb1_shr16_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to172_bb1_shr16_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to172_bb1_shr16_i_0_NO_SHIFT_REG;
 logic rnode_170to172_bb1_shr16_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to172_bb1_shr16_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_shr16_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_shr16_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_shr16_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_170to172_bb1_shr16_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to172_bb1_shr16_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to172_bb1_shr16_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_170to172_bb1_shr16_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_170to172_bb1_shr16_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_169to170_bb1_shr16_i_1_NO_SHIFT_REG),
	.data_out(rnode_170to172_bb1_shr16_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_170to172_bb1_shr16_i_0_reg_172_fifo.DEPTH = 2;
defparam rnode_170to172_bb1_shr16_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_170to172_bb1_shr16_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to172_bb1_shr16_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_170to172_bb1_shr16_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_169to170_bb1_shr16_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_shr16_i_0_NO_SHIFT_REG = rnode_170to172_bb1_shr16_i_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb1_shr16_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_shr16_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1__28_i10_stall_local;
wire [31:0] local_bb1__28_i10;

assign local_bb1__28_i10 = (rnode_169to170_bb1_lnot23_i_0_NO_SHIFT_REG ? 32'h0 : local_bb1_shl65_i);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge_not_i_stall_local;
wire local_bb1_brmerge_not_i;

assign local_bb1_brmerge_not_i = (rnode_169to170_bb1_cmp27_i_0_NO_SHIFT_REG & local_bb1_lnot33_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp96_i_stall_local;
wire local_bb1_cmp96_i;

assign local_bb1_cmp96_i = (rnode_169to170_bb1_and95_i_0_NO_SHIFT_REG == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp116_i_stall_local;
wire local_bb1_cmp116_i;

assign local_bb1_cmp116_i = (rnode_169to170_bb1_and115_i_0_NO_SHIFT_REG == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp131_not_i_stall_local;
wire local_bb1_cmp131_not_i;

assign local_bb1_cmp131_not_i = (rnode_169to170_bb1_and130_i_0_NO_SHIFT_REG != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_Pivot20_i_stall_local;
wire local_bb1_Pivot20_i;

assign local_bb1_Pivot20_i = (rnode_169to170_bb1_and149_i_1_NO_SHIFT_REG < 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1_SwitchLeaf_i_stall_local;
wire local_bb1_SwitchLeaf_i;

assign local_bb1_SwitchLeaf_i = (rnode_169to170_bb1_and149_i_2_NO_SHIFT_REG == 32'h1);

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
wire local_bb1_shr94_i_stall_local;
wire [31:0] local_bb1_shr94_i;

assign local_bb1_shr94_i = (local_bb1__28_i10 >> rnode_169to170_bb1_and93_i_0_NO_SHIFT_REG);

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
wire local_bb1_var__u18_stall_local;
wire [31:0] local_bb1_var__u18;

assign local_bb1_var__u18 = (local_bb1__28_i10 & 32'hFFF8);

// This section implements an unregistered operation.
// 
wire local_bb1_brmerge_not_not_i_stall_local;
wire local_bb1_brmerge_not_not_i;

assign local_bb1_brmerge_not_not_i = (local_bb1_brmerge_not_i ^ 1'b1);

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
wire local_bb1_var__u19_stall_local;
wire local_bb1_var__u19;

assign local_bb1_var__u19 = (local_bb1_cmp25_i | rnode_169to170_bb1_cmp27_i_2_NO_SHIFT_REG);

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
wire local_bb1_and142_i_stall_local;
wire [31:0] local_bb1_and142_i;

assign local_bb1_and142_i = (local_bb1_shr94_i >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_shr150_i_stall_local;
wire [31:0] local_bb1_shr150_i;

assign local_bb1_shr150_i = (local_bb1_shr94_i >> rnode_169to170_bb1_and149_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u20_stall_local;
wire [31:0] local_bb1_var__u20;

assign local_bb1_var__u20 = (local_bb1_shr94_i & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_and146_i_stall_local;
wire [31:0] local_bb1_and146_i;

assign local_bb1_and146_i = (local_bb1_shr94_i >> 32'h2);

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
wire local_bb1_var__u21_stall_local;
wire local_bb1_var__u21;

assign local_bb1_var__u21 = (local_bb1_var__u18 != 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_7_i_stall_local;
wire local_bb1_reduction_7_i;

assign local_bb1_reduction_7_i = (local_bb1_cmp25_i & local_bb1_brmerge_not_not_i);

// This section implements an unregistered operation.
// 
wire local_bb1_add_i22_stall_local;
wire [31:0] local_bb1_add_i22;

assign local_bb1_add_i22 = (local_bb1__27_i9 | local_bb1_and36_lobit_i);

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
wire local_bb1_var__u22_stall_local;
wire [31:0] local_bb1_var__u22;

assign local_bb1_var__u22 = (local_bb1_and146_i | local_bb1_shr94_i);

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
assign local_bb1_or107_i[0] = local_bb1_var__u21;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_8_i_stall_local;
wire local_bb1_reduction_8_i;

assign local_bb1_reduction_8_i = (rnode_169to170_bb1_cmp27_i_1_NO_SHIFT_REG & local_bb1_or_cond_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or1596_i_stall_local;
wire [31:0] local_bb1_or1596_i;

assign local_bb1_or1596_i = (local_bb1_var__u22 | local_bb1_and142_i);

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
wire local_bb1_reduction_9_i_stall_local;
wire local_bb1_reduction_9_i;

assign local_bb1_reduction_9_i = (local_bb1_reduction_7_i & local_bb1_reduction_8_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or162_i_stall_local;
wire [31:0] local_bb1_or162_i;

assign local_bb1_or162_i = (local_bb1_or1596_i & 32'h1);

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
wire local_bb1__26_i_stall_local;
wire local_bb1__26_i;

assign local_bb1__26_i = (local_bb1_reduction_9_i ? local_bb1_cmp37_i : local_bb1__24_i6);

// This section implements an unregistered operation.
// 
wire local_bb1__37_v_i_stall_local;
wire [31:0] local_bb1__37_v_i;

assign local_bb1__37_v_i = (local_bb1_Pivot20_i ? 32'h0 : local_bb1_or162_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or123_i_stall_local;
wire [31:0] local_bb1_or123_i;

assign local_bb1_or123_i[31:8] = 24'h0;
assign local_bb1_or123_i[7:0] = local_bb1_or1237_i;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u23_stall_local;
wire [7:0] local_bb1_var__u23;

assign local_bb1_var__u23 = (local_bb1__33_i18 & 8'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__39_v_i_stall_local;
wire [31:0] local_bb1__39_v_i;

assign local_bb1__39_v_i = (local_bb1_SwitchLeaf_i ? local_bb1_var__u20 : local_bb1__37_v_i);

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
assign local_bb1_conv135_i[7:0] = local_bb1_var__u23;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_3_i19_stall_local;
wire [31:0] local_bb1_reduction_3_i19;

assign local_bb1_reduction_3_i19 = (local_bb1__32_i17 | local_bb1_or124_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or136_i_stall_local;
wire [31:0] local_bb1_or136_i;

assign local_bb1_or136_i = (local_bb1_cmp131_not_i ? local_bb1_conv135_i : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_5_i20_stall_local;
wire [31:0] local_bb1_reduction_5_i20;

assign local_bb1_reduction_5_i20 = (local_bb1_shr150_i | local_bb1_reduction_3_i19);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_4_i_stall_local;
wire [31:0] local_bb1_reduction_4_i;

assign local_bb1_reduction_4_i = (local_bb1_or136_i | local_bb1__39_v_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_6_i21_stall_local;
wire [31:0] local_bb1_reduction_6_i21;

assign local_bb1_reduction_6_i21 = (local_bb1_reduction_4_i | local_bb1_reduction_5_i20);

// This section implements an unregistered operation.
// 
wire local_bb1_xor188_i_stall_local;
wire [31:0] local_bb1_xor188_i;

assign local_bb1_xor188_i = (local_bb1_reduction_6_i21 ^ local_bb1_xor_lobit_i);

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
wire local_bb1_var__u19_valid_out;
wire local_bb1_var__u19_stall_in;
 reg local_bb1_var__u19_consumed_0_NO_SHIFT_REG;
wire local_bb1_add192_i_inputs_ready;
wire local_bb1_add192_i_stall_local;
wire [31:0] local_bb1_add192_i;

assign local_bb1_add192_i_inputs_ready = (rnode_169to170_bb1__22_i_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_cmp27_i_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_lnot23_i_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_and93_i_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1__22_i_0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb1__23_i_0_valid_out_2_NO_SHIFT_REG & rnode_169to170_bb1__23_i_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_cmp27_i_0_valid_out_1_NO_SHIFT_REG & rnode_169to170_bb1_shr16_i_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_cmp27_i_0_valid_out_2_NO_SHIFT_REG & rnode_169to170_bb1_and149_i_0_valid_out_0_NO_SHIFT_REG & rnode_169to170_bb1_and95_i_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_and149_i_0_valid_out_2_NO_SHIFT_REG & rnode_169to170_bb1_and115_i_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_and130_i_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_and149_i_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_add192_i = (local_bb1_add_i22 + local_bb1_xor188_i);
assign local_bb1_cmp37_i_valid_out_1 = 1'b1;
assign local_bb1__26_i_valid_out = 1'b1;
assign local_bb1_add192_i_valid_out = 1'b1;
assign local_bb1_and17_i_valid_out_2 = 1'b1;
assign local_bb1_var__u19_valid_out = 1'b1;
assign rnode_169to170_bb1__22_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp27_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_lnot23_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and93_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__22_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__23_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1__23_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp27_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_shr16_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_cmp27_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and149_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and95_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and149_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and115_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and130_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_169to170_bb1_and149_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_cmp37_i_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1__26_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_add192_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_and17_i_consumed_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_var__u19_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_cmp37_i_consumed_1_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1_cmp37_i_consumed_1_NO_SHIFT_REG | ~(local_bb1_cmp37_i_stall_in_1)) & local_bb1_add192_i_stall_local);
		local_bb1__26_i_consumed_0_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1__26_i_consumed_0_NO_SHIFT_REG | ~(local_bb1__26_i_stall_in)) & local_bb1_add192_i_stall_local);
		local_bb1_add192_i_consumed_0_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1_add192_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_add192_i_stall_in)) & local_bb1_add192_i_stall_local);
		local_bb1_and17_i_consumed_2_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1_and17_i_consumed_2_NO_SHIFT_REG | ~(local_bb1_and17_i_stall_in_2)) & local_bb1_add192_i_stall_local);
		local_bb1_var__u19_consumed_0_NO_SHIFT_REG <= (local_bb1_add192_i_inputs_ready & (local_bb1_var__u19_consumed_0_NO_SHIFT_REG | ~(local_bb1_var__u19_stall_in)) & local_bb1_add192_i_stall_local);
	end
end


// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_170to172_bb1_cmp37_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_1_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_2_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_cmp37_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_170to172_bb1_cmp37_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to172_bb1_cmp37_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to172_bb1_cmp37_i_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_170to172_bb1_cmp37_i_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_170to172_bb1_cmp37_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_cmp37_i),
	.data_out(rnode_170to172_bb1_cmp37_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_170to172_bb1_cmp37_i_0_reg_172_fifo.DEPTH = 2;
defparam rnode_170to172_bb1_cmp37_i_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_170to172_bb1_cmp37_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to172_bb1_cmp37_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_170to172_bb1_cmp37_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp37_i_stall_in_1 = 1'b0;
assign rnode_170to172_bb1_cmp37_i_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_cmp37_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to172_bb1_cmp37_i_0_NO_SHIFT_REG = rnode_170to172_bb1_cmp37_i_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb1_cmp37_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to172_bb1_cmp37_i_1_NO_SHIFT_REG = rnode_170to172_bb1_cmp37_i_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb1_cmp37_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_170to172_bb1_cmp37_i_2_NO_SHIFT_REG = rnode_170to172_bb1_cmp37_i_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1__26_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1__26_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to171_bb1__26_i_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1__26_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to171_bb1__26_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__26_i_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__26_i_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1__26_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1__26_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1__26_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1__26_i_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1__26_i_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1__26_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1__26_i),
	.data_out(rnode_170to171_bb1__26_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1__26_i_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1__26_i_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_170to171_bb1__26_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1__26_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1__26_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__26_i_stall_in = 1'b0;
assign rnode_170to171_bb1__26_i_0_NO_SHIFT_REG = rnode_170to171_bb1__26_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1__26_i_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1__26_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_add192_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb1_add192_i_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb1_add192_i_1_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb1_add192_i_2_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_valid_out_3_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_stall_in_3_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb1_add192_i_3_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to171_bb1_add192_i_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_valid_out_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_stall_in_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_add192_i_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_add192_i_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_add192_i_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_add192_i_0_stall_in_0_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_add192_i_0_valid_out_0_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_add192_i_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_add192_i),
	.data_out(rnode_170to171_bb1_add192_i_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_add192_i_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_add192_i_0_reg_171_fifo.DATA_WIDTH = 32;
defparam rnode_170to171_bb1_add192_i_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_add192_i_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_add192_i_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add192_i_stall_in = 1'b0;
assign rnode_170to171_bb1_add192_i_0_stall_in_0_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_add192_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_add192_i_0_NO_SHIFT_REG = rnode_170to171_bb1_add192_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_add192_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_add192_i_1_NO_SHIFT_REG = rnode_170to171_bb1_add192_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_add192_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_add192_i_2_NO_SHIFT_REG = rnode_170to171_bb1_add192_i_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_add192_i_0_valid_out_3_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_add192_i_3_NO_SHIFT_REG = rnode_170to171_bb1_add192_i_0_reg_171_NO_SHIFT_REG;

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_170to172_bb1_and17_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and17_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_170to172_bb1_and17_i_0_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and17_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_170to172_bb1_and17_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and17_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and17_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_170to172_bb1_and17_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_170to172_bb1_and17_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to172_bb1_and17_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to172_bb1_and17_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_170to172_bb1_and17_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_170to172_bb1_and17_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_and17_i),
	.data_out(rnode_170to172_bb1_and17_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_170to172_bb1_and17_i_0_reg_172_fifo.DEPTH = 2;
defparam rnode_170to172_bb1_and17_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_170to172_bb1_and17_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to172_bb1_and17_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_170to172_bb1_and17_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and17_i_stall_in_2 = 1'b0;
assign rnode_170to172_bb1_and17_i_0_NO_SHIFT_REG = rnode_170to172_bb1_and17_i_0_reg_172_NO_SHIFT_REG;
assign rnode_170to172_bb1_and17_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_and17_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_170to171_bb1_var__u19_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u19_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u19_0_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u19_0_reg_171_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u19_0_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u19_0_valid_out_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u19_0_stall_in_reg_171_NO_SHIFT_REG;
 logic rnode_170to171_bb1_var__u19_0_stall_out_reg_171_NO_SHIFT_REG;

acl_data_fifo rnode_170to171_bb1_var__u19_0_reg_171_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to171_bb1_var__u19_0_reg_171_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to171_bb1_var__u19_0_stall_in_reg_171_NO_SHIFT_REG),
	.valid_out(rnode_170to171_bb1_var__u19_0_valid_out_reg_171_NO_SHIFT_REG),
	.stall_out(rnode_170to171_bb1_var__u19_0_stall_out_reg_171_NO_SHIFT_REG),
	.data_in(local_bb1_var__u19),
	.data_out(rnode_170to171_bb1_var__u19_0_reg_171_NO_SHIFT_REG)
);

defparam rnode_170to171_bb1_var__u19_0_reg_171_fifo.DEPTH = 1;
defparam rnode_170to171_bb1_var__u19_0_reg_171_fifo.DATA_WIDTH = 1;
defparam rnode_170to171_bb1_var__u19_0_reg_171_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_170to171_bb1_var__u19_0_reg_171_fifo.IMPL = "shift_reg";

assign rnode_170to171_bb1_var__u19_0_reg_171_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u19_stall_in = 1'b0;
assign rnode_170to171_bb1_var__u19_0_NO_SHIFT_REG = rnode_170to171_bb1_var__u19_0_reg_171_NO_SHIFT_REG;
assign rnode_170to171_bb1_var__u19_0_stall_in_reg_171_NO_SHIFT_REG = 1'b0;
assign rnode_170to171_bb1_var__u19_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_not_cmp37_i_stall_local;
wire local_bb1_not_cmp37_i;

assign local_bb1_not_cmp37_i = (rnode_170to172_bb1_cmp37_i_1_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1__26_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1__26_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_171to172_bb1__26_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1__26_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb1__26_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1__26_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1__26_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1__26_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1__26_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1__26_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1__26_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1__26_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1__26_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_170to171_bb1__26_i_0_NO_SHIFT_REG),
	.data_out(rnode_171to172_bb1__26_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1__26_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1__26_i_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb1__26_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1__26_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1__26_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1__26_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1__26_i_0_NO_SHIFT_REG = rnode_171to172_bb1__26_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1__26_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1__26_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_and193_i_valid_out;
wire local_bb1_and193_i_stall_in;
wire local_bb1_and193_i_inputs_ready;
wire local_bb1_and193_i_stall_local;
wire [31:0] local_bb1_and193_i;

assign local_bb1_and193_i_inputs_ready = rnode_170to171_bb1_add192_i_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_and193_i = (rnode_170to171_bb1_add192_i_0_NO_SHIFT_REG & 32'hFFFFFFF);
assign local_bb1_and193_i_valid_out = 1'b1;
assign rnode_170to171_bb1_add192_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_and195_i_valid_out;
wire local_bb1_and195_i_stall_in;
wire local_bb1_and195_i_inputs_ready;
wire local_bb1_and195_i_stall_local;
wire [31:0] local_bb1_and195_i;

assign local_bb1_and195_i_inputs_ready = rnode_170to171_bb1_add192_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_and195_i = (rnode_170to171_bb1_add192_i_1_NO_SHIFT_REG >> 32'h1B);
assign local_bb1_and195_i_valid_out = 1'b1;
assign rnode_170to171_bb1_add192_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_and198_i_valid_out;
wire local_bb1_and198_i_stall_in;
wire local_bb1_and198_i_inputs_ready;
wire local_bb1_and198_i_stall_local;
wire [31:0] local_bb1_and198_i;

assign local_bb1_and198_i_inputs_ready = rnode_170to171_bb1_add192_i_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1_and198_i = (rnode_170to171_bb1_add192_i_2_NO_SHIFT_REG & 32'h1);
assign local_bb1_and198_i_valid_out = 1'b1;
assign rnode_170to171_bb1_add192_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_and201_i_stall_local;
wire [31:0] local_bb1_and201_i;

assign local_bb1_and201_i = (rnode_170to171_bb1_add192_i_3_NO_SHIFT_REG & 32'h7FFFFFF);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_var__u19_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_var__u19_0_stall_in_NO_SHIFT_REG;
 logic rnode_171to172_bb1_var__u19_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_var__u19_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic rnode_171to172_bb1_var__u19_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_var__u19_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_var__u19_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_var__u19_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_var__u19_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_var__u19_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_var__u19_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_var__u19_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_var__u19_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(rnode_170to171_bb1_var__u19_0_NO_SHIFT_REG),
	.data_out(rnode_171to172_bb1_var__u19_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_var__u19_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_var__u19_0_reg_172_fifo.DATA_WIDTH = 1;
defparam rnode_171to172_bb1_var__u19_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_var__u19_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_var__u19_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_170to171_bb1_var__u19_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_var__u19_0_NO_SHIFT_REG = rnode_171to172_bb1_var__u19_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_var__u19_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_var__u19_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1__26_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_2_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__26_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1__26_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1__26_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1__26_i_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1__26_i_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1__26_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_171to172_bb1__26_i_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1__26_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1__26_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1__26_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1__26_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1__26_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1__26_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1__26_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__26_i_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__26_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__26_i_0_NO_SHIFT_REG = rnode_172to173_bb1__26_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__26_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__26_i_1_NO_SHIFT_REG = rnode_172to173_bb1__26_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__26_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__26_i_2_NO_SHIFT_REG = rnode_172to173_bb1__26_i_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_and193_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and193_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and193_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and193_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and193_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and193_i_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and193_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and193_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and193_i_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and193_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and193_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and193_i_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and193_i_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and193_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_and193_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_and193_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_and193_i_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_and193_i_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_and193_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_and193_i),
	.data_out(rnode_171to172_bb1_and193_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_and193_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_and193_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_and193_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_and193_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_and193_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and193_i_stall_in = 1'b0;
assign rnode_171to172_bb1_and193_i_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and193_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and193_i_0_NO_SHIFT_REG = rnode_171to172_bb1_and193_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_and193_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and193_i_1_NO_SHIFT_REG = rnode_171to172_bb1_and193_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_and193_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_and193_i_2_NO_SHIFT_REG = rnode_171to172_bb1_and193_i_0_reg_172_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_and195_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and195_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and195_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and195_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and195_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and195_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and195_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and195_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_and195_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_and195_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_and195_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_and195_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_and195_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_and195_i),
	.data_out(rnode_171to172_bb1_and195_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_and195_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_and195_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_and195_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_and195_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_and195_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and195_i_stall_in = 1'b0;
assign rnode_171to172_bb1_and195_i_0_NO_SHIFT_REG = rnode_171to172_bb1_and195_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_and195_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and195_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1_and198_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and198_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and198_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and198_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1_and198_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and198_i_0_valid_out_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and198_i_0_stall_in_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1_and198_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1_and198_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1_and198_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1_and198_i_0_stall_in_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1_and198_i_0_valid_out_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1_and198_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1_and198_i),
	.data_out(rnode_171to172_bb1_and198_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1_and198_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1_and198_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1_and198_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1_and198_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1_and198_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and198_i_stall_in = 1'b0;
assign rnode_171to172_bb1_and198_i_0_NO_SHIFT_REG = rnode_171to172_bb1_and198_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1_and198_i_0_stall_in_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and198_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shr_i_i23_stall_local;
wire [31:0] local_bb1_shr_i_i23;

assign local_bb1_shr_i_i23 = (local_bb1_and201_i >> 32'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_var__u19_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_var__u19_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_var__u19_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_var__u19_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_var__u19_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_var__u19_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_var__u19_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_var__u19_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_var__u19_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_var__u19_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_var__u19_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_var__u19_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_var__u19_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(rnode_171to172_bb1_var__u19_0_NO_SHIFT_REG),
	.data_out(rnode_172to173_bb1_var__u19_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_var__u19_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_var__u19_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_var__u19_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_var__u19_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_var__u19_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1_var__u19_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_var__u19_0_NO_SHIFT_REG = rnode_172to173_bb1_var__u19_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_var__u19_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_var__u19_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_cond292_i_stall_local;
wire [31:0] local_bb1_cond292_i;

assign local_bb1_cond292_i = (rnode_172to173_bb1__26_i_1_NO_SHIFT_REG ? 32'h400000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u24_stall_local;
wire [31:0] local_bb1_var__u24;

assign local_bb1_var__u24[31:1] = 31'h0;
assign local_bb1_var__u24[0] = rnode_172to173_bb1__26_i_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_shr216_i_stall_local;
wire [31:0] local_bb1_shr216_i;

assign local_bb1_shr216_i = (rnode_171to172_bb1_and193_i_1_NO_SHIFT_REG >> 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1__pre_i_stall_local;
wire [31:0] local_bb1__pre_i;

assign local_bb1__pre_i = (rnode_171to172_bb1_and195_i_0_NO_SHIFT_REG & 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_or_i_i24_stall_local;
wire [31:0] local_bb1_or_i_i24;

assign local_bb1_or_i_i24 = (local_bb1_shr_i_i23 | local_bb1_and201_i);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_ext_i_stall_local;
wire [31:0] local_bb1_lnot_ext_i;

assign local_bb1_lnot_ext_i = (local_bb1_var__u24 ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_or219_i_stall_local;
wire [31:0] local_bb1_or219_i;

assign local_bb1_or219_i = (local_bb1_shr216_i | rnode_171to172_bb1_and198_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_tobool213_i_stall_local;
wire local_bb1_tobool213_i;

assign local_bb1_tobool213_i = (local_bb1__pre_i == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_shr1_i_i_stall_local;
wire [31:0] local_bb1_shr1_i_i;

assign local_bb1_shr1_i_i = (local_bb1_or_i_i24 >> 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb1__40_demorgan_i_stall_local;
wire local_bb1__40_demorgan_i;

assign local_bb1__40_demorgan_i = (rnode_170to172_bb1_cmp37_i_0_NO_SHIFT_REG | local_bb1_tobool213_i);

// This section implements an unregistered operation.
// 
wire local_bb1__42_i_stall_local;
wire local_bb1__42_i;

assign local_bb1__42_i = (local_bb1_tobool213_i & local_bb1_not_cmp37_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or2_i_i_stall_local;
wire [31:0] local_bb1_or2_i_i;

assign local_bb1_or2_i_i = (local_bb1_shr1_i_i | local_bb1_or_i_i24);

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


assign local_bb1__and_i_i_inputs_ready = rnode_170to171_bb1_add192_i_0_valid_out_3_NO_SHIFT_REG;
assign local_bb1__and_i_i_valid_out = 1'b1;
assign rnode_170to171_bb1_add192_i_0_stall_in_3_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_171to172_bb1__and_i_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1__and_i_i_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1__and_i_i_0_NO_SHIFT_REG;
 logic rnode_171to172_bb1__and_i_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1__and_i_i_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1__and_i_i_1_NO_SHIFT_REG;
 logic rnode_171to172_bb1__and_i_i_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1__and_i_i_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1__and_i_i_2_NO_SHIFT_REG;
 logic rnode_171to172_bb1__and_i_i_0_reg_172_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_171to172_bb1__and_i_i_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1__and_i_i_0_valid_out_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1__and_i_i_0_stall_in_0_reg_172_NO_SHIFT_REG;
 logic rnode_171to172_bb1__and_i_i_0_stall_out_reg_172_NO_SHIFT_REG;

acl_data_fifo rnode_171to172_bb1__and_i_i_0_reg_172_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_171to172_bb1__and_i_i_0_reg_172_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_171to172_bb1__and_i_i_0_stall_in_0_reg_172_NO_SHIFT_REG),
	.valid_out(rnode_171to172_bb1__and_i_i_0_valid_out_0_reg_172_NO_SHIFT_REG),
	.stall_out(rnode_171to172_bb1__and_i_i_0_stall_out_reg_172_NO_SHIFT_REG),
	.data_in(local_bb1__and_i_i),
	.data_out(rnode_171to172_bb1__and_i_i_0_reg_172_NO_SHIFT_REG)
);

defparam rnode_171to172_bb1__and_i_i_0_reg_172_fifo.DEPTH = 1;
defparam rnode_171to172_bb1__and_i_i_0_reg_172_fifo.DATA_WIDTH = 32;
defparam rnode_171to172_bb1__and_i_i_0_reg_172_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_171to172_bb1__and_i_i_0_reg_172_fifo.IMPL = "shift_reg";

assign rnode_171to172_bb1__and_i_i_0_reg_172_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__and_i_i_stall_in = 1'b0;
assign rnode_171to172_bb1__and_i_i_0_stall_in_0_reg_172_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1__and_i_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1__and_i_i_0_NO_SHIFT_REG = rnode_171to172_bb1__and_i_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1__and_i_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1__and_i_i_1_NO_SHIFT_REG = rnode_171to172_bb1__and_i_i_0_reg_172_NO_SHIFT_REG;
assign rnode_171to172_bb1__and_i_i_0_valid_out_2_NO_SHIFT_REG = 1'b1;
assign rnode_171to172_bb1__and_i_i_2_NO_SHIFT_REG = rnode_171to172_bb1__and_i_i_0_reg_172_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_and9_i_i_stall_local;
wire [31:0] local_bb1_and9_i_i;

assign local_bb1_and9_i_i = (rnode_171to172_bb1__and_i_i_0_NO_SHIFT_REG & 32'h1F);

// This section implements an unregistered operation.
// 
wire local_bb1_and203_i_stall_local;
wire [31:0] local_bb1_and203_i;

assign local_bb1_and203_i = (rnode_171to172_bb1__and_i_i_1_NO_SHIFT_REG & 32'h18);

// This section implements an unregistered operation.
// 
wire local_bb1_and206_i_stall_local;
wire [31:0] local_bb1_and206_i;

assign local_bb1_and206_i = (rnode_171to172_bb1__and_i_i_2_NO_SHIFT_REG & 32'h7);

// This section implements an unregistered operation.
// 
wire local_bb1_sub239_i_stall_local;
wire [31:0] local_bb1_sub239_i;

assign local_bb1_sub239_i = (32'h0 - local_bb1_and9_i_i);

// This section implements an unregistered operation.
// 
wire local_bb1_shl204_i_stall_local;
wire [31:0] local_bb1_shl204_i;

assign local_bb1_shl204_i = (rnode_171to172_bb1_and193_i_0_NO_SHIFT_REG << local_bb1_and203_i);

// This section implements an unregistered operation.
// 
wire local_bb1_cond244_i_stall_local;
wire [31:0] local_bb1_cond244_i;

assign local_bb1_cond244_i = (rnode_170to172_bb1_cmp37_i_2_NO_SHIFT_REG ? local_bb1_sub239_i : local_bb1__43_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and205_i_stall_local;
wire [31:0] local_bb1_and205_i;

assign local_bb1_and205_i = (local_bb1_shl204_i & 32'h7FFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_add245_i_stall_local;
wire [31:0] local_bb1_add245_i;

assign local_bb1_add245_i = (local_bb1_cond244_i + rnode_170to172_bb1_and17_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_fold_i_stall_local;
wire [31:0] local_bb1_fold_i;

assign local_bb1_fold_i = (local_bb1_cond244_i + rnode_170to172_bb1_shr16_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_shl207_i_stall_local;
wire [31:0] local_bb1_shl207_i;

assign local_bb1_shl207_i = (local_bb1_and205_i << local_bb1_and206_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and247_i_stall_local;
wire [31:0] local_bb1_and247_i;

assign local_bb1_and247_i = (local_bb1_add245_i & 32'h100);

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
wire local_bb1_notlhs_i_stall_local;
wire local_bb1_notlhs_i;

assign local_bb1_notlhs_i = (local_bb1_and247_i != 32'h0);

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
wire local_bb1_not__46_i_stall_local;
wire local_bb1_not__46_i;

assign local_bb1_not__46_i = (local_bb1_notrhs_i | local_bb1_notlhs_i);

// This section implements an unregistered operation.
// 
wire local_bb1__45_i_stall_local;
wire [31:0] local_bb1__45_i;

assign local_bb1__45_i = (local_bb1__42_i ? rnode_171to172_bb1_and193_i_2_NO_SHIFT_REG : local_bb1__44_i);

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
wire local_bb1_cmp299_i_stall_local;
wire local_bb1_cmp299_i;

assign local_bb1_cmp299_i = (local_bb1_and270_i == 32'h4);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp226_not_i_stall_local;
wire local_bb1_cmp226_not_i;

assign local_bb1_cmp226_not_i = (local_bb1_cmp226_i ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1__47_i_stall_local;
wire local_bb1__47_i;

assign local_bb1__47_i = (local_bb1_cmp226_i | local_bb1_not__46_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and269_i_valid_out;
wire local_bb1_and269_i_stall_in;
 reg local_bb1_and269_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_add245_i_valid_out_1;
wire local_bb1_add245_i_stall_in_1;
 reg local_bb1_add245_i_consumed_1_NO_SHIFT_REG;
wire local_bb1_brmerge12_i_valid_out;
wire local_bb1_brmerge12_i_stall_in;
 reg local_bb1_brmerge12_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_shr271_i_valid_out;
wire local_bb1_shr271_i_stall_in;
 reg local_bb1_shr271_i_consumed_0_NO_SHIFT_REG;
wire local_bb1__47_i_valid_out;
wire local_bb1__47_i_stall_in;
 reg local_bb1__47_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp296_i_valid_out;
wire local_bb1_cmp296_i_stall_in;
 reg local_bb1_cmp296_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp299_i_valid_out;
wire local_bb1_cmp299_i_stall_in;
 reg local_bb1_cmp299_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_cmp226_not_i_valid_out_1;
wire local_bb1_cmp226_not_i_stall_in_1;
 reg local_bb1_cmp226_not_i_consumed_1_NO_SHIFT_REG;
wire local_bb1_brmerge12_i_inputs_ready;
wire local_bb1_brmerge12_i_stall_local;
wire local_bb1_brmerge12_i;

assign local_bb1_brmerge12_i_inputs_ready = (rnode_170to172_bb1_shr16_i_0_valid_out_NO_SHIFT_REG & rnode_170to172_bb1_cmp37_i_0_valid_out_2_NO_SHIFT_REG & rnode_170to172_bb1_and17_i_0_valid_out_NO_SHIFT_REG & rnode_170to172_bb1_cmp37_i_0_valid_out_0_NO_SHIFT_REG & rnode_171to172_bb1_and193_i_0_valid_out_2_NO_SHIFT_REG & rnode_170to172_bb1_cmp37_i_0_valid_out_1_NO_SHIFT_REG & rnode_171to172_bb1_and195_i_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb1_and193_i_0_valid_out_1_NO_SHIFT_REG & rnode_171to172_bb1_and198_i_0_valid_out_NO_SHIFT_REG & rnode_171to172_bb1_and193_i_0_valid_out_0_NO_SHIFT_REG & rnode_171to172_bb1__and_i_i_0_valid_out_1_NO_SHIFT_REG & rnode_171to172_bb1__and_i_i_0_valid_out_2_NO_SHIFT_REG & rnode_171to172_bb1__and_i_i_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_brmerge12_i = (local_bb1_cmp226_not_i | local_bb1_not_cmp37_i);
assign local_bb1_and269_i_valid_out = 1'b1;
assign local_bb1_add245_i_valid_out_1 = 1'b1;
assign local_bb1_brmerge12_i_valid_out = 1'b1;
assign local_bb1_shr271_i_valid_out = 1'b1;
assign local_bb1__47_i_valid_out = 1'b1;
assign local_bb1_cmp296_i_valid_out = 1'b1;
assign local_bb1_cmp299_i_valid_out = 1'b1;
assign local_bb1_cmp226_not_i_valid_out_1 = 1'b1;
assign rnode_170to172_bb1_shr16_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_cmp37_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_and17_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_cmp37_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and193_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_170to172_bb1_cmp37_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and195_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and193_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and198_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1_and193_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1__and_i_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1__and_i_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_171to172_bb1__and_i_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_and269_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_add245_i_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_brmerge12_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_shr271_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1__47_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp296_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp299_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_cmp226_not_i_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_and269_i_consumed_0_NO_SHIFT_REG <= (local_bb1_brmerge12_i_inputs_ready & (local_bb1_and269_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_and269_i_stall_in)) & local_bb1_brmerge12_i_stall_local);
		local_bb1_add245_i_consumed_1_NO_SHIFT_REG <= (local_bb1_brmerge12_i_inputs_ready & (local_bb1_add245_i_consumed_1_NO_SHIFT_REG | ~(local_bb1_add245_i_stall_in_1)) & local_bb1_brmerge12_i_stall_local);
		local_bb1_brmerge12_i_consumed_0_NO_SHIFT_REG <= (local_bb1_brmerge12_i_inputs_ready & (local_bb1_brmerge12_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_brmerge12_i_stall_in)) & local_bb1_brmerge12_i_stall_local);
		local_bb1_shr271_i_consumed_0_NO_SHIFT_REG <= (local_bb1_brmerge12_i_inputs_ready & (local_bb1_shr271_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_shr271_i_stall_in)) & local_bb1_brmerge12_i_stall_local);
		local_bb1__47_i_consumed_0_NO_SHIFT_REG <= (local_bb1_brmerge12_i_inputs_ready & (local_bb1__47_i_consumed_0_NO_SHIFT_REG | ~(local_bb1__47_i_stall_in)) & local_bb1_brmerge12_i_stall_local);
		local_bb1_cmp296_i_consumed_0_NO_SHIFT_REG <= (local_bb1_brmerge12_i_inputs_ready & (local_bb1_cmp296_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp296_i_stall_in)) & local_bb1_brmerge12_i_stall_local);
		local_bb1_cmp299_i_consumed_0_NO_SHIFT_REG <= (local_bb1_brmerge12_i_inputs_ready & (local_bb1_cmp299_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_cmp299_i_stall_in)) & local_bb1_brmerge12_i_stall_local);
		local_bb1_cmp226_not_i_consumed_1_NO_SHIFT_REG <= (local_bb1_brmerge12_i_inputs_ready & (local_bb1_cmp226_not_i_consumed_1_NO_SHIFT_REG | ~(local_bb1_cmp226_not_i_stall_in_1)) & local_bb1_brmerge12_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_and269_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and269_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and269_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and269_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_and269_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and269_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and269_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_and269_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_and269_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_and269_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_and269_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_and269_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_and269_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_and269_i),
	.data_out(rnode_172to173_bb1_and269_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_and269_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_and269_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_and269_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_and269_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_and269_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_and269_i_stall_in = 1'b0;
assign rnode_172to173_bb1_and269_i_0_NO_SHIFT_REG = rnode_172to173_bb1_and269_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_and269_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and269_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_add245_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_add245_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_add245_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_add245_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_add245_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_add245_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_add245_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_add245_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_add245_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_add245_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_add245_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_add245_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_add245_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_add245_i),
	.data_out(rnode_172to173_bb1_add245_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_add245_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_add245_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_add245_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_add245_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_add245_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_add245_i_stall_in_1 = 1'b0;
assign rnode_172to173_bb1_add245_i_0_NO_SHIFT_REG = rnode_172to173_bb1_add245_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_add245_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_add245_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_brmerge12_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_brmerge12_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_brmerge12_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_brmerge12_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_brmerge12_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_brmerge12_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_brmerge12_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_brmerge12_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_brmerge12_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_brmerge12_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_brmerge12_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_brmerge12_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_brmerge12_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_brmerge12_i),
	.data_out(rnode_172to173_bb1_brmerge12_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_brmerge12_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_brmerge12_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_brmerge12_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_brmerge12_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_brmerge12_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_brmerge12_i_stall_in = 1'b0;
assign rnode_172to173_bb1_brmerge12_i_0_NO_SHIFT_REG = rnode_172to173_bb1_brmerge12_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_brmerge12_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_brmerge12_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_shr271_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr271_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_shr271_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr271_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_172to173_bb1_shr271_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr271_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr271_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_shr271_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_shr271_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_shr271_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_shr271_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_shr271_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_shr271_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_shr271_i),
	.data_out(rnode_172to173_bb1_shr271_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_shr271_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_shr271_i_0_reg_173_fifo.DATA_WIDTH = 32;
defparam rnode_172to173_bb1_shr271_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_shr271_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_shr271_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_shr271_i_stall_in = 1'b0;
assign rnode_172to173_bb1_shr271_i_0_NO_SHIFT_REG = rnode_172to173_bb1_shr271_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_shr271_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_shr271_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1__47_i_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_1_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_0_valid_out_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_0_stall_in_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1__47_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1__47_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1__47_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1__47_i_0_stall_in_0_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1__47_i_0_valid_out_0_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1__47_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1__47_i),
	.data_out(rnode_172to173_bb1__47_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1__47_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1__47_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1__47_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1__47_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1__47_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1__47_i_stall_in = 1'b0;
assign rnode_172to173_bb1__47_i_0_stall_in_0_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__47_i_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__47_i_0_NO_SHIFT_REG = rnode_172to173_bb1__47_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1__47_i_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_172to173_bb1__47_i_1_NO_SHIFT_REG = rnode_172to173_bb1__47_i_0_reg_173_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_cmp296_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp296_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp296_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp296_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp296_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp296_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp296_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp296_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_cmp296_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_cmp296_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_cmp296_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_cmp296_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_cmp296_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_cmp296_i),
	.data_out(rnode_172to173_bb1_cmp296_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_cmp296_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_cmp296_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_cmp296_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_cmp296_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_cmp296_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp296_i_stall_in = 1'b0;
assign rnode_172to173_bb1_cmp296_i_0_NO_SHIFT_REG = rnode_172to173_bb1_cmp296_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_cmp296_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp296_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_cmp299_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp299_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp299_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp299_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp299_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp299_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp299_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp299_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_cmp299_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_cmp299_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_cmp299_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_cmp299_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_cmp299_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_cmp299_i),
	.data_out(rnode_172to173_bb1_cmp299_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_cmp299_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_cmp299_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_cmp299_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_cmp299_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_cmp299_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp299_i_stall_in = 1'b0;
assign rnode_172to173_bb1_cmp299_i_0_NO_SHIFT_REG = rnode_172to173_bb1_cmp299_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_cmp299_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp299_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_172to173_bb1_cmp226_not_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp226_not_i_0_stall_in_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp226_not_i_0_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp226_not_i_0_reg_173_inputs_ready_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp226_not_i_0_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp226_not_i_0_valid_out_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp226_not_i_0_stall_in_reg_173_NO_SHIFT_REG;
 logic rnode_172to173_bb1_cmp226_not_i_0_stall_out_reg_173_NO_SHIFT_REG;

acl_data_fifo rnode_172to173_bb1_cmp226_not_i_0_reg_173_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_172to173_bb1_cmp226_not_i_0_reg_173_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_172to173_bb1_cmp226_not_i_0_stall_in_reg_173_NO_SHIFT_REG),
	.valid_out(rnode_172to173_bb1_cmp226_not_i_0_valid_out_reg_173_NO_SHIFT_REG),
	.stall_out(rnode_172to173_bb1_cmp226_not_i_0_stall_out_reg_173_NO_SHIFT_REG),
	.data_in(local_bb1_cmp226_not_i),
	.data_out(rnode_172to173_bb1_cmp226_not_i_0_reg_173_NO_SHIFT_REG)
);

defparam rnode_172to173_bb1_cmp226_not_i_0_reg_173_fifo.DEPTH = 1;
defparam rnode_172to173_bb1_cmp226_not_i_0_reg_173_fifo.DATA_WIDTH = 1;
defparam rnode_172to173_bb1_cmp226_not_i_0_reg_173_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_172to173_bb1_cmp226_not_i_0_reg_173_fifo.IMPL = "shift_reg";

assign rnode_172to173_bb1_cmp226_not_i_0_reg_173_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp226_not_i_stall_in_1 = 1'b0;
assign rnode_172to173_bb1_cmp226_not_i_0_NO_SHIFT_REG = rnode_172to173_bb1_cmp226_not_i_0_reg_173_NO_SHIFT_REG;
assign rnode_172to173_bb1_cmp226_not_i_0_stall_in_reg_173_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp226_not_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_shl273_i_stall_local;
wire [31:0] local_bb1_shl273_i;

assign local_bb1_shl273_i = (rnode_172to173_bb1_and269_i_0_NO_SHIFT_REG & 32'h7F800000);

// This section implements an unregistered operation.
// 
wire local_bb1_cmp258_i_stall_local;
wire local_bb1_cmp258_i;

assign local_bb1_cmp258_i = ($signed(rnode_172to173_bb1_add245_i_0_NO_SHIFT_REG) > $signed(32'hFE));

// This section implements an unregistered operation.
// 
wire local_bb1_resultSign_0_i_stall_local;
wire [31:0] local_bb1_resultSign_0_i;

assign local_bb1_resultSign_0_i = (rnode_172to173_bb1_brmerge12_i_0_NO_SHIFT_REG ? rnode_172to173_bb1_and35_i_0_NO_SHIFT_REG : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_and272_i_stall_local;
wire [31:0] local_bb1_and272_i;

assign local_bb1_and272_i = (rnode_172to173_bb1_shr271_i_0_NO_SHIFT_REG & 32'h7FFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u25_valid_out;
wire local_bb1_var__u25_stall_in;
wire local_bb1_var__u25_inputs_ready;
wire local_bb1_var__u25_stall_local;
wire [31:0] local_bb1_var__u25;

assign local_bb1_var__u25_inputs_ready = rnode_172to173_bb1__47_i_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_var__u25[31:1] = 31'h0;
assign local_bb1_var__u25[0] = rnode_172to173_bb1__47_i_1_NO_SHIFT_REG;
assign local_bb1_var__u25_valid_out = 1'b1;
assign rnode_172to173_bb1__47_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp29649_i_stall_local;
wire [31:0] local_bb1_cmp29649_i;

assign local_bb1_cmp29649_i[31:1] = 31'h0;
assign local_bb1_cmp29649_i[0] = rnode_172to173_bb1_cmp296_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_conv300_i_stall_local;
wire [31:0] local_bb1_conv300_i;

assign local_bb1_conv300_i[31:1] = 31'h0;
assign local_bb1_conv300_i[0] = rnode_172to173_bb1_cmp299_i_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_lnot262__i_stall_local;
wire local_bb1_lnot262__i;

assign local_bb1_lnot262__i = (local_bb1_cmp258_i & rnode_172to173_bb1_cmp226_not_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_or274_i_stall_local;
wire [31:0] local_bb1_or274_i;

assign local_bb1_or274_i = (local_bb1_and272_i | local_bb1_shl273_i);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_var__u25_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u25_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u25_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u25_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_var__u25_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u25_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u25_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_var__u25_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_var__u25_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_var__u25_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_var__u25_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_var__u25_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_var__u25_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_var__u25),
	.data_out(rnode_173to174_bb1_var__u25_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_var__u25_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_var__u25_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_var__u25_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_var__u25_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_var__u25_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_var__u25_stall_in = 1'b0;
assign rnode_173to174_bb1_var__u25_0_NO_SHIFT_REG = rnode_173to174_bb1_var__u25_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_var__u25_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u25_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_or2662_i_stall_local;
wire local_bb1_or2662_i;

assign local_bb1_or2662_i = (rnode_172to173_bb1_var__u19_0_NO_SHIFT_REG | local_bb1_lnot262__i);

// This section implements an unregistered operation.
// 
wire local_bb1_or275_i_stall_local;
wire [31:0] local_bb1_or275_i;

assign local_bb1_or275_i = (local_bb1_or274_i | local_bb1_resultSign_0_i);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_ext314_i_stall_local;
wire [31:0] local_bb1_lnot_ext314_i;

assign local_bb1_lnot_ext314_i = (rnode_173to174_bb1_var__u25_0_NO_SHIFT_REG ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_or2804_i_stall_local;
wire local_bb1_or2804_i;

assign local_bb1_or2804_i = (rnode_172to173_bb1__47_i_0_NO_SHIFT_REG | local_bb1_or2662_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or2875_i_stall_local;
wire local_bb1_or2875_i;

assign local_bb1_or2875_i = (local_bb1_or2662_i | rnode_172to173_bb1__26_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u26_stall_local;
wire [31:0] local_bb1_var__u26;

assign local_bb1_var__u26[31:1] = 31'h0;
assign local_bb1_var__u26[0] = local_bb1_or2662_i;

// This section implements an unregistered operation.
// 
wire local_bb1_cond282_i_stall_local;
wire [31:0] local_bb1_cond282_i;

assign local_bb1_cond282_i = (local_bb1_or2804_i ? 32'h80000000 : 32'hFFFFFFFF);

// This section implements an unregistered operation.
// 
wire local_bb1_cond289_i_stall_local;
wire [31:0] local_bb1_cond289_i;

assign local_bb1_cond289_i = (local_bb1_or2875_i ? 32'h7F800000 : 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_lnot_ext310_i_stall_local;
wire [31:0] local_bb1_lnot_ext310_i;

assign local_bb1_lnot_ext310_i = (local_bb1_var__u26 ^ 32'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_and293_i_stall_local;
wire [31:0] local_bb1_and293_i;

assign local_bb1_and293_i = (local_bb1_cond282_i & local_bb1_or275_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or294_i_stall_local;
wire [31:0] local_bb1_or294_i;

assign local_bb1_or294_i = (local_bb1_cond289_i | local_bb1_cond292_i);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_0_i25_stall_local;
wire [31:0] local_bb1_reduction_0_i25;

assign local_bb1_reduction_0_i25 = (local_bb1_lnot_ext310_i & local_bb1_lnot_ext_i);

// This section implements an unregistered operation.
// 
wire local_bb1_and302_i_stall_local;
wire [31:0] local_bb1_and302_i;

assign local_bb1_and302_i = (local_bb1_conv300_i & local_bb1_and293_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or295_i_stall_local;
wire [31:0] local_bb1_or295_i;

assign local_bb1_or295_i = (local_bb1_or294_i | local_bb1_and293_i);

// This section implements an unregistered operation.
// 
wire local_bb1_or295_i_valid_out;
wire local_bb1_or295_i_stall_in;
 reg local_bb1_or295_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_lor_ext_i_valid_out;
wire local_bb1_lor_ext_i_stall_in;
 reg local_bb1_lor_ext_i_consumed_0_NO_SHIFT_REG;
wire local_bb1_reduction_0_i25_valid_out;
wire local_bb1_reduction_0_i25_stall_in;
 reg local_bb1_reduction_0_i25_consumed_0_NO_SHIFT_REG;
wire local_bb1_lor_ext_i_inputs_ready;
wire local_bb1_lor_ext_i_stall_local;
wire [31:0] local_bb1_lor_ext_i;

assign local_bb1_lor_ext_i_inputs_ready = (rnode_172to173_bb1_brmerge12_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_and35_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_and269_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_add245_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_cmp226_not_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_var__u19_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1__47_i_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb1__26_i_0_valid_out_0_NO_SHIFT_REG & rnode_172to173_bb1__26_i_0_valid_out_1_NO_SHIFT_REG & rnode_172to173_bb1_shr271_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1__26_i_0_valid_out_2_NO_SHIFT_REG & rnode_172to173_bb1_cmp296_i_0_valid_out_NO_SHIFT_REG & rnode_172to173_bb1_cmp299_i_0_valid_out_NO_SHIFT_REG);
assign local_bb1_lor_ext_i = (local_bb1_cmp29649_i | local_bb1_and302_i);
assign local_bb1_or295_i_valid_out = 1'b1;
assign local_bb1_lor_ext_i_valid_out = 1'b1;
assign local_bb1_reduction_0_i25_valid_out = 1'b1;
assign rnode_172to173_bb1_brmerge12_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and35_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_and269_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_add245_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp226_not_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_var__u19_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__47_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__26_i_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__26_i_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_shr271_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1__26_i_0_stall_in_2_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp296_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_172to173_bb1_cmp299_i_0_stall_in_NO_SHIFT_REG = 1'b0;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_or295_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_lor_ext_i_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_reduction_0_i25_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_or295_i_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i_inputs_ready & (local_bb1_or295_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_or295_i_stall_in)) & local_bb1_lor_ext_i_stall_local);
		local_bb1_lor_ext_i_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i_inputs_ready & (local_bb1_lor_ext_i_consumed_0_NO_SHIFT_REG | ~(local_bb1_lor_ext_i_stall_in)) & local_bb1_lor_ext_i_stall_local);
		local_bb1_reduction_0_i25_consumed_0_NO_SHIFT_REG <= (local_bb1_lor_ext_i_inputs_ready & (local_bb1_reduction_0_i25_consumed_0_NO_SHIFT_REG | ~(local_bb1_reduction_0_i25_stall_in)) & local_bb1_lor_ext_i_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_or295_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_or295_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_or295_i_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_or295_i_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_or295_i_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_or295_i_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_or295_i_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_or295_i_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_or295_i_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_or295_i_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_or295_i_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_or295_i_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_or295_i_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_or295_i),
	.data_out(rnode_173to174_bb1_or295_i_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_or295_i_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_or295_i_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_or295_i_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_or295_i_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_or295_i_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_or295_i_stall_in = 1'b0;
assign rnode_173to174_bb1_or295_i_0_NO_SHIFT_REG = rnode_173to174_bb1_or295_i_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_or295_i_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_or295_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_lor_ext_i_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_lor_ext_i_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_lor_ext_i_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_lor_ext_i_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_lor_ext_i_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_lor_ext_i_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_lor_ext_i_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_lor_ext_i_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_lor_ext_i_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_lor_ext_i_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_lor_ext_i_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_lor_ext_i_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_lor_ext_i_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_lor_ext_i),
	.data_out(rnode_173to174_bb1_lor_ext_i_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_lor_ext_i_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_lor_ext_i_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_lor_ext_i_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_lor_ext_i_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_lor_ext_i_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_lor_ext_i_stall_in = 1'b0;
assign rnode_173to174_bb1_lor_ext_i_0_NO_SHIFT_REG = rnode_173to174_bb1_lor_ext_i_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_lor_ext_i_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_lor_ext_i_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_173to174_bb1_reduction_0_i25_0_valid_out_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_0_i25_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_reduction_0_i25_0_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_0_i25_0_reg_174_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_173to174_bb1_reduction_0_i25_0_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_0_i25_0_valid_out_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_0_i25_0_stall_in_reg_174_NO_SHIFT_REG;
 logic rnode_173to174_bb1_reduction_0_i25_0_stall_out_reg_174_NO_SHIFT_REG;

acl_data_fifo rnode_173to174_bb1_reduction_0_i25_0_reg_174_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_173to174_bb1_reduction_0_i25_0_reg_174_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_173to174_bb1_reduction_0_i25_0_stall_in_reg_174_NO_SHIFT_REG),
	.valid_out(rnode_173to174_bb1_reduction_0_i25_0_valid_out_reg_174_NO_SHIFT_REG),
	.stall_out(rnode_173to174_bb1_reduction_0_i25_0_stall_out_reg_174_NO_SHIFT_REG),
	.data_in(local_bb1_reduction_0_i25),
	.data_out(rnode_173to174_bb1_reduction_0_i25_0_reg_174_NO_SHIFT_REG)
);

defparam rnode_173to174_bb1_reduction_0_i25_0_reg_174_fifo.DEPTH = 1;
defparam rnode_173to174_bb1_reduction_0_i25_0_reg_174_fifo.DATA_WIDTH = 32;
defparam rnode_173to174_bb1_reduction_0_i25_0_reg_174_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_173to174_bb1_reduction_0_i25_0_reg_174_fifo.IMPL = "shift_reg";

assign rnode_173to174_bb1_reduction_0_i25_0_reg_174_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_reduction_0_i25_stall_in = 1'b0;
assign rnode_173to174_bb1_reduction_0_i25_0_NO_SHIFT_REG = rnode_173to174_bb1_reduction_0_i25_0_reg_174_NO_SHIFT_REG;
assign rnode_173to174_bb1_reduction_0_i25_0_stall_in_reg_174_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_reduction_0_i25_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_1_i_stall_local;
wire [31:0] local_bb1_reduction_1_i;

assign local_bb1_reduction_1_i = (local_bb1_lnot_ext314_i & rnode_173to174_bb1_lor_ext_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_reduction_2_i26_stall_local;
wire [31:0] local_bb1_reduction_2_i26;

assign local_bb1_reduction_2_i26 = (rnode_173to174_bb1_reduction_0_i25_0_NO_SHIFT_REG & local_bb1_reduction_1_i);

// This section implements an unregistered operation.
// 
wire local_bb1_add320_i_stall_local;
wire [31:0] local_bb1_add320_i;

assign local_bb1_add320_i = (local_bb1_reduction_2_i26 + rnode_173to174_bb1_or295_i_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u27_stall_local;
wire [31:0] local_bb1_var__u27;

assign local_bb1_var__u27 = local_bb1_add320_i;

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi1_valid_out;
wire local_bb1_c0_exi1_stall_in;
wire local_bb1_c0_exi1_inputs_ready;
wire local_bb1_c0_exi1_stall_local;
wire [63:0] local_bb1_c0_exi1;

assign local_bb1_c0_exi1_inputs_ready = (rnode_173to174_bb1_or295_i_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb1_reduction_0_i25_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb1_var__u25_0_valid_out_NO_SHIFT_REG & rnode_173to174_bb1_lor_ext_i_0_valid_out_NO_SHIFT_REG);
assign local_bb1_c0_exi1[31:0] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
assign local_bb1_c0_exi1[63:32] = local_bb1_var__u27;
assign local_bb1_c0_exi1_valid_out = 1'b1;
assign rnode_173to174_bb1_or295_i_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_reduction_0_i25_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_var__u25_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_173to174_bb1_lor_ext_i_0_stall_in_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_c0_exit_c0_exi1_inputs_ready;
 reg local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi1_stall_in;
 reg [63:0] local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG;
wire [63:0] local_bb1_c0_exit_c0_exi1_in;
wire local_bb1_c0_exit_c0_exi1_valid;
wire local_bb1_c0_exit_c0_exi1_causedstall;

acl_stall_free_sink local_bb1_c0_exit_c0_exi1_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb1_c0_exi1),
	.data_out(local_bb1_c0_exit_c0_exi1_in),
	.input_accepted(local_bb1_c0_enter_c0_eni3_input_accepted),
	.valid_out(local_bb1_c0_exit_c0_exi1_valid),
	.stall_in(~(local_bb1_c0_exit_c0_exi1_output_regs_ready)),
	.stall_entry(local_bb1_c0_exit_c0_exi1_entry_stall),
	.valids(local_bb1_c0_exit_c0_exi1_valid_bits),
	.IIphases(local_bb1_c0_exit_c0_exi1_phases),
	.inc_pipelined_thread(local_bb1_c0_enter_c0_eni3_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb1_c0_enter_c0_eni3_dec_pipelined_thread)
);

defparam local_bb1_c0_exit_c0_exi1_instance.DATA_WIDTH = 64;
defparam local_bb1_c0_exit_c0_exi1_instance.PIPELINE_DEPTH = 17;
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
wire [31:0] local_bb1_c0_exe1;

assign local_bb1_c0_exe1_inputs_ready = local_bb1_c0_exit_c0_exi1_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_exe1 = local_bb1_c0_exit_c0_exi1_NO_SHIFT_REG[63:32];
assign local_bb1_c0_exe1_valid_out = local_bb1_c0_exe1_inputs_ready;
assign local_bb1_c0_exe1_stall_local = local_bb1_c0_exe1_stall_in;
assign local_bb1_c0_exit_c0_exi1_stall_in = (|local_bb1_c0_exe1_stall_local);

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_bb1_mul_RM_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb1_indvars_iv_next_0_reg_NO_SHIFT_REG;
 reg lvb_bb1_or_cond_NEG_RM_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb1_c0_exe1_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_0_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_1_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb1_c0_exe1_valid_out & local_bb1_exitcond_GUARD_valid_out & rnode_178to179_bb1_indvars_iv_next_0_valid_out_1_NO_SHIFT_REG & rnode_178to179_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rnode_178to179_bb1_mul_RM_0_valid_out_NO_SHIFT_REG & rnode_178to179_input_global_id_0_0_valid_out_NO_SHIFT_REG & rnode_178to179_input_global_id_1_0_valid_out_NO_SHIFT_REG & rnode_178to179_bb1_or_cond_NEG_RM_0_valid_out_1_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb1_c0_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_exitcond_GUARD_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_178to179_bb1_indvars_iv_next_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_178to179_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_178to179_bb1_mul_RM_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_178to179_input_global_id_0_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_178to179_input_global_id_1_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_178to179_bb1_or_cond_NEG_RM_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb1_mul_RM_0 = lvb_bb1_mul_RM_0_reg_NO_SHIFT_REG;
assign lvb_bb1_mul_RM_1 = lvb_bb1_mul_RM_0_reg_NO_SHIFT_REG;
assign lvb_bb1_indvars_iv_next_0 = lvb_bb1_indvars_iv_next_0_reg_NO_SHIFT_REG;
assign lvb_bb1_indvars_iv_next_1 = lvb_bb1_indvars_iv_next_0_reg_NO_SHIFT_REG;
assign lvb_bb1_or_cond_NEG_RM_0 = lvb_bb1_or_cond_NEG_RM_0_reg_NO_SHIFT_REG;
assign lvb_bb1_or_cond_NEG_RM_1 = lvb_bb1_or_cond_NEG_RM_0_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe1_0 = lvb_bb1_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe1_1 = lvb_bb1_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_0_0 = lvb_input_global_id_0_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_0_1 = lvb_input_global_id_0_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1_0 = lvb_input_global_id_1_0_reg_NO_SHIFT_REG;
assign lvb_input_global_id_1_1 = lvb_input_global_id_1_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_0 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_1 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		lvb_bb1_mul_RM_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_indvars_iv_next_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_or_cond_NEG_RM_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_c0_exe1_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_0_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_1_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb1_mul_RM_0_reg_NO_SHIFT_REG <= rnode_178to179_bb1_mul_RM_0_NO_SHIFT_REG;
			lvb_bb1_indvars_iv_next_0_reg_NO_SHIFT_REG <= rnode_178to179_bb1_indvars_iv_next_1_NO_SHIFT_REG;
			lvb_bb1_or_cond_NEG_RM_0_reg_NO_SHIFT_REG <= rnode_178to179_bb1_or_cond_NEG_RM_1_NO_SHIFT_REG;
			lvb_bb1_c0_exe1_0_reg_NO_SHIFT_REG <= local_bb1_c0_exe1;
			lvb_input_global_id_0_0_reg_NO_SHIFT_REG <= rnode_178to179_input_global_id_0_0_NO_SHIFT_REG;
			lvb_input_global_id_1_0_reg_NO_SHIFT_REG <= rnode_178to179_input_global_id_1_0_NO_SHIFT_REG;
			lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= rnode_178to179_input_acl_hw_wg_id_0_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= local_bb1_exitcond_GUARD;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
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
module matMul_basic_block_2
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_C,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_mul_RM,
		input 		input_or_cond_NEG_RM,
		input [31:0] 		input_c0_exe1,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_input_acl_hw_wg_id,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb2_st_c0_exe1_readdata,
		input 		avm_local_bb2_st_c0_exe1_readdatavalid,
		input 		avm_local_bb2_st_c0_exe1_waitrequest,
		output [29:0] 		avm_local_bb2_st_c0_exe1_address,
		output 		avm_local_bb2_st_c0_exe1_read,
		output 		avm_local_bb2_st_c0_exe1_write,
		input 		avm_local_bb2_st_c0_exe1_writeack,
		output [255:0] 		avm_local_bb2_st_c0_exe1_writedata,
		output [31:0] 		avm_local_bb2_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb2_st_c0_exe1_burstcount,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb2_st_c0_exe1_profile_bw_incr,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_total_req_cntl,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_avm_stall_cntl,
		output 		local_bb2_st_c0_exe1_active,
		input 		clock2x
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
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_mul_RM_staging_reg_NO_SHIFT_REG;
 reg input_or_cond_NEG_RM_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_mul_RM_NO_SHIFT_REG;
 reg local_lvm_or_cond_NEG_RM_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe1_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG));
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
		input_mul_RM_staging_reg_NO_SHIFT_REG <= 'x;
		input_or_cond_NEG_RM_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe1_staging_reg_NO_SHIFT_REG <= 'x;
		input_global_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_mul_RM_staging_reg_NO_SHIFT_REG <= input_mul_RM;
				input_or_cond_NEG_RM_staging_reg_NO_SHIFT_REG <= input_or_cond_NEG_RM;
				input_c0_exe1_staging_reg_NO_SHIFT_REG <= input_c0_exe1;
				input_global_id_0_staging_reg_NO_SHIFT_REG <= input_global_id_0;
				input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id;
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
					local_lvm_mul_RM_NO_SHIFT_REG <= input_mul_RM_staging_reg_NO_SHIFT_REG;
					local_lvm_or_cond_NEG_RM_NO_SHIFT_REG <= input_or_cond_NEG_RM_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_RM_NO_SHIFT_REG <= input_mul_RM;
					local_lvm_or_cond_NEG_RM_NO_SHIFT_REG <= input_or_cond_NEG_RM;
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1;
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id;
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
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
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
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
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
wire local_bb2_add15_valid_out;
wire local_bb2_add15_stall_in;
wire local_bb2_add15_inputs_ready;
wire local_bb2_add15_stall_local;
wire [31:0] local_bb2_add15;

assign local_bb2_add15_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb2_add15 = (local_lvm_mul_RM_NO_SHIFT_REG + local_lvm_input_global_id_0_NO_SHIFT_REG);
assign local_bb2_add15_valid_out = local_bb2_add15_inputs_ready;
assign local_bb2_add15_stall_local = local_bb2_add15_stall_in;
assign merge_node_stall_in_0 = (|local_bb2_add15_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_c0_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_c0_exe1_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe1_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_c0_exe1_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe1_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe1_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe1_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_c0_exe1_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_c0_exe1_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_c0_exe1_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_c0_exe1_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_c0_exe1_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe1_NO_SHIFT_REG),
	.data_out(rnode_1to2_c0_exe1_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_c0_exe1_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_c0_exe1_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_c0_exe1_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_c0_exe1_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_c0_exe1_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign merge_node_stall_in_1 = rnode_1to2_c0_exe1_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_c0_exe1_0_NO_SHIFT_REG = rnode_1to2_c0_exe1_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_c0_exe1_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_c0_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_c0_exe1_0_valid_out_NO_SHIFT_REG = rnode_1to2_c0_exe1_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_or_cond_NEG_RM_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_or_cond_NEG_RM_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to2_or_cond_NEG_RM_0_NO_SHIFT_REG;
 logic rnode_1to2_or_cond_NEG_RM_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_or_cond_NEG_RM_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_or_cond_NEG_RM_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_or_cond_NEG_RM_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_or_cond_NEG_RM_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_or_cond_NEG_RM_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_or_cond_NEG_RM_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_or_cond_NEG_RM_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_or_cond_NEG_RM_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_or_cond_NEG_RM_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_or_cond_NEG_RM_NO_SHIFT_REG),
	.data_out(rnode_1to2_or_cond_NEG_RM_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_or_cond_NEG_RM_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_or_cond_NEG_RM_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_or_cond_NEG_RM_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_or_cond_NEG_RM_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_or_cond_NEG_RM_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to2_or_cond_NEG_RM_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_or_cond_NEG_RM_0_NO_SHIFT_REG = rnode_1to2_or_cond_NEG_RM_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_or_cond_NEG_RM_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_or_cond_NEG_RM_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_or_cond_NEG_RM_0_valid_out_NO_SHIFT_REG = rnode_1to2_or_cond_NEG_RM_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 5
//  * capacity = 5
 logic rnode_1to6_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to6_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to6_input_acl_hw_wg_id_0_reg_6_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to6_input_acl_hw_wg_id_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to6_input_acl_hw_wg_id_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_1to6_input_acl_hw_wg_id_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_1to6_input_acl_hw_wg_id_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to6_input_acl_hw_wg_id_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo.DEPTH = 6;
defparam rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo.DATA_WIDTH = 32;
defparam rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo.IMPL = "ll_reg";

assign rnode_1to6_input_acl_hw_wg_id_0_reg_6_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to6_input_acl_hw_wg_id_0_stall_out_reg_6_NO_SHIFT_REG;
assign rnode_1to6_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to6_input_acl_hw_wg_id_0_reg_6_NO_SHIFT_REG;
assign rnode_1to6_input_acl_hw_wg_id_0_stall_in_reg_6_NO_SHIFT_REG = rnode_1to6_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to6_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to6_input_acl_hw_wg_id_0_valid_out_reg_6_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_add15_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add15_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_add15_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add15_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb2_add15_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add15_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add15_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_add15_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb2_add15_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_add15_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_add15_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_add15_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_add15_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_add15),
	.data_out(rnode_1to2_bb2_add15_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_add15_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb2_add15_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb2_add15_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb2_add15_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb2_add15_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb2_add15_valid_out;
assign local_bb2_add15_stall_in = rnode_1to2_bb2_add15_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_add15_0_NO_SHIFT_REG = rnode_1to2_bb2_add15_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_add15_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_bb2_add15_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_bb2_add15_0_valid_out_NO_SHIFT_REG = rnode_1to2_bb2_add15_0_valid_out_reg_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb2_idxprom16_stall_local;
wire [63:0] local_bb2_idxprom16;

assign local_bb2_idxprom16[32] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[33] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[34] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[35] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[36] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[37] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[38] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[39] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[40] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[41] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[42] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[43] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[44] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[45] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[46] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[47] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[48] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[49] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[50] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[51] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[52] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[53] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[54] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[55] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[56] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[57] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[58] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[59] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[60] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[61] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[62] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[63] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG[31];
assign local_bb2_idxprom16[31:0] = rnode_1to2_bb2_add15_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb2_arrayidx17_valid_out;
wire local_bb2_arrayidx17_stall_in;
wire local_bb2_arrayidx17_inputs_ready;
wire local_bb2_arrayidx17_stall_local;
wire [63:0] local_bb2_arrayidx17;

assign local_bb2_arrayidx17_inputs_ready = rnode_1to2_bb2_add15_0_valid_out_NO_SHIFT_REG;
assign local_bb2_arrayidx17 = (input_C + (local_bb2_idxprom16 << 6'h2));
assign local_bb2_arrayidx17_valid_out = local_bb2_arrayidx17_inputs_ready;
assign local_bb2_arrayidx17_stall_local = local_bb2_arrayidx17_stall_in;
assign rnode_1to2_bb2_add15_0_stall_in_NO_SHIFT_REG = (|local_bb2_arrayidx17_stall_local);

// This section implements a registered operation.
// 
wire local_bb2_st_c0_exe1_inputs_ready;
 reg local_bb2_st_c0_exe1_valid_out_NO_SHIFT_REG;
wire local_bb2_st_c0_exe1_stall_in;
wire local_bb2_st_c0_exe1_output_regs_ready;
wire local_bb2_st_c0_exe1_fu_stall_out;
wire local_bb2_st_c0_exe1_fu_valid_out;
wire local_bb2_st_c0_exe1_causedstall;

lsu_top lsu_local_bb2_st_c0_exe1 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb2_st_c0_exe1_fu_stall_out),
	.i_valid(local_bb2_st_c0_exe1_inputs_ready),
	.i_address(local_bb2_arrayidx17),
	.i_writedata(rnode_1to2_c0_exe1_0_NO_SHIFT_REG),
	.i_cmpdata(),
	.i_predicate(rnode_1to2_or_cond_NEG_RM_0_NO_SHIFT_REG),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb2_st_c0_exe1_output_regs_ready)),
	.o_valid(local_bb2_st_c0_exe1_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb2_st_c0_exe1_active),
	.avm_address(avm_local_bb2_st_c0_exe1_address),
	.avm_read(avm_local_bb2_st_c0_exe1_read),
	.avm_readdata(avm_local_bb2_st_c0_exe1_readdata),
	.avm_write(avm_local_bb2_st_c0_exe1_write),
	.avm_writeack(avm_local_bb2_st_c0_exe1_writeack),
	.avm_burstcount(avm_local_bb2_st_c0_exe1_burstcount),
	.avm_writedata(avm_local_bb2_st_c0_exe1_writedata),
	.avm_byteenable(avm_local_bb2_st_c0_exe1_byteenable),
	.avm_waitrequest(avm_local_bb2_st_c0_exe1_waitrequest),
	.avm_readdatavalid(avm_local_bb2_st_c0_exe1_readdatavalid),
	.profile_bw(profile_lsu_local_bb2_st_c0_exe1_profile_bw_cntl),
	.profile_bw_incr(profile_lsu_local_bb2_st_c0_exe1_profile_bw_incr),
	.profile_total_ivalid(profile_lsu_local_bb2_st_c0_exe1_profile_total_ivalid_cntl),
	.profile_total_req(profile_lsu_local_bb2_st_c0_exe1_profile_total_req_cntl),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(profile_lsu_local_bb2_st_c0_exe1_profile_avm_readwrite_count_cntl),
	.profile_avm_burstcount_total(profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_cntl),
	.profile_avm_burstcount_total_incr(profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_incr),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall(profile_lsu_local_bb2_st_c0_exe1_profile_avm_stall_cntl)
);

defparam lsu_local_bb2_st_c0_exe1.AWIDTH = 30;
defparam lsu_local_bb2_st_c0_exe1.WIDTH_BYTES = 4;
defparam lsu_local_bb2_st_c0_exe1.MWIDTH_BYTES = 32;
defparam lsu_local_bb2_st_c0_exe1.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb2_st_c0_exe1.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb2_st_c0_exe1.READ = 0;
defparam lsu_local_bb2_st_c0_exe1.ATOMIC = 0;
defparam lsu_local_bb2_st_c0_exe1.WIDTH = 32;
defparam lsu_local_bb2_st_c0_exe1.MWIDTH = 256;
defparam lsu_local_bb2_st_c0_exe1.ATOMIC_WIDTH = 3;
defparam lsu_local_bb2_st_c0_exe1.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb2_st_c0_exe1.KERNEL_SIDE_MEM_LATENCY = 4;
defparam lsu_local_bb2_st_c0_exe1.MEMORY_SIDE_MEM_LATENCY = 8;
defparam lsu_local_bb2_st_c0_exe1.USE_WRITE_ACK = 0;
defparam lsu_local_bb2_st_c0_exe1.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb2_st_c0_exe1.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb2_st_c0_exe1.NUMBER_BANKS = 1;
defparam lsu_local_bb2_st_c0_exe1.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb2_st_c0_exe1.USEINPUTFIFO = 0;
defparam lsu_local_bb2_st_c0_exe1.USECACHING = 0;
defparam lsu_local_bb2_st_c0_exe1.USEOUTPUTFIFO = 1;
defparam lsu_local_bb2_st_c0_exe1.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb2_st_c0_exe1.HIGH_FMAX = 1;
defparam lsu_local_bb2_st_c0_exe1.ACL_PROFILE = 1;
defparam lsu_local_bb2_st_c0_exe1.ACL_PROFILE_INCREMENT_WIDTH = 32;
defparam lsu_local_bb2_st_c0_exe1.ADDRSPACE = 1;
defparam lsu_local_bb2_st_c0_exe1.STYLE = "BURST-COALESCED";
defparam lsu_local_bb2_st_c0_exe1.USE_BYTE_EN = 0;

assign local_bb2_st_c0_exe1_inputs_ready = (local_bb2_arrayidx17_valid_out & rnode_1to2_c0_exe1_0_valid_out_NO_SHIFT_REG & rnode_1to2_or_cond_NEG_RM_0_valid_out_NO_SHIFT_REG);
assign local_bb2_st_c0_exe1_output_regs_ready = (&(~(local_bb2_st_c0_exe1_valid_out_NO_SHIFT_REG) | ~(local_bb2_st_c0_exe1_stall_in)));
assign local_bb2_arrayidx17_stall_in = (local_bb2_st_c0_exe1_fu_stall_out | ~(local_bb2_st_c0_exe1_inputs_ready));
assign rnode_1to2_c0_exe1_0_stall_in_NO_SHIFT_REG = (local_bb2_st_c0_exe1_fu_stall_out | ~(local_bb2_st_c0_exe1_inputs_ready));
assign rnode_1to2_or_cond_NEG_RM_0_stall_in_NO_SHIFT_REG = (local_bb2_st_c0_exe1_fu_stall_out | ~(local_bb2_st_c0_exe1_inputs_ready));
assign local_bb2_st_c0_exe1_causedstall = (local_bb2_st_c0_exe1_inputs_ready && (local_bb2_st_c0_exe1_fu_stall_out && !(~(local_bb2_st_c0_exe1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_st_c0_exe1_output_regs_ready)
		begin
			local_bb2_st_c0_exe1_valid_out_NO_SHIFT_REG <= local_bb2_st_c0_exe1_fu_valid_out;
		end
		else
		begin
			if (~(local_bb2_st_c0_exe1_stall_in))
			begin
				local_bb2_st_c0_exe1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_6to6_bb2_st_c0_exe1_valid_out;
wire rstag_6to6_bb2_st_c0_exe1_stall_in;
wire rstag_6to6_bb2_st_c0_exe1_inputs_ready;
wire rstag_6to6_bb2_st_c0_exe1_stall_local;
 reg rstag_6to6_bb2_st_c0_exe1_staging_valid_NO_SHIFT_REG;
wire rstag_6to6_bb2_st_c0_exe1_combined_valid;

assign rstag_6to6_bb2_st_c0_exe1_inputs_ready = local_bb2_st_c0_exe1_valid_out_NO_SHIFT_REG;
assign rstag_6to6_bb2_st_c0_exe1_combined_valid = (rstag_6to6_bb2_st_c0_exe1_staging_valid_NO_SHIFT_REG | rstag_6to6_bb2_st_c0_exe1_inputs_ready);
assign rstag_6to6_bb2_st_c0_exe1_valid_out = rstag_6to6_bb2_st_c0_exe1_combined_valid;
assign rstag_6to6_bb2_st_c0_exe1_stall_local = rstag_6to6_bb2_st_c0_exe1_stall_in;
assign local_bb2_st_c0_exe1_stall_in = (|rstag_6to6_bb2_st_c0_exe1_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_6to6_bb2_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_6to6_bb2_st_c0_exe1_stall_local)
		begin
			if (~(rstag_6to6_bb2_st_c0_exe1_staging_valid_NO_SHIFT_REG))
			begin
				rstag_6to6_bb2_st_c0_exe1_staging_valid_NO_SHIFT_REG <= rstag_6to6_bb2_st_c0_exe1_inputs_ready;
			end
		end
		else
		begin
			rstag_6to6_bb2_st_c0_exe1_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = (rnode_1to6_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rstag_6to6_bb2_st_c0_exe1_valid_out);
assign branch_var__output_regs_ready = ~(stall_in);
assign rnode_1to6_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_6to6_bb2_st_c0_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out = branch_var__inputs_ready;
assign lvb_input_acl_hw_wg_id = rnode_1to6_input_acl_hw_wg_id_0_NO_SHIFT_REG;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module matMul_function
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_global_id_1,
		input [31:0] 		input_acl_hw_wg_id,
		output 		stall_out,
		input 		valid_in,
		output [31:0] 		output_0,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input [255:0] 		avm_local_bb1_ld__readdata,
		input 		avm_local_bb1_ld__readdatavalid,
		input 		avm_local_bb1_ld__waitrequest,
		output [29:0] 		avm_local_bb1_ld__address,
		output 		avm_local_bb1_ld__read,
		output 		avm_local_bb1_ld__write,
		input 		avm_local_bb1_ld__writeack,
		output [255:0] 		avm_local_bb1_ld__writedata,
		output [31:0] 		avm_local_bb1_ld__byteenable,
		output [4:0] 		avm_local_bb1_ld__burstcount,
		output 		profile_lsu_local_bb1_ld__profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld__profile_bw_incr,
		output 		profile_lsu_local_bb1_ld__profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb1_ld__profile_total_req_cntl,
		output 		profile_lsu_local_bb1_ld__profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb1_ld__profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld__profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb1_ld__profile_req_cache_hit_count_cntl,
		output 		profile_lsu_local_bb1_ld__profile_avm_stall_cntl,
		input [255:0] 		avm_local_bb1_ld__u4_readdata,
		input 		avm_local_bb1_ld__u4_readdatavalid,
		input 		avm_local_bb1_ld__u4_waitrequest,
		output [29:0] 		avm_local_bb1_ld__u4_address,
		output 		avm_local_bb1_ld__u4_read,
		output 		avm_local_bb1_ld__u4_write,
		input 		avm_local_bb1_ld__u4_writeack,
		output [255:0] 		avm_local_bb1_ld__u4_writedata,
		output [31:0] 		avm_local_bb1_ld__u4_byteenable,
		output [4:0] 		avm_local_bb1_ld__u4_burstcount,
		output 		profile_lsu_local_bb1_ld__u4_profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld__u4_profile_bw_incr,
		output 		profile_lsu_local_bb1_ld__u4_profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb1_ld__u4_profile_total_req_cntl,
		output 		profile_lsu_local_bb1_ld__u4_profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb1_ld__u4_profile_req_cache_hit_count_cntl,
		output 		profile_lsu_local_bb1_ld__u4_profile_avm_stall_cntl,
		input [255:0] 		avm_local_bb2_st_c0_exe1_readdata,
		input 		avm_local_bb2_st_c0_exe1_readdatavalid,
		input 		avm_local_bb2_st_c0_exe1_waitrequest,
		output [29:0] 		avm_local_bb2_st_c0_exe1_address,
		output 		avm_local_bb2_st_c0_exe1_read,
		output 		avm_local_bb2_st_c0_exe1_write,
		input 		avm_local_bb2_st_c0_exe1_writeack,
		output [255:0] 		avm_local_bb2_st_c0_exe1_writedata,
		output [31:0] 		avm_local_bb2_st_c0_exe1_byteenable,
		output [4:0] 		avm_local_bb2_st_c0_exe1_burstcount,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_bw_cntl,
		output [31:0] 		profile_lsu_local_bb2_st_c0_exe1_profile_bw_incr,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_total_ivalid_cntl,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_total_req_cntl,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_avm_readwrite_count_cntl,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_cntl,
		output [31:0] 		profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_incr,
		output 		profile_lsu_local_bb2_st_c0_exe1_profile_avm_stall_cntl,
		input 		start,
		input 		clock2x,
		input [63:0] 		input_B,
		input [63:0] 		input_A,
		input [63:0] 		input_C,
		output 		profile_clock,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire [31:0] bb_0_lvb_input_global_id_0;
wire [31:0] bb_0_lvb_input_global_id_1;
wire [31:0] bb_0_lvb_input_acl_hw_wg_id;
wire bb_1_stall_out_0;
wire bb_1_stall_out_1;
wire bb_1_valid_out_0;
wire [31:0] bb_1_lvb_bb1_mul_RM_0;
wire [63:0] bb_1_lvb_bb1_indvars_iv_next_0;
wire bb_1_lvb_bb1_or_cond_NEG_RM_0;
wire [31:0] bb_1_lvb_bb1_c0_exe1_0;
wire [31:0] bb_1_lvb_input_global_id_0_0;
wire [31:0] bb_1_lvb_input_global_id_1_0;
wire [31:0] bb_1_lvb_input_acl_hw_wg_id_0;
wire bb_1_valid_out_1;
wire [31:0] bb_1_lvb_bb1_mul_RM_1;
wire [63:0] bb_1_lvb_bb1_indvars_iv_next_1;
wire bb_1_lvb_bb1_or_cond_NEG_RM_1;
wire [31:0] bb_1_lvb_bb1_c0_exe1_1;
wire [31:0] bb_1_lvb_input_global_id_0_1;
wire [31:0] bb_1_lvb_input_global_id_1_1;
wire [31:0] bb_1_lvb_input_acl_hw_wg_id_1;
wire bb_1_local_bb1_ld__active;
wire bb_1_local_bb1_ld__u4_active;
wire bb_2_stall_out;
wire bb_2_valid_out;
wire [31:0] bb_2_lvb_input_acl_hw_wg_id;
wire bb_2_local_bb2_st_c0_exe1_active;
wire loop_limiter_0_stall_out;
wire loop_limiter_0_valid_out;
wire writes_pending;
wire [2:0] lsus_active;

acl_loop_limiter loop_limiter_0 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_0_valid_out),
	.i_stall(bb_1_stall_out_1),
	.i_valid_exit(bb_1_valid_out_0),
	.i_stall_exit(bb_2_stall_out),
	.o_valid(loop_limiter_0_valid_out),
	.o_stall(loop_limiter_0_stall_out)
);

defparam loop_limiter_0.ENTRY_WIDTH = 1;
defparam loop_limiter_0.EXIT_WIDTH = 1;
defparam loop_limiter_0.THRESHOLD = 180;

matMul_basic_block_0 matMul_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.input_global_id_0(input_global_id_0),
	.input_global_id_1(input_global_id_1),
	.input_acl_hw_wg_id(input_acl_hw_wg_id),
	.valid_out(bb_0_valid_out),
	.stall_in(loop_limiter_0_stall_out),
	.lvb_input_global_id_0(bb_0_lvb_input_global_id_0),
	.lvb_input_global_id_1(bb_0_lvb_input_global_id_1),
	.lvb_input_acl_hw_wg_id(bb_0_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size)
);


matMul_basic_block_1 matMul_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_B(input_B),
	.input_A(input_A),
	.valid_in_0(bb_1_valid_out_1),
	.stall_out_0(bb_1_stall_out_0),
	.input_indvars_iv_0(bb_1_lvb_bb1_indvars_iv_next_1),
	.input_sum_03_0(bb_1_lvb_bb1_c0_exe1_1),
	.input_global_id_0_0(bb_1_lvb_input_global_id_0_1),
	.input_global_id_1_0(bb_1_lvb_input_global_id_1_1),
	.input_acl_hw_wg_id_0(bb_1_lvb_input_acl_hw_wg_id_1),
	.valid_in_1(loop_limiter_0_valid_out),
	.stall_out_1(bb_1_stall_out_1),
	.input_indvars_iv_1(64'h0),
	.input_sum_03_1(32'h0),
	.input_global_id_0_1(bb_0_lvb_input_global_id_0),
	.input_global_id_1_1(bb_0_lvb_input_global_id_1),
	.input_acl_hw_wg_id_1(bb_0_lvb_input_acl_hw_wg_id),
	.valid_out_0(bb_1_valid_out_0),
	.stall_in_0(bb_2_stall_out),
	.lvb_bb1_mul_RM_0(bb_1_lvb_bb1_mul_RM_0),
	.lvb_bb1_indvars_iv_next_0(bb_1_lvb_bb1_indvars_iv_next_0),
	.lvb_bb1_or_cond_NEG_RM_0(bb_1_lvb_bb1_or_cond_NEG_RM_0),
	.lvb_bb1_c0_exe1_0(bb_1_lvb_bb1_c0_exe1_0),
	.lvb_input_global_id_0_0(bb_1_lvb_input_global_id_0_0),
	.lvb_input_global_id_1_0(bb_1_lvb_input_global_id_1_0),
	.lvb_input_acl_hw_wg_id_0(bb_1_lvb_input_acl_hw_wg_id_0),
	.valid_out_1(bb_1_valid_out_1),
	.stall_in_1(bb_1_stall_out_0),
	.lvb_bb1_mul_RM_1(bb_1_lvb_bb1_mul_RM_1),
	.lvb_bb1_indvars_iv_next_1(bb_1_lvb_bb1_indvars_iv_next_1),
	.lvb_bb1_or_cond_NEG_RM_1(bb_1_lvb_bb1_or_cond_NEG_RM_1),
	.lvb_bb1_c0_exe1_1(bb_1_lvb_bb1_c0_exe1_1),
	.lvb_input_global_id_0_1(bb_1_lvb_input_global_id_0_1),
	.lvb_input_global_id_1_1(bb_1_lvb_input_global_id_1_1),
	.lvb_input_acl_hw_wg_id_1(bb_1_lvb_input_acl_hw_wg_id_1),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb1_ld__readdata(avm_local_bb1_ld__readdata),
	.avm_local_bb1_ld__readdatavalid(avm_local_bb1_ld__readdatavalid),
	.avm_local_bb1_ld__waitrequest(avm_local_bb1_ld__waitrequest),
	.avm_local_bb1_ld__address(avm_local_bb1_ld__address),
	.avm_local_bb1_ld__read(avm_local_bb1_ld__read),
	.avm_local_bb1_ld__write(avm_local_bb1_ld__write),
	.avm_local_bb1_ld__writeack(avm_local_bb1_ld__writeack),
	.avm_local_bb1_ld__writedata(avm_local_bb1_ld__writedata),
	.avm_local_bb1_ld__byteenable(avm_local_bb1_ld__byteenable),
	.avm_local_bb1_ld__burstcount(avm_local_bb1_ld__burstcount),
	.profile_lsu_local_bb1_ld__profile_bw_cntl(profile_lsu_local_bb1_ld__profile_bw_cntl),
	.profile_lsu_local_bb1_ld__profile_bw_incr(profile_lsu_local_bb1_ld__profile_bw_incr),
	.profile_lsu_local_bb1_ld__profile_total_ivalid_cntl(profile_lsu_local_bb1_ld__profile_total_ivalid_cntl),
	.profile_lsu_local_bb1_ld__profile_total_req_cntl(profile_lsu_local_bb1_ld__profile_total_req_cntl),
	.profile_lsu_local_bb1_ld__profile_avm_readwrite_count_cntl(profile_lsu_local_bb1_ld__profile_avm_readwrite_count_cntl),
	.profile_lsu_local_bb1_ld__profile_avm_burstcount_total_cntl(profile_lsu_local_bb1_ld__profile_avm_burstcount_total_cntl),
	.profile_lsu_local_bb1_ld__profile_avm_burstcount_total_incr(profile_lsu_local_bb1_ld__profile_avm_burstcount_total_incr),
	.profile_lsu_local_bb1_ld__profile_req_cache_hit_count_cntl(profile_lsu_local_bb1_ld__profile_req_cache_hit_count_cntl),
	.profile_lsu_local_bb1_ld__profile_avm_stall_cntl(profile_lsu_local_bb1_ld__profile_avm_stall_cntl),
	.local_bb1_ld__active(bb_1_local_bb1_ld__active),
	.clock2x(clock2x),
	.avm_local_bb1_ld__u4_readdata(avm_local_bb1_ld__u4_readdata),
	.avm_local_bb1_ld__u4_readdatavalid(avm_local_bb1_ld__u4_readdatavalid),
	.avm_local_bb1_ld__u4_waitrequest(avm_local_bb1_ld__u4_waitrequest),
	.avm_local_bb1_ld__u4_address(avm_local_bb1_ld__u4_address),
	.avm_local_bb1_ld__u4_read(avm_local_bb1_ld__u4_read),
	.avm_local_bb1_ld__u4_write(avm_local_bb1_ld__u4_write),
	.avm_local_bb1_ld__u4_writeack(avm_local_bb1_ld__u4_writeack),
	.avm_local_bb1_ld__u4_writedata(avm_local_bb1_ld__u4_writedata),
	.avm_local_bb1_ld__u4_byteenable(avm_local_bb1_ld__u4_byteenable),
	.avm_local_bb1_ld__u4_burstcount(avm_local_bb1_ld__u4_burstcount),
	.profile_lsu_local_bb1_ld__u4_profile_bw_cntl(profile_lsu_local_bb1_ld__u4_profile_bw_cntl),
	.profile_lsu_local_bb1_ld__u4_profile_bw_incr(profile_lsu_local_bb1_ld__u4_profile_bw_incr),
	.profile_lsu_local_bb1_ld__u4_profile_total_ivalid_cntl(profile_lsu_local_bb1_ld__u4_profile_total_ivalid_cntl),
	.profile_lsu_local_bb1_ld__u4_profile_total_req_cntl(profile_lsu_local_bb1_ld__u4_profile_total_req_cntl),
	.profile_lsu_local_bb1_ld__u4_profile_avm_readwrite_count_cntl(profile_lsu_local_bb1_ld__u4_profile_avm_readwrite_count_cntl),
	.profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_cntl(profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_cntl),
	.profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_incr(profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_incr),
	.profile_lsu_local_bb1_ld__u4_profile_req_cache_hit_count_cntl(profile_lsu_local_bb1_ld__u4_profile_req_cache_hit_count_cntl),
	.profile_lsu_local_bb1_ld__u4_profile_avm_stall_cntl(profile_lsu_local_bb1_ld__u4_profile_avm_stall_cntl),
	.local_bb1_ld__u4_active(bb_1_local_bb1_ld__u4_active)
);


matMul_basic_block_2 matMul_basic_block_2 (
	.clock(clock),
	.resetn(resetn),
	.input_C(input_C),
	.valid_in(bb_1_valid_out_0),
	.stall_out(bb_2_stall_out),
	.input_mul_RM(bb_1_lvb_bb1_mul_RM_0),
	.input_or_cond_NEG_RM(bb_1_lvb_bb1_or_cond_NEG_RM_0),
	.input_c0_exe1(bb_1_lvb_bb1_c0_exe1_0),
	.input_global_id_0(bb_1_lvb_input_global_id_0_0),
	.input_acl_hw_wg_id(bb_1_lvb_input_acl_hw_wg_id_0),
	.valid_out(bb_2_valid_out),
	.stall_in(stall_in),
	.lvb_input_acl_hw_wg_id(bb_2_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb2_st_c0_exe1_readdata(avm_local_bb2_st_c0_exe1_readdata),
	.avm_local_bb2_st_c0_exe1_readdatavalid(avm_local_bb2_st_c0_exe1_readdatavalid),
	.avm_local_bb2_st_c0_exe1_waitrequest(avm_local_bb2_st_c0_exe1_waitrequest),
	.avm_local_bb2_st_c0_exe1_address(avm_local_bb2_st_c0_exe1_address),
	.avm_local_bb2_st_c0_exe1_read(avm_local_bb2_st_c0_exe1_read),
	.avm_local_bb2_st_c0_exe1_write(avm_local_bb2_st_c0_exe1_write),
	.avm_local_bb2_st_c0_exe1_writeack(avm_local_bb2_st_c0_exe1_writeack),
	.avm_local_bb2_st_c0_exe1_writedata(avm_local_bb2_st_c0_exe1_writedata),
	.avm_local_bb2_st_c0_exe1_byteenable(avm_local_bb2_st_c0_exe1_byteenable),
	.avm_local_bb2_st_c0_exe1_burstcount(avm_local_bb2_st_c0_exe1_burstcount),
	.profile_lsu_local_bb2_st_c0_exe1_profile_bw_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_bw_cntl),
	.profile_lsu_local_bb2_st_c0_exe1_profile_bw_incr(profile_lsu_local_bb2_st_c0_exe1_profile_bw_incr),
	.profile_lsu_local_bb2_st_c0_exe1_profile_total_ivalid_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_total_ivalid_cntl),
	.profile_lsu_local_bb2_st_c0_exe1_profile_total_req_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_total_req_cntl),
	.profile_lsu_local_bb2_st_c0_exe1_profile_avm_readwrite_count_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_avm_readwrite_count_cntl),
	.profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_cntl),
	.profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_incr(profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_incr),
	.profile_lsu_local_bb2_st_c0_exe1_profile_avm_stall_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_avm_stall_cntl),
	.local_bb2_st_c0_exe1_active(bb_2_local_bb2_st_c0_exe1_active),
	.clock2x(clock2x)
);


matMul_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign valid_out = bb_2_valid_out;
assign output_0 = bb_2_lvb_input_acl_hw_wg_id;
assign stall_out = bb_0_stall_out;
assign profile_clock = 1'b1;
assign writes_pending = bb_2_local_bb2_st_c0_exe1_active;
assign lsus_active[0] = bb_1_local_bb1_ld__active;
assign lsus_active[1] = bb_1_local_bb1_ld__u4_active;
assign lsus_active[2] = bb_2_local_bb2_st_c0_exe1_active;

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
module matMul_function_wrapper
	(
		input 		clock,
		input 		resetn,
		input 		clock2x,
		input 		local_router_hang,
		input 		profile_extmem_matMul_function_bank0_port0_read_data_inc_en,
		input 		profile_extmem_matMul_function_bank0_port0_read_burst_count_en,
		input 		profile_extmem_matMul_function_bank0_port0_write_data_inc_en,
		input 		profile_extmem_matMul_function_bank0_port0_write_burst_count_en,
		input 		avs_cra_read,
		input 		avs_cra_write,
		input [3:0] 		avs_cra_address,
		input [63:0] 		avs_cra_writedata,
		input [7:0] 		avs_cra_byteenable,
		output reg [63:0] 		avs_cra_readdata,
		output reg 		avs_cra_readdatavalid,
		output 		cra_irq,
		input [255:0] 		avm_local_bb1_ld__inst0_readdata,
		input 		avm_local_bb1_ld__inst0_readdatavalid,
		input 		avm_local_bb1_ld__inst0_waitrequest,
		output [29:0] 		avm_local_bb1_ld__inst0_address,
		output 		avm_local_bb1_ld__inst0_read,
		output 		avm_local_bb1_ld__inst0_write,
		input 		avm_local_bb1_ld__inst0_writeack,
		output [255:0] 		avm_local_bb1_ld__inst0_writedata,
		output [31:0] 		avm_local_bb1_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb1_ld__inst0_burstcount,
		input [255:0] 		avm_local_bb1_ld__u4_inst0_readdata,
		input 		avm_local_bb1_ld__u4_inst0_readdatavalid,
		input 		avm_local_bb1_ld__u4_inst0_waitrequest,
		output [29:0] 		avm_local_bb1_ld__u4_inst0_address,
		output 		avm_local_bb1_ld__u4_inst0_read,
		output 		avm_local_bb1_ld__u4_inst0_write,
		input 		avm_local_bb1_ld__u4_inst0_writeack,
		output [255:0] 		avm_local_bb1_ld__u4_inst0_writedata,
		output [31:0] 		avm_local_bb1_ld__u4_inst0_byteenable,
		output [4:0] 		avm_local_bb1_ld__u4_inst0_burstcount,
		input [255:0] 		avm_local_bb2_st_c0_exe1_inst0_readdata,
		input 		avm_local_bb2_st_c0_exe1_inst0_readdatavalid,
		input 		avm_local_bb2_st_c0_exe1_inst0_waitrequest,
		output [29:0] 		avm_local_bb2_st_c0_exe1_inst0_address,
		output 		avm_local_bb2_st_c0_exe1_inst0_read,
		output 		avm_local_bb2_st_c0_exe1_inst0_write,
		input 		avm_local_bb2_st_c0_exe1_inst0_writeack,
		output [255:0] 		avm_local_bb2_st_c0_exe1_inst0_writedata,
		output [31:0] 		avm_local_bb2_st_c0_exe1_inst0_byteenable,
		output [4:0] 		avm_local_bb2_st_c0_exe1_inst0_burstcount
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
 reg [191:0] kernel_arguments_NO_SHIFT_REG;
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
wire [24:0] profile_increment_cntl;
wire [799:0] profile_increment_val;

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
defparam profiler_inst.NUM_COUNTERS = 25;
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
		kernel_arguments_NO_SHIFT_REG <= 192'h0;
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

				4'hE:
				begin
					kernel_arguments_NO_SHIFT_REG[159:128] <= ((kernel_arguments_NO_SHIFT_REG[159:128] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[191:160] <= ((kernel_arguments_NO_SHIFT_REG[191:160] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
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
wire profile_lsu_local_bb1_ld__profile_bw_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb1_ld__profile_bw_incr_inst0_wire_0;
wire profile_lsu_local_bb1_ld__profile_total_ivalid_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld__profile_total_req_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld__profile_avm_readwrite_count_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld__profile_avm_burstcount_total_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb1_ld__profile_avm_burstcount_total_incr_inst0_wire_0;
wire profile_lsu_local_bb1_ld__profile_req_cache_hit_count_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld__profile_avm_stall_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld__u4_profile_bw_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb1_ld__u4_profile_bw_incr_inst0_wire_0;
wire profile_lsu_local_bb1_ld__u4_profile_total_ivalid_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld__u4_profile_total_req_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld__u4_profile_avm_readwrite_count_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_incr_inst0_wire_0;
wire profile_lsu_local_bb1_ld__u4_profile_req_cache_hit_count_cntl_inst0_wire_0;
wire profile_lsu_local_bb1_ld__u4_profile_avm_stall_cntl_inst0_wire_0;
wire profile_lsu_local_bb2_st_c0_exe1_profile_bw_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb2_st_c0_exe1_profile_bw_incr_inst0_wire_0;
wire profile_lsu_local_bb2_st_c0_exe1_profile_total_ivalid_cntl_inst0_wire_0;
wire profile_lsu_local_bb2_st_c0_exe1_profile_total_req_cntl_inst0_wire_0;
wire profile_lsu_local_bb2_st_c0_exe1_profile_avm_readwrite_count_cntl_inst0_wire_0;
wire profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_cntl_inst0_wire_0;
wire [31:0] profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_incr_inst0_wire_0;
wire profile_lsu_local_bb2_st_c0_exe1_profile_avm_stall_cntl_inst0_wire_0;
wire profile_clock_inst0_wire_0;

matMul_function matMul_function_inst0 (
	.clock(clock),
	.resetn(resetn),
	.input_global_id_0(global_id[0][0]),
	.input_global_id_1(global_id[0][1]),
	.input_acl_hw_wg_id(),
	.stall_out(stall_out),
	.valid_in(valid_in),
	.output_0(),
	.valid_out(valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size_NO_SHIFT_REG),
	.avm_local_bb1_ld__readdata(avm_local_bb1_ld__inst0_readdata),
	.avm_local_bb1_ld__readdatavalid(avm_local_bb1_ld__inst0_readdatavalid),
	.avm_local_bb1_ld__waitrequest(avm_local_bb1_ld__inst0_waitrequest),
	.avm_local_bb1_ld__address(avm_local_bb1_ld__inst0_address),
	.avm_local_bb1_ld__read(avm_local_bb1_ld__inst0_read),
	.avm_local_bb1_ld__write(avm_local_bb1_ld__inst0_write),
	.avm_local_bb1_ld__writeack(avm_local_bb1_ld__inst0_writeack),
	.avm_local_bb1_ld__writedata(avm_local_bb1_ld__inst0_writedata),
	.avm_local_bb1_ld__byteenable(avm_local_bb1_ld__inst0_byteenable),
	.avm_local_bb1_ld__burstcount(avm_local_bb1_ld__inst0_burstcount),
	.profile_lsu_local_bb1_ld__profile_bw_cntl(profile_lsu_local_bb1_ld__profile_bw_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__profile_bw_incr(profile_lsu_local_bb1_ld__profile_bw_incr_inst0_wire_0),
	.profile_lsu_local_bb1_ld__profile_total_ivalid_cntl(profile_lsu_local_bb1_ld__profile_total_ivalid_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__profile_total_req_cntl(profile_lsu_local_bb1_ld__profile_total_req_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__profile_avm_readwrite_count_cntl(profile_lsu_local_bb1_ld__profile_avm_readwrite_count_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__profile_avm_burstcount_total_cntl(profile_lsu_local_bb1_ld__profile_avm_burstcount_total_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__profile_avm_burstcount_total_incr(profile_lsu_local_bb1_ld__profile_avm_burstcount_total_incr_inst0_wire_0),
	.profile_lsu_local_bb1_ld__profile_req_cache_hit_count_cntl(profile_lsu_local_bb1_ld__profile_req_cache_hit_count_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__profile_avm_stall_cntl(profile_lsu_local_bb1_ld__profile_avm_stall_cntl_inst0_wire_0),
	.avm_local_bb1_ld__u4_readdata(avm_local_bb1_ld__u4_inst0_readdata),
	.avm_local_bb1_ld__u4_readdatavalid(avm_local_bb1_ld__u4_inst0_readdatavalid),
	.avm_local_bb1_ld__u4_waitrequest(avm_local_bb1_ld__u4_inst0_waitrequest),
	.avm_local_bb1_ld__u4_address(avm_local_bb1_ld__u4_inst0_address),
	.avm_local_bb1_ld__u4_read(avm_local_bb1_ld__u4_inst0_read),
	.avm_local_bb1_ld__u4_write(avm_local_bb1_ld__u4_inst0_write),
	.avm_local_bb1_ld__u4_writeack(avm_local_bb1_ld__u4_inst0_writeack),
	.avm_local_bb1_ld__u4_writedata(avm_local_bb1_ld__u4_inst0_writedata),
	.avm_local_bb1_ld__u4_byteenable(avm_local_bb1_ld__u4_inst0_byteenable),
	.avm_local_bb1_ld__u4_burstcount(avm_local_bb1_ld__u4_inst0_burstcount),
	.profile_lsu_local_bb1_ld__u4_profile_bw_cntl(profile_lsu_local_bb1_ld__u4_profile_bw_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__u4_profile_bw_incr(profile_lsu_local_bb1_ld__u4_profile_bw_incr_inst0_wire_0),
	.profile_lsu_local_bb1_ld__u4_profile_total_ivalid_cntl(profile_lsu_local_bb1_ld__u4_profile_total_ivalid_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__u4_profile_total_req_cntl(profile_lsu_local_bb1_ld__u4_profile_total_req_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__u4_profile_avm_readwrite_count_cntl(profile_lsu_local_bb1_ld__u4_profile_avm_readwrite_count_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_cntl(profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_incr(profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_incr_inst0_wire_0),
	.profile_lsu_local_bb1_ld__u4_profile_req_cache_hit_count_cntl(profile_lsu_local_bb1_ld__u4_profile_req_cache_hit_count_cntl_inst0_wire_0),
	.profile_lsu_local_bb1_ld__u4_profile_avm_stall_cntl(profile_lsu_local_bb1_ld__u4_profile_avm_stall_cntl_inst0_wire_0),
	.avm_local_bb2_st_c0_exe1_readdata(avm_local_bb2_st_c0_exe1_inst0_readdata),
	.avm_local_bb2_st_c0_exe1_readdatavalid(avm_local_bb2_st_c0_exe1_inst0_readdatavalid),
	.avm_local_bb2_st_c0_exe1_waitrequest(avm_local_bb2_st_c0_exe1_inst0_waitrequest),
	.avm_local_bb2_st_c0_exe1_address(avm_local_bb2_st_c0_exe1_inst0_address),
	.avm_local_bb2_st_c0_exe1_read(avm_local_bb2_st_c0_exe1_inst0_read),
	.avm_local_bb2_st_c0_exe1_write(avm_local_bb2_st_c0_exe1_inst0_write),
	.avm_local_bb2_st_c0_exe1_writeack(avm_local_bb2_st_c0_exe1_inst0_writeack),
	.avm_local_bb2_st_c0_exe1_writedata(avm_local_bb2_st_c0_exe1_inst0_writedata),
	.avm_local_bb2_st_c0_exe1_byteenable(avm_local_bb2_st_c0_exe1_inst0_byteenable),
	.avm_local_bb2_st_c0_exe1_burstcount(avm_local_bb2_st_c0_exe1_inst0_burstcount),
	.profile_lsu_local_bb2_st_c0_exe1_profile_bw_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_bw_cntl_inst0_wire_0),
	.profile_lsu_local_bb2_st_c0_exe1_profile_bw_incr(profile_lsu_local_bb2_st_c0_exe1_profile_bw_incr_inst0_wire_0),
	.profile_lsu_local_bb2_st_c0_exe1_profile_total_ivalid_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_total_ivalid_cntl_inst0_wire_0),
	.profile_lsu_local_bb2_st_c0_exe1_profile_total_req_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_total_req_cntl_inst0_wire_0),
	.profile_lsu_local_bb2_st_c0_exe1_profile_avm_readwrite_count_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_avm_readwrite_count_cntl_inst0_wire_0),
	.profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_cntl_inst0_wire_0),
	.profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_incr(profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_incr_inst0_wire_0),
	.profile_lsu_local_bb2_st_c0_exe1_profile_avm_stall_cntl(profile_lsu_local_bb2_st_c0_exe1_profile_avm_stall_cntl_inst0_wire_0),
	.start(start_out),
	.clock2x(clock2x),
	.input_B(kernel_arguments_NO_SHIFT_REG[127:64]),
	.input_A(kernel_arguments_NO_SHIFT_REG[63:0]),
	.input_C(kernel_arguments_NO_SHIFT_REG[191:128]),
	.profile_clock(profile_clock_inst0_wire_0),
	.has_a_write_pending(has_a_write_pending),
	.has_a_lsu_active(has_a_lsu_active)
);


assign profile_increment_cntl[0] = profile_lsu_local_bb1_ld__profile_bw_cntl_inst0_wire_0;
assign profile_increment_val[31:0] = profile_lsu_local_bb1_ld__profile_bw_incr_inst0_wire_0;
assign profile_increment_cntl[1] = profile_lsu_local_bb1_ld__profile_total_ivalid_cntl_inst0_wire_0;
assign profile_increment_val[63:32] = 32'h1;
assign profile_increment_cntl[2] = profile_lsu_local_bb1_ld__profile_total_req_cntl_inst0_wire_0;
assign profile_increment_val[95:64] = 32'h1;
assign profile_increment_cntl[3] = profile_lsu_local_bb1_ld__profile_avm_readwrite_count_cntl_inst0_wire_0;
assign profile_increment_val[127:96] = 32'h1;
assign profile_increment_cntl[4] = profile_lsu_local_bb1_ld__profile_avm_burstcount_total_cntl_inst0_wire_0;
assign profile_increment_val[159:128] = profile_lsu_local_bb1_ld__profile_avm_burstcount_total_incr_inst0_wire_0;
assign profile_increment_cntl[5] = profile_lsu_local_bb1_ld__profile_req_cache_hit_count_cntl_inst0_wire_0;
assign profile_increment_val[191:160] = 32'h1;
assign profile_increment_cntl[6] = profile_lsu_local_bb1_ld__profile_avm_stall_cntl_inst0_wire_0;
assign profile_increment_val[223:192] = 32'h1;
assign profile_increment_cntl[7] = profile_lsu_local_bb1_ld__u4_profile_bw_cntl_inst0_wire_0;
assign profile_increment_val[255:224] = profile_lsu_local_bb1_ld__u4_profile_bw_incr_inst0_wire_0;
assign profile_increment_cntl[8] = profile_lsu_local_bb1_ld__u4_profile_total_ivalid_cntl_inst0_wire_0;
assign profile_increment_val[287:256] = 32'h1;
assign profile_increment_cntl[9] = profile_lsu_local_bb1_ld__u4_profile_total_req_cntl_inst0_wire_0;
assign profile_increment_val[319:288] = 32'h1;
assign profile_increment_cntl[10] = profile_lsu_local_bb1_ld__u4_profile_avm_readwrite_count_cntl_inst0_wire_0;
assign profile_increment_val[351:320] = 32'h1;
assign profile_increment_cntl[11] = profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_cntl_inst0_wire_0;
assign profile_increment_val[383:352] = profile_lsu_local_bb1_ld__u4_profile_avm_burstcount_total_incr_inst0_wire_0;
assign profile_increment_cntl[12] = profile_lsu_local_bb1_ld__u4_profile_req_cache_hit_count_cntl_inst0_wire_0;
assign profile_increment_val[415:384] = 32'h1;
assign profile_increment_cntl[13] = profile_lsu_local_bb1_ld__u4_profile_avm_stall_cntl_inst0_wire_0;
assign profile_increment_val[447:416] = 32'h1;
assign profile_increment_cntl[14] = profile_lsu_local_bb2_st_c0_exe1_profile_bw_cntl_inst0_wire_0;
assign profile_increment_val[479:448] = profile_lsu_local_bb2_st_c0_exe1_profile_bw_incr_inst0_wire_0;
assign profile_increment_cntl[15] = profile_lsu_local_bb2_st_c0_exe1_profile_total_ivalid_cntl_inst0_wire_0;
assign profile_increment_val[511:480] = 32'h1;
assign profile_increment_cntl[16] = profile_lsu_local_bb2_st_c0_exe1_profile_total_req_cntl_inst0_wire_0;
assign profile_increment_val[543:512] = 32'h1;
assign profile_increment_cntl[17] = profile_lsu_local_bb2_st_c0_exe1_profile_avm_readwrite_count_cntl_inst0_wire_0;
assign profile_increment_val[575:544] = 32'h1;
assign profile_increment_cntl[18] = profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_cntl_inst0_wire_0;
assign profile_increment_val[607:576] = profile_lsu_local_bb2_st_c0_exe1_profile_avm_burstcount_total_incr_inst0_wire_0;
assign profile_increment_cntl[19] = profile_lsu_local_bb2_st_c0_exe1_profile_avm_stall_cntl_inst0_wire_0;
assign profile_increment_val[639:608] = 32'h1;
assign profile_increment_cntl[20] = profile_clock_inst0_wire_0;
assign profile_increment_val[671:640] = 32'h1;
assign profile_increment_cntl[21] = profile_extmem_matMul_function_bank0_port0_read_data_inc_en;
assign profile_increment_val[703:672] = 32'h1;
assign profile_increment_cntl[22] = profile_extmem_matMul_function_bank0_port0_read_burst_count_en;
assign profile_increment_val[735:704] = 32'h1;
assign profile_increment_cntl[23] = profile_extmem_matMul_function_bank0_port0_write_data_inc_en;
assign profile_increment_val[767:736] = 32'h1;
assign profile_increment_cntl[24] = profile_extmem_matMul_function_bank0_port0_write_burst_count_en;
assign profile_increment_val[799:768] = 32'h1;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// altera message_off 10036
// altera message_off 10230
// altera message_off 10858
module matMul_sys_cycle_time
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

