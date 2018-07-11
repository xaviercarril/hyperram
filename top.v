`default_nettype none

module top (
	input  clk,
    // dram pins
    inout [7:0] dram_dq,
    inout dram_rwds,
    output dram_ck,
    output dram_rst_l,
    output dram_cs_l,

    // leds
    output led


);

    assign led = 1;

    wire reset = 0;
    wire [7:0] data_pins_in;
    wire [7:0] data_pins_out;
    wire dram_dq_oe_l;
    
    SB_IO #(
        .PIN_TYPE(6'b 1010_01),
    ) hyperram_data_pins [7:0] (
        .PACKAGE_PIN(dram_dq),
        .OUTPUT_ENABLE(~dram_dq_oe_l),
        .D_OUT_0(data_pins_out),
        .D_IN_0(data_pins_in),
    );

    wire dram_rwds_out;
    wire dram_rwds_in;
    wire dram_rwds_oe_l;

    SB_IO #(
        .PIN_TYPE(6'b 1010_01),
    ) hyperram_rwds (
        .PACKAGE_PIN(dram_rwds),
        .OUTPUT_ENABLE(~dram_rwds_oe_l),
        .D_OUT_0(dram_rwds_out),
        .D_IN_0(dram_rwds_in),
    );

    hyper_xface hyper_xface_0(.reset(reset), .clk(clk),
    .dram_dq_in(data_pins_in), .dram_dq_out(data_pins_out), .dram_dq_oe_l(dram_dq_oe_l),
    .dram_rwds_in(dram_rwds_in), .dram_rwds_out(dram_rwds_out), .dram_rwds_oe_l(dram_rwds_oe_l),
    .dram_ck(dram_ck),
    .dram_rst_l(dram_rst_l),
    .dram_cs_l(dram_cs_l));

endmodule
    /*
(
  input  wire         reset,
  input  wire         clk,
  input  wire         rd_req,
  input  wire         wr_req,
  input  wire         mem_or_reg,
  input  wire [3:0]   wr_byte_en,
  input  wire [5:0]   rd_num_dwords,
  input  wire [31:0]  addr,
  input  wire [31:0]  wr_d,
  output reg  [31:0]  rd_d,
  output reg          rd_rdy,
  output reg          busy,
  output reg          burst_wr_rdy,
  input  wire [7:0]   latency_1x,
  input  wire [7:0]   latency_2x,

  input  wire [7:0]   dram_dq_in,
  output reg  [7:0]   dram_dq_out,
  output reg          dram_dq_oe_l,

  input  wire         dram_rwds_in,
  output reg          dram_rwds_out,
  output reg          dram_rwds_oe_l,

  output reg          dram_ck,
  output wire         dram_rst_l,
  output wire         dram_cs_l,
  output wire [7:0]   sump_dbg
  */
