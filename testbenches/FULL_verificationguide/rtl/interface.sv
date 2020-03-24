//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
interface mem_intf(input logic clk, input logic reset);
 
  	//declaring the signals
  	logic [31:0] addr;
  	logic wr_req;
  	logic rd_req;
  	logic [7:0] wdata;
  	logic [7:0] rdata;
	logic busy;
	logic rd_rdy;
  
	//driver clocking block
	clocking driver_cb @(posedge clk);
		default input #1 output #1;
    	output	addr;
    	output	wr_req;
	    output	rd_req;
	    output	wdata;
	    input 	rdata;
		input 	busy;
		input 	rd_rdy;  
	endclocking
  
	//monitor clocking block
	clocking monitor_cb @(posedge clk);
	    default input #1 output #1;
	    input	addr;
	    input	wr_req;
	    input	rd_req;
	    input	wdata;
	    input	rdata;
		input	busy;
		input	rd_rdy;
	endclocking
  
	//driver modport
	modport DRIVER  (clocking driver_cb,input clk,reset);
  
	//monitor modport  
	modport MONITOR (clocking monitor_cb,input clk,reset);
  
endinterface
