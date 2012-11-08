// Enclosure for GNSS Firehose board, bottom piece
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>


//
// wall cutouts for connectors
//

module cutout(x,y)
{ translate([0,-y/2,0]) cube([x,y,100]); }

//
// bosses for screws
// 1.5 mm hole (suitable for UNC #4 or M2.5), 1.4 mm annulus
//

module boss(x)
{ difference () {
    cylinder(h=x,r=2.9,center=false);
    cylinder(h=x,r=1.5,center=false);
  }
}

//
// ribs in y and x directions
// 1.0 mm thick, 1.8 mm high
//

module rib_y(y)
{ cube([1.0,y,1.95+1.8],center=false); }

module rib_x(x)
{ cube([x,1.0,1.95+1.8],center=false); }

//
// main
//

module gnss_firehose_bottom()
{ pcb_x = 4.000*25.4;  // PCB dimensions and thickness
  pcb_y = 3.200*25.4;
  pcb_t = 0.063*25.4;
  eps = 0.8;           // clearance gap between PCB and plastic
  wall = 1.95;         // wall thickness
  base = 1.95;         // base thickness
  h = 6;               // height above PCB
  cavity = 3.5;        // space below PCB and above base
  m = 25.4;            // convert between inch and mm

  _w = wall+eps;             // derived quantities
  _th = base+cavity+pcb_t+h;
  _c = pcb_t+cavity;
  _b = pcb_t+cavity+base;

  difference () {
    union () {
      translate([-_w, -_w, -_b]) {                              // four walls
        cube([pcb_x+2*_w, pcb_y+2*_w, base]);
        cube([pcb_x+2*_w, wall, _th]);
        translate([0, pcb_y+(wall+2*eps), 0])
          cube([pcb_x+2*_w, wall, _th]);
        cube([wall, pcb_y+2*_w, _th]);
        translate([pcb_x+(wall+2*eps), 0, 0])
          cube([wall, pcb_y+2*_w, _th]);
      }
      translate([0.330*m,0.150*m,-_c]) boss(cavity);            // screw mounts
      translate([3.500*m,0.150*m,-_c]) boss(cavity);
      translate([0.330*m,3.050*m,-_c]) boss(cavity);
      translate([3.500*m,3.050*m,-_c]) boss(cavity);
      translate([0.5*m,-_w,-_b]) rib_y(pcb_y+2*_w);             // vertical ribs
      translate([1.4*m,-_w,-_b]) rib_y(pcb_y+2*_w);
      translate([2.3*m,-_w,-_b]) rib_y(pcb_y+2*_w);
      translate([3.2*m,-_w,-_b]) rib_y(pcb_y+2*_w);
      translate([-_w,(0.340+0.315)*m,-_b]) rib_x(pcb_x+2*_w);   // horizontal ribs
      translate([-_w,(0.970+0.315)*m,-_b]) rib_x(pcb_x+2*_w);
      translate([-_w,(1.600+0.315)*m,-_b]) rib_x(pcb_x+2*_w);
      translate([-_w,(2.230+0.315)*m,-_b]) rib_x(pcb_x+2*_w);
    }
    union () {
      translate([-_w,0.340*m,-(pcb_t+2.7)]) cutout(wall,11);    // SMA cutouts
      translate([-_w,0.970*m,-(pcb_t+2.7)]) cutout(wall,11);
      translate([-_w,1.600*m,-(pcb_t+2.7)]) cutout(wall,11);
      translate([-_w,2.230*m,-(pcb_t+2.7)]) cutout(wall,11);
      translate([-_w,2.860*m,-(pcb_t+2.7)]) cutout(wall,11);
      translate([pcb_x+eps,0.655*m,-1]) cutout(wall,21);        // Ethernet cutout
      translate([pcb_x+eps,2.700*m,-1]) cutout(wall,12);        // power-jack cutout
    }
  }
}

$fn=20;
gnss_firehose_bottom();
