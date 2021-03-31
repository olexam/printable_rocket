use <components/Fittings.scad>
/// coments
//params
// include <Settings.scad>

wallThicknes=0.45*2;
internalDiameter=55;
overlap=15;
tubeLength=100;
tlrnc = 0.1;
minWall=0.3;

MainTube(tubeLength, internalDiameter, wallThicknes, minWall, overlap, tlrnc);

module MainTube(length, intDiameter, wThickness, minWall, ovrlp, tlrnc) {
    translate([0, 0, length - ovrlp]) topFitting(ovrlp, intDiameter, wThickness, minWall, tlrnc);
    translate([0,0, ovrlp]) tube(length - 2* ovrlp, intDiameter, wThickness);
    fitting(ovrlp, intDiameter, wThickness, minWall, tlrnc);
}
