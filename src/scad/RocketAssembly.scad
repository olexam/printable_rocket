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
// holderBarLength = 3*internalDiameter/5;
// holderBarDiameter=5;

// motorCount=1;

translate([0,0,400+tubeLength]) NoseCone(72, internalDiameter);
translate([0,0,250+tubeLength]) rotate([0, 0, 180]) CamAltimeterTube();
translate([0,0,200+tubeLength]) TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc, rodDiam);
translate([0,0,180]) MainTube(tubeLength, internalDiameter, wallThicknes, overlap, tlrnc);
translate([0,0,130]) rotate([0, 0, 180]) TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc, rodDiam);
MotorMount(motorDiameter, motorLength, motorCount, tlrnc);

translate([0,0, -15]) rotate([0, 0, 82]) MotorSaferKnob();
