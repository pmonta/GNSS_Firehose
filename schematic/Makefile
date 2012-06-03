SCH=firehose_00_overview.sch \
    firehose_01_ch1.sch \
    firehose_02_ch2.sch \
    firehose_03_ch3.sch \
    firehose_04_ch4.sch \
    firehose_05_clock.sch \
    firehose_06_fpga.sch \
    firehose_07_ethernet.sch \
    firehose_08_power.sch

DEST=../pcb

all:
	refdes_renum $(SCH)
	gsch2pcb --skip-m4 -o $(DEST)/board $(SCH)
