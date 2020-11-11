use <components/Fittings.scad>
include <Settings.scad>

fitterInternalDiameter=motorDiameter+3*wallThicknes;


MotorMount(motorDiameter, motorLength, motorCount, tlrnc);

function radiusS(motorCount = 1, fitterInternalDiameter = fitterInternalDiameter, wallThicknes = wallThicknes) = 
    motorCount == 1 
        ? 0 
        : (fitterInternalDiameter+3*wallThicknes)/(2*sin(180/motorCount));

module MotorMount(motorDiameter = 20, motorLength=70, motorCount=1, tlrnc=0.1) {
    difference () {
        motorMountOuterShell(motorLength, motorCount, motorDiameter);
        for(i = [0:motorCount-1]) {
            rotate([0,0,360/motorCount*i])
                translate([radiusS(motorCount), 0, 0])
                    motorMountInternalCut(motorLength, motorDiameter, motorCount);
        }
    }
    translate ([0, 0, 2*overlap + motorStopperHeigh + motorLength])
        manifold(motorDiameter, motorCount);
    translate ([0, 0, 2*overlap + motorStopperHeigh + motorLength])
        topFitting(overlap, internalDiameter, wallThicknes, tlrnc);
}

module fin(motorLength, motorDiameter, finThicknes) {
    translate([0, finThicknes/2, 0])
        rotate([90,0,0])
            linear_extrude(finThicknes)
                polygon(points=finShape);


}

module manifold(motorDiameter, motorCount) {
    difference(){
        hull() { // outer shell
            linear_extrude (0.01) circle(d = outerDiameter);
            for(i = [0:motorCount-1]) {
                rotate([0,0,360/motorCount*i])
                    translate([radiusS(motorCount), 0, -2*(overlap)])
                        linear_extrude (0.01) circle(d = fitterInternalDiameter + 2 * wallThicknes);
            }
        }
        hull() { // inner shell
            translate([0,0,dz])
                linear_extrude (0.01) circle(d = internalDiameter);
            for(i = [0:motorCount-1]) {
                rotate([0,0,360/motorCount*i])
                    translate([radiusS(motorCount), 0, -2*(overlap+dz)])
                        linear_extrude (0.01) circle(d = fitterInternalDiameter);
            }
        }
    }
}

module motorMountOuterShell(motorLength, motorCount = 1, motorDiameter) {
    for(i = [0:motorCount-1]) {
        rotate([0,0,360/motorCount*i])
        translate([radiusS(motorCount), 0, 0])
            motorSaferRing();
    }
    hull() {
        for(i = [0:motorCount-1]) {
            rotate([0,0,360/motorCount*i])
                translate([radiusS(motorCount), 0, 0])
                    translate([0,0,7]) {
                        cylinder(h=motorStopperHeigh + motorLength - 7, d=fitterInternalDiameter + 2 * wallThicknes );
                    }
        }
    }

    finsPerMotor = floor(finCount/motorCount);
    echo(finsPerMotor);
    for(j = [0:motorCount-1]) {
        rotate([0,0,360/motorCount*j])
            translate([radiusS(motorCount), 0, 0])
                for(i = [0:finsPerMotor-1]) {
                    rotate([0,0,(360/motorCount)/finsPerMotor*i + finRotOffest])
                        translate([fitterInternalDiameter/2 + wallThicknes/2, 0, 0])
                            fin(motorLength, motorDiameter, finThicknes);
                }
    }
}

module motorSaferRing() {
    difference() {
        union() {
            cylinder(h = 0.4, d = 13.6 * 2 );
            translate([0,0,0.4]) {
                cylinder(h=1.6, r1=13.6, r2=12);
            }
        }
        rotate_extrude(angle=90, convexity=10) {
            translate([12, -dz, 0]) square(size=2+dz);
        }
        rotate_extrude(angle=90, convexity=10) {
            translate([-14, -dz, 0]) square(size=2+dz);
        }
    }
    translate([0,0,2]) {
        cylinder(h=3, d=24);
    }
    translate([0,0,5]) {
        cylinder(h=2, r1=12, r2=fitterInternalDiameter/ 2 + wallThicknes);
    }
}


module motorMountInternalCut(motorLength, motorDiameter, motorCount = 1) {
    translate([0,0,-dz]) cylinder(h = motorLength + 3*tlrnc + dz, d = motorDiameter + 8*tlrnc);
    translate ([0, 0, motorLength + 2* tlrnc]) {
        cylinder(h = motorStopperHeigh , d = motorDiameter - 2);
    }
}
