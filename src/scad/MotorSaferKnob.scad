// include <Settings.scad>
$fn = 256;
MotorSaferKnob(20, 0.1);

module MotorSaferKnob(motorDiameter, tlrnc) {
    neckRadius=motorDiameter/2 + 2;
    dz=0.01;
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

    difference() {
        rotate_extrude() 
            translate([neckRadius-3, 0,0]) 
                polygon(points=saferShape);
        translate([0,0,2+dz]) 
            curveCut(neckRadius, tlrnc);
        rotate([0,0,180])
            translate([0,0,2+dz]) curveCut(neckRadius, tlrnc);
    }
    for (i=[0:15:360]) {
        rotate([0,0,i])
            translate([neckRadius + 2.5, -0.35, 0]) 
                cube([0.5 ,0.7, 6]);
    }
    
}

module curveCut(neckRadius, tlrnc) {
    rotate_extrude(angle=110) translate([neckRadius + tlrnc,0,0]) square([1.6, 4]);
}