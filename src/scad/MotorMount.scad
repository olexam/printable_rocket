/// coments
//params
use <components/Fittings.scad>
include <Settings.scad>

fitterInternalDiameter=internalDiameter;
motorStopperHeigh=5;
motorCount=2;
finShape=[[0,7],[10,0],[40,0],[40,20],[40,30],[0,70]];
//finShape=[[0,7],[30,20],[30,40],[0,70]];
finCount=4;
finRotOffest=-45;
finThicknes = perimeter*2;
motorDiameter=20;
motorLength=70;


MotorMount(motorDiameter, motorLength, motorCount, tlrnc);

function radiusS(motorCount = 1) =  motorCount == 1 ? 0 : (fitterInternalDiameter+3*wallThicknes)/(2*sin(180/motorCount));

module MotorMount(motorDiameter = 20, motorLength=70, motorCount=1, tlrnc=0.1) {
    difference () {
        motorMountOuterShell(motorLength, motorCount, motorDiameter);
        for(i = [0:motorCount-1]) {
            rotate([0,0,360/motorCount*i])
                translate([radiusS(motorCount), 0, 0])
                    motorMountInternalCut(motorLength, motorDiameter, motorCount);
        }
    }
    manifold(motorLength, motorDiameter, motorCount);
    translate ([0, 0, 2*overlap + motorStopperHeigh + motorLength])
        topFitting(overlap, fitterInternalDiameter, wallThicknes, tlrnc);
}

module fin(motorLength, motorDiameter, finThicknes) {
    translate([0, finThicknes/2, 0])
        rotate([90,0,0])
            linear_extrude(finThicknes)
                polygon(points=finShape);


}

module manifold(motorLength, motorDiameter, motorCount) {
    difference(){
        hull() {
            translate([0,0,overlap + motorStopperHeigh + motorLength + overlap])
                linear_extrude (0.01) circle(d = fitterInternalDiameter + 2 * wallThicknes);
            for(i = [0:motorCount-1]) {
                rotate([0,0,360/motorCount*i])
                    translate([radiusS(motorCount), 0, motorStopperHeigh + motorLength])
                        linear_extrude (0.01) circle(d = fitterInternalDiameter + 2 * wallThicknes);
            }
        }
        hull() {
            translate([0,0, overlap + motorStopperHeigh + motorLength +overlap])
                linear_extrude (0.01) circle(d = fitterInternalDiameter);
            for(i = [0:motorCount-1]) {
                rotate([0,0,360/motorCount*i])
                    translate([radiusS(motorCount), 0, motorStopperHeigh + motorLength])
                        linear_extrude (0.01) circle(d = fitterInternalDiameter);
            }
        }
    }
}

module motorMountOuterShell(motorLength, motorCount = 1, motorDiameter) {
    for(i = [0:motorCount-1]) {
        rotate([0,0,360/motorCount*i])
        translate([radiusS(motorCount), 0, 0])
            motorSafer();
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

module motorSafer() {
    difference() {
        union() {
            cylinder(h = 0.4, d = 13.6 *2 );
            translate([0,0,0.4]) {
                cylinder(h=1.6, r1=13.6, r2=12);
            }
        }
        rotate_extrude(angle=90, convexity=10) {
            translate([12, 0, 0]) square(size=2);
        }
        rotate_extrude(angle=90, convexity=10) {
            translate([-14, 0, 0]) square(size=2);
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
    cylinder(h = motorLength + 3*tlrnc, d = motorDiameter + 8*tlrnc);
    translate ([0, 0, motorLength + 2* tlrnc]) {
        cylinder(h = motorStopperHeigh , d = motorDiameter - 2);
    }
}
