use <Camera.scad>
use <CamAltimeterMount.scad>
include <Settings.scad>

camL=14;
camW=18;

GyroHolder(internalDiameter - 2*tlrnc, wallThicknes, tlrnc);

module GyroHolder(internalDiameter, wallThicknes, tlrnc) {
    zd = 0.001;
    difference() {
        cylinder(d=internalDiameter, h=wallThicknes);
        translate([internalDiameter/4, -internalDiameter/2, -zd]) cube([internalDiameter, internalDiameter, wallThicknes+2*zd]);
    }
    slotL = 3*wallThicknes;
    translate([0, internalDiameter/2 - slotL - 2*wallThicknes, -wallThicknes]) {
        rotate([0,90,90]) slot(slotL, wallThicknes, tlrnc);  
    }
    translate([0, -internalDiameter/2 + 2*wallThicknes, -wallThicknes]) {
        rotate([0,90,90]) slot(slotL, wallThicknes, tlrnc);  
    }

}
