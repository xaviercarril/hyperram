//-------------------------------------------------------------------------
//						www.verificationguide.com 
//-------------------------------------------------------------------------
package transaction_pkg;

class transaction;
  //declaring the transaction items
  rand bit [31:0] 	addr;
  rand bit       	wr_req;
  rand bit       	rd_req;
  rand bit [31:0] 	wdata;
  	   bit [3:0]	wr_byte_en;
       bit [31:0] 	rdata;
	   bit [1:0]	cnt;
  
  //constraint, to generate any one among write and read
  constraint wr_rd_c { wr_req != rd_req; }; 
  //constraint, to not exceed the available range
  constraint addr_c { addr < 32'h800000; };
 
  //postrandomize function, displaying randomized values of items 
  function void post_randomize();
    $display("--------- [Trans] post_randomize ------");
    //$display("\t addr  = %0h",addr);
    if(wr_req) $display("\t addr  = 0x%0h\t wr_req = %0h\t wdata = 0x%0h\t wr_byte_en = 0x%0h",addr,wr_req,wdata,wr_byte_en);
    if(rd_req) $display("\t addr  = 0x%0h\t rd_req = %0h",addr,rd_req);
    $display("-----------------------------------------");
  endfunction
  
  //deep copy method
  function transaction do_copy();
    transaction trans;
    trans = new();
    trans.addr  = this.addr;
    trans.wr_req = this.wr_req;
    trans.rd_req = this.rd_req;
    trans.wdata = this.wdata;
	trans.wr_byte_en = this.wr_byte_en;
    return trans;
  endfunction
endclass

endpackage
