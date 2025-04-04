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
    


//===----------------------------------------------------------------------===//
//
// Parameterized FIFO with input and output registers and ACL pipeline
// protocol ports. Device implementation can be selected via parameters.
//
// DATA_WIDTH = 0:
//  Data width can be zero, in which case the the FIFO stores no data.
//
// Supported implementations (DATA_WIDTH > 0):
//  ram: RAM-based FIFO (min. latency 3)
//  ll_reg: low-latency register-based FIFO (min. latency 1)
//  ll_ram: low-latency RAM (min. latency 1; combination of ll_reg + ram)
//  zl_reg: zero-latency ll_reg (adds bypass path)
//  zl_ram: zero-latency ll_ram (adds bypass path)
//
// Supported implementations (DATA_WIDTH == 0);
//  For DATA_WIDTH == 0, the latency is either 1 ("low") or 0.
//  All implementations mentioned above are supported, with their implications
//  for either using the "ll_counter" or the "zl_counter"
//  (i.e. ram/ll_reg/ll_ram -> ll_counter, zl_reg/zl_ram -> zl_counter).
//
// STRICT_DEPTH:
//  A value of 0 means the FIFO that is instantiated will have a depth
//  of at least DEPTH. A value of 1 means the FIFO will have a depth exactly
//  equal to DEPTH.
//
//===----------------------------------------------------------------------===//

// altera message_off 10034

