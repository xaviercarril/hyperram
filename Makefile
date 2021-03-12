PIN_DEF = fpga/blackice-mx.pcf
DEVICE = hx8k
SRC = rtl/top.v rtl/selectCS.v rtl/hyperram_controller.v rtl/baudgen.v rtl/baudgen_rx.v rtl/uart_rx.v rtl/uart_tx.v 
PORT = /dev/ttyACM0

.PHONY: 

all: top.bin

top.json: $(SRC)
	yosys -q -p  "synth_ice40 -top top -json top.json" $^ 

top.blif: $(SRC)
	yosys -q -p "synth_ice40 -top top -blif top.blif" $^ 

top.txt: $(PIN_DEF) top.json
	nextpnr-ice40 --$(DEVICE) --package tq144:4k --pcf $(PIN_DEF) --json top.json --asc top.txt --freq 50  
	#arachne-pnr -d 8k -P tq144:4k -p $(PIN_DEF) top.blif -o top.txt

top.bin: top.txt
	icepack top.txt top.bin

top.rpt: top.txt
	icetime -d $(DEVICE) -mtr $@ $<

prog: top.bin
	cat top.bin >$(PORT)

debug-ram:
	iverilog -o test tb/hyper_xface_tb.v rtl/hyper_xface.v
	vvp test -fst
	gtkwave test.vcd tb/gtk.gtkw
clean:
	$(RM) -f top.json top.txt top.ex top.bin *.csv test.vcd test top.rpt top.blif

