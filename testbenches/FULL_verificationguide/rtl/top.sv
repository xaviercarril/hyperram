`include "s27ks0641.sv"
`include "hyper_xface.sv"


//top, this is the top most file, in which DUT(Design Under Test) and Verification environment are connected. 
//-------------------------------------------------------------------------

//including interfcae and testcase files
`include "interface.sv"

//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
`include "random_test.sv"
//`include "wr_rd_test.sv"
//`include "default_rd_test.sv"
//----------------------------------------------------------------

module top();

//clock and reset signal declaration
  bit clk;
  bit reset;

//clock generation
initial begin
  clk = 0;
end	
always #5 clk = ~clk;

//reset generation
initial begin
	reset = 1;
	#5 reset = 0;
end
  
//creatinng instance of interface, inorder to connect DUT and testcase
mem_intf intf(clk,reset);
  
//Testcase instance, interface handle is passed to test as an argument
test t1(intf);

/*reg rd_req, wr_req;
wire busy;

always_ff @(posedge clk) begin
	if (!busy) begin
		if (intf.wr_en) begin
			rd_req <= 0;
			wr_req <= 1;
		else if (intf.rd_en) begin
			rd_req <= 1;
			wr_req <= 0;
		else begin
			rd_req <= 0;
			wr_req <= 0;
		end
			
	end
	else begin
		rd_req <= 0;
		wr_req <= 0;
	end
end

wire [31:0] rd_d;
wire rd_rdy;
always_ff @(posedge clk) begin
	if (rd_rdy) intf.rdata <= rd_d;
end
*/
reg mem_or_reg;
reg [3:0] wr_byte_en;
reg [5:0] rd_num_dwords;
reg [7:0] latency_1x, latency_2x; 
wire burst_wr_rdy; //Not connected
initial begin
	mem_or_reg = 0;

    wr_byte_en = 4'hF;         // write 4 bytes
    rd_num_dwords = 6'h1;      // read 1 4 byte word

    latency_1x[7:0] = 8'h10;   // latency setup - not so important latency_1x because is configured to go at latency_2x
    latency_2x[7:0] = 8'd22;   // 22 edges = 6 cycles if configured at 166MHz * (2 latency_2x) * (2 controller is configured by each edge) - 2
end

wire [7:0] data_pins_in, data_pins_out, dram_dq;
wire dram_dq_oe_l, dram_rwds_in, dram_rwds_out, dram_rwds_oe_l, dram_ck, dram_rst_l, dram_cs_l, dram_rwds;

//DQ IO
assign data_pins_in[7:0] = dram_dq_oe_l ? dram_dq : 8'bz;
assign dram_dq[7:0] = ~dram_dq_oe_l ? data_pins_out : 8'bz;

//RWDS IO
assign dram_rwds = ~dram_rwds_oe_l ? dram_rwds_out : 1'bz;
assign dram_rwds_in = dram_rwds_oe_l ? dram_rwds : 1'bz;


hyper_xfce controller_ip(
.clk				(intf.clk),
.rd_req				(intf.rd_en),
.wr_req				(intf.wr_en),
.mem_or_req			(mem_or_reg),
.wr_byte_en			(wr_byte_en),
.rd_num_dwords		(rd_num_dwords),
.addr				(intf.addr),
.wr_d				(intf.wdata),
.rd_d				(intf.rdata),
.rd_rdy				(intf.rd_rdy),
.busy				(intf.busy),
.burst_wr_rdy		(burst_wr_rdy),

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



s27ks0641 hyperRAM(
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
