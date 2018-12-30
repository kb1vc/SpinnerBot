$fn=100;

// All dimensions in mm
// rise is 31.5 for 2.6 inch wheels, add 0.25 inch for larger
Rise = 31.5;
MountWidth = 8; // from 0.1 * PlateLength in PlainBase.scad
Thickness = 3; // make the scoop a little thicker
ContactWidth = 0.7 * Thickness; // width of the scoop's shoe

ScoopLength = 80; // would really like 160, but the printer won't do it.

epsilon = 0.1; // little bit more to provide overlap

AccHoleSpace = 10; // from Plainbase.scad
HoleDia = 2.5; 

module AccessoryHoles()
{
  union() {
    for(idx = [-2:2]) {
      translate([idx * AccHoleSpace, 0, 0]) cylinder(d = HoleDia, h = Thickness * 2);
    }
  }
}

module Rib() {
  translate([0, 0, -0.5 * Thickness])
    linear_extrude(height = Thickness)
      polygon(points = [ [MountWidth, Rise + 0.001], 
                         [MountWidth + Rise + 0.001, 0.001],
	  	         [MountWidth, 0.02] ]);
}

module Ribs() {
  translate([0, 0, -0.45 * ScoopLength])
    Rib();
  translate([0, 0, 0.45 * ScoopLength])
    Rib();
    
}

module ScoopBody() {
difference() {
  translate([0, 0, -(0.5 * ScoopLength + epsilon)])
    linear_extrude(height = ScoopLength)
      polygon(points = [ [0, Rise], [0, Rise + Thickness],
                         [MountWidth + ContactWidth, Rise + Thickness],
			 [MountWidth + ContactWidth + Rise + Thickness, 0],
			 [MountWidth + Rise, 0],
			 [MountWidth, Rise],
			 [0, Rise] ]);
  translate([0.45 * MountWidth, Rise + 1.5 * Thickness, 0]) rotate([90, 90, 0]) AccessoryHoles();    
}
}

module Scoop() {
  union() {
    ScoopBody();
    Ribs();
  }
}

Scoop();