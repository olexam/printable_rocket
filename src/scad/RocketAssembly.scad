use <MainTube.scad>
use <NoseCone.scad>
use <MotorMount.scad>
use <TubeFitter.scad>
use <CamAltimeterMount.scad>

/// coments
//params

include <Settings.scad>

tubeLength=80;
holderBarLength = 3*internalDiameter/5;
holderBarDiameter=5;

MotorMount(20, 70, 2);
translate([0,0,130]) TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc);
translate([0,0,180]) MainTube(tubeLength, internalDiameter, wallThicknes, overlap, tlrnc);
translate([0,0,200+tubeLength]) tubeWithWhole();
translate([0,0,350+tubeLength]) TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc);
translate([0,0,400+tubeLength]) NoseCone(72, internalDiameter);
