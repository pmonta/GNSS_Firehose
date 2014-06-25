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
h.max2112_init(channel=1, N=N)
h.set_agc(channel=1, val=100)
