use <components/Fittings.scad>
use <components/functions.scad>
use <MotorSaferRing.scad>

include <Settings.scad>

//fnSp=[[0,7],[10,0],[40,0],[40,20],[40,30],[0,70]];

// MotorMount(20, 70, 3, 15, 55, 0.45, 0.45, 3, 5, 1, fnSp, 0, 0.1);
// MotorMount(motorDiameter, motorLength, motorCount, overlap, internalDiameter, wallThickness, perimeter, finCount, motorStopperHeigh, finThickness, finShape, finRotOffest, tlrnc);
MotorMountTubed(motorDiameter, motorLength, motorCount, overlap, internalDiameter, wallThickness, perimeter, finCount, motorStopperHeigh, finThickness, finShape, finRotOffest, tlrnc);

// =====================

// finsConunt must be bigger or equal to motorCount
module MotorMount(motorDiameter, motorLength, motorCount, overlap, internalDiameter, wallThickness, minWall, finCount, motorStopperHeigh, finThicknes, finShape, finRotOffest, tlrnc){
  motorHolderThck = 1.5;
  motorHolderInnerDiameter = motorDiameter + 8 * tlrnc;
  morotHolderOutDiameter = motorHolderInnerDiameter + 2 * motorHolderThck;

  translate([0, 0, 2 * overlap + motorStopperHeigh + motorLength])
    topFitting(overlap, internalDiameter, wallThickness, minWall, tlrnc);

  translate([0, 0, 2 * overlap + motorStopperHeigh + motorLength])
    manifold(motorDiameter, motorCount, internalDiameter, morotHolderOutDiameter, wallThickness, motorHolderThck, overlap);

  difference(){
    translate([0,0,7]) motorMountOuterShell(motorLength, motorCount, motorDiameter, morotHolderOutDiameter, motorStopperHeigh);
    for(i = [0:motorCount - 1]){
      rotate([0, 0, 360 / motorCount * i])
        translate([radiusS(motorCount, motorDiameter), 0, 0])
          motorMountInternalCut(motorLength, motorDiameter, motorHolderThck, motorStopperHeigh, overlap, tlrnc);
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
          translate([morotHolderOutDiameter / 2 - 0.5, 0, 0])
            fin(motorLength, finThicknes, finShape);
      }
  }
}


module MotorMountTubed(motorDiameter, motorLength, motorCount, overlap, internalDiameter, wallThickness, minWall, finCount, motorStopperHeigh, finThicknes, finShape, finRotOffest, tlrnc){
  emptyBody = false;
  motorHolderThck = 1.5;
  zd = 0.001;
  motorHolderInnerDiameter = motorDiameter + 8 * tlrnc;
  morotHolderOutDiameter = motorHolderInnerDiameter + 2 * motorHolderThck;

  translate([0, 0, 2 * overlap + motorStopperHeigh + motorLength])
    topFitting(overlap, internalDiameter, wallThickness, minWall, tlrnc);

  floorThck = 3*minWall;
  difference(){
    translate([0, 0, 7]) {
      if (emptyBody) {
        tube(2 * overlap + motorStopperHeigh + motorLength - 7, internalDiameter, wallThickness);
        translate([0,0,motorStopperHeigh + motorLength - 7 - floorThck]) 
          cylinder(h=floorThck,d=internalDiameter);
        cylinder(h=floorThck,d=internalDiameter);
      } else {
        tube(2 * overlap + motorStopperHeigh + motorLength - 7, internalDiameter, wallThickness);
        cylinder(h=motorStopperHeigh + motorLength - 7, d=internalDiameter);
      }
    }
    for(i = [0:motorCount - 1]){
      rotate([0, 0, 360 / motorCount * i]) {
        translate([radiusS(motorCount, motorDiameter), 0, 0]) {
          motorMountInternalCut(motorLength, motorDiameter, motorHolderThck, motorStopperHeigh, overlap, tlrnc);
        }
      }
    }
  }

