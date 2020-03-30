`include "environment.sv"
program test(mem_intf intf);
  
  class my_trans extends transaction;
    
    bit [31:0] count;
    
    function void pre_randomize();
      wr_req.rand_mode(0);
      rd_req.rand_mode(0);
      addr.rand_mode(0);
	  wr_byte_en = 4'hF; //write 4 bytes
            
      if(cnt %2 == 0) begin
        wr_req = 1;
        rd_req = 0;
        addr  = count;      
      end 
      else begin
        wr_req = 0;
        rd_req = 1;
        addr  = count;
        count = count + 3'b100; //aligened to 4
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
    
    //setting the repeat count of generator as 4, means to generate 4 packets
    env.gen.repeat_count = 10;
    
    env.gen.trans = my_tr;
    
    //calling run of env, it interns calls generator and driver main tasks.
    env.run();
  end
endprogram
