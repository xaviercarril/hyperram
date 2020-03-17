`ifndef MEM_BASE_OBJECT_SV
`define MEM_BASE_OBJECT_SV
class tb_base_object;
  bit [31:0] addr;
  bit [31:0] data;
  // Read = 0, Write = 1
  bit rd_wr;
endclass
`endif