  difference() {
    union() {
      for(i = [0:motorCount - 1]){
        rotate([0, 0, 360 / motorCount * i]) {
          translate([radiusS(motorCount, motorDiameter), 0, 0]) {
            booster(motorLength, motorDiameter, motorHolderInnerDiameter, motorHolderThck, motorStopperHeigh, overlap, tlrnc);
          }
        }
      }
    }
    translate([0,0,motorStopperHeigh + motorLength]) {
      cylinder(h=2 * overlap, d = internalDiameter);
    }
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
}

module booster(motorLength, motorDiameter, motorHolderInnerDiameter, motorHolderThck, motorStopperHeigh, overlap, tlrnc) {
  morotHolderOutDiameter = motorHolderInnerDiameter + 2 * motorHolderThck;
  difference() {
    boosterOutShell(motorLength, motorDiameter, motorHolderInnerDiameter, motorHolderThck, motorStopperHeigh, overlap, tlrnc);
    motorMountInternalCut(motorLength, motorDiameter, motorHolderThck, motorStopperHeigh, overlap, tlrnc);
  }
}

module boosterOutShell(motorLength, motorDiameter, motorHolderInnerDiameter, motorHolderThck, motorStopperHeigh, overlap, tlrnc) {
  morotHolderOutDiameter = motorHolderInnerDiameter + 2 * motorHolderThck;
  union() {
    translate([0,0,7]) {
      cylinder(h = motorStopperHeigh + motorLength - 7, d = morotHolderOutDiameter);
    }
    translate([0,0,motorStopperHeigh + motorLength]) {
      cylinder(h = 2*overlap, r1 = morotHolderOutDiameter/2, r2 = 0);
    }
    motorSaferRing(motorDiameter, morotHolderOutDiameter, tlrnc);
  }
}

module motorMountInternalCut(motorLength, motorDiameter, motorHolderThck, motorStopperHeigh, overlap, tlrnc){
  dz=0.01;
  innerMotorLength = motorLength + 2 * tlrnc;
  motorHolderInnerDiameter = motorDiameter + 8 * tlrnc;
  morotHolderOutDiameter = motorHolderInnerDiameter + 2 * motorHolderThck;
  translate([0, 0, -dz]) {
    cylinder(h = innerMotorLength + 2 * dz, d = motorHolderInnerDiameter);
  }
  translate([0, 0, innerMotorLength]){
    cylinder(h = motorStopperHeigh, r1 = motorHolderInnerDiameter/2, r2= motorHolderInnerDiameter/5);
  }
  translate([0, 0, innerMotorLength]){
    cylinder(h = motorStopperHeigh + dz, d = motorDiameter - 2);
  }
  translate([0,0,motorStopperHeigh + motorLength]){
    cylinder(h = 2*(overlap - motorHolderThck), r1 = morotHolderOutDiameter/2 - motorHolderThck, r2 = 0);
  }
}

module manifold(motorDiameter, motorCount, internalDiameter, morotHolderOutDiameter, wallThickness, manifoldWall, overlap){
    outerDiameter = outerDiam(internalDiameter, wallThickness);
    dz=0.1;
  difference(){
    hull(){ // outer shell
      linear_extrude(0.01) circle(d = outerDiameter);
      translate([0,0, -2 * overlap]) {
        for(i = [0:motorCount - 1]){
          rotate([0, 0, 360 / motorCount * i])
            translate([radiusS(motorCount, motorDiameter), 0, 0])
            linear_extrude(0.01) circle(d = morotHolderOutDiameter);
        }
      }
    }
    hull(){ // inner shell
      translate([0, 0, dz])
        linear_extrude(0.1) circle(d = internalDiameter - manifoldWall );
      translate([0,0, -2 * overlap - dz]) {
        for(i = [0:motorCount - 1]){
          rotate([0, 0, 360 / motorCount * i])
            translate([radiusS(motorCount, motorDiameter), 0, 0])
            linear_extrude(0.01) circle(d = morotHolderOutDiameter - manifoldWall );
        }
      }
    }
  }
}

module motorMountOuterShell(motorLength, motorCount, motorDiameter, morotHolderOutDiameter, motorStopperHeigh){
  hull(){
    for(i = [0:motorCount - 1]){
      rotate([0, 0, 360 / motorCount * i])
        translate([radiusS(motorCount, motorDiameter), 0, 0])
          cylinder(h = motorStopperHeigh + motorLength - 7, d = morotHolderOutDiameter);
    }
  }
}

module fin(motorLength,finThicknes, finShape){
    translate([0, finThicknes / 2, 0])
      rotate([90, 0, 0])
      linear_extrude(finThicknes)
      polygon(points = finShape);
}
  
// 12 is max diam of safer knob related to motor diameter (+10) plus clearance
function radiusS(motorCount, motorDiameter) =
    motorCount == 1 
    ? 0
    :(motorDiameter + 12) / (2 * sin(180 / motorCount));

