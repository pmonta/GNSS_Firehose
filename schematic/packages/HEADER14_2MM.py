def mm2pcb(x):
  return int(round((x/25.4)*1000*100))

def mil2mm(x):
  return (x/1000.0)*25.4

# x y thickness clearance mask drill "name" "number" sflags

def pin(x,y,drill,name):
  thick = drill + mil2mm(20)
  clear = mil2mm(20)
  mask = thick + mil2mm(10)
  print '\tPin[%d %d %d %d %d %d \"%s\" \"%s\" 0x00000000]' % (mm2pcb(x),mm2pcb(y),mm2pcb(thick),mm2pcb(clear),mm2pcb(mask),mm2pcb(drill),name,name)

print 'Element[0x00000000 "" "" "" 0 0 0 0 0 100 0x00000000]'

print '('

for j in range(7):
  for i in range(2):
    pin(2*j, 2*(2-i), 0.9, "%d"%(2*j+i+1))

print ')'
