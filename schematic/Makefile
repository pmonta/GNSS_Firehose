SCH=firehose_00_overview.sch \
    firehose_01_ch1.sch \
    firehose_02_ch2.sch \
    firehose_03_ch3.sch \
    firehose_04_ch4.sch \
    firehose_05_clock.sch \
    firehose_06_fpga.sch \
    firehose_07_ethernet.sch \
    firehose_08_power.sch \
    firehose_09_mechanical.sch

DEST=../pcb

all:
	refdes_renum $(SCH)
	gsch2pcb --skip-m4 -o $(DEST)/board $(SCH)

bom:
	gnetlist -g bom2 $(SCH) -Oattribs=value,footprint,device -o firehose.bom

pdf:
	rm -f schematic.ps
	for i in $(SCH); do \
		echo gschem -o temp.ps -s print.scm $$i ; \
		gschem -o temp.ps -s print.scm $$i ; \
		cat temp.ps >>schematic.ps ; \
	done
	ps2pdf schematic.ps GNSS_Firehose_schematic.pdf
	cp GNSS_Firehose_schematic.pdf ../doc
	rm -f temp.ps
	rm -f schematic.ps
