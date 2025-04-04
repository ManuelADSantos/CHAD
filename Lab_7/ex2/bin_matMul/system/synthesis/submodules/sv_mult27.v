// megafunction wizard: %ALTMULT_ADD%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTMULT_ADD 

// ============================================================
// File Name: sv_mult27.v
// Megafunction Name(s):
// 			ALTMULT_ADD
//
// Simulation Library Files(s):
// 			altera_lnsim
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 12.1 Build 177 11/07/2012 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2012 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


//altmult_add ACCUM_SLOAD_REGISTER="UNREGISTERED" ADDNSUB_MULTIPLIER_PIPELINE_REGISTER1="UNREGISTERED" ADDNSUB_MULTIPLIER_REGISTER1="CLOCK0" CBX_AUTO_BLACKBOX="ALL" COEF0_0=0 COEF0_1=0 COEF0_2=0 COEF0_3=0 COEF0_4=0 COEF0_5=0 COEF0_6=0 COEF0_7=0 COEF1_0=0 COEF1_1=0 COEF1_2=0 COEF1_3=0 COEF1_4=0 COEF1_5=0 COEF1_6=0 COEF1_7=0 COEF2_0=0 COEF2_1=0 COEF2_2=0 COEF2_3=0 COEF2_4=0 COEF2_5=0 COEF2_6=0 COEF2_7=0 COEF3_0=0 COEF3_1=0 COEF3_2=0 COEF3_3=0 COEF3_4=0 COEF3_5=0 COEF3_6=0 COEF3_7=0 COEFSEL0_REGISTER="UNREGISTERED" DEDICATED_MULTIPLIER_CIRCUITRY="AUTO" DEVICE_FAMILY="Stratix V" INPUT_REGISTER_A0="CLOCK0" INPUT_REGISTER_B0="CLOCK0" INPUT_REGISTER_C0="UNREGISTERED" INPUT_SOURCE_A0="DATAA" INPUT_SOURCE_B0="DATAB" LOADCONST_VALUE=64 MULTIPLIER1_DIRECTION="ADD" MULTIPLIER_REGISTER0="UNREGISTERED" NUMBER_OF_MULTIPLIERS=1 OUTPUT_REGISTER="CLOCK0" port_addnsub1="PORT_UNUSED" port_signa="PORT_UNUSED" port_signb="PORT_UNUSED" PREADDER_DIRECTION_0="ADD" PREADDER_DIRECTION_1="ADD" PREADDER_DIRECTION_2="ADD" PREADDER_DIRECTION_3="ADD" PREADDER_MODE="SIMPLE" REPRESENTATION_A="UNSIGNED" REPRESENTATION_B="UNSIGNED" SIGNED_PIPELINE_REGISTER_A="UNREGISTERED" SIGNED_PIPELINE_REGISTER_B="UNREGISTERED" SIGNED_REGISTER_A="CLOCK0" SIGNED_REGISTER_B="CLOCK0" SYSTOLIC_DELAY1="UNREGISTERED" SYSTOLIC_DELAY3="UNREGISTERED" WIDTH_A=27 WIDTH_B=27 WIDTH_RESULT=54 clock0 dataa datab result
//VERSION_BEGIN 12.1 cbx_alt_ded_mult_y 2012:11:07:18:03:20:SJ cbx_altera_mult_add 2012:11:07:18:03:20:SJ cbx_altmult_add 2012:11:07:18:03:20:SJ cbx_cycloneii 2012:11:07:18:03:20:SJ cbx_lpm_add_sub 2012:11:07:18:03:20:SJ cbx_lpm_mult 2012:11:07:18:03:20:SJ cbx_mgl 2012:11:07:18:50:05:SJ cbx_padd 2012:11:07:18:03:20:SJ cbx_parallel_add 2012:11:07:18:03:20:SJ cbx_stratix 2012:11:07:18:03:20:SJ cbx_stratixii 2012:11:07:18:03:20:SJ cbx_util_mgl 2012:11:07:18:03:20:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = altera_mult_add 1 dsp_mac 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  sv_mult27_mult_add_cfq3
	( 
	clock0,
        ena0,
	dataa,
	datab,
	result) ;
  
  parameter REPRESENTATION = "UNSIGNED";
	input   clock0;
        input   ena0;
	input   [26:0]  dataa;
	input   [26:0]  datab;
	output   [53:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1   clock0;
	tri0   [26:0]  dataa;
	tri0   [26:0]  datab;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [53:0]   wire_altera_mult_add1_result;
	wire ena1;
	wire ena2;
	wire ena3;

	altera_mult_add   altera_mult_add1
	( 
	.chainout_sat_overflow(),
	.clock0(clock0),
	.dataa(dataa),
	.datab(datab),
	.ena0(ena0),
	.ena1(ena1),
	.ena2(ena2),
	.ena3(ena3),
	.mult0_is_saturated(),
	.mult1_is_saturated(),
	.mult2_is_saturated(),
	.mult3_is_saturated(),
	.overflow(),
	.result(wire_altera_mult_add1_result),
	.scanouta(),
	.scanoutb(),
	.accum_sload(1'b0),
	.aclr0(1'b0),
	.aclr1(1'b0),
	.aclr2(1'b0),
	.aclr3(1'b0),
	.addnsub1(1'b1),
	.addnsub1_round(1'b0),
	.addnsub3(1'b1),
	.addnsub3_round(1'b0),
	.chainin({1{1'b0}}),
	.chainout_round(1'b0),
	.chainout_saturate(1'b0),
	.clock1(1'b1),
	.clock2(1'b1),
	.clock3(1'b1),
	.coefsel0({3{1'b0}}),
	.coefsel1({3{1'b0}}),
	.coefsel2({3{1'b0}}),
	.coefsel3({3{1'b0}}),
	.datac({22{1'b0}}),
	.mult01_round(1'b0),
	.mult01_saturation(1'b0),
	.mult23_round(1'b0),
	.mult23_saturation(1'b0),
	.output_round(1'b0),
	.output_saturate(1'b0),
	.rotate(1'b0),
	.scanina({27{1'b0}}),
	.scaninb({27{1'b0}}),
	.shift_right(1'b0),
	.signa(1'b0),
	.signb(1'b0),
	.sourcea({1{1'b0}}),
	.sourceb({1{1'b0}}),
	.zero_chainout(1'b0),
	.zero_loopback(1'b0)
	);
	defparam
		altera_mult_add1.accum_direction = "ADD",
		altera_mult_add1.accum_sload_aclr = "ACLR0",
		altera_mult_add1.accum_sload_pipeline_aclr = "ACLR0",
		altera_mult_add1.accum_sload_pipeline_register = "CLOCK0",
		altera_mult_add1.accum_sload_register = "UNREGISTERED",
		altera_mult_add1.accumulator = "NO",
		altera_mult_add1.adder1_rounding = "NO",
		altera_mult_add1.adder3_rounding = "NO",
		altera_mult_add1.addnsub1_round_aclr = "ACLR0",
		altera_mult_add1.addnsub1_round_pipeline_aclr = "ACLR0",
		altera_mult_add1.addnsub1_round_pipeline_register = "CLOCK0",
		altera_mult_add1.addnsub1_round_register = "CLOCK0",
		altera_mult_add1.addnsub3_round_aclr = "ACLR0",
		altera_mult_add1.addnsub3_round_pipeline_aclr = "ACLR0",
		altera_mult_add1.addnsub3_round_pipeline_register = "CLOCK0",
		altera_mult_add1.addnsub3_round_register = "CLOCK0",
		altera_mult_add1.addnsub_multiplier_aclr1 = "ACLR0",
		altera_mult_add1.addnsub_multiplier_aclr3 = "ACLR0",
		altera_mult_add1.addnsub_multiplier_pipeline_aclr1 = "ACLR0",
		altera_mult_add1.addnsub_multiplier_pipeline_aclr3 = "ACLR0",
		altera_mult_add1.addnsub_multiplier_pipeline_register1 = "UNREGISTERED",
		altera_mult_add1.addnsub_multiplier_pipeline_register3 = "CLOCK0",
		altera_mult_add1.addnsub_multiplier_register1 = "CLOCK0",
		altera_mult_add1.addnsub_multiplier_register3 = "CLOCK0",
		altera_mult_add1.chainout_aclr = "ACLR0",
		altera_mult_add1.chainout_adder = "NO",
		altera_mult_add1.chainout_register = "CLOCK0",
		altera_mult_add1.chainout_round_aclr = "ACLR0",
		altera_mult_add1.chainout_round_output_aclr = "ACLR0",
		altera_mult_add1.chainout_round_output_register = "CLOCK0",
		altera_mult_add1.chainout_round_pipeline_aclr = "ACLR0",
		altera_mult_add1.chainout_round_pipeline_register = "CLOCK0",
		altera_mult_add1.chainout_round_register = "CLOCK0",
		altera_mult_add1.chainout_rounding = "NO",
		altera_mult_add1.chainout_saturate_aclr = "ACLR0",
		altera_mult_add1.chainout_saturate_output_aclr = "ACLR0",
		altera_mult_add1.chainout_saturate_output_register = "CLOCK0",
		altera_mult_add1.chainout_saturate_pipeline_aclr = "ACLR0",
		altera_mult_add1.chainout_saturate_pipeline_register = "CLOCK0",
		altera_mult_add1.chainout_saturate_register = "CLOCK0",
		altera_mult_add1.chainout_saturation = "NO",
		altera_mult_add1.coef0_0 = 0,
		altera_mult_add1.coef0_1 = 0,
		altera_mult_add1.coef0_2 = 0,
		altera_mult_add1.coef0_3 = 0,
		altera_mult_add1.coef0_4 = 0,
		altera_mult_add1.coef0_5 = 0,
		altera_mult_add1.coef0_6 = 0,
		altera_mult_add1.coef0_7 = 0,
		altera_mult_add1.coef1_0 = 0,
		altera_mult_add1.coef1_1 = 0,
		altera_mult_add1.coef1_2 = 0,
		altera_mult_add1.coef1_3 = 0,
		altera_mult_add1.coef1_4 = 0,
		altera_mult_add1.coef1_5 = 0,
		altera_mult_add1.coef1_6 = 0,
		altera_mult_add1.coef1_7 = 0,
		altera_mult_add1.coef2_0 = 0,
		altera_mult_add1.coef2_1 = 0,
		altera_mult_add1.coef2_2 = 0,
		altera_mult_add1.coef2_3 = 0,
		altera_mult_add1.coef2_4 = 0,
		altera_mult_add1.coef2_5 = 0,
		altera_mult_add1.coef2_6 = 0,
		altera_mult_add1.coef2_7 = 0,
		altera_mult_add1.coef3_0 = 0,
		altera_mult_add1.coef3_1 = 0,
		altera_mult_add1.coef3_2 = 0,
		altera_mult_add1.coef3_3 = 0,
		altera_mult_add1.coef3_4 = 0,
		altera_mult_add1.coef3_5 = 0,
		altera_mult_add1.coef3_6 = 0,
		altera_mult_add1.coef3_7 = 0,
		altera_mult_add1.coefsel0_aclr = "ACLR0",
		altera_mult_add1.coefsel0_register = "UNREGISTERED",
		altera_mult_add1.coefsel1_aclr = "ACLR0",
		altera_mult_add1.coefsel1_register = "CLOCK0",
		altera_mult_add1.coefsel2_aclr = "ACLR0",
		altera_mult_add1.coefsel2_register = "CLOCK0",
		altera_mult_add1.coefsel3_aclr = "ACLR0",
		altera_mult_add1.coefsel3_register = "CLOCK0",
		altera_mult_add1.dedicated_multiplier_circuitry = "AUTO",
		altera_mult_add1.double_accum = "NO",
		altera_mult_add1.dsp_block_balancing = "Auto",
		altera_mult_add1.extra_latency = 0,
		altera_mult_add1.input_aclr_a0 = "ACLR0",
		altera_mult_add1.input_aclr_a1 = "ACLR0",
		altera_mult_add1.input_aclr_a2 = "ACLR0",
		altera_mult_add1.input_aclr_a3 = "ACLR0",
		altera_mult_add1.input_aclr_b0 = "ACLR0",
		altera_mult_add1.input_aclr_b1 = "ACLR0",
		altera_mult_add1.input_aclr_b2 = "ACLR0",
		altera_mult_add1.input_aclr_b3 = "ACLR0",
		altera_mult_add1.input_aclr_c0 = "ACLR0",
		altera_mult_add1.input_aclr_c1 = "ACLR0",
		altera_mult_add1.input_aclr_c2 = "ACLR0",
		altera_mult_add1.input_aclr_c3 = "ACLR0",
		altera_mult_add1.input_register_a0 = "CLOCK0",
		altera_mult_add1.input_register_a1 = "CLOCK0",
		altera_mult_add1.input_register_a2 = "CLOCK0",
		altera_mult_add1.input_register_a3 = "CLOCK0",
		altera_mult_add1.input_register_b0 = "CLOCK0",
		altera_mult_add1.input_register_b1 = "CLOCK0",
		altera_mult_add1.input_register_b2 = "CLOCK0",
		altera_mult_add1.input_register_b3 = "CLOCK0",
		altera_mult_add1.input_register_c0 = "UNREGISTERED",
		altera_mult_add1.input_register_c1 = "CLOCK0",
		altera_mult_add1.input_register_c2 = "CLOCK0",
		altera_mult_add1.input_register_c3 = "CLOCK0",
		altera_mult_add1.input_source_a0 = "DATAA",
		altera_mult_add1.input_source_a1 = "DATAA",
		altera_mult_add1.input_source_a2 = "DATAA",
		altera_mult_add1.input_source_a3 = "DATAA",
		altera_mult_add1.input_source_b0 = "DATAB",
		altera_mult_add1.input_source_b1 = "DATAB",
		altera_mult_add1.input_source_b2 = "DATAB",
		altera_mult_add1.input_source_b3 = "DATAB",
		altera_mult_add1.loadconst_control_aclr = "ACLR0",
		altera_mult_add1.loadconst_control_register = "CLOCK0",
		altera_mult_add1.loadconst_value = 64,
		altera_mult_add1.mult01_round_aclr = "ACLR0",
		altera_mult_add1.mult01_round_register = "CLOCK0",
		altera_mult_add1.mult01_saturation_aclr = "ACLR1",
		altera_mult_add1.mult01_saturation_register = "CLOCK0",
		altera_mult_add1.mult23_round_aclr = "ACLR0",
		altera_mult_add1.mult23_round_register = "CLOCK0",
		altera_mult_add1.mult23_saturation_aclr = "ACLR0",
		altera_mult_add1.mult23_saturation_register = "CLOCK0",
		altera_mult_add1.multiplier01_rounding = "NO",
		altera_mult_add1.multiplier01_saturation = "NO",
		altera_mult_add1.multiplier1_direction = "ADD",
		altera_mult_add1.multiplier23_rounding = "NO",
		altera_mult_add1.multiplier23_saturation = "NO",
		altera_mult_add1.multiplier3_direction = "ADD",
		altera_mult_add1.multiplier_aclr0 = "ACLR0",
		altera_mult_add1.multiplier_aclr1 = "ACLR0",
		altera_mult_add1.multiplier_aclr2 = "ACLR0",
		altera_mult_add1.multiplier_aclr3 = "ACLR0",
		altera_mult_add1.multiplier_register0 = "UNREGISTERED",
		altera_mult_add1.multiplier_register1 = "CLOCK0",
		altera_mult_add1.multiplier_register2 = "CLOCK0",
		altera_mult_add1.multiplier_register3 = "CLOCK0",
		altera_mult_add1.number_of_multipliers = 1,
		altera_mult_add1.output_aclr = "ACLR0",
		altera_mult_add1.output_register = "CLOCK0",
		altera_mult_add1.output_round_aclr = "ACLR0",
		altera_mult_add1.output_round_pipeline_aclr = "ACLR0",
		altera_mult_add1.output_round_pipeline_register = "CLOCK0",
		altera_mult_add1.output_round_register = "CLOCK0",
		altera_mult_add1.output_round_type = "NEAREST_INTEGER",
		altera_mult_add1.output_rounding = "NO",
		altera_mult_add1.output_saturate_aclr = "ACLR0",
		altera_mult_add1.output_saturate_pipeline_aclr = "ACLR0",
		altera_mult_add1.output_saturate_pipeline_register = "CLOCK0",
		altera_mult_add1.output_saturate_register = "CLOCK0",
		altera_mult_add1.output_saturate_type = "ASYMMETRIC",
		altera_mult_add1.output_saturation = "NO",
		altera_mult_add1.port_addnsub1 = "PORT_UNUSED",
		altera_mult_add1.port_addnsub3 = "PORT_UNUSED",
		altera_mult_add1.port_chainout_sat_is_overflow = "PORT_UNUSED",
		altera_mult_add1.port_output_is_overflow = "PORT_UNUSED",
		altera_mult_add1.port_signa = "PORT_UNUSED",
		altera_mult_add1.port_signb = "PORT_UNUSED",
		altera_mult_add1.preadder_direction_0 = "ADD",
		altera_mult_add1.preadder_direction_1 = "ADD",
		altera_mult_add1.preadder_direction_2 = "ADD",
		altera_mult_add1.preadder_direction_3 = "ADD",
		altera_mult_add1.preadder_mode = "SIMPLE",
		altera_mult_add1.representation_a = REPRESENTATION,
		altera_mult_add1.representation_b = REPRESENTATION,
		altera_mult_add1.rotate_aclr = "ACLR0",
		altera_mult_add1.rotate_output_aclr = "ACLR0",
		altera_mult_add1.rotate_output_register = "CLOCK0",
		altera_mult_add1.rotate_pipeline_aclr = "ACLR0",
		altera_mult_add1.rotate_pipeline_register = "CLOCK0",
		altera_mult_add1.rotate_register = "CLOCK0",
		altera_mult_add1.scanouta_aclr = "ACLR0",
		altera_mult_add1.scanouta_register = "UNREGISTERED",
		altera_mult_add1.selected_device_family = "Stratix V",
		altera_mult_add1.shift_mode = "NO",
		altera_mult_add1.shift_right_aclr = "ACLR0",
		altera_mult_add1.shift_right_output_aclr = "ACLR0",
		altera_mult_add1.shift_right_output_register = "CLOCK0",
		altera_mult_add1.shift_right_pipeline_aclr = "ACLR0",
		altera_mult_add1.shift_right_pipeline_register = "CLOCK0",
		altera_mult_add1.shift_right_register = "CLOCK0",
		altera_mult_add1.signed_aclr_a = "ACLR0",
		altera_mult_add1.signed_aclr_b = "ACLR0",
		altera_mult_add1.signed_pipeline_aclr_a = "ACLR0",
		altera_mult_add1.signed_pipeline_aclr_b = "ACLR0",
		altera_mult_add1.signed_pipeline_register_a = "UNREGISTERED",
		altera_mult_add1.signed_pipeline_register_b = "UNREGISTERED",
		altera_mult_add1.signed_register_a = "CLOCK0",
		altera_mult_add1.signed_register_b = "CLOCK0",
		altera_mult_add1.systolic_aclr1 = "ACLR0",
		altera_mult_add1.systolic_aclr3 = "ACLR0",
		altera_mult_add1.systolic_delay1 = "UNREGISTERED",
		altera_mult_add1.systolic_delay3 = "UNREGISTERED",
		altera_mult_add1.width_a = 27,
		altera_mult_add1.width_b = 27,
		altera_mult_add1.width_c = 22,
		altera_mult_add1.width_chainin = 1,
		altera_mult_add1.width_coef = 18,
		altera_mult_add1.width_msb = 17,
		altera_mult_add1.width_result = 54,
		altera_mult_add1.width_saturate_sign = 1,
		altera_mult_add1.zero_chainout_output_aclr = "ACLR0",
		altera_mult_add1.zero_chainout_output_register = "CLOCK0",
		altera_mult_add1.zero_loopback_aclr = "ACLR0",
		altera_mult_add1.zero_loopback_output_aclr = "ACLR0",
		altera_mult_add1.zero_loopback_output_register = "CLOCK0",
		altera_mult_add1.zero_loopback_pipeline_aclr = "ACLR0",
		altera_mult_add1.zero_loopback_pipeline_register = "CLOCK0",
		altera_mult_add1.zero_loopback_register = "CLOCK0",
		altera_mult_add1.lpm_type = "altera_mult_add";
	assign
		ena1 = 1'b1,
		ena2 = 1'b1,
		ena3 = 1'b1,
		result = wire_altera_mult_add1_result;
endmodule //sv_mult27_mult_add_cfq3
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module sv_mult27 (
	clock0,
        ena0,
	dataa_0,
	datab_0,
	result);
  
  parameter REPRESENTATION = "UNSIGNED";
  
	input	  clock0;
        input     ena0;
	input	[26:0]  dataa_0;
	input	[26:0]  datab_0;
	output	[53:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clock0;
	tri0	[26:0]  dataa_0;
	tri0	[26:0]  datab_0;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [53:0] sub_wire0;
	wire [53:0] result = sub_wire0[53:0];

	sv_mult27_mult_add_cfq3	sv_mult27_mult_add_cfq3_component (
				.clock0 (clock0),
        .ena0(ena0),
				.dataa (dataa_0),
				.datab (datab_0),
				.result (sub_wire0));
    defparam sv_mult27_mult_add_cfq3_component.REPRESENTATION = REPRESENTATION;        

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACCUM_SLOAD_ACLR_SRC_MULT0 NUMERIC "3"
// Retrieval info: PRIVATE: ACCUM_SLOAD_CLK_SRC_MULT0 NUMERIC "0"
// Retrieval info: PRIVATE: ADDNSUB1_ACLR_SRC NUMERIC "2"
// Retrieval info: PRIVATE: ADDNSUB1_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: ADDNSUB1_PIPE_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: ADDNSUB1_PIPE_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: ADDNSUB1_PIPE_REG STRING "0"
// Retrieval info: PRIVATE: ADDNSUB1_REG STRING "1"
// Retrieval info: PRIVATE: ADDNSUB3_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: ADDNSUB3_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: ADDNSUB3_PIPE_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: ADDNSUB3_PIPE_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: ADDNSUB3_PIPE_REG STRING "0"
// Retrieval info: PRIVATE: ADDNSUB3_REG STRING "1"
// Retrieval info: PRIVATE: ADD_ENABLE NUMERIC "0"
// Retrieval info: PRIVATE: ALL_REG_ACLR NUMERIC "0"
// Retrieval info: PRIVATE: A_ACLR_SRC_MULT0 NUMERIC "2"
// Retrieval info: PRIVATE: A_CLK_SRC_MULT0 NUMERIC "0"
// Retrieval info: PRIVATE: B_ACLR_SRC_MULT0 NUMERIC "3"
// Retrieval info: PRIVATE: B_CLK_SRC_MULT0 NUMERIC "0"
// Retrieval info: PRIVATE: C_ACLR_SRC_MULT0 NUMERIC "3"
// Retrieval info: PRIVATE: C_CLK_SRC_MULT0 NUMERIC "0"
// Retrieval info: PRIVATE: ENABLE_PRELOAD_CONSTANT NUMERIC "0"
// Retrieval info: PRIVATE: HAS_MAC STRING "0"
// Retrieval info: PRIVATE: HAS_SAT_ROUND STRING "0"
// Retrieval info: PRIVATE: IMPL_STYLE_DEDICATED NUMERIC "0"
// Retrieval info: PRIVATE: IMPL_STYLE_DEFAULT NUMERIC "1"
// Retrieval info: PRIVATE: IMPL_STYLE_LCELL NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix V"
// Retrieval info: PRIVATE: MULT_COEFSEL STRING "0"
// Retrieval info: PRIVATE: MULT_REGA0 NUMERIC "1"
// Retrieval info: PRIVATE: MULT_REGB0 NUMERIC "1"
// Retrieval info: PRIVATE: MULT_REGC NUMERIC "0"
// Retrieval info: PRIVATE: MULT_REGOUT0 NUMERIC "0"
// Retrieval info: PRIVATE: MULT_REG_ACCUM_SLOAD NUMERIC "0"
// Retrieval info: PRIVATE: MULT_REG_SYSTOLIC_DELAY NUMERIC "0"
// Retrieval info: PRIVATE: NUM_MULT STRING "1"
// Retrieval info: PRIVATE: OP1 STRING "Add"
// Retrieval info: PRIVATE: OP3 STRING "Add"
// Retrieval info: PRIVATE: OUTPUT_EXTRA_LAT NUMERIC "0"
// Retrieval info: PRIVATE: OUTPUT_REG_ACLR_SRC NUMERIC "2"
// Retrieval info: PRIVATE: OUTPUT_REG_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: Q_ACLR_SRC_MULT0 NUMERIC "3"
// Retrieval info: PRIVATE: Q_CLK_SRC_MULT0 NUMERIC "0"
// Retrieval info: PRIVATE: REG_OUT NUMERIC "1"
// Retrieval info: PRIVATE: RNFORMAT STRING "54"
// Retrieval info: PRIVATE: RQFORMAT STRING "Q1.15"
// Retrieval info: PRIVATE: RTS_WIDTH STRING "54"
// Retrieval info: PRIVATE: SAME_CONFIG NUMERIC "1"
// Retrieval info: PRIVATE: SAME_CONTROL_SRC_A0 NUMERIC "1"
// Retrieval info: PRIVATE: SAME_CONTROL_SRC_B0 NUMERIC "1"
// Retrieval info: PRIVATE: SCANOUTA NUMERIC "0"
// Retrieval info: PRIVATE: SCANOUTB NUMERIC "0"
// Retrieval info: PRIVATE: SHIFTOUTA_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SHIFTOUTA_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SHIFTOUTA_REG STRING "0"
// Retrieval info: PRIVATE: SIGNA STRING "UNSIGNED"
// Retrieval info: PRIVATE: SIGNA_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SIGNA_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SIGNA_PIPE_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SIGNA_PIPE_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SIGNA_PIPE_REG STRING "0"
// Retrieval info: PRIVATE: SIGNA_REG STRING "1"
// Retrieval info: PRIVATE: SIGNB STRING "UNSIGNED"
// Retrieval info: PRIVATE: SIGNB_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SIGNB_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SIGNB_PIPE_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SIGNB_PIPE_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SIGNB_PIPE_REG STRING "0"
// Retrieval info: PRIVATE: SIGNB_REG STRING "1"
// Retrieval info: PRIVATE: SRCA0 STRING "Multiplier input"
// Retrieval info: PRIVATE: SRCB0 STRING "Multiplier input"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: SYSTOLIC_ACLR_SRC_MULT0 NUMERIC "3"
// Retrieval info: PRIVATE: SYSTOLIC_CLK_SRC_MULT0 NUMERIC "0"
// Retrieval info: PRIVATE: WIDTHA STRING "27"
// Retrieval info: PRIVATE: WIDTHB STRING "27"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: ACCUM_SLOAD_REGISTER STRING "UNREGISTERED"
// Retrieval info: CONSTANT: ADDNSUB_MULTIPLIER_ACLR1 STRING "UNUSED"
// Retrieval info: CONSTANT: ADDNSUB_MULTIPLIER_PIPELINE_REGISTER1 STRING "UNREGISTERED"
// Retrieval info: CONSTANT: ADDNSUB_MULTIPLIER_REGISTER1 STRING "CLOCK0"
// Retrieval info: CONSTANT: COEF0_0 NUMERIC "0"
// Retrieval info: CONSTANT: COEF0_1 NUMERIC "0"
// Retrieval info: CONSTANT: COEF0_2 NUMERIC "0"
// Retrieval info: CONSTANT: COEF0_3 NUMERIC "0"
// Retrieval info: CONSTANT: COEF0_4 NUMERIC "0"
// Retrieval info: CONSTANT: COEF0_5 NUMERIC "0"
// Retrieval info: CONSTANT: COEF0_6 NUMERIC "0"
// Retrieval info: CONSTANT: COEF0_7 NUMERIC "0"
// Retrieval info: CONSTANT: COEF1_0 NUMERIC "0"
// Retrieval info: CONSTANT: COEF1_1 NUMERIC "0"
// Retrieval info: CONSTANT: COEF1_2 NUMERIC "0"
// Retrieval info: CONSTANT: COEF1_3 NUMERIC "0"
// Retrieval info: CONSTANT: COEF1_4 NUMERIC "0"
// Retrieval info: CONSTANT: COEF1_5 NUMERIC "0"
// Retrieval info: CONSTANT: COEF1_6 NUMERIC "0"
// Retrieval info: CONSTANT: COEF1_7 NUMERIC "0"
// Retrieval info: CONSTANT: COEF2_0 NUMERIC "0"
// Retrieval info: CONSTANT: COEF2_1 NUMERIC "0"
// Retrieval info: CONSTANT: COEF2_2 NUMERIC "0"
// Retrieval info: CONSTANT: COEF2_3 NUMERIC "0"
// Retrieval info: CONSTANT: COEF2_4 NUMERIC "0"
// Retrieval info: CONSTANT: COEF2_5 NUMERIC "0"
// Retrieval info: CONSTANT: COEF2_6 NUMERIC "0"
// Retrieval info: CONSTANT: COEF2_7 NUMERIC "0"
// Retrieval info: CONSTANT: COEF3_0 NUMERIC "0"
// Retrieval info: CONSTANT: COEF3_1 NUMERIC "0"
// Retrieval info: CONSTANT: COEF3_2 NUMERIC "0"
// Retrieval info: CONSTANT: COEF3_3 NUMERIC "0"
// Retrieval info: CONSTANT: COEF3_4 NUMERIC "0"
// Retrieval info: CONSTANT: COEF3_5 NUMERIC "0"
// Retrieval info: CONSTANT: COEF3_6 NUMERIC "0"
// Retrieval info: CONSTANT: COEF3_7 NUMERIC "0"
// Retrieval info: CONSTANT: COEFSEL0_REGISTER STRING "UNREGISTERED"
// Retrieval info: CONSTANT: DEDICATED_MULTIPLIER_CIRCUITRY STRING "AUTO"
// Retrieval info: CONSTANT: INPUT_ACLR_A0 STRING "UNUSED"
// Retrieval info: CONSTANT: INPUT_ACLR_B0 STRING "UNUSED"
// Retrieval info: CONSTANT: INPUT_REGISTER_A0 STRING "CLOCK0"
// Retrieval info: CONSTANT: INPUT_REGISTER_B0 STRING "CLOCK0"
// Retrieval info: CONSTANT: INPUT_REGISTER_C0 STRING "UNREGISTERED"
// Retrieval info: CONSTANT: INPUT_SOURCE_A0 STRING "DATAA"
// Retrieval info: CONSTANT: INPUT_SOURCE_B0 STRING "DATAB"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix V"
// Retrieval info: CONSTANT: LOADCONST_VALUE NUMERIC "64"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altmult_add"
// Retrieval info: CONSTANT: MULTIPLIER1_DIRECTION STRING "ADD"
// Retrieval info: CONSTANT: MULTIPLIER_ACLR0 STRING "UNUSED"
// Retrieval info: CONSTANT: MULTIPLIER_REGISTER0 STRING "UNREGISTERED"
// Retrieval info: CONSTANT: NUMBER_OF_MULTIPLIERS NUMERIC "1"
// Retrieval info: CONSTANT: OUTPUT_ACLR STRING "UNUSED"
// Retrieval info: CONSTANT: OUTPUT_REGISTER STRING "CLOCK0"
// Retrieval info: CONSTANT: PORT_ADDNSUB1 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SIGNA STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SIGNB STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PREADDER_DIRECTION_0 STRING "ADD"
// Retrieval info: CONSTANT: PREADDER_DIRECTION_1 STRING "ADD"
// Retrieval info: CONSTANT: PREADDER_DIRECTION_2 STRING "ADD"
// Retrieval info: CONSTANT: PREADDER_DIRECTION_3 STRING "ADD"
// Retrieval info: CONSTANT: PREADDER_MODE STRING "SIMPLE"
// Retrieval info: CONSTANT: REPRESENTATION_A STRING "UNSIGNED"
// Retrieval info: CONSTANT: REPRESENTATION_B STRING "UNSIGNED"
// Retrieval info: CONSTANT: SIGNED_ACLR_A STRING "UNUSED"
// Retrieval info: CONSTANT: SIGNED_ACLR_B STRING "UNUSED"
// Retrieval info: CONSTANT: SIGNED_PIPELINE_REGISTER_A STRING "UNREGISTERED"
// Retrieval info: CONSTANT: SIGNED_PIPELINE_REGISTER_B STRING "UNREGISTERED"
// Retrieval info: CONSTANT: SIGNED_REGISTER_A STRING "CLOCK0"
// Retrieval info: CONSTANT: SIGNED_REGISTER_B STRING "CLOCK0"
// Retrieval info: CONSTANT: SYSTOLIC_DELAY1 STRING "UNREGISTERED"
// Retrieval info: CONSTANT: SYSTOLIC_DELAY3 STRING "UNREGISTERED"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "27"
// Retrieval info: CONSTANT: WIDTH_B NUMERIC "27"
// Retrieval info: CONSTANT: WIDTH_RESULT NUMERIC "54"
// Retrieval info: USED_PORT: clock0 0 0 0 0 INPUT VCC "clock0"
// Retrieval info: USED_PORT: dataa_0 0 0 27 0 INPUT GND "dataa_0[26..0]"
// Retrieval info: USED_PORT: datab_0 0 0 27 0 INPUT GND "datab_0[26..0]"
// Retrieval info: USED_PORT: result 0 0 54 0 OUTPUT GND "result[53..0]"
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock0 0 0 0 0
// Retrieval info: CONNECT: @dataa 0 0 27 0 dataa_0 0 0 27 0
// Retrieval info: CONNECT: @datab 0 0 27 0 datab_0 0 0 27 0
// Retrieval info: CONNECT: result 0 0 54 0 @result 0 0 54 0
// Retrieval info: GEN_FILE: TYPE_NORMAL sv_mult27.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL sv_mult27.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sv_mult27.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sv_mult27.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sv_mult27_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sv_mult27_bb.v TRUE
// Retrieval info: LIB_FILE: altera_lnsim
