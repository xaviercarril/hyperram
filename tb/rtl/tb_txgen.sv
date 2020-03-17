`ifndef MEM_TXGEN_SV
`define MEM_TXGEN_SV

`include "tb_base_object.sv"
`include "tb_scoreboard.sv"
`include "tb_ports.sv"

class tb_txgen;
  tb_base_object  tb_object;
  tb_driver  tb_driver;
  
  integer num_cmds;

function new(virtual tb_ports ports);
  begin
    num_cmds = 3;
    tb_driver = new(ports);
  end
endfunction


task gen_cmds();
  begin
    integer i = 0;
    for (i=0; i < num_cmds; i ++ ) begin
      tb_object = new();
      tb_object.addr = $random();
      tb_object.data = $random();
      tb_object.rd_wr = 1;
      tb_driver.drive_tb(tb_object);
      tb_object.rd_wr = 0;
      tb_driver.drive_tb(tb_object);
    end
  end
endtask

endclass
`endif
