//gets the packet from monitor, Generated the expected result and compares with the //actual result recived from Monitor

class scoreboard;
	//creating mailbox handle
	mailbox mon2scb;
  	
	//used to count the number of transactions
  	int no_transactions;
	
	//counter num pass and fail 
	int num_pass;
	int num_fail; 
  	//array to use as local memory
	bit [31:0] mem[bit[31:0]];
  
	//constructor
	function new(mailbox mon2scb);
		//getting the mailbox handles from  environment 
		this.mon2scb = mon2scb;
	  	foreach(mem[i]) mem[i] = 8'hFF;
	endfunction
  
  	//stores wdata and compare rdata with stored data
  	task main;
    	transaction trans;
	    forever begin
			#50;
			mon2scb.get(trans);
			if(trans.rd_req) begin
				case (trans.wr_byte_en)
					4'b1111: //4 Bytes Access
					begin
						if(mem[trans.addr] != trans.rdata) begin 
          					$error("[SCB-FAIL] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.addr,mem[trans.addr],trans.rdata);
							num_fail++;
						end
       					else begin 
          					$display("[SCB-PASS] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.addr,mem[trans.addr],trans.rdata);
							num_pass++;
						end
      				end
					4'b0011: //2 Bytes Access
					begin
						if(mem[trans.addr][15:0] != trans.rdata[15:0]) begin 
          					$error("[SCB-FAIL] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.addr,mem[trans.addr][15:0],trans.rdata[15:0]);
							num_fail++;
						end
	       				else begin 
    	      				$display("[SCB-PASS] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.addr,mem[trans.addr][15:0],trans.rdata[15:0]);
							num_pass++;
						end
	      			end
					4'b0001: //1 Byte Access
					begin
						if(mem[trans.addr][7:0] != trans.rdata[7:0]) begin
		          			$error("[SCB-FAIL] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.addr,mem[trans.addr][7:0],trans.rdata[7:0]);
							num_fail++;
						end
		       			else begin 
		          			$display("[SCB-PASS] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.addr,mem[trans.addr][7:0],trans.rdata[7:0]);
							num_pass++;
						end
		      		end
				endcase
			end
			else if(trans.wr_req)
				mem[trans.addr] = trans.wdata;
	
			no_transactions++;
		end
	endtask
  
endclass
