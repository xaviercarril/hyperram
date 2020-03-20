$1
CYCLES=80
BASE_DIR="."
RTL="${BASE_DIR}/rtl"

mv lib_module /tmp

vlib lib_module
vmap work $PWD/lib_module
vlog +acc=rn +incdir+ $RTL/*.sv
vmake lib_module/ > Makefile

#vsim work.tb_icache_interface -do  "view wave -new" -do "do wave.do" -do "run 20"

if [ -z "$1" ]
then
      vsim work.tb_icache_interface -do "view wave -new" -do "do wave.do" -do "run $CYCLES"
else
      vsim work.tb_icache_interface $1 -do "run $CYCLES"
fi

