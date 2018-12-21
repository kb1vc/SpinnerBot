$fn=100;

// All dimensions in inches

Span = 2.25;
Width = 0.5;
Thickness = 0.225;
WeightHole = 0.15; 

Shaft = 0.078;
SpringDia = 0.25; 

module bar()
{
  cube([Span, Width, Thickness], true);
}


module shaftHole()
{
  difference() {
    cylinder(d = SpringDia, h = Thickness * 4, center=true);
    difference() {
      union() {
        translate([0, -Shaft * 0.4, 0]) cube([SpringDia * 2, Shaft * 0.5, Thickness * 4], true);
        translate([0, Shaft * 0.4, 0]) cube([SpringDia * 2, Shaft * 0.5, Thickness * 4], true);
        translate([0, -Shaft * 0.65, 0]) cube([SpringDia * 0.5, Shaft, Thickness * 4], true);
        translate([0, Shaft * 0.65, 0]) cube([SpringDia * 0.5, Shaft, Thickness * 4], true);
      }
      cylinder(d = Shaft, h = Thickness * 4, center=true);
    }
  }
}

module weightHoles()
{
  union() {
    translate([2 * Span / 5, 0, 0]) cylinder(d = WeightHole, h = Thickness * 4, center = true);
    translate([-2 * Span / 5, 0, 0]) cylinder(d = WeightHole, h = Thickness * 4, center = true);        
  }
}

scale([25.4, 25.4, 25.4]) {
  difference() {
    bar();
    union() {
      shaftHole();
      weightHoles();
    }
  }
}