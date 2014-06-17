#!/usr/bin/python

# Misc ad-hoc settings at run-time
#
# GNSS Firehose
# Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

import time
import hw
import sys

h = hw.hw()

f_tcxo = 38.88
vco_div = 64
max2112_div = 76
adc_div = 38
N=48

#f_tcxo = 38.88
#vco_div = 64
#max2112_div = 105
#adc_div = 40
#N=66

#f_tcxo = 38.88
#vco_div = 65
#max2112_div = 91
#adc_div = 37
#N=57

#f_tcxo = 38.88
#vco_div = 64
#max2112_div = 106
#adc_div = 37
#N=67

f_vco = f_tcxo*vco_div
f_ref = f_vco/max2112_div
f_adc = f_vco/adc_div

#h.clock_init(vco_div=vco_div, max2112_div=max2112_div, adc_div=adc_div)
h.max2112_init(channel=1, N=N)
h.set_agc(channel=1, val=500)
sys.exit()

#h.set_agc(channel=1, val=250)
#sys.exit()

# tune downconverters
#
#h.max2112_init(channel=1, N=65) # L1
#h.max2112_init(channel=3, N=65) # L1
#h.max2112_init(channel=3, N=65)
#h.max2112_init(channel=1, N=50) # L250
#h.max2112_init(channel=3, N=50) # L250
#h.max2112_init(channel=1, N=49) # L5
#h.max2112_init(channel=3, N=49) # L5

h.max2112_init(channel=1, N=65)
h.max2112_init(channel=3, N=49)

# set AGC
#
#h.set_agc(channel=1, val=225)
#h.set_agc(channel=2, val=)
#h.set_agc(channel=3, val=225)

# print PHY registers
#
#for addr in xrange(0,32):
#  print '0x%04x' % h.phy_smi_read(addr)




#h.i2c_init(1)
#h.i2c_init(3)

#print 'channel 1:'
#h.max2112_dump(1)
#print 'channel 3:'
#h.max2112_dump(3)

## set max2112 baseband filter
#h.i2c_write(1,8,33)
#h.i2c_write(3,8,33)

#h.histogram_dump()

## set max2112 baseband gain to 0 dB
#h.i2c_write(1,9,0)
#h.i2c_write(3,9,0)

#time.sleep(1)
#h.histogram_dump()

## set max2112 baseband gain to 15 dB
#h.i2c_write(1,9,15)
#h.i2c_write(3,9,15)

#time.sleep(1)
#h.histogram_dump()

#print 'channel 1:'
#h.max2112_dump(1)
#print 'channel 3:'
#h.max2112_dump(3)
