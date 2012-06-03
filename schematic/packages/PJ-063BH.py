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

# (-4.5mm,-5.0mm) 110 mil
# (+4.5mm,-5.0mm) 110 mil
# (0,-3.0mm) 63 mil
# (0,-6.0mm) 100 mil
# (0,-12.0mm) 125 mil

print 'Element[0x00000000 "" "" "" 0 0 0 0 0 100 0x00000000]'

print '('

pin(-4.5, 5, mil2mm(110), "4")
pin(4.5, 5, mil2mm(110), "5")
pin(0, 3, mil2mm(63), "3")
pin(0, 6, mil2mm(100), "2")
pin(0, 12, mil2mm(125), "1")

print ')'
