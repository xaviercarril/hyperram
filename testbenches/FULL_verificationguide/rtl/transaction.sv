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
       bit [31:0] 	rdata;
  
  //constaint, to generate any one among write and read
  constraint wr_rd_c { wr_req != rd_req; }; 
  
  //postrandomize function, displaying randomized values of items 
  function void post_randomize();
    $display("--------- [Trans] post_randomize ------");
    //$display("\t addr  = %0h",addr);
    if(wr_req) $display("\t addr  = %0h\t wr_req = %0h\t wdata = %0h",addr,wr_req,wdata);
    if(rd_req) $display("\t addr  = %0h\t rd_req = %0h",addr,rd_req);
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
    return trans;
  endfunction
endclass

endpackage
