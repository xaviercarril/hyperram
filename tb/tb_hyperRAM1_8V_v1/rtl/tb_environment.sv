`include "tb_transaction.sv"
import transaction_pkg::*;

`include "tb_generator.sv"
`include "tb_driver.sv"
`include "tb_monitor.sv"
`include "tb_scoreboard.sv"

class environment;
  
  //generator and driver instance
  generator  gen;
  driver     driv;
  monitor    mon;
  scoreboard scb;
  
  //mailbox handle's
  mailbox gen2driv;
  mailbox mon2scb;
  
  //event for synchronization between generator and test
  event gen_ended;
  
  //virtual interface
  virtual mem_intf mem_vif;
  
  //constructor
  function new(virtual mem_intf mem_vif);
    //get the interface from test
    this.mem_vif = mem_vif;
    
    //creating the mailbox (Same handle will be shared across generator and driver)
    gen2driv = new();
    mon2scb  = new();
    
    //creating generator and driver
    gen  = new(gen2driv,gen_ended);
    driv = new(mem_vif,gen2driv);
    mon  = new(mem_vif,mon2scb);
    scb  = new(mon2scb);
  endfunction
  
  //
  task pre_test();
    driv.reset();
  endtask
  
  task test();
    fork 
    gen.main();
    driv.main();
    mon.main();
    scb.main();      
	join_any
  endtask
  
  task post_test();
    wait(gen_ended.triggered);
    wait(gen.repeat_count == driv.no_transactions);
    wait(gen.repeat_count == scb.no_transactions);
  endtask  
  
  //run task
  task run;
    pre_test();
    test();
    post_test();
	$display("[PASS] = %0d \t [FAIL] = %0d \t [TOTAL] = %0d",scb.num_pass, scb.num_fail, scb.num_pass+scb.num_fail);
    $finish;
  endtask
  
endclass
