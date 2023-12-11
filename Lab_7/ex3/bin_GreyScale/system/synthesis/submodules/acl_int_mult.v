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
    



// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module acl_int_mult (
	enable,
	clock,
	dataa,
	datab,
	result);

  parameter INPUT1_WIDTH = 64;
  parameter INPUT2_WIDTH = 64;
  parameter OUTPUT_WIDTH = 64;
  parameter SIGNED = 0;
  parameter LATENCY = 3;
 
  // Determine the complete size of the output.
  localparam O_WIDTH = (OUTPUT_WIDTH > (INPUT1_WIDTH + INPUT2_WIDTH)) ? OUTPUT_WIDTH : (INPUT1_WIDTH + INPUT2_WIDTH);
  localparam REP_STRING = (SIGNED == 0) ? "UNSIGNED" : "SIGNED";
    
  input	  [INPUT1_WIDTH - 1 : 0]  dataa;
  input	  [INPUT2_WIDTH - 1 : 0]  datab;
  input	  enable;
  input	  clock;
  output	[OUTPUT_WIDTH - 1 : 0]  result;

  generate
  if ((INPUT1_WIDTH>=19) && (INPUT1_WIDTH<=27) && (INPUT2_WIDTH>=19) && (INPUT2_WIDTH<=27))
  begin
    (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg	[INPUT1_WIDTH - 1 : 0]  reg_dataa;
    (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg	[INPUT2_WIDTH - 1 : 0]  reg_datab;
  
    // Use a special WYSIWYG for the 27x27 multiplier mode
    always@(posedge clock)
    begin
      if (enable)
      begin
        reg_dataa <= dataa;
        reg_datab <= datab;
      end
    end

    wire [53:0] output_wire;
    wire [26:0] inp_a;
    wire [26:0] inp_b;

    assign inp_a = reg_dataa;
    assign inp_b = reg_datab;

    sv_mult27 the_multiplier(clock,enable,inp_a,inp_b, output_wire);
      defparam the_multiplier.REPRESENTATION = REP_STRING;

    if (SIGNED == 0)
    begin
       if (OUTPUT_WIDTH > 54)
         assign result = {{{OUTPUT_WIDTH-54}{1'b0}}, output_wire};
       else
         assign result = output_wire[OUTPUT_WIDTH-1:0];
    end
    else
    begin
       if (OUTPUT_WIDTH > 54)
         assign result = {{{OUTPUT_WIDTH-54}{output_wire[53]}}, output_wire};
       else
         assign result = output_wire[OUTPUT_WIDTH-1:0];
    end
  end
  else if (((SIGNED == 0) && (OUTPUT_WIDTH >= 33) && (OUTPUT_WIDTH <= 64)) && ((INPUT1_WIDTH == 64) && (INPUT2_WIDTH >= 32) || (INPUT2_WIDTH == 64) && (INPUT1_WIDTH >= 32)))
  begin : GEN_LONG_MUL //Karatsuba algorithm
  	 localparam TMP1_WIDTH = (INPUT1_WIDTH > 32)? INPUT1_WIDTH : 33;
	 localparam TMP2_WIDTH = (INPUT2_WIDTH > 32)? INPUT2_WIDTH : 33;  
    reg [63:0] temp0;
    reg [TMP1_WIDTH-1:0] R_a;
    reg [TMP2_WIDTH-1:0] R_b;
    reg [31:0] temp1, temp2;
    reg [63:0] output_wire;
    always@(posedge clock)
    begin
      if(enable)
      begin
        R_a <= dataa;
        R_b <= datab;
        temp0 <= R_a[31:0] * R_b[31:0];
        temp1 <= R_a[31:0] * R_b[TMP2_WIDTH-1:32];
        temp2 <= R_a[TMP1_WIDTH-1:32] * R_b[31:0];
        output_wire[63:32] <= temp0[63:32] + temp1 + temp2;
        output_wire[31:0] <= temp0[31:0];
      end
    end
    
    assign result = output_wire[OUTPUT_WIDTH-1:0];  
  end
  else if (OUTPUT_WIDTH > 64)
  begin
    wire [O_WIDTH-1:0] output_wire;

    lpm_mult  lpm_mult_component (
      .clock (clock),
      .dataa (dataa),
      .datab (datab),
      .clken (enable),
      .result (output_wire),
      .aclr (1'b0),
      .sum (1'b0));
    defparam
      lpm_mult_component.lpm_hint = "MAXIMIZE_SPEED=9",
      lpm_mult_component.lpm_pipeline = LATENCY,
      lpm_mult_component.lpm_representation = REP_STRING,
      lpm_mult_component.lpm_type = "LPM_MULT",
      lpm_mult_component.lpm_widtha = INPUT1_WIDTH,
      lpm_mult_component.lpm_widthb = INPUT2_WIDTH,
      lpm_mult_component.lpm_widthp = O_WIDTH;  

    if (SIGNED == 0)
    begin
       if (OUTPUT_WIDTH > O_WIDTH)
         assign result = {{{OUTPUT_WIDTH-O_WIDTH}{1'b0}}, output_wire};
       else
         assign result = output_wire[OUTPUT_WIDTH-1:0];
    end
    else
    begin
       if (OUTPUT_WIDTH > O_WIDTH)
         assign result = {{{OUTPUT_WIDTH-O_WIDTH}{output_wire[O_WIDTH-1]}}, output_wire};
       else
         assign result = output_wire[OUTPUT_WIDTH-1:0];
    end 
  end
  else
  begin
    // Default LPM_MULT inference
    if (SIGNED == 0)
    begin
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [O_WIDTH-1:0] output_reg;
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [INPUT1_WIDTH - 1 : 0]  reg_dataa;
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [INPUT2_WIDTH - 1 : 0]  reg_datab;
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [INPUT1_WIDTH - 1 : 0]  reg_dataa2;
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [INPUT2_WIDTH - 1 : 0]  reg_datab2;
    
      always@(posedge clock)
      begin
        if (enable)
        begin
          output_reg <= reg_dataa2 * reg_datab2; 
          reg_dataa <= dataa;
          reg_datab <= datab;
          reg_dataa2 <= reg_dataa;
          reg_datab2 <= reg_datab;
        end
      end 

      assign result = output_reg[OUTPUT_WIDTH-1:0];         
    end
    else
    begin
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg signed [O_WIDTH-1:0] output_reg;
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg signed [INPUT1_WIDTH - 1 : 0]  reg_dataa;
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg signed [INPUT2_WIDTH - 1 : 0]  reg_datab;
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg signed [INPUT1_WIDTH - 1 : 0]  reg_dataa2;
      (* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg signed [INPUT2_WIDTH - 1 : 0]  reg_datab2;
    
      always@(posedge clock)
      begin
        if (enable)
        begin
          output_reg <= reg_dataa2 * reg_datab2; 
          reg_dataa <= dataa;
          reg_datab <= datab;
          reg_dataa2 <= reg_dataa;
          reg_datab2 <= reg_datab;
        end
      end
      
      assign result = output_reg[OUTPUT_WIDTH-1:0];  
    end    
  end
  endgenerate   
  
endmodule
