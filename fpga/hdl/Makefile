ICARUS_SUFFIX =
IVERILOG = iverilog$(ICARUS_SUFFIX)
VVP = vvp$(ICARUS_SUFFIX)
IVL_FLAGS = -Wall -Wno-timescale
GTKWAVE = gtkwave

%_tb: %_tb.v
	$(IVERILOG) $(IVL_FLAGS) $^ -o $@

%.vcd: %_tb
	$(VVP) -N $<

%_view: %.vcd %.gtkw
	$(GTKWAVE) $^

SUB_V = activity.v crc.v packet_rx.v picorv32_soc.v pwm.v ram.v reset_gen.v uart.v \
  cpu.v histogram.v packet_streamer.v picorv32.v quantize.v random.v

all: top_check packet_rx.vcd

top_check: top.v $(SUB_V)
	$(IVERILOG) -o $@ -Wall -Wno-timescale -DSIMULATE $<

packet_rx_tb: packet_rx.v ram.v

clean:
	rm -f top_check *_tb *.vcd
