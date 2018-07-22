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
  wire busy;
  reg [3:0] wr_byte_en = 4'hF;
  reg [5:0] rd_num_dwords = 6'h1;
  initial begin
     $dumpfile("test.vcd");
     $dumpvars(0,test);
     $dumpon;
     # 1
     reset <= 0;
     /*
     # 10
     addr <= 32'h012345;
     wr_d <= 32'h012345;
     wr_req <= 1;
     # 2
     wr_req <= 0;
     # 2
     wait(hyper_xface_0.busy == 0);
     # 10

    // read
     addr <= 32'h6789ab;
     rd_req <= 1;
     wr_byte_en <= 0;
     # 2
     rd_req <= 0;
     # 2
     wait(hyper_xface_0.busy == 0);
     # 100
     */
     # 6000
     
     $finish;
  end

    hyper_xface hyper_xface_0(.reset(reset), .clk(clk),
    .rd_req(rd_req),
    .wr_req(wr_req),
    .wr_d(wr_d),
    .rd_d(rd_d),
    .wr_byte_en(wr_byte_en),
    .rd_num_dwords(rd_num_dwords),

    .addr(addr),
    .busy(busy),

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

    //part requires 150us on startup = 1800 cycles at 12Mhz. use an 11 bit reg to count
    reg [10:0] start_delay_reg = 0;

    reg start_delay = 0;
    always @(posedge clk) begin
        start_delay_reg <= start_delay_reg + 1;
        if(start_delay_reg == 2000)
            start_delay <= 1;
    end

    always @(posedge clk) begin
        if(start_delay) begin
            if(busy == 0 && wr_req == 0) begin
                addr <= addr + 1;
                wr_d <= wr_d + 1;
                wr_req <= 1;
            end else
                wr_req <= 0;
        end
    end

endmodule

