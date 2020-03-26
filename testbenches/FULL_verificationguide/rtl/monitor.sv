//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
//Samples the interface signals, captures into transaction packet and send the packet to scoreboard.

`define MON_IF mem_vif.MONITOR.monitor_cb
class monitor;
  
  //creating virtual interface handle
  virtual mem_intf mem_vif;
  
  //creating mailbox handle
  mailbox mon2scb;
  
  //constructor
  function new(virtual mem_intf mem_vif,mailbox mon2scb);
    //getting the interface
    this.mem_vif = mem_vif;
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Samples the interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      transaction trans;
      trans = new();

      @(posedge mem_vif.MONITOR.clk);
      wait(`MON_IF.rd_req || `MON_IF.wr_req);
        trans.addr  = `MON_IF.addr;
        trans.wr_req = `MON_IF.wr_req;
        trans.wdata = `MON_IF.wdata;
		trans.wr_byte_en = `MON_IF.wr_byte_en;
        if(`MON_IF.rd_req) begin
          trans.rd_req = `MON_IF.rd_req;
          @(posedge mem_vif.MONITOR.clk);
          @(posedge mem_vif.MONITOR.clk);
		  wait(`MON_IF.rd_rdy);
          trans.rdata = `MON_IF.rdata;
        end      
        mon2scb.put(trans);
    end
  endtask
  
endclass
