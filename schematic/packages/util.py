def pin_mil(x,y,drill,outer,name):
  thick = outer
  clear = 20
  mask = thick + 10
  print '\tPin[%fmil %fmil %fmil %fmil %fmil %fmil \"%s\" \"%s\" 0x00000000]' % (x,y,thick,clear,mask,drill,name,name)

def pad2trace(x,y,dx,dy):
  if dy>dx:
    thick = dx
    x1,x2 = x,x
    y1 = y - dy/2.0 + thick/2.0
    y2 = y + dy/2.0 - thick/2.0
  else:
    thick = dy
    y1,y2 = y,y
    x1 = x - dx/2.0 + thick/2.0
    x2 = x + dx/2.0 - thick/2.0
  return x1,y1,x2,y2,thick

def mil2mm(x):
  return (x/1000.0)*25.4

def pad_mm(x,y,dx,dy,name,clear=mil2mm(20),mask=mil2mm(10),flags="square"):
  x1,y1,x2,y2,thick = pad2trace(x,y,dx,dy)
  mask = mask + thick
  print '\tPad[%fmm %fmm %fmm %fmm %fmm %fmm %fmm \"%s\" \"%s\" \"%s\"]' % (x1,y1,x2,y2,thick,clear,mask,name,name,flags)
