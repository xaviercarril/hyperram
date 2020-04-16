$1
CYCLES=200000000
BASE_DIR="."
RTL="${BASE_DIR}/rtl"

rm -rf lib_module

vlib lib_module
vmap work $PWD/lib_module
vlog +acc=rn +incdir+. $RTL/tb_top.sv
vmake lib_module/ > Makefile

#vsim work.tb_icache_interface -do  "view wave -new" -do "do wave.do" -do "run 20"

if [ -z "$1" ]
then
      vsim work.top -c +param1=4 -do "run $CYCLES"  #-t ns #-do "view wave -new"
else
      vsim work.top +param1=$1 -do "do wave.do" -do "run $CYCLES" #-t ns
fi

