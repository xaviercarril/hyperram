`include "s27ks0641.sv"
`include "hyper_xface.sv"

module top();

wire [31:0] address, data_in;
reg [31:0] data_out;
wire  read_write, chip_en;
reg clk;

// Connect the interface
tb_ports ports(
 .clock       (clk),
 .address     (address),
 .chip_en     (chip_en),
 .read_write  (read_write),
 .data_in     (data_in),
 .data_out    (data_out)
);

// Connect the program
tb tb(ports);

initial begin
  clk = 0;
end	

always #1 clk = ~clk;

reg rd_req, wr_req;
wire busy;

always_ff @(posedge clk) begin
	if (chip_en && !busy) begin
		if (read_write) wr_req <= 1;
		else rd_req <= 1;
	end
	else begin
		wr_req <= 0;
		rd_req <= 0;
	end
end

wire [31:0] rd_d;
wire rd_rdy;
always_ff @(posedge clk) begin
	if (rd_rdy) data_out <= rd_d;
end

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
.clk				(clk),
.rd_req				(rd_req),
.wr_req				(wr_req),
.mem_or_req			(mem_or_reg),
.wr_byte_en			(wr_byte_en),
.rd_num_dwords			(rd_num_dwords),
.addr				(address),
.wr_d				(data_in),
.rd_d				(rd_d),
.rd_rdy				(rd_rdy),
.busy				(busy),
.burst_wr_rdy			(burst_wr_rdy),

.dram_dq_in			(data_pins_in),
.dram_dq_out			(data_pins_out),
.dram_dq_oe_l			(dram_dq_oe_l),
.dram_rwds_in			(dram_rwds_in),
.dram_rwds_out			(dram_rwds_out),
.dram_rwds_oe_l			(dram_rwds_oe_l),
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


endmodule
