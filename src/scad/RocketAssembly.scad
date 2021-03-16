use <MainTube.scad>
use <NoseCone.scad>
use <MotorMount.scad>
use <TubeFitter.scad>
use <CamAltimeterMount.scad>
use <MotorSaferKnob.scad>

/// coments
//params

include <Settings.scad>

tubeLength=180;

motorCount=3;
internalDiameter=55;

translate([0,0,400+tubeLength]) NoseCone(72, internalDiameter, false, overlap, wallThicknes, holderBarLength, holderBarDiameter, tlrnc, noseConeType);
translate([0,0,250+tubeLength]) CamAltimeterTube(100, internalDiameter, wallThicknes, frameThicknes, overlap, holderBarLength, holderBarDiameter, tlrnc);
translate([0,0,200+tubeLength]) rotate([0, 0, 180]) TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc, rodDiam, perimeter);
translate([0,0,180]) MainTube(tubeLength, internalDiameter, wallThicknes, overlap, tlrnc);
translate([0,0,130]) rotate([0, 0, 180]) TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc, rodDiam, perimeter);
MotorMount(motorDiameter, motorLength, motorCount, overlap, internalDiameter, wallThicknes, finCount, motorStopperHeigh, finThicknes, finShape, finRotOffest, tlrnc);


for(i = [0:motorCount - 1]){
    rotate([0, 0, 360 / motorCount * i])
      translate([radiusS(motorCount, motorDiameter), 0, 0])
        translate([0,0, -15]) rotate([0, 0, 82]) MotorSaferKnob(motorDiameter, tlrnc);
  }

