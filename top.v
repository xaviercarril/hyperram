`default_nettype none
`include "baudgen.vh"

module top (
	input  clk,
    // dram pins
    inout [7:0] dram_dq,
    inout dram_rwds,
    output dram_ck,
    output dram_rst_l,
    output dram_cs_l,
    output dram_rwds_oe,
    output dram_dq_oe,


    input rx,
    output tx,

    // leds
    output [4:0] leds


);

    reg [3:0] clk_div;
    always @(posedge clk)
        clk_div <= clk_div + 1;

    wire hram_clk = clk_div[3];
    reg reset = 1;
    wire nreset = ~ reset;

    always @(posedge clk)
        reset <= 0;

    wire [7:0] data_pins_in;
    wire [7:0] data_pins_out;
    wire dram_dq_oe_l;
    assign dram_dq_oe = ~dram_dq_oe_l;
    assign dram_rwds_oe = ~dram_rwds_oe_l;


    wire rd_rdy;
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
    
    SB_IO #(
        .PIN_TYPE(6'b 1010_01),
    ) hyperram_data_pins [7:0] (
        .PACKAGE_PIN(dram_dq),
        .OUTPUT_ENABLE(~dram_dq_oe_l),
        .D_OUT_0(data_pins_out),
        .D_IN_0(data_pins_in),
    );

    wire dram_rwds_out;
    wire dram_rwds_in;
    wire dram_rwds_oe_l;

    SB_IO #(
        .PIN_TYPE(6'b 1010_01),
    ) hyperram_rwds (
        .PACKAGE_PIN(dram_rwds),
        .OUTPUT_ENABLE(~dram_rwds_oe_l),
        .D_OUT_0(dram_rwds_out),
        .D_IN_0(dram_rwds_in),
    );

    /*
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
            //if(busy == 0 && wr_req == 0) begin
            if(busy == 0 && rd_req == 0) begin
                addr <= addr + 1;
                //wr_d <= wr_d + 1;
                //wr_req <= 1;
                rd_req <= 1;
            end else
                rd_req <= 0;
                //wr_req <= 0;
        end
    end
    */

    hyper_xface hyper_xface_0(.reset(reset), .clk(clk),
    // module control
    .rd_req(rd_req),
    .wr_req(wr_req),
    .wr_d(wr_d),
    .rd_d(rd_d),
    .rd_rdy(rd_rdy),
    .wr_byte_en(wr_byte_en),
    .rd_num_dwords(rd_num_dwords),
    .addr(addr),
    .busy(busy),


    .latency_1x(latency_1x),
    .latency_2x(latency_2x),
    .mem_or_reg(0),


    // pins
    .dram_dq_in(data_pins_in), .dram_dq_out(data_pins_out), .dram_dq_oe_l(dram_dq_oe_l),
    .dram_rwds_in(dram_rwds_in), .dram_rwds_out(dram_rwds_out), .dram_rwds_oe_l(dram_rwds_oe_l),
    .dram_ck(dram_ck),
    .dram_rst_l(dram_rst_l),
    .dram_cs_l(dram_cs_l));
    //-- Parametro: Velocidad de transmision
    localparam BAUD = `B115200;

    //-- Señal de dato recibido
    wire rcv;

    //-- Datos recibidos
    wire [7:0] rxdata;
    wire [7:0] txdata;

    //-- Señal de reset
    reg rstn = 0;

    //-- Señal de transmisor listo
    wire ready;
    wire logic_ce;
    //-- Inicializador

    //-- Instanciar la unidad de recepcion
    uart_rx RX0 (.clk(clk),      //-- Reloj del sistema
           .rstn(nreset),    //-- Señal de reset
           .rx(rx),        //-- Linea de recepción de datos serie
           .rcv(rcv),      //-- Señal de dato recibido
           .data(rxdata)     //-- Datos recibidos
          );

    //-- Instanciar la unidad de transmision
    uart_tx TX0 ( .clk(clk),        //-- Reloj del sistema
             .rstn(nreset),     //-- Reset global (activo nivel bajo)
             .start(tx_strb),     //-- Comienzo de transmision
             .data(txdata),     //-- Dato a transmitir
             .tx(tx),         //-- Salida de datos serie (hacia el PC)
             .ready(ready)    //-- Transmisor listo / ocupado
           );

    wire tx_strb;

  reg [31:0] ram_data;

  reg [39:0] rx_reg = 0;
  reg [31:0] tx_reg = 0;
  reg [2:0] rx_byte_cnt = 0;

/*
  // latch data when it's ready
  always @(posedge rd_rdy)
    ram_data <= rd_d;
    */

  assign leds = addr;
  reg [31:0] count = 0;

  always @(posedge clk)
    if (rcv && ready) begin
        tx_strb <= 1'b1;
        txdata <= tx_reg[31:24]; 
        tx_reg <= tx_reg << 8;
        
        rx_reg <= {rx_reg[31:0], rxdata};
        rx_byte_cnt <= rx_byte_cnt + 1;
        if(rx_byte_cnt == 5) begin
            case(rx_reg[39:32])
                8'h01: begin addr <= rx_reg[31:0]; tx_reg <= rx_reg[31:0]; end
                8'h02: begin wr_d <= rx_reg[31:0]; tx_reg <= rx_reg[31:0]; end
                8'h03: begin wr_req <= 1; tx_reg <= 32'h03; end
                8'h04: tx_reg <= ram_data;
                8'h05: begin rd_req <= 1; tx_reg <= 32'h05; end
                8'h06: begin tx_reg <= count; count <= count + 1; end
                8'h07: tx_reg <= 32'h01010101;
                default: tx_reg <= count;
            endcase
            rx_byte_cnt <= 0;
            
        end

    end else begin
        tx_strb <= 1'b0;
        rd_req <= 0;
        wr_req <= 0;
    end
endmodule
