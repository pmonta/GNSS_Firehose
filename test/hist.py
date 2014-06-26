#!/usr/bin/python

import hw
import time

h = hw.hw()

#h.set_agc(channel=1, val=206)
#h.set_agc(channel=2, val=)
#h.set_agc(channel=3, val=230)

print 'histograms: ',h.read(20), h.read(21), h.read(22), h.read(23), h.read(24), h.read(25)
print 'gc values: ',h.read_scratchpad(0), h.read_scratchpad(1), h.read_scratchpad(2), h.read_scratchpad(3), h.read_scratchpad(4), h.read_scratchpad(5)

ch1_sum_i = h.read(35)
if ch1_sum_i>127:
  ch1_sum_i = ch1_sum_i - 256

ch1_sum_q = h.read(36)
if ch1_sum_q>127:
  ch1_sum_q = ch1_sum_q - 256

print 'dc values: ',ch1_sum_i,ch1_sum_q

print 'DCM locked: ',h.read(43)
