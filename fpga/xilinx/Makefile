# Makefile for Xilinx implementation flow
#
# GNSS Firehose
# Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

DEVICE=xc6slx9-2tqg144

all:
	xst -ifn chip.xst
	ngdbuild -p ${DEVICE} -uc chip.ucf chip.ngc chip.ngd
	map -w -timing -detail -ol high -p ${DEVICE} -o chip_map.ncd chip.ngd chip.pcf
	par -w -ol high chip_map.ncd chip.ncd chip.pcf
	bitgen -g Compress -g ConfigRate:26 -w chip.ncd chip.bit chip.pcf
	promgen -w -spi -p mcs -s 4096 -u 0 chip.bit

prog:
	LD_PRELOAD=~/libusb-driver.so impact -batch impact.cmd

flash:
	LD_PRELOAD=~/libusb-driver.so impact -batch impact_flash.cmd

clean:
	rm -f *~
	rm -rf *.xrpt _xmsgs
	rm -rf *.ngc *.srp xst
	rm -rf xlnx_auto_0_xdb *.ngd netlist.lst *.bld
	rm -rf *.ngm *.pcf *.ncd *_usage.xml *_summary.xml *.mrp *.map
	rm -rf par_usage_statistics.html *.ptwx *_pad.csv *.pad *_pad.txt *.unroutes *.xpi *.par
	rm -rf *.drc *.cwbt *.bit *.bgn *.xwbt usage_statistics_webtalk.html webtalk.log
	rm -rf *.prm *.mcs *.cfi
	rm -rf _impact.cmd _impact.log _impactbatch.log
	rm -rf impact_impact.xwbt impact.xsl webtalk_impact.xml
