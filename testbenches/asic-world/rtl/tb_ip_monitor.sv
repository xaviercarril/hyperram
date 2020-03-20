`ifndef MEM_IP_MONITOR_SV
`define MEM_IP_MONITOR_SV

`include "tb_base_object.sv"
`include "tb_scoreboard.sv"

class tb_ip_monitor;
	tb_base_object tb_object;
	tb_scoreboard  sb;
	virtual tb_ports       ports;

function new (tb_scoreboard sb,virtual tb_ports ports);
	begin  
		this.sb    = sb;
		this.ports = ports;
	end
endfunction


task input_monitor();
	begin
	while (1) begin
		@ (posedge ports.clock);
		if ((ports.chip_en == 1) && (ports.read_write == 1)) begin
			tb_object = new();
         	$display("input_monitor : Memory wr access-> Address : %x Data : %x", 
            ports.address,ports.data_in);
	 		tb_object.addr = ports.address;
	 		tb_object.data = ports.data_in;
         	sb.post_input(tb_object);
      end
    end
  end
endtask

endclass

`endif
