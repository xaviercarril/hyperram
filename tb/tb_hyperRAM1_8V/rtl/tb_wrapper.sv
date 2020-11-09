
`include "../../modules/s27kl0641/model/s27kl0641.v"
`include "../../rtl/hyperram_controller.v" //Module controller to test 


module tb_wrapper( 
    input  wire         resetn,
    input  wire         clk,
    input  wire         rd_req,
    input  wire         wr_req,
    input  wire         mem_or_reg,
    input  wire [3:0]   wr_byte_en,
    input  wire [21:0]  rd_num_dwords,
    input  wire [31:0]  addr,
    input  wire [31:0]  wr_d,
    output reg  [31:0]  rd_d,
    output reg          rd_rdy,
    output reg          busy,
    output reg          burst_wr_rdy,
    input  wire [7:0]   latency_1x,
    input  wire [7:0]   latency_2x
);

 
//Connections between hyperRAM controller and hyperRAM model.
wire [7:0] data_pins_in, data_pins_out, dram_dq;
wire dram_dq_oe_l, dram_rwds_in, dram_rwds_out, dram_rwds_oe_l, dram_ck, dram_rst_l, dram_cs_l, dram_rwds;
 
//DQ IO
assign data_pins_in[7:0] = dram_dq_oe_l ? dram_dq : 8'bz;
assign dram_dq[7:0] = ~dram_dq_oe_l ? data_pins_out : 8'bz;

//RWDS IO
assign dram_rwds = ~dram_rwds_oe_l ? dram_rwds_out : 1'bz;
assign dram_rwds_in = dram_rwds_oe_l ? dram_rwds : 1'bz;

//Wire for debug
wire sump_dbg [7:0];

hyperram_controller controller_ip(
    .resetn         (resetn),
    .clk            (clk),
    .rd_req         (rd_req),
    .wr_req         (wr_req),
    .mem_or_reg     (mem_or_reg),
    .wr_byte_en     (wr_byte_en),
    .rd_num_dwords  (rd_num_dwords),
    .addr           (addr),
    .wr_d           (wr_d),
    .rd_d           (rd_d),
    .rd_rdy         (rd_rdy),
    .busy           (busy),
    .burst_wr_rdy   (burst_wr_rdy),
    .latency_1x     (latency_1x),
    .latency_2x     (latency_2x),

    .dram_dq_in     (data_pins_in),
    .dram_dq_out    (data_pins_out),
    .dram_dq_oe_l   (dram_dq_oe_l),
    .dram_rwds_in   (dram_rwds_in),
    .dram_rwds_out  (dram_rwds_out),
    .dram_rwds_oe_l (dram_rwds_oe_l),
    .dram_ck        (dram_ck),
    .dram_rst_l     (dram_rst_l),
    .dram_cs_l      (dram_cs_l)

//.sump_dbg           (sump_dbg)   //Useless in the testbench
);



s27kl0641 #(.TimingModel("S27KL0641DABHI020"))
hyperRAM(
.DQ7      (dram_dq[7]),
.DQ6      (dram_dq[6]),
.DQ5      (dram_dq[5]),
.DQ4      (dram_dq[4]),
.DQ3      (dram_dq[3]),
.DQ2      (dram_dq[2]),
.DQ1      (dram_dq[1]),
.DQ0      (dram_dq[0]),
.RWDS     (dram_rwds),
.CSNeg    (dram_cs_l),
.CK       (dram_ck),
//.CKNeg    (~dram_ck),
.RESETNeg (dram_rst_l)
);

endmodule
