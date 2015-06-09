w=0.4;

module exterior() {
  linear_extrude(height=4.5, center=false) {
    polygon(points=[[0-w,0-w],[15+w,0-w],[15+w,7.5+w/2],[11.5+w/2,11+w],[0-w,11+w]]);
  }
}

module interior() {
  translate([0,0,-1]) {
    linear_extrude(height=4.5, center=false) {
      polygon(points=[[0+w,0+w],[15-w,0+w],[15-w,7.5-w/2],[11.5-w/2,11-w],[0+w,11-w]]);
    }
  }
}

module cap() {
  difference() {
    exterior();
    interior();
  }
}

for (i=[0:2])
  for (j=[0:1])
    translate([i*20,j*17,0])
      cap();
