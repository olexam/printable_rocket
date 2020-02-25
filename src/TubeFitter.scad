use <MainTube.scad>
/// coments
//params

$fn=100;
tlrnc=0.1;
overlap=15;
internalDiameter=27;
perimeter = 0.4;
wallThicknes = 3* perimeter;
length=200;
rodDiam=8;


TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc, rodDiam);

module TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc=0.1, rodDiam=8) {
    MainTube(2*overlap + 5, internalDiameter, wallThicknes, overlap, tlrnc);
    translate([0, internalDiameter/2 +wallThicknes, overlap])
        RodGuider(rodDiam, perimeter, tlrnc);
    translate([0, -(internalDiameter/2+wallThicknes), overlap])
    translate([0,0,5]) rotate([0,90,0]) scale([2,1,1]) difference() {
        cylinder(h=1, d=5);
        cylinder(h=1, d=3);
        translate([-5,0,0]) cube([10,10,10]);
    }
}

module RodGuider(rodDiam, perimeter, tlrnc) {
    translate([0,rodDiam/2 + perimeter-tlrnc,0])
    difference() {
        h=rodDiam+3;
        cylinder(h=h, d=rodDiam + 2*perimeter);
        cylinder(h=h, d=rodDiam);
        translate([-rodDiam,-rodDiam/2,0]) rotate([-45,0,0]) cube([2*rodDiam,rodDiam,2*rodDiam]);
    }
}
