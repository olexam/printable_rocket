use <functions.scad>
// include <../Settings.scad>

// debug object
union() {
    w=2;
    internalDiameter=50;
    overlap=15;
    perimeter=2;    
    $fn=150;
    tlrnc = 0.5;

    tOver=10;

    topFitting(overlap, internalDiameter, w, perimeter, tlrnc);
    translate ([0,0, tOver]) fitting(overlap, internalDiameter, w, perimeter, tlrnc);
    translate ([0,0, -overlap/2]) color([0/255, 128/255, 0/255]) tube(overlap/2, internalDiameter, w);
    translate ([0,0, tOver + overlap]) color([0/255, 128/255, 0/255]) tube(overlap/2, internalDiameter, w);
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

module topFitting(ovrlp, intDiam, wlThckns, minWall, tlrnc) {
    axDiam = intDiam + wlThckns;
    interFitDiam = axDiam + tlrnc;
    dOut = outerDiam(intDiam, wlThckns);
    fitterWall = (dOut - interFitDiam)/2 < minWall ? minWall : (dOut - interFitDiam)/2;
    tube(ovrlp, interFitDiam, fitterWall);
    interFit(interFitDiam + fitterWall * 2, intDiam);
}

module fitting(ovrlp, intDiam, wlThckns, minWall, tlrnc) {
    axDiam = intDiam + wlThckns;
    interFitDiam = axDiam - tlrnc;

    fitterWall = (interFitDiam - intDiam)/2 < minWall ? minWall : (interFitDiam - intDiam)/2;
    fitInDiam = interFitDiam - fitterWall*2;
    tube(ovrlp, fitInDiam, fitterWall);
    dOut = outerDiam(intDiam, wlThckns);
    translate([0,0,ovrlp]) 
        interFit(dOut, fitInDiam);
}

module tube(length, intDiam, wlThckns) {
    dz = 0.1; /// size difference for improve quick rendering
    difference() {
        cylinder(h=length, d=intDiam + 2 * wlThckns);
        translate([0,0,-dz]) cylinder(h=length + 2*dz, d=intDiam);
    }
}
