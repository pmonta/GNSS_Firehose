// Enclosure for GNSS Firehose board, top piece
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>


//
// wall cutouts for connectors
//

module cutout(x,y)
{ translate([0,-y/2,-100]) cube([x,y,100]); }

//
// ribs in y and x directions
// 1.0 mm thick, 1.8 mm high
//

module rib_y(y)
{ translate([0,0,-1.8]) cube([1.0,y,1.95+1.8],center=false); }

module rib_x(x)
{ translate([0,0,-1.8]) cube([x,1.0,1.95+1.8],center=false); }

//
// main
//

module gnss_firehose_top()
{ pcb_x = 4.000*25.4;  // PCB dimensions
  pcb_y = 3.200*25.4;
  eps = 0.8;           // clearance gap between PCB and plastic
  wall = 1.95;         // wall thickness
  base = 1.95;         // base thickness
  h = 6;               // starting height above PCB
  cavity = 10.7;       // additional clearance height
  m = 25.4;            // convert between inch and mm

  _w = wall+eps;             // derived quantities
  _th = h+cavity;

  difference () {
    union () {
      translate([-_w, -_w, _th])                                // base plate
        cube([pcb_x+2*_w, pcb_y+2*_w, base]);
      translate([-_w, -_w, h]) {                                // walls
        cube([pcb_x+2*_w, wall, cavity+base]);
        cube([wall, pcb_y+2*_w, cavity+base]);
      }
      translate([-_w, pcb_y+eps, h])
        cube([pcb_x+2*_w, wall, cavity+base]);
      translate([pcb_x+eps, -_w, h])
        cube([wall, pcb_y+2*_w, cavity+base]);
      translate([-eps, -eps, h-2])               cube([3, 3, 2+cavity+base]);        // retaining pins
      translate([-eps, pcb_y+eps-3, h-2])        cube([3, 3, 2+cavity+base]);
      translate([pcb_x+eps-3, -eps, h-2])        cube([3, 3, 2+cavity+base]);
      translate([pcb_x+eps-3, pcb_y+eps-3, h-2]) cube([3, 3, 2+cavity+base]);
      translate([0.5*m,-_w,_th]) rib_y(pcb_y+2*_w);             // vertical ribs
      translate([1.4*m,-_w,_th]) rib_y(pcb_y+2*_w);
      translate([2.3*m,-_w,_th]) rib_y(pcb_y+2*_w);
      translate([3.2*m,-_w,_th]) rib_y(pcb_y+2*_w);
      translate([-_w,(0.340+0.315)*m,_th]) rib_x(pcb_x+2*_w);   // horizontal ribs
      translate([-_w,(0.970+0.315)*m,_th]) rib_x(pcb_x+2*_w);
      translate([-_w,(1.600+0.315)*m,_th]) rib_x(pcb_x+2*_w);
      translate([-_w,(2.230+0.315)*m,_th]) rib_x(pcb_x+2*_w);
    }
    union () {
      translate([pcb_x+eps,0.655*m,_th-1.8]) cutout(wall,21);        // Ethernet cutout
      translate([pcb_x+eps,2.700*m,_th-1.8-2.5]) cutout(wall,12);    // power-jack cutout
    }
  }
}

$fn=20;
gnss_firehose_top();
