`include "tb_base_object.sv"
`include "tb_ports.sv"
`include "tb_txgen.sv"
`include "tb_scoreboard.sv"
`include "tb_ip_monitor.sv"
`include "tb_op_monitor.sv"
program tb(tb_ports ports);

  tb_txgen txgen;
  tb_scoreboard sb;
  tb_ip_monitor ipm;
  tb_op_monitor opm;

initial begin
  sb    = new();
  ipm   = new (sb, ports);
  opm   = new (sb, ports);
  txgen = new(ports);
  fork
    ipm.input_monitor();
    opm.output_monitor();
  join_none
  txgen.gen_cmds();
  repeat (20) @ (posedge ports.clock);
end

endprogram
