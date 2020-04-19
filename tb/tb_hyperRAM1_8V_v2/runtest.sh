#!/bin/bash

echo "Which test will you want to prove?"
echo "0: All"
echo "1: Write and Read 4 bytes in one memory positon"
read var1
echo "Test $var1 selected"


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
