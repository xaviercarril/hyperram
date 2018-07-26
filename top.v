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

    output [4:0] dram_debug,

    input rx,
    output tx,

    // leds
    output [4:0] leds


);

 //   assign dram_debug[0] = dram_ck;
//    assign dram_debug[4:1] = data_pins_out[3:0];

    assign dram_debug[0] = tx;
    assign dram_debug[1] = rx;
//    assign dram_debug[2] = tx_strb;
//    assign dram_debug[3] = rx_byte_cnt == 5;
    /*


    SB_PLL40_CORE #(
        .FEEDBACK_PATH("SIMPLE"),
        .PLLOUT_SELECT("GENCLK"),
        .DIVR(4'b0000),
        .DIVF(7'b1000010),
        .DIVQ(3'b011),
        .FILTER_RANGE(3'b001)
    ) uut (
//        .LOCK(lock),
        .RESETB(1'b1),
        .BYPASS(1'b0),
        .REFERENCECLK(clk),
        .PLLOUTCORE(hram_clk)
    );
    */
/*    reg [2:0] clk_div;
    always @(posedge clk)
        clk_div <= clk_div + 1;

    wire hram_clk = clk_div[1]; // 12mhz -> 3mhz
        */
        wire hram_clk = clk;
    reg reset = 1;
    wire nreset = ~ reset;

    always @(posedge hram_clk)
        reset <= 0;

    wire [7:0] data_pins_in;
    wire [7:0] data_pins_out;
    wire dram_dq_oe_l;


    wire rd_rdy;
    reg rd_req = 0;
    reg wr_req_init = 0;
    reg wr_req_ser = 0;
    wire wr_req = wr_req_ser;

    wire [31:0] addr = addr_ser;
    reg [31:0] addr_init = 0;
    reg [31:0] addr_ser = 0;

    wire [31:0] wr_d = wr_d_ser;
    reg [31:0] wr_d_init = 0;
    reg [31:0] wr_d_ser = 0;

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

    //part requires 150us on startup = 1800 cycles at 12Mhz. use an 11 bit reg to count
    reg [10:0] start_delay_reg = 0;

    reg start_delay = 0;
    always @(posedge hram_clk) begin
        start_delay_reg <= start_delay_reg + 1;
        //if(start_delay_reg == 20000)
         //   start_delay <= 1;
    end

    reg [7:0] latency_1x = 8'h12;
    reg [7:0] latency_2x = 8'h16;

/*
    always @(posedge hram_clk) begin
        if(start_delay_reg == 2000 ) begin
        #ifdf
            if(busy == 0 && wr_req_init == 0) begin
                wr_req_init <= 1;
                addr_init <= count;
                wr_d_init <= count;
                mem_or_reg <= 0;
                count <= count + 1;
            end
        end else
            wr_req_init <= 0;
        #endif
            if(busy == 0 && rd_req == 0) begin
                rd_req <= 1;
                addr_init <= count;
                mem_or_reg <= 0;
                count <= count + 1;
            end
        end else
            rd_req <= 0;
    end
    */

/*
    reg mem_or_reg = 0;
    hyper_xface hyper_xface_0(.reset(reset), .clk(hram_clk),
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
    .mem_or_reg(mem_or_reg),

    // pins
    .dram_dq_in(data_pins_in), .dram_dq_out(data_pins_out), .dram_dq_oe_l(dram_dq_oe_l),
    .dram_rwds_in(dram_rwds_in), .dram_rwds_out(dram_rwds_out), .dram_rwds_oe_l(dram_rwds_oe_l),
    .dram_ck(dram_ck),
    .dram_rst_l(dram_rst_l),
    .dram_cs_l(dram_cs_l));

*/
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
    uart_rx #(.BAUD(BAUD)) RX0 (.clk(hram_clk),      //-- Reloj del sistema
           .rstn(nreset),    //-- Señal de reset
           .rx(rx),        //-- Linea de recepción de datos serie
           .rcv(rcv),      //-- Señal de dato recibido
           .data(rxdata)     //-- Datos recibidos
          );

    //-- Instanciar la unidad de transmision
    uart_tx #(.BAUD(BAUD)) TX0 ( .clk(hram_clk),        //-- Reloj del sistema
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

  // latch data when it's ready
  always @(posedge rd_rdy)
    ram_data <= rd_d;

  assign leds = addr;
  reg [31:0] count = 0;
  localparam ADDR = 8'h1;
  localparam LOAD = 8'h2;
  localparam WRITE = 8'h3;
  localparam READ = 8'h4;
  localparam READ_REQ = 8'h5;
  localparam COUNT = 8'h6;
  localparam CONST = 8'h7;


  wire [7:0] cmd_byte = rx_reg[39:32];
  wire [31:0] data_bytes = rx_reg[31:0];

  reg [2:0] tx_bytes = 0;
  reg last_ready = 0;

  always @(posedge clk)
    last_ready <= ready;

  always @(posedge hram_clk) begin
    if (rcv) begin
        rx_reg <= {rx_reg[31:0], rxdata};
        rx_byte_cnt <= rx_byte_cnt + 1;
        if(rx_byte_cnt == 5) begin
            case(cmd_byte)
                ADDR:  begin addr_ser <= data_bytes; tx_reg <= data_bytes; end
//                LOAD:  begin wr_d_ser <= data_bytes; tx_reg <= data_bytes; end
//                WRITE: begin wr_req_ser <= 1; tx_reg <= WRITE; end
//                READ:  tx_reg <= ram_data;
//                READ_REQ: begin rd_req <= 1; tx_reg <= READ_REQ; end
 //               COUNT: begin tx_reg <= count; count <= count + 1; end
                CONST: tx_reg <= 32'd259;
 //               default: tx_reg <= count;
            endcase
            rx_byte_cnt <= 0;
            tx_bytes <= 5;
        end
    end else begin
        rd_req <= 0;
        wr_req_ser <= 0;
    end

    if (tx_bytes > 0 )begin
        if(ready) begin
            tx_strb <= 1'b1;
            txdata <= tx_reg[31:24]; 
        // tx_uart takes 2 clock cycles for ready to go low after starting, so have to only do this on transition
        end else if (~ready && last_ready) begin
            tx_reg <= tx_reg << 8;
            tx_bytes <= tx_bytes - 1;
        end 
    end else
        tx_strb <= 1'b0;

  end
            
endmodule
