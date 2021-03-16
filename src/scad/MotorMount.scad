use <components/Fittings.scad>
use <components/functions.scad>
use <MotorSaferRing.scad>
// include <Settings.scad>

fnSp=[[0,7],[10,0],[40,0],[40,20],[40,30],[0,70]];

MotorMount(20, 70, 3, 15, 55, 0.45, 3, 5, 1, fnSp, 0, 0.1);

// =====================

// finsConunt must be bigger or equal to motorCount
module MotorMount(motorDiameter, motorLength, motorCount, overlap, internalDiameter, wallThickness, finCount, motorStopperHeigh, finThicknes, finShape, finRotOffest, tlrnc){
    motorHolderThck = 1.5;
    motorHolderInnerDiameter = motorDiameter + 8 * tlrnc;
    morotHolderOutDiameter = motorHolderInnerDiameter + 2 * motorHolderThck;

  difference(){
    motorMountOuterShell(motorLength, motorCount, motorDiameter, morotHolderOutDiameter, motorStopperHeigh);
    for(i = [0:motorCount - 1]){
      rotate([0, 0, 360 / motorCount * i])
        translate([radiusS(motorCount, motorDiameter), 0, 0])
          motorMountInternalCut(motorLength, motorDiameter, motorCount, motorStopperHeigh, tlrnc);
    }
  }
  for(i = [0:motorCount - 1]){
    rotate([0, 0, 360 / motorCount * i])
      translate([radiusS(motorCount, motorDiameter), 0, 0])
      motorSaferRing(motorDiameter, morotHolderOutDiameter, tlrnc);
  }

  finsPerMotor = floor(finCount / motorCount);
  for(j = [0:motorCount - 1]){
    rotate([0, 0, 360 / motorCount * j])
      translate([radiusS(motorCount, motorDiameter), 0, 0])
      for(i = [0: finsPerMotor - 1]){
        finAngle = 360 / motorCount / finsPerMotor * i + finRotOffest;
        rotate([0, 0, finAngle])
          translate([morotHolderOutDiameter / 2, 0, 0])
          fin(motorLength, finThicknes, finShape);
      }
  }

  translate([0, 0, 2 * overlap + motorStopperHeigh + motorLength])
    manifold(motorDiameter, motorCount, internalDiameter, morotHolderOutDiameter, wallThickness, motorHolderThck, overlap);
  translate([0, 0, 2 * overlap + motorStopperHeigh + motorLength])
    topFitting(overlap, internalDiameter, wallThickness, tlrnc);
}

module manifold(motorDiameter, motorCount, internalDiameter, morotHolderOutDiameter, wallThickness, manifoldWall, overlap){
    outerDiameter = outerDiam(internalDiameter, wallThickness);
    dz=0.01;
  difference(){
    hull(){ // outer shell
      linear_extrude(0.01) circle(d = outerDiameter);
      for(i = [0:motorCount - 1]){
        rotate([0, 0, 360 / motorCount * i])
          translate([radiusS(motorCount, motorDiameter), 0, -2 * (overlap)])
          linear_extrude(0.01)circle(d = morotHolderOutDiameter);
      }
    }
    hull(){ // inner shell
      translate([0, 0, dz])
        linear_extrude(0.01) circle(d = internalDiameter - manifoldWall );
      for(i = [0:motorCount - 1]){
        rotate([0, 0, 360 / motorCount * i])
          translate([radiusS(motorCount, motorDiameter), 0, -2 * (overlap + dz)])
          linear_extrude(0.01)circle(d = morotHolderOutDiameter - manifoldWall );
      }
    }
  }
}

module motorMountOuterShell(motorLength, motorCount, motorDiameter, morotHolderOutDiameter, motorStopperHeigh){
  hull(){
    for(i = [0:motorCount - 1]){
      rotate([0, 0, 360 / motorCount * i])
        translate([radiusS(motorCount, motorDiameter), 0, 0])
        translate([0, 0, 7]){
          cylinder(h = motorStopperHeigh + motorLength - 7, d = morotHolderOutDiameter);
        }
    }
  }
}

module fin(motorLength,finThicknes, finShape){
    translate([0, finThicknes / 2, 0])
      rotate([90, 0, 0])
      linear_extrude(finThicknes)
      polygon(points = finShape);
}
  
module motorMountInternalCut(motorLength, motorDiameter, motorCount, motorStopperHeigh, tlrnc){
    dz=0.01;
  translate([0, 0, -dz]) cylinder(h = motorLength + 3 * tlrnc + dz, d = motorDiameter + 8 * tlrnc);
  translate([0, 0, motorLength + 2 * tlrnc]){
    cylinder(h = motorStopperHeigh, d = motorDiameter - 2);
  }
}

// 12 is max diam of safer knob related to motor diameter (+10) plus clearance
function radiusS(motorCount, motorDiameter) =
    motorCount == 1 
    ? 0
    :(motorDiameter + 12) / (2 * sin(180 / motorCount));

