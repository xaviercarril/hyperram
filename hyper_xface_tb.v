module test;

  reg clk = 0;
  reg reset = 1;

  reg rd_req = 0;
  reg wr_req = 0;
 reg [7:0] latency_1x = 8'h12;
 reg [7:0] latency_2x = 8'h16;

  reg [31:0] addr = 0;
  reg [31:0] wr_d = 0;
  wire [31:0] rd_d;
  reg [3:0] wr_byte_en = 4'hF;
  initial begin
     $dumpfile("test.vcd");
     $dumpvars(0,test);
     $dumpon;
     # 1
     reset <= 0;
     # 10
     addr <= 0;
     wr_d <= 0;
     wr_req <= 1;
     # 2
     wr_req <= 0;
     # 2
     wait(hyper_xface_0.busy == 0);
     # 10
     
     $finish;
  end

    hyper_xface hyper_xface_0(.reset(reset), .clk(clk),
    .rd_req(rd_req),
    .wr_req(wr_req),
    .wr_d(wr_d),
    .rd_d(rd_d),
    .wr_byte_en(wr_byte_en),

    .addr(addr),

    .latency_1x(latency_1x),
    .latency_2x(latency_2x),
    .mem_or_reg(0)
/*
    .dram_dq_in(data_pins_in), .dram_dq_out(data_pins_out), .dram_dq_oe_l(dram_dq_oe_l),
    .dram_rwds_in(dram_rwds_in), .dram_rwds_out(dram_rwds_out), .dram_rwds_oe_l(dram_rwds_oe_l),
    .dram_ck(dram_ck),
    .dram_rst_l(dram_rst_l),
    .dram_cs_l(dram_cs_l)
   */ 
    );

  always #1 clk = !clk;

endmodule

