use <components/Fittings.scad>
/// coments
//params
// include <Settings.scad>

wallThicknes=0.45*1;
internalDiameter=55;
overlap=15;
tubeLength=100;
tlrnc = 0.1;

MainTube(tubeLength, internalDiameter, wallThicknes, overlap, tlrnc);

module MainTube(length, intDiameter, wThickness, ovrlp, tlrnc) {
    translate([0, 0, length - ovrlp]) topFitting(ovrlp, intDiameter, wThickness, tlrnc);
    translate([0,0, ovrlp]) tube(length - 2* ovrlp, intDiameter, wThickness);
    fitting(ovrlp, intDiameter, wThickness, tlrnc);
}
