use <functions.scad>
// include <../Settings.scad>

// debug object
union() {
    wallThicknes=0.45*1;
    internalDiameter=50;
    overlap=15;
    
    $fn=150;
    tlrnc = 0.1;
    w=wallThicknes;
    translate ([0,0, 10]) 
        fitting(overlap, internalDiameter, w, tlrnc);
    topFitting(overlap, internalDiameter, w, tlrnc);
}


module interFit(dOut, intDiam) {
    angle=45;
    w = (dOut - intDiam)/2;
    sqSize = sqrt(w*w/2);
    rotate_extrude()
        translate([intDiam/2 + w/2, 0, 0]) 
            rotate([0,0,angle]) 
                square(sqSize, true);
}

module topFitting(ovrlp, intDiam, wlThckns, tlrnc=0.1) {
    interFitDiam = intDiam + wlThckns + 2*tlrnc;
    dOut = outerDiam(intDiam, wlThckns);
    fitterWall = (dOut - interFitDiam)/2;
    tube(ovrlp, interFitDiam, fitterWall);
    interFit(dOut, intDiam);
}

module fitting(ovrlp, intDiam, wlThckns, tlrnc=0.1) {
    interFitDiam = intDiam + wlThckns - 2*tlrnc;
    fitterWall = (interFitDiam - intDiam)/2;
    tube(ovrlp, intDiam, fitterWall);
    dOut = outerDiam(intDiam, wlThckns);
    translate([0,0,ovrlp]) 
        interFit(dOut, intDiam);
}

module tube(length, intDiam, wlThckns) {
    dz = 0.01; /// size difference for improve quick rendering
    difference() {
        cylinder(h=length, d=intDiam + 2*wlThckns);
        translate([0,0,-dz]) cylinder(h=length + 2*dz, d=intDiam);
    }
}
