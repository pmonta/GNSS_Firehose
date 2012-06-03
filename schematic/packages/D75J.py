def pad(x1,y1,x2,y2):
  print "%d %d %d %d" % (int(round(100000*x1)),int(round(100000*(0.215-y1))),int(round(100000*x2)),int(round(100000*(0.215-y2))))

cx = 0.295/2
cy = 0.215/2

t0 = 0.03
h0 = 0.051

for x in [cx-0.05,cx,cx+0.05]:
  pad(x, h0-t0/2, x, t0/2)

for x in [cx+0.05,cx,cx-0.05]:
  pad(x, 2*cy-h0+t0/2, x, 2*cy-t0/2)

t0 = 0.037
h0 = 0.051

yy = 2*cy-0.1

for y in [cy-0.05,cy+0.05]:
  pad(2*cx-h0+t0/2, y, 2*cx-t0/2, y)

for y in [cy+0.05,cy-0.05]:
  pad(t0/2, y, h0-t0/2, y)