module acl_data_fifo 
#(
    parameter integer DATA_WIDTH = 32,          // >=0
    parameter integer DEPTH = 32,               // >0
    parameter integer STRICT_DEPTH = 0,         // 0|1 (1 == FIFO depth will be EXACTLY equal to DEPTH, otherwise >= DEPTH)
    parameter integer ALLOW_FULL_WRITE = 0,     // 0|1 (only supported by pure reg fifos: ll_reg, zl_reg, ll_counter, zl_counter)

    parameter string IMPL = "ram",              // see above (ram|ll_reg|ll_ram|zl_reg|zl_ram|ll_counter|zl_counter)
    parameter integer ALMOST_FULL_VALUE = 0     // >= 0
)
(
    input logic clock,
    input logic resetn,
    input logic [DATA_WIDTH-1:0] data_in,       // not used if DATA_WIDTH=0
    output logic [DATA_WIDTH-1:0] data_out,     // not used if DATA_WIDTH=0
    input logic valid_in,
    output logic valid_out,
    input logic stall_in,
    output logic stall_out,

    // internal signals (not required to use)
    output logic empty,
    output logic full,
    output logic almost_full
);
    generate
        if( DATA_WIDTH > 0 )
        begin
            if( IMPL == "ram" )
            begin
                // Normal RAM FIFO.
                // Note that ALLOW_FULL_WRITE == 1 is not supported.
                acl_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(DEPTH),
                    .ALMOST_FULL_VALUE(ALMOST_FULL_VALUE)
                )
                fifo (
                    .clock(clock),
                    .resetn(resetn),
                    .data_in(data_in),
                    .data_out(data_out),
                    .valid_in(valid_in),
                    .valid_out(valid_out),
                    .stall_in(stall_in),
                    .stall_out(stall_out),
                    .empty(empty),
                    .full(full),
                    .almost_full(almost_full)
                );
            end
            else if( (IMPL == "ll_reg" || IMPL == "shift_reg") && DEPTH >= 2 && !ALLOW_FULL_WRITE )
            begin
                // For ll_reg's create an ll_fifo of DEPTH-1 with ALLOW_FULL_WRITE=1 followed by a staging register
                wire r_valid;
                wire [DATA_WIDTH-1:0] r_data;
                wire staging_reg_stall;

                acl_data_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(DEPTH-1),
                    .ALLOW_FULL_WRITE(1),
                    .IMPL(IMPL),
                    .ALMOST_FULL_VALUE(ALMOST_FULL_VALUE)
                )
                fifo (
                    .clock(clock),
                    .resetn(resetn),
                    .data_in(data_in),
                    .data_out(r_data),
                    .valid_in(valid_in),
                    .valid_out(r_valid),
                    .empty(empty),
                    .stall_in(staging_reg_stall),
                    .stall_out(stall_out),
                    .almost_full(almost_full)
                );
                acl_staging_reg #(
                   .WIDTH(DATA_WIDTH)
                ) staging_reg (
                   .clk(clock), 
                   .reset(~resetn), 
                   .i_data(r_data), 
                   .i_valid(r_valid), 
                   .o_stall(staging_reg_stall), 
                   .o_data(data_out), 
                   .o_valid(valid_out), 
                   .i_stall(stall_in)
                );
            end
            else if( IMPL == "shift_reg" && DEPTH <= 1)
            begin
                // Shift register implementation of a FIFO
                // Case:149478 Removed individual no-shift-reg
                // assignments.

                reg [DEPTH-1:0] r_valid_NO_SHIFT_REG;
                logic [DEPTH-1:0] r_valid_in;
                reg [DEPTH-1:0][DATA_WIDTH-1:0] r_data_NO_SHIFT_REG;
                logic [DEPTH-1:0][DATA_WIDTH-1:0] r_data_in;
                wire [DEPTH-1:0] r_o_stall;
                logic [DEPTH-1:0] r_i_stall;
                reg [DEPTH:0] filled_NO_SHIFT_REG;

                integer i;

                assign r_o_stall = r_valid_NO_SHIFT_REG & r_i_stall; 
                assign empty = !r_valid_NO_SHIFT_REG[0];

                always @(*)
                begin
                    r_i_stall[0] = stall_in;
                    r_data_in[DEPTH-1] = data_in;
                    r_valid_in[DEPTH-1] = valid_in;

                    for (i=1; i<=DEPTH-1; i++)
                        r_i_stall[i] = r_o_stall[i-1];

                    for (i=0; i<DEPTH-1; i++) 
                    begin
                        r_data_in[i] = r_data_NO_SHIFT_REG[i+1];
                        r_valid_in[i] = r_valid_NO_SHIFT_REG[i+1];
                    end
                end

                always @(posedge clock or negedge resetn)
                begin
                    if (!resetn)
                    begin
                        r_valid_NO_SHIFT_REG <= {(DEPTH){1'b0}};
                        r_data_NO_SHIFT_REG  <= 'x;
                        filled_NO_SHIFT_REG  <= {{(DEPTH){1'b0}},1'b1};
                    end
                    else
                    begin
                        if (valid_in & ~stall_out & ~(valid_out & ~stall_in))
                        begin
                            filled_NO_SHIFT_REG <= {filled_NO_SHIFT_REG[DEPTH-1:0],1'b0}; // Added an element
                        end
                        else if (~(valid_in & ~stall_out) & valid_out & ~stall_in)
                        begin
                            filled_NO_SHIFT_REG <= {1'b0,filled_NO_SHIFT_REG[DEPTH:1]};   // Subtracted an element
                        end

                        for (i=0; i<=DEPTH-1; i++)
                        begin
                            if (!r_o_stall[i])
                            begin
                                r_valid_NO_SHIFT_REG[i] <= r_valid_in[i];
                                r_data_NO_SHIFT_REG[i] <= r_data_in[i];
                            end
                        end
                    end
                end    
                assign stall_out = filled_NO_SHIFT_REG[DEPTH] & stall_in; 
                assign valid_out = r_valid_NO_SHIFT_REG[0];
                assign data_out = r_data_NO_SHIFT_REG[0];
            end
            else if( IMPL == "shift_reg" )
            begin
                // Shift register implementation of a FIFO

                reg [DEPTH-1:0] r_valid;
                logic [DEPTH-1:0] r_valid_in;
                reg [DEPTH-1:0][DATA_WIDTH-1:0] r_data;
                logic [DEPTH-1:0][DATA_WIDTH-1:0] r_data_in;
                wire [DEPTH-1:0] r_o_stall;
                logic [DEPTH-1:0] r_i_stall;
                reg [DEPTH:0] filled;

                integer i;

                assign r_o_stall = r_valid & r_i_stall; 
                assign empty = !r_valid[0];

                always @(*)
                begin
                    r_i_stall[0] = stall_in;
                    r_data_in[DEPTH-1] = data_in;
                    r_valid_in[DEPTH-1] = valid_in;

                    for (i=1; i<=DEPTH-1; i++)
                        r_i_stall[i] = r_o_stall[i-1];

                    for (i=0; i<DEPTH-1; i++) 
                    begin
                        r_data_in[i] = r_data[i+1];
                        r_valid_in[i] = r_valid[i+1];
                    end
                end

                always @(posedge clock or negedge resetn)
                begin
                    if (!resetn)
                    begin
                        r_valid <= {(DEPTH){1'b0}};
                        r_data  <= 'x;
                        filled  <= {{(DEPTH){1'b0}},1'b1};
                    end
                    else
                    begin
                        if (valid_in & ~stall_out & ~(valid_out & ~stall_in))
                        begin
                            filled <= {filled[DEPTH-1:0],1'b0}; // Added an element
                        end
                        else if (~(valid_in & ~stall_out) & valid_out & ~stall_in)
                        begin
                            filled <= {1'b0,filled[DEPTH:1]};   // Subtracted an element
                        end

                        for (i=0; i<=DEPTH-1; i++)
                        begin
                            if (!r_o_stall[i])
                            begin
                                r_valid[i] <= r_valid_in[i];
                                r_data[i] <= r_data_in[i];
                            end
                        end
                    end
                end    
                assign stall_out = filled[DEPTH] & stall_in; 
                assign valid_out = r_valid[0];
                assign data_out = r_data[0];
            end
            else if( IMPL == "ll_reg" )
            begin
                // LL REG FIFO. Supports ALLOW_FULL_WRITE == 1.
                logic write, read;

                assign write = valid_in & ~stall_out;
                assign read = ~stall_in & ~empty;

                acl_ll_fifo #(
                    .WIDTH(DATA_WIDTH),
                    .DEPTH(DEPTH),
                    .ALMOST_FULL_VALUE(ALMOST_FULL_VALUE)
                )
                fifo (
                    .clk(clock),
                    .reset(~resetn),
                    .data_in(data_in),
                    .write(write),
                    .data_out(data_out),
                    .read(read),
                    .empty(empty),
                    .full(full),
                    .almost_full(almost_full)
                );

                assign valid_out = ~empty;
                assign stall_out = ALLOW_FULL_WRITE ? (full & stall_in) : full;
            end
            else if( IMPL == "ll_ram" )
            begin
                // LL RAM FIFO.
                acl_ll_ram_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(DEPTH)
                )
                fifo (
                    .clock(clock),
                    .resetn(resetn),
                    .data_in(data_in),
                    .data_out(data_out),
                    .valid_in(valid_in),
                    .valid_out(valid_out),
                    .stall_in(stall_in),
                    .stall_out(stall_out),
                    .empty(empty),
                    .full(full)
                );
            end
            else if( IMPL == "passthrough" )
            begin
                // Useful for turning off a FIFO and making it into a wire
                assign valid_out = valid_in; 
                assign stall_out = stall_in;
                assign data_out = data_in;
            end
            else if( IMPL == "ram_plus_reg" )
            begin
                wire [DATA_WIDTH-1:0] rdata2;
                wire v2;
                wire s2;

                acl_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(DEPTH)
                )
                fifo_inner (
                    .clock(clock),
                    .resetn(resetn),
                    .data_in(data_in),
                    .data_out(rdata2),
                    .valid_in(valid_in),
                    .valid_out(v2),
                    .stall_in(s2),
                    .empty(empty),
                    .stall_out(stall_out)
                );
                acl_data_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(2),
                    .IMPL("ll_reg")
                )
                fifo_outer (
                    .clock(clock),
                    .resetn(resetn),
                    .data_in(rdata2),
                    .data_out(data_out),
                    .valid_in(v2),
                    .valid_out(valid_out),
                    .stall_in(stall_in),
                    .stall_out(s2)
                );
            end
            else if( IMPL == "sandwich" )
            begin
                wire [DATA_WIDTH-1:0] rdata1;
                wire [DATA_WIDTH-1:0] rdata2;
                wire v1, v2;
                wire s1, s2;
                acl_data_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(2),
                    .IMPL("ll_reg")
                )
                fifo_outer1 (
                    .clock(clock),
                    .resetn(resetn),
                    .data_in(data_in),
                    .data_out(rdata1),
                    .valid_in(valid_in),
                    .valid_out(v1),
                    .stall_in(s1),
                    .stall_out(stall_out)
                );
                acl_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(DEPTH),
                    .ALMOST_FULL_VALUE(ALMOST_FULL_VALUE)
                )
                fifo_inner (
                    .clock(clock),
                    .resetn(resetn),
                    .data_in(rdata1),
                    .data_out(rdata2),
                    .valid_in(v1),
                    .valid_out(v2),
                    .stall_in(s2),
                    .stall_out(s1),
                    .empty(empty),
                    .almost_full(almost_full)
                );
                acl_data_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(2),
                    .IMPL("ll_reg")
                )
                fifo_outer2 (
                    .clock(clock),
                    .resetn(resetn),
                    .data_in(rdata2),
                    .data_out(data_out),
                    .valid_in(v2),
                    .valid_out(valid_out),
                    .stall_in(stall_in),
                    .stall_out(s2)
                );
            end
            else if( IMPL == "zl_reg" || IMPL == "zl_ram" )
            begin
                // ZL RAM/REG FIFO.
                logic [DATA_WIDTH-1:0] fifo_data_in, fifo_data_out;
                logic fifo_valid_in, fifo_valid_out;
                logic fifo_stall_in, fifo_stall_out;

                acl_data_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(DEPTH),
                    .ALLOW_FULL_WRITE(ALLOW_FULL_WRITE),
                    .IMPL(IMPL == "zl_reg" ? "ll_reg" : "ll_ram"),
                    .ALMOST_FULL_VALUE(ALMOST_FULL_VALUE)
                )
                fifo (
                    .clock(clock),
                    .resetn(resetn),
                    .data_in(fifo_data_in),
                    .data_out(fifo_data_out),
                    .valid_in(fifo_valid_in),
                    .valid_out(fifo_valid_out),
                    .stall_in(fifo_stall_in),
                    .stall_out(fifo_stall_out),
                    .empty(empty),
                    .full(full),
                    .almost_full(almost_full)
                );

		wire staging_reg_stall;

                assign fifo_data_in = data_in;
                assign fifo_valid_in = valid_in & (staging_reg_stall | fifo_valid_out);
                assign fifo_stall_in = staging_reg_stall;

                assign stall_out = fifo_stall_out;

                 // Staging register to break the stall path
                acl_staging_reg #(
                   .WIDTH(DATA_WIDTH)
                ) staging_reg (
                   .clk(clock), 
                   .reset(~resetn), 
                   .i_data(fifo_valid_out ? fifo_data_out : data_in), 
                   .i_valid(fifo_valid_out | valid_in), 
                   .o_stall(staging_reg_stall), 
                   .o_data(data_out), 
                   .o_valid(valid_out), 
                   .i_stall(stall_in)
                );
            end
         end
         else // DATA_WIDTH == 0
         begin
            if( IMPL == "ram" || IMPL == "ram_plus_reg" || IMPL == "ll_reg" || IMPL == "ll_ram" || IMPL == "ll_counter" )
            begin
                // LL counter fifo.
                acl_valid_fifo_counter #(
                    .DEPTH(DEPTH),
                    .STRICT_DEPTH(STRICT_DEPTH),
                    .ALLOW_FULL_WRITE(ALLOW_FULL_WRITE)
                )
                counter (
                    .clock(clock),
                    .resetn(resetn),
                    .valid_in(valid_in),
                    .valid_out(valid_out),
                    .stall_in(stall_in),
                    .stall_out(stall_out),
                    .empty(empty),
                    .full(full)
                );
             end
             else if( IMPL == "zl_reg" || IMPL == "zl_ram" || IMPL == "zl_counter" )
             begin
                // ZL counter fifo.
                logic fifo_valid_in, fifo_valid_out;
                logic fifo_stall_in, fifo_stall_out;

                acl_data_fifo #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .DEPTH(DEPTH),
                    .STRICT_DEPTH(STRICT_DEPTH),
                    .ALLOW_FULL_WRITE(ALLOW_FULL_WRITE),
                    .IMPL("ll_counter")
                )
                fifo (
                    .clock(clock),
                    .resetn(resetn),
                    .valid_in(fifo_valid_in),
                    .valid_out(fifo_valid_out),
                    .stall_in(fifo_stall_in),
                    .stall_out(fifo_stall_out),
                    .empty(empty),
                    .full(full)
                );

                assign fifo_valid_in = valid_in & (stall_in | fifo_valid_out);
                assign fifo_stall_in = stall_in;

                assign stall_out = fifo_stall_out;
                assign valid_out = fifo_valid_out | valid_in;
             end
         end
    endgenerate
endmodule

