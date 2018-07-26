# hyperram
Portable Verilog RTL interface to S27KL0641DABHI020 64Mbit HyperRAM IC

This is an open-source RTL project for a simple DWORD burst interface to a Cypress [S27KL0641DABHI020 64Mbit HyperRAM](http://www.cypress.com/part/s27kl0641dabhi020).

# ice stick test

run make prog to synthesise and program onto an attached icestick.

then run ./control.py to test the first 100 addresses

currently fails at address 98 most of the time. 

If only a read is done, the test passes. If a write is done first, the test most often fails.

The scope shows the data is real, so maybe it's reading from an unwanted address.

I can't see the difference between a good read and a bad read.


# PCB 

Also included is a dual-PMOD PCB adapter design.

![pinout](images/pinout.png)

@OSHPark Shared Project: https://oshpark.com/shared_projects/oZ3pCvob

Kevin Hubbard - Black Mesa Labs 2018.04.28
