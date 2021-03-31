use <NoseCone.scad>
use <components/Camera.scad>
use <MainTube.scad>
use <CamAltimeterFrame.scad>

/// coments
//params
include <Settings.scad>

CamAltimeterTube(100, internalDiameter, wallThickness, perimeter, frameThickness, overlap, holderBarLength, holderBarDiameter, tlrnc);

module CamAltimeterTube(length, internalDiameter, wallThickness, minWall, frameThickness, overlap, holderBarLength, holderBarDiameter, tlrnc) {
    difference() {
        outerTubeWithFitting(length, internalDiameter, overlap, wallThickness, minWall, holderBarLength, holderBarDiameter, tlrnc);
        translate([0,internalDiameter/2 - 3, length - 3 ]) rotate([-40, 0, 0]) camera();
    }
    translate([internalDiameter/2-frameThickness, 0, overlap]) slot(length - overlap, frameThickness, tlrnc);
    rotate([0,0,180]) translate([internalDiameter/2-frameThickness, 0, overlap]) slot(length - overlap, frameThickness, tlrnc);
}

module outerTubeWithFitting(length, internalDiameter, overlap, wallThickness, minWall, holderBarLength,holderBarDiameter,tlrnc) {
    holderBar(overlap,internalDiameter,wallThickness,holderBarLength,holderBarDiameter);
    MainTube(length + 2* overlap, internalDiameter, wallThickness, minWall, overlap, tlrnc);
}

module slot(l, wallThickness, tlrnc) {
    zd = 0.001;
    translate([-wallThickness, -3/2 *wallThickness, 0]) difference() {
        cube([2*wallThickness, 3*wallThickness, l]);
        translate([-zd, wallThickness - tlrnc, -zd])
            cube([2*(wallThickness + zd), wallThickness + 2*tlrnc, l + 2*zd]);
    }
}
