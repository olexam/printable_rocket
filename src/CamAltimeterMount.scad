use <NoseCone.scad>
use <Camera.scad>
use <MainTube.scad>
use <CamAltimeterFrame.scad>

/// coments
//params

$fn=100;
tlrnc=0.1;
overlap=15;
internalDiameter=27;
perimeter = 0.4;
wallThicknes = 3* perimeter;
length=100;
holderBarLength = 3*internalDiameter/5;
holderBarDiameter=5;


tubeWuthWhole();

module tubeWuthWhole() {
    difference() {
        outerTubeWithFitting(length, internalDiameter);
        translate([0,internalDiameter/2 - 3, length - 3 ]) rotate([-40, 0, 0]) #camera(); 
    }
    translate([internalDiameter/2-wallThicknes, 0, 0]) slot(length);
    rotate([0,0,180]) translate([internalDiameter/2-wallThicknes, 0, 0]) slot(length);
}

module outerTubeWithFitting(l, internalDiameter) {
    holderBar(overlap,internalDiameter,wallThicknes,holderBarLength,holderBarDiameter);
    MainTube(length + 2* overlap, internalDiameter, wallThicknes, overlap, tlrnc);
}

module slot(l) {
    translate([-wallThicknes, -3/2 *wallThicknes, 0]) difference() {
        cube([2*wallThicknes,3 *wallThicknes, l]);
        translate([0, wallThicknes + tlrnc, 0]) cube([2*wallThicknes,wallThicknes + 2*tlrnc, l]);
    }
}


