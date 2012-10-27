#!/usr/bin/python

import hw
import time

h = hw.hw()

h.set_agc(channel=1, val=206)
##h.set_agc(channel=2, val=)
h.set_agc(channel=3, val=230)

print h.read(20), h.read(21), h.read(22), h.read(23), h.read(24), h.read(25)
time.sleep(1)
print h.read(20), h.read(21), h.read(22), h.read(23), h.read(24), h.read(25)
time.sleep(1)
