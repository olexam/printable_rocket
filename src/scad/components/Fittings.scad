// debug object
union() {
    $fn=150;
    tlrnc = 0.5;
    w=1.2;
    topFitting(15, 30, w, tlrnc=tlrnc);

    translate ([0,0, 16]) fitting(15, 30, w, tlrnc=tlrnc);

    translate ([0,40, 0]) tube(15, 30, w);
}

module topFitting(overlap, internalDiameter, wallThicknes, tlrnc=0.1) {
    zd = 0.001; //size difference for improve quick rendering

    outerDiameter = internalDiameter + 2*wallThicknes;
    interFitDiam = internalDiameter + 2*tlrnc;
    h = (outerDiameter - interFitDiam);
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
    internalD = internalDiameter - wallThicknes - tlrnc*2;
    h = (outerDiameter - interFitDiam)/2;
    echo(str(">>> fitting::Outer Diameter=", outerDiameter));
    echo(str(">>> fitting::Inner diameter=", interFitDiam));

    translate([0,0,overlap]) difference() {
        cylinder(h=h, d=internalDiameter);
        translate([0,0,-zd]) cylinder(h=h+2*zd, d2=internalDiameter, d1=internalD);
    }
    difference() {
        union() {
            cylinder(h=overlap, d=interFitDiam);
            translate([0,0,overlap-h])cylinder(h=h, d1=interFitDiam, d2=outerDiameter);
        }
        translate([0,0,-zd]) cylinder(h=overlap + 2*zd, d=internalD);
    }
}

module tube(length, internalDiameter, wallThicknes) {
    zd = 0.001; //size difference for improve quick rendering
    difference() {
        cylinder(h=length, d=internalDiameter + 2*wallThicknes);
        translate([0,0,-zd]) cylinder(h=length + 2*zd, d=internalDiameter);
    }
}
