module topFitting(overlap, internalDiameter, wallThicknes, tlrnc=0.1) {
    h = (internalDiameter + wallThicknes - tlrnc - internalDiameter)/2;
    difference() {
        cylinder(h=overlap, d=internalDiameter + 2*wallThicknes);
        cylinder(h=overlap+tlrnc, d=internalDiameter);
        difference() {
            union() {
                cylinder(h=overlap+tlrnc, d=internalDiameter + wallThicknes - tlrnc);
                translate([0,0, -h])
                    cylinder(h=h, d1=internalDiameter, d2=internalDiameter + wallThicknes - tlrnc);
            }
            cylinder(h=overlap + 2*h, d=internalDiameter);
        }
    }
}

module fitting(overlap, internalDiameter, wallThicknes, tlrnc=0.1) {
    difference() {
        cylinder(h=overlap, d=internalDiameter + 2*wallThicknes);
        cylinder(h=overlap + tlrnc, d=internalDiameter);
        difference() {
            h = (wallThicknes + 2*tlrnc)/2;
            cylinder(h=overlap, d=internalDiameter + 2*wallThicknes + tlrnc);
            union() {
                cylinder(h=overlap , d=internalDiameter + wallThicknes);
                translate([0,0,overlap-h])cylinder(h=h, d2=internalDiameter + 2*wallThicknes + tlrnc, d1=internalDiameter + wallThicknes-2*tlrnc);
            }
        }
    }
}

module tube(length, internalDiameter, wallThicknes) {
    difference() {
        cylinder(h=length, d=internalDiameter + 2*wallThicknes);
        cylinder(h=length, d=internalDiameter);
    }
}
