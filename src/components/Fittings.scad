// debug object
union() {
    $fn=150;
    tlrnc = 0.35;
    w=1.4;
    topFitting(15, 30, w, tlrnc=tlrnc);

    translate ([0,0, 15]) fitting(15, 30, w, tlrnc=tlrnc);
}

module topFitting(overlap, internalDiameter, wallThicknes, tlrnc=0.1) {
    zd = 0.001; //size difference for improve quick rendering

    h = (wallThicknes - tlrnc)/2;
    outerDiameter = internalDiameter + 2 * wallThicknes;
    interFitDiam = internalDiameter + wallThicknes + tlrnc*2;
    echo(str(">>> topFitting::Outer Diameter=", outerDiameter));
    echo(str(">>> topFitting::Inner diameter=", interFitDiam));
    difference() {
        cylinder(h=overlap, d=outerDiameter);
            union() {
                translate([0,0,h]) cylinder(h=overlap, d=interFitDiam);
                cylinder(h=h+zd, d1=internalDiameter, d2=interFitDiam);
            }
            translate([0,0,-zd]) cylinder(h=overlap + 2*zd, d=internalDiameter);
    }
}

module fitting(overlap, internalDiameter, wallThicknes, tlrnc=0.1) {
    zd = 0.001; //size difference for improve quick rendering
    
    outerDiameter = internalDiameter + 2 * wallThicknes;
    interFitDiam = internalDiameter + wallThicknes - tlrnc*2;
    h = (wallThicknes - tlrnc)/2;
    echo(str(">>> fitting::Outer Diameter=", outerDiameter));
    echo(str(">>> fitting::Inner diameter=", interFitDiam));

    difference() {
        difference() {
            union() {
                cylinder(h=overlap, d=interFitDiam);
                translate([0,0,overlap-h])cylinder(h=h, d1=interFitDiam, d2=outerDiameter);
            }
        }
        translate([0,0,-zd]) cylinder(h=overlap + 2*zd, d=internalDiameter);
    }
}

module tube(length, internalDiameter, wallThicknes) {
    zd = 0.001; //size difference for improve quick rendering
    difference() {
        cylinder(h=length, d=internalDiameter + 2*wallThicknes);
        translate([0,0,-zd]) cylinder(h=length + 2*zd, d=internalDiameter);
    }
}
