use <MainTube.scad>
use <NoseCone.scad>
use <MotorMount.scad>
use <TubeFitter.scad>

/// coments
//params

$fn=100;
tlrnc=0.1;
overlap=15;
internalDiameter=27;
perimeter = 0.4;
wallThicknes = 3* perimeter;
tubeLength=200;
holderBarLength = 3*internalDiameter/5;
holderBarDiameter=5;

MotorMount(20, 70, 2);
translate([0,0,130]) TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc);
translate([0,0,170]) MainTube(tubeLength, internalDiameter, wallThicknes, overlap, tlrnc);
translate([0,0,180+tubeLength]) TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc);
translate([0,0,220+tubeLength]) NoseCone(72, internalDiameter);
