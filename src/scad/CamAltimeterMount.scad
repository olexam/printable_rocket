use <NoseCone.scad>
use <components/Camera.scad>
use <MainTube.scad>
use <CamAltimeterFrame.scad>

/// coments
//params
// include <Settings.scad>

length=100;
internalDiameter=55;
holderBarLength = 3*internalDiameter/5;
holderBarDiameter=5;
wallThicknes = 0.45;
frameThicknes=1.2;
overlap=15;
tlrnc=0.1;


CamAltimeterTube(length, internalDiameter, wallThicknes, frameThicknes, overlap, holderBarLength, holderBarDiameter, tlrnc);

module CamAltimeterTube(length, internalDiameter, wallThicknes, frameThicknes, overlap, holderBarLength, holderBarDiameter, tlrnc) {
    difference() {
        outerTubeWithFitting(length, internalDiameter, overlap, wallThicknes,holderBarLength,holderBarDiameter,tlrnc);
        translate([0,internalDiameter/2 - 3, length - 3 ]) rotate([-40, 0, 0]) camera();
    }
    translate([internalDiameter/2-frameThicknes, 0, overlap]) slot(length - overlap, frameThicknes, tlrnc);
    rotate([0,0,180]) translate([internalDiameter/2-frameThicknes, 0, overlap]) slot(length - overlap, frameThicknes, tlrnc);
}

module outerTubeWithFitting(length, internalDiameter, overlap, wallThicknes,holderBarLength,holderBarDiameter,tlrnc) {
    holderBar(overlap,internalDiameter,wallThicknes,holderBarLength,holderBarDiameter);
    MainTube(length + 2* overlap, internalDiameter, wallThicknes, overlap, tlrnc);
}

module slot(l, wallThicknes, tlrnc) {
    zd = 0.001;
    translate([-wallThicknes, -3/2 *wallThicknes, 0]) difference() {
        cube([2*wallThicknes, 3*wallThicknes, l]);
        translate([-zd, wallThicknes - tlrnc, -zd])
            cube([2*(wallThicknes + zd), wallThicknes + 2*tlrnc, l + 2*zd]);
    }
}
