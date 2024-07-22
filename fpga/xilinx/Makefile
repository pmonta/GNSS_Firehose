# Makefile for Xilinx implementation flow
#
# GNSS Firehose
# Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

DEVICE=xc6slx9-2tqg144

all: chip.bit

chip.ncd:
	xst -ifn chip.xst
	ngdbuild -p ${DEVICE} -bm chip.bmm -uc chip.ucf chip.ngc chip.ngd
	map -w -timing -detail -ol high -p ${DEVICE} -o chip_map.ncd chip.ngd chip.pcf
	par -w -ol high chip_map.ncd chip.ncd chip.pcf

chip.bit: ../firmware/firmware.elf chip.ncd
	bitgen -g Compress -g ConfigRate:26 -bd ../firmware/firmware.elf -w chip.ncd chip.bit chip.pcf

prog:
	LD_PRELOAD=~/libusb-driver.so impact -batch impact.cmd

flash:
	promgen -w -spi -p mcs -s 4096 -u 0 chip.bit
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
	rm -f chip.edif ngc2edif.log
	rm -f chip_map.twr chip_map.twx
	rm -f chip_bd.bmm
