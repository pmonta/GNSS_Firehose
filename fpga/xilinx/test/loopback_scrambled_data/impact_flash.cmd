setMode -bs
setCable -port auto
Identify -inferir 
identifyMPM 
assignFile -p 1 -file "chip.bit"
attachflash -position 1 -spi "M25P40"
assignfiletoattachedflash -position 1 -file "chip.mcs"
attachflash -position 1 -spi "M25P40"
Program -p 1 -dataWidth 1 -spionly -e -v -loadfpga 
quit
