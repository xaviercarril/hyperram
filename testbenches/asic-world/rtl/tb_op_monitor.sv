`ifndef MEM_OP_MONITOR_SV
`define MEM_OP_MONITOR_SV

`include "tb_base_object.sv"
`include "tb_scoreboard.sv"

class tb_op_monitor;
  tb_base_object tb_object;
  tb_scoreboard sb;
  virtual tb_ports       ports;

function new (tb_scoreboard sb,virtual tb_ports ports);
  begin
    this.sb    = sb;
    this.ports = ports;
  end
endfunction
  

task output_monitor();
  begin
    while (1) begin
      @ (negedge ports.clock);
      if ((ports.chip_en == 1) && (ports.read_write == 0)) begin
        tb_object = new();
        $display("Output_monitor : Memory rd access-> Address : %x Data : %x", 
          ports.address,ports.data_out);
        tb_object.addr = ports.address;
        tb_object.data = ports.data_out;
        sb.post_output(tb_object);
      end
    end
  end
endtask


endclass

`endif
