#!/usr/bin/python

# Misc ad-hoc settings at run-time
#
# GNSS Firehose
# Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

import hw

h = hw.hw()

f_tcxo = 38.88
vco_div = 62
max2112_div = 70
adc_div = 35
N=46

f_vco = f_tcxo*vco_div
f_ref = f_vco/max2112_div
f_adc = f_vco/adc_div

#h.clock_init(vco_div=vco_div, max2112_div=max2112_div, adc_div=adc_div)
h.adc_init(channel=1)
h.max2112_init(channel=1, N=46)
#h.max2112_init(channel=1, N=36)
#h.set_agc(channel=1, val=110)
h.set_agc(channel=1, val=270)
#h.set_agc(channel=1, val=310)

def mmd_read(h,dev,addr):
  h.phy_smi_write(0xd,dev)
  h.phy_smi_write(0xe,addr)
  h.phy_smi_write(0xd,0x4000+dev)
  return h.phy_smi_read(0xe)

def mmd_write(h,dev,addr,data):
  h.phy_smi_write(0xd,dev)
  h.phy_smi_write(0xe,addr)
  h.phy_smi_write(0xd,0x4000+dev)
  h.phy_smi_write(0xe,data)

mmd_write(h,2,0,0x0018)
