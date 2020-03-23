
module tb_hyperram(
		output				reset,
		output	 			clk,
		output 				rd_req,
		output 				wr_req,
		output	 			mem_or_reg,
		output 	  [3:0]		wr_byte_en,
		output	  [7:0]		rd_num_dwords,
		output 	  [31:0]	addr,
		output	  [31:0]	wr_d,
		input	  [31:0]	rd_d,
		input	 	 		rd_rdy,
		input	 	 		busy,
		output 	  [7:0]		latency_1x,
		output	  [7:0]		latency_2x
);

initial begin
	clk = 0;
	reset = 1;
	#2 reset = 0;
	main;
	$finish;
end

always #1 clk = ~clk;


task automatic main;
	pre_test;
	test;
endtask


task automatic pre_test;
	//Configuration statement
	mem_or_reg = 0;

    latency_1x[7:0] = 8'h10;   // latency setup - not so important latency_1x because is configured to go at latency_2x
    latency_2x[7:0] = 8'd22;   // 22 edges = 6 cycles if configured at 166MHz * (2 latency_2x) * (2 controller is configured by each edge) - 2
endtask
	
	
task automatic test;
	bit [31:0] address = 32'h0000;
	bit [31:0] wr_data = 32'h33;
	write(address, wr_data);
	bit [31:0] rd_data = read(addr);
	
	if (rd_data == wr_data) begin
		$display("Test OK");
	end
	else $display("TEST FAIL");
endtask

function automatic void write (logic [31:0] address, wr_data);
	wait(!busy);
	addr = address;
	wr_d = wr_data;
	wr_byte_en = 4'hF; 			//write 4 bytes
	wr_req = 1;
	#1 wr_req = 0;
endfunction

function automatic bit[31:0] read (logic [31:0] address);
	wait(!busy);
	addr = address;
    rd_num_dwords = 6'h1;      	// read 1 4 byte word
	rd_req = 1;
	#1 rd_req = 0;
	wait(rd_rdy);
	//bit [31:0] rd_data = rd_d;
	return rd_d;
endfunction

endmodule
