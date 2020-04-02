`include "environment.sv"

program test(mem_intf intf);

	class my_trans extends transaction;
		
		bit [31:0] count;
		integer n_byte;

		function void pre_randomize();
			$value$plusargs("param1=%d", n_byte);
			wr_req.rand_mode(0);
			rd_req.rand_mode(0);
			addr.rand_mode(0);
			if (n_byte == 4) 	
				wr_byte_en = 4'b1111; //write 4 bytes
			else if (n_byte == 2)
				wr_byte_en = 4'b0011; //write 2 bytes
      		else if (n_byte == 1)
				wr_byte_en = 4'b0001; //write 1 byte
			else begin
				$display("Number of byte access invalid: %d bytes. Only can be 4/2/1 byte.\nExecution failed", n_byte);
				$finish;
			end
		
			if(cnt %2 == 0) begin
				wr_req = 1;
				rd_req = 0;
				addr  = count;
			end 
			else begin
				wr_req = 0;
				rd_req = 1;
				addr  = count;
				if (n_byte == 4) 	
					count = count + 3'b100; //aligned to 4
				else if (n_byte == 2)
					count = count + 3'b010; //aligned to 2
				else
					count = count + 3'b001; //aligned to 1
			end
	      	cnt++;
	   	endfunction
	endclass

//declaring environment instance
	environment env;
	my_trans my_tr;
	initial begin
    	//creating environment
    	env = new(intf);
    
    	my_tr = new();
    
    	//setting the repeat count of generator 
    	env.gen.repeat_count = 10;
    
    	env.gen.trans = my_tr;
    
    	//calling run of env, it interns calls generator and driver main tasks.
	    env.run();
	end
endprogram
