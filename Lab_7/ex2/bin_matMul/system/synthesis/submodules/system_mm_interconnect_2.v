// system_mm_interconnect_2.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 14.1 186 at 2023.12.14.11:25:53

`timescale 1 ps / 1 ps
module system_mm_interconnect_2 (
		input  wire        acl_iface_kernel_clk_clk,                                          //                                        acl_iface_kernel_clk.clk
		input  wire        acl_iface_global_reset_reset_bridge_in_reset_reset,                //                acl_iface_global_reset_reset_bridge_in_reset.reset
		input  wire        acl_iface_kernel_cra_translator_reset_reset_bridge_in_reset_reset, // acl_iface_kernel_cra_translator_reset_reset_bridge_in_reset.reset
		input  wire        cra_root_reset_reset_bridge_in_reset_reset,                        //                        cra_root_reset_reset_bridge_in_reset.reset
		input  wire [29:0] acl_iface_kernel_cra_address,                                      //                                        acl_iface_kernel_cra.address
		output wire        acl_iface_kernel_cra_waitrequest,                                  //                                                            .waitrequest
		input  wire [0:0]  acl_iface_kernel_cra_burstcount,                                   //                                                            .burstcount
		input  wire [7:0]  acl_iface_kernel_cra_byteenable,                                   //                                                            .byteenable
		input  wire        acl_iface_kernel_cra_read,                                         //                                                            .read
		output wire [63:0] acl_iface_kernel_cra_readdata,                                     //                                                            .readdata
		output wire        acl_iface_kernel_cra_readdatavalid,                                //                                                            .readdatavalid
		input  wire        acl_iface_kernel_cra_write,                                        //                                                            .write
		input  wire [63:0] acl_iface_kernel_cra_writedata,                                    //                                                            .writedata
		input  wire        acl_iface_kernel_cra_debugaccess,                                  //                                                            .debugaccess
		output wire [3:0]  cra_root_cra_slave_address,                                        //                                          cra_root_cra_slave.address
		output wire        cra_root_cra_slave_write,                                          //                                                            .write
		output wire        cra_root_cra_slave_read,                                           //                                                            .read
		input  wire [63:0] cra_root_cra_slave_readdata,                                       //                                                            .readdata
		output wire [63:0] cra_root_cra_slave_writedata,                                      //                                                            .writedata
		output wire [7:0]  cra_root_cra_slave_byteenable,                                     //                                                            .byteenable
		input  wire        cra_root_cra_slave_readdatavalid,                                  //                                                            .readdatavalid
		input  wire        cra_root_cra_slave_waitrequest                                     //                                                            .waitrequest
	);

	wire         acl_iface_kernel_cra_translator_avalon_universal_master_0_waitrequest;   // cra_root_cra_slave_translator:uav_waitrequest -> acl_iface_kernel_cra_translator:uav_waitrequest
	wire  [63:0] acl_iface_kernel_cra_translator_avalon_universal_master_0_readdata;      // cra_root_cra_slave_translator:uav_readdata -> acl_iface_kernel_cra_translator:uav_readdata
	wire         acl_iface_kernel_cra_translator_avalon_universal_master_0_debugaccess;   // acl_iface_kernel_cra_translator:uav_debugaccess -> cra_root_cra_slave_translator:uav_debugaccess
	wire  [29:0] acl_iface_kernel_cra_translator_avalon_universal_master_0_address;       // acl_iface_kernel_cra_translator:uav_address -> cra_root_cra_slave_translator:uav_address
	wire         acl_iface_kernel_cra_translator_avalon_universal_master_0_read;          // acl_iface_kernel_cra_translator:uav_read -> cra_root_cra_slave_translator:uav_read
	wire   [7:0] acl_iface_kernel_cra_translator_avalon_universal_master_0_byteenable;    // acl_iface_kernel_cra_translator:uav_byteenable -> cra_root_cra_slave_translator:uav_byteenable
	wire         acl_iface_kernel_cra_translator_avalon_universal_master_0_readdatavalid; // cra_root_cra_slave_translator:uav_readdatavalid -> acl_iface_kernel_cra_translator:uav_readdatavalid
	wire         acl_iface_kernel_cra_translator_avalon_universal_master_0_lock;          // acl_iface_kernel_cra_translator:uav_lock -> cra_root_cra_slave_translator:uav_lock
	wire         acl_iface_kernel_cra_translator_avalon_universal_master_0_write;         // acl_iface_kernel_cra_translator:uav_write -> cra_root_cra_slave_translator:uav_write
	wire  [63:0] acl_iface_kernel_cra_translator_avalon_universal_master_0_writedata;     // acl_iface_kernel_cra_translator:uav_writedata -> cra_root_cra_slave_translator:uav_writedata
	wire   [3:0] acl_iface_kernel_cra_translator_avalon_universal_master_0_burstcount;    // acl_iface_kernel_cra_translator:uav_burstcount -> cra_root_cra_slave_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (30),
		.AV_DATA_W                   (64),
		.AV_BURSTCOUNT_W             (1),
		.AV_BYTEENABLE_W             (8),
		.UAV_ADDRESS_W               (30),
		.UAV_BURSTCOUNT_W            (4),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (8),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (0),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) acl_iface_kernel_cra_translator (
		.clk                    (acl_iface_kernel_clk_clk),                                                //                       clk.clk
		.reset                  (acl_iface_kernel_cra_translator_reset_reset_bridge_in_reset_reset),       //                     reset.reset
		.uav_address            (acl_iface_kernel_cra_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (acl_iface_kernel_cra_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (acl_iface_kernel_cra_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (acl_iface_kernel_cra_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (acl_iface_kernel_cra_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (acl_iface_kernel_cra_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (acl_iface_kernel_cra_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (acl_iface_kernel_cra_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (acl_iface_kernel_cra_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (acl_iface_kernel_cra_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (acl_iface_kernel_cra_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (acl_iface_kernel_cra_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (acl_iface_kernel_cra_waitrequest),                                        //                          .waitrequest
		.av_burstcount          (acl_iface_kernel_cra_burstcount),                                         //                          .burstcount
		.av_byteenable          (acl_iface_kernel_cra_byteenable),                                         //                          .byteenable
		.av_read                (acl_iface_kernel_cra_read),                                               //                          .read
		.av_readdata            (acl_iface_kernel_cra_readdata),                                           //                          .readdata
		.av_readdatavalid       (acl_iface_kernel_cra_readdatavalid),                                      //                          .readdatavalid
		.av_write               (acl_iface_kernel_cra_write),                                              //                          .write
		.av_writedata           (acl_iface_kernel_cra_writedata),                                          //                          .writedata
		.av_debugaccess         (acl_iface_kernel_cra_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer  (1'b0),                                                                    //               (terminated)
		.av_begintransfer       (1'b0),                                                                    //               (terminated)
		.av_chipselect          (1'b0),                                                                    //               (terminated)
		.av_lock                (1'b0),                                                                    //               (terminated)
		.uav_clken              (),                                                                        //               (terminated)
		.av_clken               (1'b1),                                                                    //               (terminated)
		.uav_response           (2'b00),                                                                   //               (terminated)
		.av_response            (),                                                                        //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                                    //               (terminated)
		.av_writeresponsevalid  ()                                                                         //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (4),
		.AV_DATA_W                      (64),
		.UAV_DATA_W                     (64),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (8),
		.UAV_BYTEENABLE_W               (8),
		.UAV_ADDRESS_W                  (30),
		.UAV_BURSTCOUNT_W               (4),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (8),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) cra_root_cra_slave_translator (
		.clk                    (acl_iface_kernel_clk_clk),                                                //                      clk.clk
		.reset                  (cra_root_reset_reset_bridge_in_reset_reset),                              //                    reset.reset
		.uav_address            (acl_iface_kernel_cra_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (acl_iface_kernel_cra_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (acl_iface_kernel_cra_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (acl_iface_kernel_cra_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (acl_iface_kernel_cra_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (acl_iface_kernel_cra_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (acl_iface_kernel_cra_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (acl_iface_kernel_cra_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (acl_iface_kernel_cra_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (acl_iface_kernel_cra_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (acl_iface_kernel_cra_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (cra_root_cra_slave_address),                                              //      avalon_anti_slave_0.address
		.av_write               (cra_root_cra_slave_write),                                                //                         .write
		.av_read                (cra_root_cra_slave_read),                                                 //                         .read
		.av_readdata            (cra_root_cra_slave_readdata),                                             //                         .readdata
		.av_writedata           (cra_root_cra_slave_writedata),                                            //                         .writedata
		.av_byteenable          (cra_root_cra_slave_byteenable),                                           //                         .byteenable
		.av_readdatavalid       (cra_root_cra_slave_readdatavalid),                                        //                         .readdatavalid
		.av_waitrequest         (cra_root_cra_slave_waitrequest),                                          //                         .waitrequest
		.av_begintransfer       (),                                                                        //              (terminated)
		.av_beginbursttransfer  (),                                                                        //              (terminated)
		.av_burstcount          (),                                                                        //              (terminated)
		.av_writebyteenable     (),                                                                        //              (terminated)
		.av_lock                (),                                                                        //              (terminated)
		.av_chipselect          (),                                                                        //              (terminated)
		.av_clken               (),                                                                        //              (terminated)
		.uav_clken              (1'b0),                                                                    //              (terminated)
		.av_debugaccess         (),                                                                        //              (terminated)
		.av_outputenable        (),                                                                        //              (terminated)
		.uav_response           (),                                                                        //              (terminated)
		.av_response            (2'b00),                                                                   //              (terminated)
		.uav_writeresponsevalid (),                                                                        //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                                     //              (terminated)
	);

endmodule
