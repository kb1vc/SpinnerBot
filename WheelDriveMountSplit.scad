// Motor Mounts for wheels -- notice 90 degree offset


// All dimensions in mm.
$fn=100;

HoleSpace = 17.8;
HoleDia = 2.5;
MCaseWidth = 23.2;
HoleCornerOffset = (MCaseWidth - HoleSpace) * 0.5; 
MCaseDepth = 13.8;
MountWidth = 48;
MountHeight = 45;
MountDepth = 20;
MCaseLength = 48;
SlotWidth = MountWidth - 2.0 * MCaseDepth - 4.0; 

MotorBoxWidth = MCaseWidth + 2.5;
MotorBoxHeight = MountHeight;
MotorBoxDepth = MCaseDepth + 7.5;

module motor_case()
{
  union() {
    cube([MCaseDepth, MCaseWidth, MCaseLength],false); 
    translate([0, - (MCaseWidth + 3), 0])
      cube([MCaseDepth - 1, MCaseWidth, MCaseLength], false);
    translate([0, 0, -(MCaseLength + 2)])
      cube([MCaseDepth - 1, 2 * MCaseWidth, MCaseLength], false);
  }
}

module motor_cases()
{
  union() {
    rotate([45,0,0]) translate([-0.01, -HoleCornerOffset, -HoleCornerOffset])
      motor_case();
    rotate([45,0,180]) translate([-(0.01 + MountWidth), 
    		      		 -(HoleCornerOffset), -HoleCornerOffset])
      motor_case();
    translate([0.5 * (MountWidth - SlotWidth), -MountHeight * 0.5 - 4.5, -6])
      cube([SlotWidth, MountHeight + 6, MountDepth + 8]);
      
  }
}

// First make the mount box
module mount_case()
{
  translate([0,-0.5*MountWidth, -5])
  cube([MountWidth, MountHeight, MountDepth], false);
}

// make a half-mount box
module half_mount()
{
  translate([0, -MotorBoxWidth, -5])
  cube([MotorBoxWidth, MotorBoxHeight, MotorBoxDepth], false);
}

module motor_mount_hole() {
  cylinder(d=HoleDia, h=120);
}

module motor_mount_holes() {
  translate([100,0,0]) rotate([45,0,0]) rotate([0, -90, 0]) {
    union() {
      motor_mount_hole();
      translate([HoleSpace, 0, 0]) motor_mount_hole();
      translate([0, HoleSpace, 0]) motor_mount_hole();
    }
  }
    translate([-30, -20, 2.5]) rotate([90, 0, 90]) motor_mount_hole();
    translate([-30, 15, 2.5]) rotate([90, 0, 90]) motor_mount_hole();    
}


module motor_mount_pair() {
  difference() {
    mount_case();
      // half_mount();
    union() {
      motor_cases();
      motor_mount_holes();
    }
  }
}

module left() {
  intersection() {
    motor_mount_pair();
    translate([20, -100, -60]) cube([100, 200, 100], false);
  }
}

module right() {
  intersection() {
    motor_mount_pair();
    rotate([0, 0, 180]) translate([-20, -100, -60]) cube([100, 200, 100], false);
  }
}

translate([0, 0, 15.8]) rotate([0, 90, 0]) right();
translate([-20, 0, -(14.2 + 18)]) rotate([0, -90, 0]) left();