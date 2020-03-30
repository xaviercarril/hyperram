//gets the packet from generator and drive the transaction paket items into interface (interface is connected to DUT, so the items driven into interface signal will get driven in to DUT) 

`define DRIV_IF mem_vif.DRIVER.driver_cb
class driver;
  
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual mem_intf mem_vif;
  
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual mem_intf mem_vif,mailbox gen2driv);
    //getting the interface
    this.mem_vif = mem_vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(mem_vif.reset);
	no_transactions = 1;
    $display("--------- [DRIVER] Reset Started ---------");
    `DRIV_IF.wr_req <= 0;
    `DRIV_IF.rd_req <= 0;
    `DRIV_IF.addr  <= 0;
    `DRIV_IF.wdata <= 0;
	`DRIV_IF.wr_byte_en <= 0;        
    wait(!mem_vif.reset);
    $display("--------- [DRIVER] Reset Ended ---------");
  endtask
  
  //drivers the transaction items to interface signals
  task drive;
      transaction_pkg::transaction trans;
      `DRIV_IF.wr_req <= 0;
      `DRIV_IF.rd_req <= 0;
      gen2driv.get(trans);
      @(posedge mem_vif.DRIVER.clk);
	  wait(!(`DRIV_IF.busy));
      $display("--------- [DRIVER-TRANSFER: %0d] ---------",no_transactions);
      @(posedge mem_vif.DRIVER.clk);
        `DRIV_IF.addr <= trans.addr;
      if(trans.wr_req) begin
        `DRIV_IF.wr_req <= trans.wr_req;
        `DRIV_IF.wdata <= trans.wdata;
		`DRIV_IF.wr_byte_en <= trans.wr_byte_en;
        $display("\tADDR = 0x%0h \tWDATA = 0x%0h \twr_byte_en = %0b", trans.addr, trans.wdata, trans.wr_byte_en);
        @(posedge mem_vif.DRIVER.clk);
      end
      if(trans.rd_req) begin
        `DRIV_IF.rd_req <= trans.rd_req;
        @(posedge mem_vif.DRIVER.clk);
        `DRIV_IF.rd_req <= 0;
        @(posedge mem_vif.DRIVER.clk);
		wait(`DRIV_IF.rd_rdy);
        trans.rdata = `DRIV_IF.rdata;
		`DRIV_IF.wr_byte_en <= trans.wr_byte_en; //Only to know how bytes to read on the scoreboard
        $display("\tADDR = 0x%0h \tRDATA = 0x%0h \twr_byte_en = %0b", trans.addr, `DRIV_IF.rdata, trans.wr_byte_en);
      end
      $display("-----------------------------------------");
      no_transactions++;
  endtask
  
    
  //
  task main;
    forever begin
      fork
        //Thread-1: Waiting for reset
        begin
          wait(mem_vif.reset);
        end
        //Thread-2: Calling drive task
        begin
          forever
            drive();
        end
      join_any
      disable fork;
    end
  endtask
        
endclass
