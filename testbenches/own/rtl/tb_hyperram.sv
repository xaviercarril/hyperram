
module tb_hyperram(
		output	reg 		reset,
		output	reg 		clk,
		output 	wire		rd_req,
		output 	wire		wr_req,
		output	reg 		mem_or_reg,
		output 	reg  [3:0]	wr_byte_en,
		output	reg  [7:0]	rd_num_dwords,
		output 	reg  [31:0]	addr,
		output	reg  [31:0]	wr_d,
		input	wire [31:0]	rd_d,
		input	wire 		rd_rdy,
		input	wire 		busy,
		output 	reg  [7:0]	latency_1x,
		output	reg  [7:0]	latency_2x
);

reg clk;

initial begin
	clk = 0;
	reset = 1;
	#2 reset = 0;
	main();
	$finish;
end

always #1 clk = ~clk;


task main();
	pre_test();
	test();
end


task pre_test();
	//Configuration statement
	mem_or_reg = 0;

    wr_byte_en = 4'hF;         // write 4 bytes
    rd_num_dwords = 6'h1;      // read 1 4 byte word

    latency_1x[7:0] = 8'h10;   // latency setup - not so important latency_1x because is configured to go at latency_2x
    latency_2x[7:0] = 8'd22;   // 22 edges = 6 cycles if configured at 166MHz * (2 latency_2x) * (2 controller is configured by each edge) - 2
end
	
	
task test();
	write(addr, wr_data, num_bytes);
	rd_data = read(addr, num_bytes);
	

function void write ()	
