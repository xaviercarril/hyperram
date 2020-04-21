#!/bin/bash

echo "Select order: (ex: 231)"
echo "Default: All in sequential order"
echo "1: Write and Read 4 bytes in one memory positon"
echo "2: Write and Read 2 bytes in one memory positon"
echo "3: Write and Read 1 byte in one memory positon"
echo "4: Write and Read 4 bytes in 10 random memory positons"
echo "5: Write and Read 4 bytes in an out of memory positon (This test needs to fail)"
echo "6: Write and Read 4 bytes in 10 consecutive memory positon (bursting)"
echo "7: Write and Read 4 bytes in 240 consecutive memory positon (bursting the maximum as possible)"
echo "8: Write and Read all memory (bursting)"

read var1

if [ -z "$var1" ]
then
    var1=12345678
fi
mv lib_module /tmp

vlib lib_module
vmap work $PWD/lib_module
vlog +acc=rn +incdir+ rtl/tb_wrapper.sv rtl/tb_hyper_xface.sv colors.vh
vmake lib_module/ > Makefile

#vsim work.tb_module -do  "view wave -new" -do "do wave.do" -do "run 20"

if [ -z "$1" ]
then
      vsim work.tb_hyper_xface +param1=$var1 -do "do wave.do" -do "run -all"
else
      vsim work.tb_hyper_xface $1 +param1=$var1 -do "run -all"
fi
