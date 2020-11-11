include <../Settings.scad>

// debug object
union() {
    $fn=150;
    tlrnc = 0.2;
    w=wallThicknes;
    translate ([0,0, 10]) fitting(15, internalDiameter, w, tlrnc=tlrnc);
    topFitting(15, internalDiameter, w, tlrnc=tlrnc);
}

module interFit(outerDiameter, internalDiameter) {
    angle=45;
    w = (outerDiameter - internalDiameter)/2;
    sqSize = sqrt(w*w/2);
    rotate_extrude()
        translate([internalDiameter/2 + w/2, 0, 0]) 
            rotate([0,0,angle]) 
                square(sqSize, true);
}

module topFitting(overlap, internalDiameter, wallThicknes, tlrnc=0.1) {
    interFitDiam = internalDiameter + wallThicknes + 2*tlrnc;
    h = (outerDiameter - interFitDiam)/2;
    tube(overlap, interFitDiam, h);
    interFit(outerDiameter, internalDiameter);
}

module fitting(overlap, internalDiameter, wallThicknes, tlrnc=0.1) {
    interFitDiam = internalDiameter + wallThicknes - 2*tlrnc;
    h = (interFitDiam - internalDiameter)/2;
    tube(overlap, internalDiameter, h);
    translate([0,0,overlap]) 
        interFit(outerDiameter, internalDiameter);
}

module tube(length, internalDiameter, wallThicknes) {
    difference() {
        cylinder(h=length, d=internalDiameter + 2*wallThicknes);
        translate([0,0,-dz]) cylinder(h=length + 2*dz, d=internalDiameter);
    }
}
