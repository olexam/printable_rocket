use <components/Fittings.scad>
/// coments
//params

$fn=100;
tlrnc=0.1;
overlap=15;
internalDiameter=27;
perimeter = 0.4;
wallThicknes = 3* perimeter;
length=200;

MainTube(length, internalDiameter, wallThicknes, overlap, tlrnc);

module MainTube(length, internalDiameter, wallThicknes, overlap, tlrnc) {
    translate([0, 0, length - overlap]) topFitting(overlap, internalDiameter, wallThicknes);
    translate([0,0, overlap]) tube(length - 2* overlap, internalDiameter, wallThicknes);
    fitting(overlap, internalDiameter, wallThicknes);
}
