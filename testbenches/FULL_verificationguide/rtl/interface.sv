//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
interface mem_intf(input logic clk,reset);
 
  	//declaring the signals
  	logic [31:0] addr;
  	logic wr_en;
  	logic rd_en;
  	logic [7:0] wdata;
  	logic [7:0] rdata;
	logic busy;
	logic rd_rdy;
  
	//driver clocking block
	clocking driver_cb @(posedge clk);
		default input #1 output #1;
    	output	addr;
    	output	wr_en;
	    output	rd_en;
	    output	wdata;
	    input 	rdata;
		input 	busy;
		input 	rd_rdy;  
	endclocking
  
	//monitor clocking block
	clocking monitor_cb @(posedge clk);
	    default input #1 output #1;
	    input	addr;
	    input	wr_en;
	    input	rd_en;
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
