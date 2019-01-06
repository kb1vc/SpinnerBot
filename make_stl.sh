#!/bin/bash

# make a temporary SpinnerMotorMount_2r6
sed -e 's/Scoop_3r1/Scoop_2r6/' < SpinnerMotorMount_3r1.scad > temp_2r6.scad

for fi in PlainBase HorizontalSpinner WheelDriveMountSplit Scoop_2r6_wheels Scoop_3r1_wheels SpinnerMotorMount_3r1 temp_2r6 BatteryClip LightBar
do
  openscad -o ${fi}.stl ${fi}.scad    
done

mv temp_2r6.stl SpinnerMotorMount_2r6.stl
rm temp_2r6.scad
