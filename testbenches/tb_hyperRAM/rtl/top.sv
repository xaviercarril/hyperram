
`include "s27ks0641.v"
`include "hyper_xface.v"

`timescale 1 ns/1 ps

//top, this is the top most file, in which DUT(Design Under Test) and Verification environment are connected. 
//-------------------------------------------------------------------------

//including interfcae and testcase files
`include "interface.sv"

//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
`include "wr_rd_test.sv"
//----------------------------------------------------------------

module top();

//clock and reset signal declaration
	bit clk;
	bit reset;

//clock generation
initial begin
  	clk = 0;
end	
always #6.7 clk = ~clk;  //150MHz

//power-up generation
initial begin
	reset = 1;
	#150e3 reset = 0; //150us : tVCS
end
 

//creatinng instance of interface, inorder to connect DUT and testcase
mem_intf intf(clk,reset);
  
//Testcase instance, interface handle is passed to test as an argument
test t1(intf);

reg mem_or_reg;
reg [5:0] rd_num_dwords;
reg [7:0] latency_1x, latency_2x; 
wire burst_wr_rdy; //Not connected
initial begin
	mem_or_reg = 0;

    rd_num_dwords = 6'h1;      // read 1 4 byte word

    latency_1x[7:0] = 8'h10;   // latency setup - not so important latency_1x because is configured to go at latency_2x
    latency_2x[7:0] = 8'd21;   // 22 edges = 6 cycles if configured at 166MHz * (2 latency_2x) * (2 controller is configured by each edge) - 2
end

wire [7:0] data_pins_in, data_pins_out, dram_dq;
wire dram_dq_oe_l, dram_rwds_in, dram_rwds_out, dram_rwds_oe_l, dram_ck, dram_rst_l, dram_cs_l, dram_rwds;

//DQ IO
assign data_pins_in[7:0] = dram_dq_oe_l ? dram_dq : 8'bz;
assign dram_dq[7:0] = ~dram_dq_oe_l ? data_pins_out : 8'bz;

//RWDS IO
assign dram_rwds = ~dram_rwds_oe_l ? dram_rwds_out : 1'bz;
assign dram_rwds_in = dram_rwds_oe_l ? dram_rwds : 1'bz;


hyper_xface controller_ip(
.reset				(reset),
.clk				(intf.clk),
.rd_req				(intf.rd_req),
.wr_req				(intf.wr_req),
.mem_or_reg			(mem_or_reg),
.wr_byte_en			(intf.wr_byte_en),
.rd_num_dwords		(rd_num_dwords),
.addr				(intf.addr),
.wr_d				(intf.wdata),
.rd_d				(intf.rdata),
.rd_rdy				(intf.rd_rdy),
.busy				(intf.busy),
.burst_wr_rdy		(burst_wr_rdy),
.latency_1x			(latency_1x),
.latency_2x			(latency_2x),

.dram_dq_in			(data_pins_in),
.dram_dq_out		(data_pins_out),
.dram_dq_oe_l		(dram_dq_oe_l),
.dram_rwds_in		(dram_rwds_in),
.dram_rwds_out		(dram_rwds_out),
.dram_rwds_oe_l		(dram_rwds_oe_l),
.dram_ck			(dram_ck),
.dram_rst_l			(dram_rst_l),
.dram_cs_l			(dram_cs_l)
);



s27ks0641 #(.TimingModel("S27KS0641DPBHI020"))
hyperRAM(
.DQ7      (dram_dq[7]),
.DQ6      (dram_dq[6]),
.DQ5      (dram_dq[5]),
.DQ4      (dram_dq[4]),
.DQ3      (dram_dq[3]),
.DQ2      (dram_dq[2]),
.DQ1      (dram_dq[1]),
.DQ0      (dram_dq[0]),
.RWDS     (dram_rwds),
.CSNeg    (dram_cs_l),
.CK       (dram_ck),
.CKNeg    (~dram_ck),
.RESETNeg (dram_rst_l)
);


//enabling the wave dump
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end

endmodule
