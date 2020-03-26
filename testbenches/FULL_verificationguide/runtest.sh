$1
CYCLES=80
BASE_DIR="."
RTL="${BASE_DIR}/rtl"

rm -rf lib_module 

vlib lib_module
vmap work $PWD/lib_module
vlog +acc=rn +incdir+. $RTL/top.sv 
vmake lib_module/ > Makefile

#vsim work.tb_icache_interface -do  "view wave -new" -do "do wave.do" -do "run 20"

if [ -z "$1" ]
then
      vsim work.top -do "do wave.do" -do "run $CYCLES"  #-do "view wave -new" 
else
      vsim work.top $1 -do "run $CYCLES" -t ns
fi

