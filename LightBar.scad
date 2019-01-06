// Holder for SparkFun Lumenati 8 lamp stick

$fn=100;

// All dimensions in mm

ClipLength = 50;
Height = 12;
Depth = 15;
SlotWidth = 30;
Thickness = 2.5;

AccHoleSpace = 10; // from Plainbase.scad
HoleDia = 2.5; 

LampHoleSpace = (1.65 * 25.4);  // 1.465 in

module Box()
{
  union() {
    cube([ClipLength, Height, Depth], center=true);
  }
}

module LampHoles() {
  union() {
    translate([0.5 * LampHoleSpace, 2.5, 0])
       cylinder(d = HoleDia, h = 20, center=true);
    translate([-0.5 * LampHoleSpace, 2.5, 0])
       cylinder(d = HoleDia, h = 20, center=true);
  }
}

module Cutout()
{
  union() {
    translate([0, Thickness, Thickness]) cube([ClipLength + 10, Height, Depth], center=true);
    translate([0, Thickness*1.5, -Thickness]) cube([LampHoleSpace - 10, Height, Depth], center=true);
  }
}


difference() {
  Box();
  union() {
    LampHoles();
    Cutout();
  }
}