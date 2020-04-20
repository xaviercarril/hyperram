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

//-----------------------------
// Classes 
//-----------------------------

class address_pack;
    rand bit [31:0] addr;
    constraint addr_range {addr > 32'h0; addr < 32'd8000000;}
endclass

module tb_hyper_xface();

//-----------------------------
// Local parameters
//-----------------------------
    parameter VERBOSE         = 1;
    parameter CLK_PERIOD      = 1.7; //600MHz
    parameter CLK_HALF_PERIOD = CLK_PERIOD / 2;
    parameter RESET_DELAY     = 150e3; //150uS
    parameter MEM_SIZE        = 8388608; //8MB 

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
    reg [21:0] tb_rd_num_dwords_i;

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
        input string test_order;
        begin
            int tmp = 0;
            bit test_mask [*]; // To know which test pass or fail
            int num_test;
            string char;
            $display("*** test_sim");
            for (int i = 0; i < test_order.len(); ++i) begin 

                tmp = 0;

                if (test_order[i] == "1") begin
                    `START_BLUE_PRINT
                        $display("TEST 1 STARTED");
                    `END_COLOR_PRINT
                    test_sim_1(tmp);
                    if (tmp > 0) begin
                        `START_RED_PRINT
                            $display("TEST 1 FAILED");
                            test_mask[1] = 0;
                        `END_COLOR_PRINT
                    end else begin
                        `START_GREEN_PRINT
                            $display("TEST 1 PASSED");
                            test_mask[1] = 1;
                        `END_COLOR_PRINT
                    end
                end
            
                if (test_order[i] == "2") begin
                    `START_BLUE_PRINT
                        $display("TEST 2 STARTED");
                    `END_COLOR_PRINT
                    test_sim_2(tmp);
                    if (tmp > 0) begin
                        `START_RED_PRINT
                            $display("TEST 2 FAILED");
                            test_mask[2] = 0;
                        `END_COLOR_PRINT
                    end else begin
                        `START_GREEN_PRINT
                            $display("TEST 2 PASSED");
                            test_mask[2] = 1;
                        `END_COLOR_PRINT
                    end
                end
                
                if (test_order[i] == "3") begin
                    `START_BLUE_PRINT
                        $display("TEST 3 STARTED");
                    `END_COLOR_PRINT
                    test_sim_3(tmp);
                    if (tmp > 0) begin
                        `START_RED_PRINT
                            $display("TEST 3 FAILED");
                            test_mask[3] = 0;
                        `END_COLOR_PRINT
                    end else begin
                        `START_GREEN_PRINT
                            $display("TEST 3 PASSED");
                            test_mask[3] = 1;
                        `END_COLOR_PRINT
                    end
                end
                
                if (test_order[i] == "4") begin
                    `START_BLUE_PRINT
                        $display("TEST 4 STARTED");
                    `END_COLOR_PRINT
                    test_sim_4(tmp);
                    if (tmp > 0) begin
                        `START_RED_PRINT
                            $display("TEST 4 FAILED");
                            test_mask[4] = 0;
                        `END_COLOR_PRINT
                    end else begin
                        `START_GREEN_PRINT
                            $display("TEST 4 PASSED");
                            test_mask[4] = 1;
                        `END_COLOR_PRINT
                    end
                end
                
                if (test_order[i] == "5") begin
                    `START_BLUE_PRINT
                        $display("TEST 5 STARTED");
                    `END_COLOR_PRINT
                    test_sim_5(tmp);
                    if (tmp > 0) begin
                        `START_RED_PRINT
                            $display("TEST 5 FAILED");
                            test_mask[5] = 0;
                        `END_COLOR_PRINT
                    end else begin
                        `START_GREEN_PRINT
                            $display("TEST 5 PASSED");
                            test_mask[5] = 1;
                        `END_COLOR_PRINT
                    end
                end


                if (test_order[i] == "6") begin
                    `START_BLUE_PRINT
                        $display("TEST 6 STARTED");
                    `END_COLOR_PRINT
                    test_sim_6(tmp);
                    if (tmp > 0) begin
                        `START_RED_PRINT
                            $display("TEST 6 FAILED");
                            test_mask[6] = 0;
                        `END_COLOR_PRINT
                    end else begin
                        `START_GREEN_PRINT
                            $display("TEST 6 PASSED");
                            test_mask[6] = 1;
                        `END_COLOR_PRINT
                    end
                end

                if (test_order[i] == "7") begin
                    `START_BLUE_PRINT
                        $display("TEST 7 STARTED");
                    `END_COLOR_PRINT
                    test_sim_7(tmp);
                    if (tmp > 0) begin
                        `START_RED_PRINT
                            $display("TEST 7 FAILED");
                            test_mask[7] = 0;
                        `END_COLOR_PRINT
                    end else begin
                        `START_GREEN_PRINT
                            $display("TEST 7 PASSED");
                            test_mask[7] = 1;
                        `END_COLOR_PRINT
                    end
                end
            end
            
            //Print Summary
            $display("*************************");
            `START_MAGENTA_PRINT
                $display("Summary:");
            `END_COLOR_PRINT
            for (int j = 0; j < test_order.len(); ++j) begin
                char = {test_order[j]};
                num_test = char.atoi();
                if (test_mask[num_test] == 1'b1) begin
                    `START_GREEN_PRINT
                        $display("TEST %0d PASSED", num_test);
                    `END_COLOR_PRINT
                end else begin
                     `START_RED_PRINT
                        $display("TEST %0d FAILED", num_test);
                     `END_COLOR_PRINT
                end
            end

            $display("Done");
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
            tb_wr_d_i <= 32'h12345678; // Burst of 1 dword (4 bytes)
            write_req();

            //Read Process
            tb_rd_num_dwords_i <= 1;  //Burst of 1 dword (4 bytes)
            tick();
            wait(!tb_busy_o);
            read_req();
            wait(tb_rd_rdy_o);

            //Checking Process
            assert (tb_wr_d_i == tb_rd_d_o)
                    $display("0x%0h : 0x%0h", tb_addr_i, tb_rd_d_o[31:0]);
            else begin
                $display("The data written in 0x%0h should be 0x%0h and it is 0x%0h", tb_addr_i, tb_wr_d_i, tb_rd_d_o);
                ++tmp;
            end
        end
   endtask

//***task automatic test_sim_2***
// Test Write and Read 2 bytes in one memory positon
// Output should be nothing 
    task automatic test_sim_2;
        output int tmp;
        begin
            tmp = 0;
            tb_addr_i <= 32'h42;

            //Write Process
            wr_mask(2); //Write 2 bytes
            wait(!tb_busy_o);
            tb_wr_d_i <= 16'h1234; // (2 bytes)
            write_req();

            //Read Process
            tb_rd_num_dwords_i <= 1;  //Burst of 1 dword (4 bytes)
            tick();
            wait(!tb_busy_o);
            read_req();
            wait(tb_rd_rdy_o);

            //Checking Process
            assert (tb_wr_d_i[15:0] == tb_rd_d_o[15:0])
                    $display("0x%0h : 0x%0h", tb_addr_i, tb_rd_d_o[15:0]);
            else begin
                $display("The data written in 0x%0h should be 0x%0h and it is 0x%0h", tb_addr_i, tb_wr_d_i[15:0], tb_rd_d_o[15:0]);
                ++tmp;
            end
        end
   endtask

//***task automatic test_sim_3***
// Test Write and Read 1 byte in one memory positon
// Output should be nothing 
    task automatic test_sim_3;
        output int tmp;
        begin
            tmp = 0;
            tb_addr_i <= 32'h42;

            //Write Process
            wr_mask(1); //Write 1 bytes
            wait(!tb_busy_o);
            tb_wr_d_i <= 8'h12; //(1 byte)
            write_req();

            //Read Process
            tb_rd_num_dwords_i <= 1;  //Burst of 1 dword (4 bytes)
            tick();
            wait(!tb_busy_o);
            read_req();
            wait(tb_rd_rdy_o);

            //Checking Process
            assert (tb_wr_d_i[7:0] == tb_rd_d_o[7:0])
                    $display("0x%0h : 0x%0h", tb_addr_i, tb_rd_d_o[7:0]);
            else begin
                $display("The data written in 0x%0h should be 0x%0h and it is 0x%0h", tb_addr_i, tb_wr_d_i[7:0], tb_rd_d_o[7:0]);
                ++tmp;
            end
        end
   endtask

//***task automatic test_sim_4***
// Test Write and Read 4 bytes in 10 random memory positons
// Output should be nothing 
    task automatic test_sim_4;
        output int tmp;
        begin
            bit [31:0] addr;
            address_pack addr_pck = new();
            tmp = 0;
            for (int i = 0; i < 10; i++) begin
                addr_pck.randomize();
                addr = addr_pck.addr;
                tb_addr_i <= addr;
    
                //Write Process
                wr_mask(4); //Write 4 bytes
                wait(!tb_busy_o);
                tb_wr_d_i <= addr; // We are going to write the address. Burst of 1 dword (4 bytes)
                write_req();

                //Read Process
                tb_rd_num_dwords_i <= 1;  //Burst of 1 dword (4 bytes)
                tick();
                wait(!tb_busy_o);
                read_req();
                wait(tb_rd_rdy_o);

                //Checking Process
                assert (tb_wr_d_i[31:0] == tb_rd_d_o[31:0]) 
                    $display("0x%0h : 0x%0h", tb_addr_i, tb_rd_d_o[31:0]);
                else begin
                    $display("The data written in 0x%0h should be 0x%0h and it is 0x%0h", tb_addr_i, tb_wr_d_i[31:0], tb_rd_d_o[31:0]);
                    ++tmp;
                end
            end
        end
   endtask


//***task automatic test_sim_5***
// Test Write and Read 4 bytes in out of memory positon
// Output should be nothing 
    task automatic test_sim_5;
        output int tmp;
        begin
            tmp = 0;
            tb_addr_i <= 32'hFFFFFFFF; //Out of range

            //Write Process
            wr_mask(4); //Write 4 bytes
            wait(!tb_busy_o);
            tb_wr_d_i <= 32'hDEAD; // Burst of 1 dword (4 bytes)
            write_req();

            //Read Process
            tb_rd_num_dwords_i <= 1;  //Burst of 1 dword (4 bytes)
            tick();
            wait(!tb_busy_o);
            read_req();
            wait(tb_rd_rdy_o);

            //Checking Process
            assert (tb_wr_d_i[31:0] == tb_rd_d_o[31:0])
                    $display("0x%0h : 0x%0h", tb_addr_i, tb_rd_d_o[31:0]);
            else begin
                $display("The data written in 0x%0h should be 0x%0h and it is 0x%0h", tb_addr_i, tb_wr_d_i[31:0], tb_rd_d_o[31:0]);
                ++tmp;
            end
        end
   endtask

//***task automatic test_sim_6***
// Test Write and Read 4 bytes in 10 consecutive memory positon (bursting) 
// Output should be nothing 
    task automatic test_sim_6;
        output int tmp;
        begin
            bit [31:0] wr_data = 32'hABCDEF00; 
            tmp = 0;
            tb_addr_i <= 32'h0;

            //Write Process
            wr_mask(4); //Write 4 bytes each burst
            wait(!tb_busy_o);
            // Bursting
            for (int i = 0; i < 10; i++) begin
                tb_wr_d_i <= wr_data + i;
                write_req();
                wait(tb_burst_wr_rdy_o);
                tick();
            end

            //Read Process
            tb_rd_num_dwords_i <= 6'd10;  //Burst of 10 dword (40 bytes)
            tick();
            wait(!tb_busy_o);
            read_req();
            // Bursting
            for (int i = 0; i < 10; i++) begin
                tick();
                tick();
                $display("Burst %0d:", i);
                wait(tb_rd_rdy_o);
                //Checking Process
                assert ((wr_data + i) == tb_rd_d_o[31:0])
                    $display("0x%0h : 0x%0h", tb_addr_i + i*4, tb_rd_d_o[31:0]);
                else begin
                    $display("The data written in 0x%0h should be 0x%0h and it is 0x%0h", tb_addr_i + i*4, (wr_data + i), tb_rd_d_o);
                    ++tmp;
                end
            end

        end
   endtask

//***task automatic test_sim_7***
// Test Write and Read all memory (bursting) 
// Output should be nothing 
    task automatic test_sim_7;
        output int tmp;
        begin
            bit [31:0] wr_data = 32'h0; 
            tmp = 0;
            tb_addr_i <= 32'h0;

            //Write Process
            wr_mask(4); //Write 4 bytes each burst
            wait(!tb_busy_o);
            // Bursting
            for (int i = 0; i < MEM_SIZE/4; i++) begin
                tb_wr_d_i <= wr_data + i*4;
                write_req();
                wait(tb_burst_wr_rdy_o);
                tick();
            end

            //Read Process
            tb_rd_num_dwords_i <= MEM_SIZE/4;  //Maximum possible read burst 
            tick();
            wait(!tb_busy_o);
            read_req();
            // Bursting
            for (int i = 0; i < MEM_SIZE/4; i++) begin
                tick();
                tick();
                $display("Burst %0d:", i);
                wait(tb_rd_rdy_o);
                //Checking Process
                assert ((wr_data + i*4) == tb_rd_d_o[31:0])
                    $display("0x%0h : 0x%0h", tb_addr_i + i*4, tb_rd_d_o[31:0]);
                else begin
                    $display("The data written in 0x%0h should be 0x%0h and it is 0x%0h", tb_addr_i + i*4, (wr_data + i), tb_rd_d_o);
                    ++tmp;
                end
            end

        end
   endtask

//***init_sim***
//The tasks that compose my testbench are executed here, feel free to add more tasks.
    initial begin
        string arg;
        init_sim();
        init_dump();
        reset_dut();
		$value$plusargs("param1=%s", arg);
        test_sim(arg);
        $finish;
    end


endmodule
`default_nettype wire

