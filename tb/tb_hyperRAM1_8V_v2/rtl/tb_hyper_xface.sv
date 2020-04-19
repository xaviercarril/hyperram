//-----------------------------
// Header
//-----------------------------

/* -----------------------------------------------
* Project Name   : DRAC
* File           : tb_hyper_xface.v
* Organization   : Barcelona Supercomputing Center
* Author(s)      : Xavier Carril
* Email(s)       : xavier.carril@bsc.es
* References     : 
* -----------------------------------------------
* Revision History
*  Revision   | Author     | Commit | Description
* -----------------------------------------------
*/

//-----------------------------
// includes
//-----------------------------

`timescale 1 ns / 1 ns
`default_nettype none

`include "../colors.vh"

module tb_hyper_xface();

//-----------------------------
// Local parameters
//-----------------------------
    parameter VERBOSE         = 1;
    parameter CLK_PERIOD      = 1.7; //600MHz
    parameter CLK_HALF_PERIOD = CLK_PERIOD / 2;
    parameter RESET_DELAY     = 150e3; //150uS

//-----------------------------
// Signals
//-----------------------------
    //Reset & Clock 600MHz
    reg tb_rst_i;
    reg tb_clk_i;

    //Request signals
    reg tb_rd_req_i;
    reg tb_wr_req_i;
        
    //Configuration signals
    reg tb_mem_or_reg_i;
    reg [3:0] tb_wr_byte_en_i;
    reg [5:0] tb_rd_num_dwords_i;

    //Address signal
    reg [31:0] tb_addr_i;

    //Data signals
    reg [31:0] tb_wr_d_i;
    reg [31:0] tb_rd_d_o;

    //Acknowledge signals
    wire tb_rd_rdy_o;
    wire tb_busy_o;
    wire tb_burst_wr_rdy_o;

    //Latency configuration signals
    reg [7:0] tb_latency_1x_i;
    reg [7:0] tb_latency_2x_i;

    //Tests to do 
    logic [1:4] test_mask;

    //Data Registers
    reg [31:0] wr_data;
    reg [31:0] rd_data;
//-----------------------------
// Module
//-----------------------------

tb_wrapper tb_wrapper_inst (
    .reset          (tb_rst_i),
    .clk            (tb_clk_i),
    .rd_req         (tb_rd_req_i),
    .wr_req         (tb_wr_req_i),
    .mem_or_reg     (tb_mem_or_reg_i),
    .wr_byte_en     (tb_wr_byte_en_i),
    .rd_num_dwords  (tb_rd_num_dwords_i),
    .addr           (tb_addr_i),
    .wr_d           (tb_wr_d_i),
    .rd_d           (tb_rd_d_o),
    .rd_rdy         (tb_rd_rdy_o),
    .busy           (tb_busy_o),
    .burst_wr_rdy   (tb_burst_wr_rdy_o),
    .latency_1x     (tb_latency_1x_i),
    .latency_2x     (tb_latency_2x_i)
);

//-----------------------------
// DUT
//-----------------------------

//***clk_gen***
// A single clock source is used in this design.
    initial tb_clk_i = 1;
    always #CLK_HALF_PERIOD tb_clk_i = !tb_clk_i;

    //***task automatic reset_dut***
    task automatic reset_dut;
        begin
            $display("*** Toggle reset.");
            tb_rst_i <= 1'b1;
            #RESET_DELAY;
            tb_rst_i <= 1'b0;
            #CLK_PERIOD;
            $display("Done");
        end
    endtask

//***task automatic init_sim***
    task automatic init_sim;
        begin
            $display("*** init_sim");
            tb_clk_i <='{default:1};

            //Configuration by default
            tb_mem_or_reg_i <= '{default:0};

            //Latency configuration
            //Latency 1x is not used in the default memory configuration
            //Latency 2x: 21 edges = 6 cycles if configured at 166MHz * (2 latency_2x) * (2 controller is configured by each edge) - 2 data alignment - 1 fsm_addr cycle added

            tb_latency_1x_i <= 8'd11;
            tb_latency_2x_i <= 8'd21;

            $display("Done");
        end
    endtask

//***task automatic init_dump***
//This task dumps the ALL signals of ALL levels of instance dut_example into the test.vcd file
//If you want a subset to modify the parameters of $dumpvars
    task automatic init_dump;
        begin
            $display("*** init_dump");
            $dumpfile("dum_file.vcd");
            $dumpvars(0,tb_wrapper_inst);
            $display("Done");
        end
    endtask

//***task automatic test_sim***
    task automatic tick;
        begin
            #CLK_PERIOD;
        end
    endtask

//***task automatic test_sim***
    task automatic test_sim;
        begin
            int tmp;
            $display("*** test_sim");
            if (test_mask[1] == 1'b1) begin
                `START_BLUE_PRINT
                    $display("TEST 1 STARTED");
                `END_COLOR_PRINT
                test_sim_1(tmp);
                if (tmp == 1) begin
                    `START_RED_PRINT
                        $display("TEST 1 FAILED");
                    `END_COLOR_PRINT
                end else begin
                    `START_GREEN_PRINT
                        $display("TEST 1 PASSED");
                    `END_COLOR_PRINT
                end
            end
        end
    endtask

//***task automatic pre_write***
    task automatic wr_mask;
        input int n_byte;
        begin
            if (n_byte == 4) 	
			    tb_wr_byte_en_i <= 4'b1111; //write 4 bytes
		    else if (n_byte == 2)
			    tb_wr_byte_en_i <= 4'b0011; //write 2 bytes
          	else if (n_byte == 1)
	    		tb_wr_byte_en_i <= 4'b0001; //write 1 byte
		    else 
			    $error("Number of byte access invalid: %d bytes. Only can be 4/2/1 byte.\nExecution failed", n_byte);
        end
    endtask
    
//***task automatic read_req***
    task automatic read_req;
        begin
            tb_rd_req_i <= 1;
            tick();
            tb_rd_req_i <= 0;
        end
    endtask


//***task automatic write_req***
    task automatic write_req;
        begin
            tb_wr_req_i <= 1;
            tick();
            tb_wr_req_i <= 0;
        end
    endtask


//***task automatic test_sim_1***
// Test Write and Read 4 bytes in one memory positon
// Output should be nothing 
    task automatic test_sim_1;
        output int tmp;
        begin
            tmp = 0;
            tb_addr_i <= 32'h42;

            //Write Process
            wr_mask(4); //Write 4 bytes
            wait(!tb_busy_o);
            tb_wr_d_i <= 32'hDEAD; // Burst of 1 dword (4 bytes)
            write_req();
            /* For bursts :
            for (int i = 0; i < burst_wr; i++) begin
                write(burst_data_wr[i*32+31:i*32]);
                wait(tb_burst_wr_rdy_o);
            end
            */

            //Read Process
            tb_rd_num_dwords_i <= 1;  //Burst of 1 dword (4 bytes)
            tick();
            wait(!tb_busy_o);
            read_req();
            wait(tb_rd_rdy_o);
            /* For bursts:
            for (int i = 0; i < burst_rd; i++) begin
                read(burst_data_rd[i*32+31:i*32]);
                wait(tb_rd_rdy_o);
            end
            */

            //Checking Process
            assert (tb_wr_d_i == tb_rd_d_o)
            else begin
                $display("The data written in 0x%0h should be 0x%0h and it is 0x%0h", tb_addr_i, wr_data, rd_data);
                ++tmp;
            end
        end
   endtask


//***task automatic decode_input***
//Decode input arguments
    task automatic decode_input;
        input int arg;
        begin
            if (arg == 1) test_mask = 4'b1000;
            else test_mask = 4'b1111;
        end
    endtask

//***init_sim***
//The tasks that compose my testbench are executed here, feel free to add more tasks.
    initial begin
        integer arg;
        init_sim();
        init_dump();
        reset_dut();
		$value$plusargs("param1=%d", arg);
        decode_input(arg);
        test_sim();
        $finish;
    end


endmodule
`default_nettype wire

