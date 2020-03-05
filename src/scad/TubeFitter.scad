use <MainTube.scad>
include <Settings.scad>
/// coments
//params


TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc, rodDiam);

module TubeFitter(internalDiameter, wallThicknes, overlap, tlrnc, rodDiam) {
    zd = 0.001; //size difference for improve quick rendering
    MainTube(2*overlap + 5, internalDiameter, wallThicknes, overlap, tlrnc);
    translate([0, (internalDiameter+rodDiam)/2+wallThicknes+perimeter, overlap])
        RodGuider(rodDiam, perimeter, tlrnc);
    translate([0, -(internalDiameter/2 + wallThicknes), overlap])
        leierHolder(overlap, internalDiameter, wallThicknes);
}

module RodGuider(rodDiam, perimeter, tlrnc) {
    zd = 0.001; //size difference for improve quick rendering
    h=rodDiam+3;
    difference() {
        cylinder(h=h, d=rodDiam + 3*perimeter);
        translate([0,0,-zd]) 
            cylinder(h=h+2*zd, d=rodDiam);
        translate([-rodDiam,-rodDiam/2,0]) rotate([-45,0,0]) cube([2*rodDiam, rodDiam, 2*rodDiam]);
    }
}

module leierHolder(overlap, internalDiameter, wallThicknes) {
    zd = 0.001; //size difference for improve quick rendering
    translate([-1,0,6]) rotate([0,90,0]) scale([2,1,1]) difference() {
        cylinder(h=2, d=6);
        translate([0,0,-zd]) 
            cylinder(h=2 + 2*zd, d=3);
        translate([-6,wallThicknes/3,-1]) cube([10,10,10]);
    }
}