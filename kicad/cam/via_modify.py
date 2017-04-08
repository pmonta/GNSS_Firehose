#!/usr/bin/python

import sys
import re
import string
import os

#
# change all 28/26 mil vias to 16/14 mil
#

def modify_28mil(x):
  p = re.compile("%ADD(\d+)C,0.711200\*%\n")
  m = p.match(x)
  if m:
    y = string.replace(x,'0.711200','0.406400')
    sys.stderr.write('%s  --->  %s\n' % (x[:-1],y[:-1]))
    return y
  else:
    return x

def modify_26mil(x):
  p = re.compile("%ADD(\d+)C,0.660400\*%\n")
  m = p.match(x)
  if m:
    y = string.replace(x,'0.660400','0.355600')
    sys.stderr.write('%s  --->  %s\n' % (x[:-1],y[:-1]))
    return y
  else:
    return x

filename = sys.argv[1]
fp = open(filename,"r")
fp_out = open("temp.gbr","w")

while True:
  x = fp.readline()
  if not x:
    break
  x = modify_28mil(x)
  x = modify_26mil(x)
  fp_out.write(x)
    
fp.close()
fp_out.close()

os.system('rm %s'%filename)
os.system('mv temp.gbr %s'%filename)
