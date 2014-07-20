# x y thickness clearance mask drill "name" "number" sflags

def pin(x,y,drill,name):
  thick = drill + 20
  clear = 20
  mask = thick + 10
  y = y - 550
  (x,y,thick,clear,mask,drill) = (100*x,100*y,100*thick,100*clear,100*mask,100*drill)
  print '\tPin[%d %d %d %d %d %d \"%s\" \"%s\" 0x00000000]' % (x,y,thick,clear,mask,drill,name,name)

print 'Element[0x00000000 "" "" "" 0 0 0 0 0 100 0x00000000]'

print '('

for p in range(10):
  x = 450 - 50*p
  if ((p%2)==0):
    y = 0
  else:
    y = -100
  pin(x, y, 35, "%d"%(p+1))

pin(10, -290, 40, "11")
pin(110, -290, 40, "12")
pin(340, -290, 40, "13")
pin(440, -290, 40, "14")

pin(-80, 130, 62, "15")
pin(530, 130, 62, "16")

pin(0, 250, 128, "17")
pin(450, 250, 128, "18")

print ')'
