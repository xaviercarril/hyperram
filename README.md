# hyperram

Portable Verilog RTL interface to S27KL0641DABHI020 64Mbit HyperRAM IC

This is an open-source RTL project for a simple DWORD burst interface to a Cypress [S27KL0641DABHI020 64Mbit HyperRAM](http://www.cypress.com/part/s27kl0641dabhi020).

# ice stick test

For higher speeds, the memory needs latency configuration. This test is at 12Mhz, so the default latencies are plenty and no configuration is performed.

run make prog to synthesise and program onto an attached icestick.

then run ./control.py to test the ram

# BlackIce Mx

As in the ice stick test, the module is running at 12Mhz. Since the oscilator 
in the board is og 25Mhz, a PLL and a clock divider have been used to achive the
12MHz clock.

Type ```make all``` to compile the bitstream.

Remember to have a terminal open where cat /dev/ttyACX is running, otherwise yo
will not be able to flash the FPGA. Close it after flashing the bitstream,
otherwise the python script for testing the IP will not work.
```
stty -F /dev/ttyACM0 raw -echo
cat /dev/ttyACM0
```

I used a 1bitsquared HyperRAM pmod adapter. It shall be connected to MX2 (Side
closest to R4 and R9).

Once the previous step is done load the design into the FPGA:
```
make prog
```

Now you can run the ./control.py script from the software folder software.
You may need to change the serial port in the script.
```
ser.port="/dev/ttyACM0"
```
# clock modification

If you want to edit the frequency Clock, first you have to edit the baudgen.vh in order to specify the baudrate speed.

## test results

* tested every address up to 100000, then every 100 up to full size of 2000000

# connections

I used a 1bitsquared HyperRAM pmod adapter. It shall be connected to MX2 (Side
closest to R4 and R9).

no pullups or pulldowns on any lines - just straight through.

Note that even at 12Mhz you can have problems of signal integrity if you add a
mixmod tester adaptor, so it is not recommended.

# PCB 

Also included is a dual-PMOD PCB adapter design.

![pinout](images/pinout.png)

@OSHPark Shared Project: https://oshpark.com/shared_projects/oZ3pCvob

Kevin Hubbard - Black Mesa Labs 2018.04.28
