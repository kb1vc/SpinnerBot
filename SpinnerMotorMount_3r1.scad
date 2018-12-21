use <Scoop_3r1_wheels.scad>

$fn=100;

// All dimensions in inches

Dia = 0.8;
Width = 0.6;
Len = 0.7;
Hole = 0.25; 
WallThickness = 0.05;

module motor()
{
  intersection() {
    cylinder(d = Dia, h = Len + 2 * WallThickness, center=true);
    cube([Dia * 2, Width, Len + 2 * WallThickness], center=true);
  }
}

module mountCase()
{
  cube([Dia + 2 * WallThickness, Width + 2 * WallThickness, Len + 2 * WallThickness], true);
}

module mount()
{
  difference() {
    mountCase();
    translate([0, 0, WallThickness]) union() {
      motor();
      cylinder(d = Hole, h = Len * 10, center=true);
    }
  }
}

module metricMount()
{
  scale([25.4, 25.4, 25.4]) {
    mount();
  }
}

module metricMountCase()
{
  scale([25.3, 25.3, 25.3]) {
    mountCase();
  }
}

union() {
  translate([28, 0, 25]) metricMount();
  translate([13.5, 0, 31.75]) cube([6.5,25,7.0], center=true);
  difference() {
    rotate([90, 0, 0]) Scoop();
    union() {
      translate([0, 0, 0]) cube([200, 2.5 * 25.4, 35], center=true);
      translate([28, 0, 25]) metricMountCase();
    }
  }
}
