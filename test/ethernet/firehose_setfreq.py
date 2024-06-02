#!/usr/bin/python

import firehose_hw
import sys
import numpy as np

mac_addr = sys.argv[1]
interface = sys.argv[2]
channel = int(sys.argv[3])
freq_mhz = float(sys.argv[4])

if freq_mhz<950.0 or freq_mhz>2150.0:
  sys.stdout.write("frequency out of range\n")
  sys.exit()

f = firehose_hw.firehose(interface=interface, mac_addr=mac_addr)

def max2112_init(channel,freq_mhz):
  f_ref = 69984000//2
  r = (freq_mhz)*1000000.0/f_ref
  N = np.floor(r).astype('int')
  F = np.round(1048576*(r-N)).astype('int')
  sys.stdout.write("channel %d: int %d frac %d\n" % (channel,N,F))
  f.max2112_write_reg(channel,5,0x02)
  f.max2112_write_reg(channel,6,0x40)
  f.max2112_write_reg(channel,7,0xcc)
  f.max2112_write_reg(channel,8,0x5c)
  f.max2112_write_reg(channel,9,0x07)
  f.max2112_write_reg(channel,10,0x00)
  f.max2112_write_reg(channel,11,0x08)
  f.max2112_write_reg(channel,1,N)
  f.max2112_write_reg(channel,2,0x10|((F>>16)&0xf))
  f.max2112_write_reg(channel,3,(F>>8)&0xff)
  f.max2112_write_reg(channel,4,F&0xff)
  f.max2112_write_reg(channel,0,0x80)

max2112_init(channel,freq_mhz)
