#!/usr/bin/python

# Semi-automatic AGC.  Sweep the gain-control setting, looking for the right 4-level histogram
#
# GNSS Firehose
# Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

import hw
import os
import string
import time

h = hw.hw()

def read_hist(fname):
  f = open('/tmp/agc.hist','r');
  r = f.readline()
  r = r[:-1]
#  print 'read_hist: %s' % r
  x = string.split(r,' ')
#  print x
  hist = [float(x[0]),float(x[1]),float(x[2]),float(x[3]),float(x[8]),float(x[9]),float(x[10]),float(x[11])]
  f.close()
  return hist

for channel in [1,3]:
  time.sleep(1)
  if channel==1:
    packet_channel = 0
  else:
    packet_channel = 1
  ratio = 1
  for val in range(0,450,2):
    h.set_agc(channel=channel, val=val)
    os.system('tcpdump -i p37p1 -c 200 -n -w /tmp/agc.tcpdump ether proto 0x9800 >/dev/null 2>/dev/null')
    os.system('./tcpdump_hist_2ch_2bits %d </tmp/agc.tcpdump >/tmp/agc.hist' % packet_channel)
    hist = read_hist('/tmp/agc.hist')
    ratio = hist[0]/hist[1]
    if ratio<0.5:
      print 'channel_%d: agc_%d: histogram %s' % (channel,val,`hist`)
      break
