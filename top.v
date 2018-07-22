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

    reg rd_req = 0;
    reg wr_req = 0;

    reg [7:0] latency_1x = 8'h12;
    reg [7:0] latency_2x = 8'h16;

    reg [31:0] addr = 0;
    reg [31:0] wr_d = 0;
    wire [31:0] rd_d;
    wire busy;
    reg [3:0] wr_byte_en = 4'hF;
    reg [5:0] rd_num_dwords = 6'h1;
    
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

    //part requires 150us on startup = 1800 cycles at 12Mhz. use an 11 bit reg to count
    reg [10:0] start_delay_reg = 0;

    reg start_delay = 0;
    always @(posedge clk) begin
        start_delay_reg <= start_delay_reg + 1;
        if(start_delay_reg == 2000)
            start_delay <= 1;
    end

    always @(posedge clk) begin
        if(start_delay) begin
            if(busy == 0 && wr_req == 0) begin
                addr <= addr + 1;
                wr_d <= wr_d + 1;
                wr_req <= 1;
            end else
                wr_req <= 0;
        end
    end

    hyper_xface hyper_xface_0(.reset(reset), .clk(clk),
    // module control
    .rd_req(rd_req),
    .wr_req(wr_req),
    .wr_d(wr_d),
    .rd_d(rd_d),
    .wr_byte_en(wr_byte_en),
    .rd_num_dwords(rd_num_dwords),
    .addr(addr),
    .busy(busy),


    .latency_1x(latency_1x),
    .latency_2x(latency_2x),
    .mem_or_reg(0),


    // pins
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
