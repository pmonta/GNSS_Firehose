setMode -bs
setCable -port auto
Identify -inferir 
identifyMPM 
assignFile -p 1 -file "/home/pmonta/gps-front-end/fpga/xilinx/chip.bit"
Program -p 1
quit
