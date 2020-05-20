# HyperRAM Controller - Lattice ice40 FPGA iceStick 

Portable Verilog RTL interface to S27KL0641DABHI020 64Mbit HyperRAM IC

This is an open-source RTL project for a simple DWORD burst interface to a Cypress [S27KL0641DABHI020 64Mbit HyperRAM](http://www.cypress.com/part/s27kl0641dabhi020).

# Synthesis

In order to synthesize the maximum frequency as posible:
- Define ASIC on rtl/top.v
- Comment on Makefile: rtl/baudgen.v rtl/baudgen_rx.v rtl/uart_rx.v rtl/uart_tx.v  
- Comment on fpga/blackice-mx.pcf, the UART pins
 
# HyperRAM simulation

To simulate the HyperRAM module of 1.8V at higher speed, check the README of the tb/tb_hyperRAM1_8V folder. 

# iceStick test (HyperRAM 3V)

As in the ice stick test, the module is running at 96Mhz. Since the oscilator 
in the board is og 25Mhz, a PLL and a clock divider have been used to achive the
96MHz clock.

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

Now you can run the ./control.py script from the tb/tb_FPGA folder.
You may need to change the serial port in the script.
This test checks every address up to 1000, then every 100 up to full size of 2097151 (64Mb). 
```
ser.port="/dev/ttyACM0"
```
# Clock modification

If you want to edit the frequency Clock, first you have to edit the baudgen.vh in order to specify the baudrate speed.
Also you have to include an icePLL function (SB_PLL40_CORE) on rtl/top.v , and be careful with the access latencies. 

# Connections

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
