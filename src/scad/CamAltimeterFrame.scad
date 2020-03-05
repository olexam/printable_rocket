use <components/Camera.scad>
include <Settings.scad>

//internalDiameter=internalDiameter - 2*tlrnc;

length=100;
camL=14;
camW=18;

CamAltimeterMount(length, internalDiameter - 4*tlrnc, frameThicknes- 2*tlrnc, tlrnc);

module CamAltimeterMount(length, internalDiameter, wallThicknes, tlrnc) {
    echo(str("WallThicknes=", wallThicknes));
    translate([-internalDiameter/2, -wallThicknes/2, 0 ]) {
        difference() {
            cube([internalDiameter, wallThicknes, length ]);
            translate([internalDiameter/2 - camL/2 ,-tlrnc,length -camW ]) {
                cube([camL, wallThicknes + 2 * tlrnc, camW ]);
            }
            translate([internalDiameter/2 - camL/2 ,-tlrnc,-0.01]) {
                cube([camL, wallThicknes + 2 * tlrnc, 5 ]);
            }
        }
        yPos = -3 + wallThicknes;
        translate([internalDiameter/2 + camL/2, yPos, length -camW + camW/2 ]) holder();
        translate([internalDiameter/2 - camL/2 - 3, yPos, length -camW + camW/2 ]) holder();
    }
}

module holder() {
    rotate([0,90,0]) difference() {
        cylinder(r=3, h=3);
        cylinder(r=1, h=3 + tlrnc);
    }
}
