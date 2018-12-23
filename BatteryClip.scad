
$fn=100;

// All dimensions in inches

InterDeckSpace = 0.7; // from PlainBase.scad
BatteryWidth = 1.5;
Width = BatteryWidth + 0.5;
Thickness = 0.125;
ClipLength = 0.35;
//BumpSize = 0.03125;
BumpSize = 0.0625;

module Box()
{
  union() {
    cube([ClipLength + BumpSize + Thickness, Width, InterDeckSpace]);
  }
}

module Cutout()
{
  union() {
    translate([-0.01, -0.01, Thickness]) cube([ClipLength + BumpSize, Width+0.1, InterDeckSpace + 0.5]);
  }
}

scale([25.4, 25.4, 25.4]) {
  difference() {
    Box(); 
    Cutout();
  }
}