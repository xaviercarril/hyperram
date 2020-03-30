`include "environment.sv"

/*---------------------[TYPE OF ACCESS]------------------------------*/
//Uncomment one and comment the rest

//`define 4BYTE
//`define 2BYTE
`define 1BYTE

/*-------------------------------------------------------------------*/
program test(mem_intf intf);

	class my_trans extends transaction;
		bit [31:0] count;
		function void pre_randomize();
			wr_req.rand_mode(0);
			rd_req.rand_mode(0);
			addr.rand_mode(0);
			`ifdef 4BYTE
				wr_byte_en = 4'b1111; //write 4 bytes
			`elsif 2BYTE
				wr_byte_en = 4'b0011; //write 2 bytes
      		`else
				wr_byte_en = 4'b0001; //write 1 byte
			`endif
		
			if(cnt %2 == 0) begin
				wr_req = 1;
				rd_req = 0;
				addr  = count;
			end 
			else begin
				wr_req = 0;
				rd_req = 1;
				addr  = count;
				`ifdef 4BYTE
					count = count + 3'b100; //aligened to 4
				`elsif 2BYTE
					count = count + 3'b010; //aligened to 2
				`else
					count = count + 3'b001; //aligened to 1
				`endif
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
