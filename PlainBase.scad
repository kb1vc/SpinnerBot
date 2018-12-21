// Simple baseplate


// All dimensions in mm.
$fn=100;

HoleSpace = 35;
CornerHoleOffset = 15; // From WhileDriveMountSplit.scad
CornerHoleDrop = 2.5; // same thing
AccHoleSpace = 10;
PlateWidth = 2.5 * 25.4;
PlateLength = 80;
InterDeckSpace = 0.7 * 25.4; // size of a battery
PlateThickness = 2.5;
HoleDia = 2.5;

EconoboxY = 8;
EconoboxX = PlateWidth - EconoboxY;

TotalHeight = InterDeckSpace + 2 * PlateThickness;

module Slab() {
  cube([PlateWidth, PlateLength, InterDeckSpace + 2 * PlateThickness], false);
}


module BatteryBox() {
  cube([PlateWidth - 2 * PlateThickness, PlateLength + 0.2, InterDeckSpace], false);
}

module MountingHoles() {
  rotate([0, 90, 0])
  union() {
    cylinder(d = HoleDia, h = PlateWidth + 5);
    translate([0, HoleSpace, 0]) cylinder(d = HoleDia, h = PlateWidth + 5);
    translate([CornerHoleDrop, HoleSpace - CornerHoleOffset, 0]) cylinder(d = HoleDia, h = PlateWidth + 10);
    translate([CornerHoleDrop, CornerHoleOffset, 0]) cylinder(d = HoleDia, h = PlateWidth + 10);    
    translate([-CornerHoleDrop, HoleSpace - CornerHoleOffset, 0]) cylinder(d = HoleDia, h = PlateWidth + 10);
    translate([-CornerHoleDrop, CornerHoleOffset, 0]) cylinder(d = HoleDia, h = PlateWidth + 10);    
  }
}

module AccessoryHoles()
{
  translate([0, 0, -5]) 
    union() {
      for(idx = [-2:2]) {
        translate([idx * AccHoleSpace, 0, 0]) cylinder(d = HoleDia, h = TotalHeight * 2);
      }
    }
}

// without these the build time is 5+ hours... a little excessive.
module RectEconomyCuts() {
       
   translate([0.5 * (PlateWidth - EconoboxX), 0, -0.5]) 
      cube([EconoboxX, EconoboxY, 200], false);
}

// without these the build time is 5+ hours... a little excessive.
module DiamondEconomyCuts() {
  translate([0,  0, -0.5]) {
    linear_extrude(height = 2 * PlateWidth, center = true)
      polygon(points = [ [PlateThickness, 0.1 * PlateLength],
                         [PlateWidth - PlateThickness, 0.1 * PlateLength],
		         [0.5 * PlateWidth, 0.45 * PlateLength] ]);
  }
}

module DiamondSideEconomyCuts() {
  translate([0, 0, -0.5]) {
    linear_extrude(height = 2 * PlateWidth, center = true)
      polygon(points = [ [PlateThickness, 0.175 * PlateLength],
                         [PlateThickness, 0.825 * PlateLength],
			 [0.45 * PlateWidth, 0.5 * PlateLength] ]);
			 
  }
}

difference() {
   Slab();
   union() {
     translate([PlateThickness, -0.05, PlateThickness]) BatteryBox();
     translate([-2.5, 0.5 * (PlateLength - HoleSpace), 0.3 * TotalHeight ]) MountingHoles();
     translate([-2.5, 0.5 * (PlateLength - HoleSpace), 0.7 * TotalHeight ]) MountingHoles();     
     DiamondEconomyCuts();
     translate([0, PlateLength, 0]) scale([1, -1, 1]) DiamondEconomyCuts();
     DiamondSideEconomyCuts();
     translate([PlateWidth, 0, 0]) scale([-1, 1, 1]) DiamondSideEconomyCuts();
     translate([PlateWidth * 0.5, 0.05 * PlateLength, 0]) AccessoryHoles();
     translate([PlateWidth * 0.5, 0.95 * PlateLength, 0]) AccessoryHoles();          
   }
}


