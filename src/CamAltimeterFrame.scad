use <Camera.scad>
/// coments
//params

$fn=100;
tlrnc=0.1;
overlap=15;
internalDiameter=27 - 2*tlrnc;
perimeter = 0.4;
wallThicknes = 3* perimeter;
length=100;
camL=14;
camW=18;


CamAltimeterMount();

module CamAltimeterMount() {
    translate([-internalDiameter/2, -wallThicknes/2, 0 ]) {
        difference() {
            cube([internalDiameter, wallThicknes, length ]);
            translate([internalDiameter/2 - camL/2 ,-tlrnc,length -camW ]) {
                cube([camL, wallThicknes + 2 * tlrnc, camW ]);
            }
        }
        translate([internalDiameter/2 + camL/2,-3*wallThicknes/2,length -camW + camW/2 ]) holder();
        translate([internalDiameter/2 - camL/2 - 3,-3*wallThicknes/2,length -camW + camW/2 ]) holder();
    }
}

module holder() {
    rotate([0,90,0]) difference() {
        cylinder(r=3, h=3);
        cylinder(r=1, h=3 + tlrnc);
    }
}
    