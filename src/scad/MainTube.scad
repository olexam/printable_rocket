use <components/Fittings.scad>
/// coments
//params
include <Settings.scad>


length=200;

MainTube(length, internalDiameter, wallThicknes, overlap, tlrnc);

module MainTube(length, internalDiameter, wallThicknes, overlap, tlrnc) {
    zd = 0.001; //size difference for improve quick rendering

    translate([0, 0, length - overlap]) topFitting(overlap, internalDiameter, wallThicknes, tlrnc);
    translate([0,0, overlap]) tube(length - 2* overlap, internalDiameter, wallThicknes);
    fitting(overlap, internalDiameter, wallThicknes, tlrnc);
}
