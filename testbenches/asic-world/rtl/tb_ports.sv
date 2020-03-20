`ifndef MEM_DRIVER_SV
`define MEM_DRIVER_SV

`include "tb_base_object.sv"

class tb_driver;
  virtual tb_ports ports;

function new(virtual tb_ports ports);
  begin
    this.ports = ports;
    ports.address    = 0;
    ports.chip_en    = 0;
    ports.read_write = 0;
    ports.data_in    = 0;
  end
endfunction

task drive_tb (tb_base_object object);
  begin
    @ (posedge ports.clock);
    ports.address    = object.addr;
    ports.chip_en    = 1;
    ports.read_write = object.rd_wr;
    ports.data_in    = (object.rd_wr) ? object.data : 0;
    if (object.rd_wr) begin
      $display("Driver : Memory write access-> Address : %x Data : %x\n", 
        object.addr,object.data);
    end else begin
      $display("Driver : Memory read  access-> Address : %x\n", 
        object.addr);
    end
    @ (posedge ports.clock);
    ports.address    = 0;
    ports.chip_en    = 0;
    ports.read_write = 0;
    ports.data_in    = 0;
 end
endtask

endclass
`endif

