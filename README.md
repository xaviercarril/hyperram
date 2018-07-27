# hyperram

Portable Verilog RTL interface to S27KL0641DABHI020 64Mbit HyperRAM IC

This is an open-source RTL project for a simple DWORD burst interface to a Cypress [S27KL0641DABHI020 64Mbit HyperRAM](http://www.cypress.com/part/s27kl0641dabhi020).

# ice stick test

For higher speeds, the memory needs latency configuration. This test is at 12Mhz, so the default latencies are plenty and no configuration is performed.

run make prog to synthesise and program onto an attached icestick.

then run ./control.py to test the ram

## test results

* tested every address up to 100000, then every 100 up to full size of 2000000

Initial tests failed because wires between hyperram module and icestick were [too long](https://twitter.com/bml_khubbard/status/1022484444068757505).

# connections

see icestick.pcf for connections. I'm plugging the adapter into the pmod port and wiring 6 wires from the other side. See [picture](images/icestick.jpg)

no pullups or pulldowns on any lines - just straight through.

# PCB 

Also included is a dual-PMOD PCB adapter design.

![pinout](images/pinout.png)

@OSHPark Shared Project: https://oshpark.com/shared_projects/oZ3pCvob

Kevin Hubbard - Black Mesa Labs 2018.04.28
