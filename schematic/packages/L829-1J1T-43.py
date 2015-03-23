# x y thickness clearance mask drill "name" "number" sflags

def pin(x,y,drill,name):
  thick = drill + 20
  clear = 20
  mask = thick + 10
  (x,y,thick,clear,mask,drill) = (100*x,-100*y,100*thick,100*clear,100*mask,100*drill)
  print '\tPin[%d %d %d %d %d %d \"%s\" \"%s\" 0x00000000]' % (x,y,thick,clear,mask,drill,name,name)

def line(x1,y1,x2,y2):
  print '\tElementLine[%d %d %d %d 1000]' % (100*x1,-100*y1,100*x2,-100*y2)

def rectangle(x1,y1,x2,y2):
  line(x1,y1,x2,y1)
  line(x2,y1,x2,y2)
  line(x2,y2,x1,y2)
  line(x1,y2,x1,y1)

print 'Element[0x00000000 "" "" "" 0 0 0 0 0 100 0x00000000]'

print '('

pin(-200,-260,35,"1")
pin(-120,-260,35,"2")
pin(-40,-260,35,"3")
pin(40,-260,35,"4")
pin(120,-260,35,"5")
pin(200,-260,35,"6")
pin(-240,-360,35,"7")
pin(-160,-360,35,"8")
pin(-80,-360,35,"9")
pin(80,-360,35,"10")
pin(160,-360,35,"11")
pin(240,-360,35,"12")

pin(-592/2, 250, 50, "13")
pin(-592/2, 350, 50, "14")

pin(592/2, 150, 50, "15")
pin(592/2, 250, 50, "16")
pin(592/2, 350, 50, "17")

pin(-692/2, 0, 62, "18")
pin(692/2, 0, 62, "19")

pin(-380/2, 0, 128, "20")
pin(380/2, 0, 128, "21")

rectangle(-692/2, -425, 692/2, 520)

print ')'
