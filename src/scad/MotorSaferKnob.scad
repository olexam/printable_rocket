include <Settings.scad>

saferShape=[
    [0,0],
    [5.6, 0], 
    [5.6, 6],
    [3.4, 6],
    [3.4, 4],
    [4.75, 2.65],
    [4.75, 2],
    [0, 2],
    [0, 0]
    ];

MotorSaferKnob();

module MotorSaferKnob() {
    difference() {
        rotate_extrude() translate([9, 0,0]) polygon(points=saferShape, paths=[[0,1,2,3,4,5,6,7,8]]);
        translate([0,0,2+dz]) curveCut();
        rotate([0,0,180]) translate([0,0,2+dz]) curveCut();
    }
    for (i=[0:15:360]) {
        rotate([0,0,i]) translate([14.6,0,3]) cube([0.7,0.7,6], true);
    }
    
}

module curveCut() {
    rotate_extrude(angle=110) translate([12.1,0,0]) square([1.6, 4]);
}