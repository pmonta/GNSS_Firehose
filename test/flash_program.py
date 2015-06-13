#!/usr/bin/python

import hw
import sys

h = hw.hw()

mac_string = sys.argv[1]

h.spi_sector_erase()
for i in range(6):
  byte = int('0x'+mac_string[3*i:3*i+2],16)
  h.spi_write(0x7ff00+i,byte)

#h.spi_dump()
#h.spi_status()
