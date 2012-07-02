#!/usr/bin/python

# Program all the resources on the board
#
# GNSS Firehose
# Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

import hw
import time

h = hw.hw()

# set up clock chip
#   VCO: 32*40 == 2560 MHz
#   MAX2112 reference clock:       2560/105 == 24.380952 MHz
#   ADC clock (and also to FPGA):  2560/40  == 64.000000 MHz

h.clock_init(vco_div=32, max2112_div=105, adc_div=40)
time.sleep(1)
print 'LMK03806: max2112_div 105, adc_div 40, locked: %d' % h.clock_locked()

# set up ADC chips

h.adc_init(channel=1)
#h.adc_init(channel=2)
h.adc_init(channel=3)
h.adc_init(channel=4)

# set up PHY timing modifications

#fixme: reset PHY here?
h.phy_smi_write_extended(28,0xf000)

# tune the MAX2112 downconverters

h.max2112_init(channel=1, N=65) # L1
#h.max2112_init(channel=1, N=51) # L2
#h.max2112_init(channel=1, N=49) # L5

#h.max2112_init(channel=2, N=65) # L1
#h.max2112_init(channel=2, N=51) # L2
#h.max2112_init(channel=2, N=49) # L5

#h.max2112_init(channel=3, N=65) # L1
h.max2112_init(channel=3, N=51) # L2
#h.max2112_init(channel=3, N=49) # L5

# set AGC

h.set_agc(channel=1, val=220)
#h.set_agc(channel=2, val=)
h.set_agc(channel=3, val=220)
