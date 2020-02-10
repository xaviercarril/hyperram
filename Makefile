PROJ = hyperram
PIN_DEF = fpga/blackice-mx.pcf 
#DEVICE = hx8k

SRC = rtl/top.v rtl/hyper_xface.v rtl/baudgen.v rtl/baudgen_rx.v rtl/uart_rx.v rtl/uart_tx.v 


.PHONY: all
all: top.bin

top.json: $(SRC)
	yosys -q -p "synth_ice40 -json top.json" $^ 

top.asc: $(PIN_DEF) top.json
	nextpnr-ice40 --hx8k --package tq144:4k --pcf fpga/blackice-mx.pcf  --json top.json --asc top.txt --freq 25

top.bin: top.asc
	icepack top.txt top.bin

top.rpt: top.asc
	icetime -d $(DEVICE) -mtr $@ $<

prog: top.bin
	cat top.bin >/dev/ttyACM0

debug-serial:
	iverilog -o test serial_recv_tb.v uart_tx.v baudgen.v
	vvp test -fst
	gtkwave test.vcd gtk-serial.gtkw

debug-ram:
	iverilog -o test hyper_xface_tb.v hyper_xface.v
	vvp test -fst
	gtkwave test.vcd gtk.gtkw

.PHONY: clean
clean:
	$(RM) -f top.json top.txt top.ex top.bin *.csv

.SECONDARY:
.PHONY: all prog clean
