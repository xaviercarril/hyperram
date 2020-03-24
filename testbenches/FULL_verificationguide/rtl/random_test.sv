//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
import env::environment 
`include "environment.sv"
program test(interface intf);
  
  //declaring environment instance
  environment enviro;
  
  initial begin
    //creating environment
    enviro = new(intf);
    
    //setting the repeat count of generator as 4, means to generate 4 packets
    enviro.gen.repeat_count = 4;
    
    //calling run of env, it interns calls generator and driver main tasks.
    enviro.run();
  end
endprogram
