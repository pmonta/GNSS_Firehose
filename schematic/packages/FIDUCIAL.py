from util import *

print 'Element[0x00000000 "" "" "" 0 0 0 0 0 60 0x00000000]'
print '('

pad_mm(0,0,1.0,1.0,"1",clear=1.5,mask=1.0,flags="nopaste")
pad_mm(0,0,1.0,1.0,"2",clear=1.5,mask=1.0,flags="nopaste,onsolder")

print ')'
