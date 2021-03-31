use <MainTube.scad>
include <Settings.scad>
/// coments
//params

TubeFitter(internalDiameter, wallThickness, overlap, tlrnc, rodDiam, perimeter);

module TubeFitter(internalDiameter, wallThickness, overlap, tlrnc, rodDiam, minWall) {
    zd = 0.001; //size difference for improve quick rendering
    MainTube(2*overlap + 5, internalDiameter, wallThickness, minWall, overlap, tlrnc);
    translate([0, (internalDiameter+rodDiam)/2+wallThickness + minWall, overlap])
        RodGuider(rodDiam, minWall, tlrnc);
    translate([0, -(internalDiameter/2 + wallThickness), overlap])
        leierHolder(overlap, internalDiameter, wallThickness);
}

module RodGuider(rodDiam, minWall, tlrnc) {
    zd = 0.001; //size difference for improve quick rendering
    h=rodDiam+3;
    difference() {
        cylinder(h=h, d=rodDiam + 3*minWall);
        translate([0,0,-zd]) 
            cylinder(h=h+2*zd, d=rodDiam);
        translate([-rodDiam,-rodDiam/2,0]) rotate([-45,0,0]) cube([2*rodDiam, rodDiam, 2*rodDiam]);
    }
}

module leierHolder(overlap, internalDiameter, wallThickness) {
    zd = 0.001; //size difference for improve quick rendering
    translate([-1,0,6]) rotate([0,90,0]) scale([2,1,1]) difference() {
        cylinder(h=2, d=6);
        translate([0,0,-zd]) 
            cylinder(h=2 + 2*zd, d=3);
        translate([-6,wallThickness/3,-1]) cube([10,10,10]);
    }
}