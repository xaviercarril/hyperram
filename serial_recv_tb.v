module test;

  reg clk = 0;
  reg reset = 1;

  reg rcv = 0;
  reg [39:0] rx_reg = 0;
  reg [31:0] tx_reg = 0;
  reg [7:0] tx_data = 0;
  reg [2:0] rx_byte_cnt = 0;
  reg [31:0] addr = 0;
  reg [31:0] wr_d = 0;
  reg [7:0] txdata = 1;
  reg [7:0] rxdata = 0;
  reg tx_strb = 0;

    wire [7:0] cmd_byte = rx_reg[39:32];
    wire [31:0] data_bytes = rx_reg[31:0];

      integer i;
    task send_data;
      input [39:0] data;
    begin
        for(i = 0; i < 5; i ++) begin
            rxdata <= data[39:32];
            data <= data << 8;
            rcv <= 1;
            # 2;
            rcv <= 0;
            # 2;
        end
        rcv <= 1;
        # 2;
        rcv <= 0;
        # 2;
    end
    endtask


  initial begin
     $dumpfile("test.vcd");
     $dumpvars(0,test);
     $dumpon;
     # 1
     reset <= 0;
     # 2

    send_data({8'h01,32'h01});
    send_data({8'h02,32'hFF});
    send_data({8'h03,32'hFF});
    send_data({8'h04,32'h00});
    send_data({8'h01,32'hFF});

     # 10

     $finish;
  end

  reg start = 0;

  always #1 clk = !clk;

  always @(posedge clk)
    if (rcv) begin
        tx_strb <= 1'b1;
        tx_data <= tx_reg[31:24]; 
        tx_reg <= tx_reg << 8;

        rx_reg <= {rx_reg[31:0], rxdata};
        rx_byte_cnt <= rx_byte_cnt + 1;
        if(rx_byte_cnt == 5) begin
            case(cmd_byte)
                8'h01: addr <= data_bytes;
                8'h02: wr_d <= data_bytes;
                8'h03: tx_reg <= addr;
                8'h04: start <= 1;
                default: tx_reg <= 32'h00;
            endcase
            rx_byte_cnt <= 0;
        end

    end else begin;
        tx_strb <= 1'b0;
        start <= 0;
    end

endmodule


