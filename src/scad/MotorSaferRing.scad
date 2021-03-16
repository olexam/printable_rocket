// include <Settings.scad>

motorSaferRing(20, 23, 0.1);

module motorSaferRing(motorDiameter, motorHolderOuterDiameter, tlrnc) {

    neckRadius=motorDiameter/2 + 2;
    dz = 0.01;

    difference() {
        union(){
            difference() {
                union() {
                    cylinder(h = 0.4, r = neckRadius + 1.6 );
                    translate([0,0,0.4]) {
                        cylinder(h=1.6, r1=neckRadius + 1.6, r2=neckRadius);
                    }
                }
                rotate_extrude(angle=90, convexity=10) {
                    translate([neckRadius, -dz, 0]) square(size=2+dz);
                }
                rotate_extrude(angle=90, convexity=10) {
                    translate([-(neckRadius + 2), -dz, 0]) square(size=2+dz);
                }
            }
            translate([0,0,2]) {
                cylinder(h=3, r=neckRadius);
            }
            translate([0,0,5]) {
                cylinder(h=2, r1=neckRadius, r2=motorHolderOuterDiameter/ 2);
            }
        }
        translate([0,0,-dz]) cylinder(h=7 + 2*dz, d = motorDiameter + 8*tlrnc);
    }
}
