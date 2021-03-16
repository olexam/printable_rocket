use <MainTube.scad>
use <NoseCone.scad>
use <MotorMount.scad>
use <TubeFitter.scad>
use <CamAltimeterMount.scad>
use <MotorSaferKnob.scad>

/// coments
//params

include <Settings.scad>

translate([0,0,450+2* tubeLength]) NoseCone(72, internalDiameter, true, overlap, wallThickness, holderBarLength, holderBarDiameter, tlrnc, noseConeType);
translate([0,0,300+2* tubeLength]) CamAltimeterTube(100, internalDiameter, wallThickness, frameThickness, overlap, holderBarLength, holderBarDiameter, tlrnc);
translate([0,0,250+2 * tubeLength]) rotate([0, 0, 180]) TubeFitter(internalDiameter, wallThickness, overlap, tlrnc, rodDiam, perimeter);
translate([0,0,200 + tubeLength]) MainTube(tubeLength, internalDiameter, wallThickness, overlap, tlrnc);
translate([0,0,180]) MainTube(tubeLength, internalDiameter, wallThickness, overlap, tlrnc);
translate([0,0,130]) rotate([0, 0, 180]) TubeFitter(internalDiameter, wallThickness, overlap, tlrnc, rodDiam, perimeter);
MotorMount(motorDiameter, motorLength, motorCount, overlap, internalDiameter, wallThickness, finCount, motorStopperHeigh, finThickness, finShape, finRotOffest, tlrnc);

for(i = [0:motorCount - 1]) {
    rotate([0, 0, 360 / motorCount * i])
      translate([radiusS(motorCount, motorDiameter), 0, 0])
        translate([0,0, -15]) 
            rotate([0, 0, 82]) 
                MotorSaferKnob(motorDiameter, tlrnc);
}

