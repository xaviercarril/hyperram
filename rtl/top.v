`default_nettype none
//`define ASIC 

`ifndef ASIC
	`include "baudgen.vh"
`endif

module top (
    input wire clk,
    //input wire rstn,
`ifndef ASIC
    // Serial
    input wire rx,
    output wire tx,
`endif
`ifdef ASIC
	input wire hrd_req,
	input wire hwr_req,
	input wire [31:0] hwr_d,
	input wire [31:0] haddr,
	input wire [7:0] hdata_pins_in,
	input wire hdram_rwds_in,
`endif
    // dram pins
    inout wire [7:0] dram_dq,
    inout wire dram_rwds,
    output wire dram_ck,
    output wire dram_rst_l,
    output wire [3:0] dram_cs_l_mask
);

//Module selection 0-3
localparam MODULE = 0;

//Use PLL to go from 25MHz to 50Mhz
	wire clk_pll;
//25MHz to 50MHz

`ifndef ASIC
SB_PLL40_CORE #(
    .FEEDBACK_PATH("SIMPLE"),
    .DIVR(4'b0000),         // DIVR =  0
    .DIVF(7'b0011111),      // DIVF = 31
    .DIVQ(3'b100),          // DIVQ =  4
    .FILTER_RANGE(3'b010)   // FILTER_RANGE = 2

    ) uut (
        //.LOCK(locked),
        .RESETB(1'b1),
        .BYPASS(1'b0),
        .REFERENCECLK(clk),
        .PLLOUTCORE(clk_pll)
    );
`endif
`ifdef ASIC
	assign clk_pll = clk;
`endif

    wire hram_clk;
    assign hram_clk = clk_pll;

    reg rstn = 0;
	integer cnt = 0;

	always @(posedge hram_clk) begin
		if (cnt == 100) rstn <= 1;
		else begin
			rstn <= 0;
			cnt <= cnt + 1;
		end
	end

    // signals for HyperRAM controller
    wire rd_rdy;
    reg rd_req;
    reg wr_req;
    reg [31:0] addr;
    reg [31:0] wr_d;
    wire [31:0] rd_d;
    wire busy;
    reg mem_or_reg;

    reg [3:0] wr_byte_en;
    reg [21:0] rd_num_dwords;

    reg [7:0] latency_1x;
	reg [7:0] latency_2x;		
   

	// latch data when it's ready
    reg [31:0] ram_data;
    always @(posedge hram_clk) begin
      if (rd_rdy) ram_data <= rd_d;
    end

    wire [7:0] data_pins_in;
    wire [7:0] data_pins_out;
    wire dram_dq_oe_l;

`ifndef ASIC    
    // setup inout lines for data pins
    SB_IO #(
        .PIN_TYPE(6'b 1010_01),
        .PULLUP(1'b 0),
        .NEG_TRIGGER(1'b 0),
        .IO_STANDARD("SB_LVCMOS")
    ) hyperram_data_pins [7:0] (
        .PACKAGE_PIN(dram_dq),
        .OUTPUT_ENABLE(~dram_dq_oe_l),
        .D_OUT_0(data_pins_out),
        .D_IN_0(data_pins_in)
    );
`else
	assign data_pins_in[7:0] = dram_dq_oe_l ? dram_dq : 8'bz;
	assign dram_dq[7:0] = ~dram_dq_oe_l ? data_pins_out : 8'bz;
`endif

    wire dram_rwds_out;
    wire dram_rwds_in;
    wire dram_rwds_oe_l;

`ifndef ASIC
    // setup inout lines for rwds pins
    SB_IO #(
        .PIN_TYPE(6'b 1010_01),
        .PULLUP(1'b 0),
        .NEG_TRIGGER(1'b 0),
        .IO_STANDARD("SB_LVCMOS")
    ) hyperram_rwds (
        .PACKAGE_PIN(dram_rwds),
        .OUTPUT_ENABLE(~dram_rwds_oe_l),
        .D_OUT_0(dram_rwds_out),
        .D_IN_0(dram_rwds_in)
    );
`else

	assign dram_rwds = ~dram_rwds_oe_l ? dram_rwds_out : 1'bz;
	assign dram_rwds_in = dram_rwds_oe_l ? dram_rwds : 1'bz;

`endif

// Select Module with CS
wire dram_cs_l;
selectCS #(
    .MODULES(4),
    .RAM_SIZE(8388608),
    .ADDR_WIDTH(32)
) selCS (
    .clk(clk_pll),
    .rstn(rstn),
    .cs_i(dram_cs_l),
    .cs_mask_o(dram_cs_l_mask),
    .addr_i(addr)
);

// instantiate
hyperram_controller hyperram_controller(
    .resetn(rstn),
    .clk(hram_clk),
	`ifdef ASIC 
    .rd_req(hrd_req),
    .wr_req(hwr_req),
    .wr_d(hwr_d),
    .addr(haddr),
	`else 
    .rd_req(rd_req),
    .wr_req(wr_req),
    .wr_d(wr_d),
    .addr(addr),
	`endif
    .rd_d(rd_d),
    .rd_rdy(rd_rdy),
    .wr_byte_en(wr_byte_en),
    .rd_num_dwords(rd_num_dwords),
    .busy(busy),


    .latency_1x(latency_1x),
    .latency_2x(latency_2x),
    .mem_or_reg(mem_or_reg),

    // pins
	`ifdef ASIC
    .dram_dq_in(hdata_pins_in), .dram_dq_out(data_pins_out), .dram_dq_oe_l(dram_dq_oe_l),
    .dram_rwds_in(hdram_rwds_in), .dram_rwds_out(dram_rwds_out), .dram_rwds_oe_l(dram_rwds_oe_l),
	`else 
    .dram_dq_in(data_pins_in), .dram_dq_out(data_pins_out), .dram_dq_oe_l(dram_dq_oe_l),
    .dram_rwds_in(dram_rwds_in), .dram_rwds_out(dram_rwds_out), .dram_rwds_oe_l(dram_rwds_oe_l),
    `endif
	.dram_ck(dram_ck),
    .dram_rst_l(dram_rst_l),
    .dram_cs_l(dram_cs_l));

`ifndef ASIC
    // serial port setup
    localparam BAUD = `B115200;

    wire rcv;
    reg tx_strb;
    wire [7:0] rx_data;
    reg [7:0] tx_data;
    wire ready;
    wire logic_ce;

    reg [39:0] rx_reg = 0;
    reg [31:0] tx_reg = 0;
    reg [2:0] rx_byte_cnt = 0;
    reg [31:0] count = 0;

    // instantiate rx and tx
    uart_rx #(.BAUD(BAUD)) RX0 (.clk(hram_clk),
           .rstn(rstn),
           .rx(rx),
           .rcv(rcv),
           .data(rx_data)
          );

    uart_tx #(.BAUD(BAUD)) TX0 ( .clk(hram_clk),
             .rstn(rstn),
             .start(tx_strb),
             .data(tx_data),
             .tx(tx),
             .ready(ready)
           );

  // state machine states
  localparam ADDR = 8'h1;
  localparam LOAD = 8'h2;
  localparam WRITE = 8'h3;
  localparam READ = 8'h4;
  localparam READ_REQ = 8'h5;
  localparam COUNT = 8'h6;
  localparam CONST = 8'h7;


  // convenience buses for cmd and data bytes
  wire [7:0] cmd_byte = rx_reg[39:32];
  wire [31:0] data_bytes = rx_reg[31:0];

  // bytes waiting to send
  reg [2:0] tx_bytes = 0;

  // need a delay between starting serial and it toggling the busy pin
  reg last_ready = 0;
  always @(posedge hram_clk)
    last_ready <= ready;

  // serial interface
  // waits for 5 data bytes and 1 end byte
  // first byte is a command (see above), second 4 make up an unsigned integer
  always @(posedge hram_clk, negedge rstn) begin
      // initialization
      if (rstn == 0) begin
          mem_or_reg <= 0;

          wr_byte_en <= 4'hF;			// write 4 bytes
          rd_num_dwords <= 6'h1;		// read 1 4 byte word

          rd_req <= 1'b0;
          wr_req <= 1'b0;

          addr <= 32'b0;
          wr_d <= 32'b0;

          latency_1x[7:0] <= 8'h10;	// latency setup - not so important latency_1x because is configured to go at latency_2x
          latency_2x[7:0] <= 8'd21;    // 21 edges = 6 cycles if configured at 166MHz * (2 latency_2x) * (2 controller is configured by each edge) - 2 data alignment
      end
      else begin
          if (rcv) begin
              rx_reg <= {rx_reg[31:0], rx_data};
              rx_byte_cnt <= rx_byte_cnt + 1;
              if (rx_byte_cnt == 5) begin
                  case(cmd_byte)
                      ADDR:  begin addr <= data_bytes; tx_reg <= data_bytes; end
                      LOAD:  begin wr_d <= data_bytes; tx_reg <= data_bytes; end
                      WRITE: begin wr_req <= 1; tx_reg <= WRITE; end
                      READ:  tx_reg <= ram_data;
                      READ_REQ: begin rd_req <= 1; tx_reg <= READ_REQ; end
                      COUNT: begin tx_reg <= count; count <= count + 1; end
                      CONST: tx_reg <= 32'd259;
                      default: tx_reg <= count;
                  endcase
                  rx_byte_cnt <= 0;
                  // only want 4, but couldn't get it to work, so read an extra in the control program
                  tx_bytes <= 5;
              end
          end else begin
              rd_req <= 0;
              wr_req <= 0;
          end

          // if a command is received, the tx data is queued in tx_reg
          // so while there are bytes to send, send each one
          if (tx_bytes > 0 )begin
              if(ready) begin
                  tx_strb <= 1'b1;
                  tx_data <= tx_reg[31:24]; 
                  // tx_uart takes 2 clock cycles for ready to go low after starting, so have to only do this on transition
              end else if (~ready && last_ready) begin
                  tx_reg <= tx_reg << 8;
                  tx_bytes <= tx_bytes - 1;
              end 
          end else begin
              tx_strb <= 1'b0;
          end
      end
  end
`endif
            
endmodule
