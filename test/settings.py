#!/usr/bin/python

# Misc ad-hoc settings at run-time
#
# GNSS Firehose
# Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

import hw

h = hw.hw()

# tune downconverters
#
#h.max2112_init(channel=1, N=65) # L1
#h.max2112_init(channel=3, N=65) # L1
#h.max2112_init(channel=3, N=65)
#h.max2112_init(channel=1, N=50) # L250
#h.max2112_init(channel=3, N=50) # L250
#h.max2112_init(channel=1, N=49) # L5
#h.max2112_init(channel=3, N=49) # L5

#h.max2112_init(channel=1, N=65)
#h.max2112_init(channel=3, N=51)

# set AGC
#
h.set_agc(channel=1, val=225)
#h.set_agc(channel=2, val=)
h.set_agc(channel=3, val=225)

# print PHY registers
#
#for addr in xrange(0,32):
#  print '0x%04x' % h.phy_smi_read(addr)
