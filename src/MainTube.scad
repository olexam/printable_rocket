/// coments
//params

$fn=100;
tlrnc=0.1;
overlap=15;
internalDiameter=27;
perimeter = 0.4;
wallThicknes = 3* perimeter;
length=200;

MainTube(length, internalDiameter, wallThicknes, overlap, tlrnc);

module MainTube(length, internalDiameter, wallThicknes, overlap, tlrnc) {
    difference() {
        difference() {
            cylinder(h=length, d=internalDiameter + 2*wallThicknes);
            union() {
                h = (internalDiameter + wallThicknes - tlrnc - internalDiameter)/2;
                translate([0,0, length-overlap]) 
                    cylinder(h=overlap, d=internalDiameter + wallThicknes - tlrnc);
                translate([0,0, length-overlap-h]) 
                    cylinder(h=h, d1=internalDiameter, d2=internalDiameter + wallThicknes - tlrnc);
                cylinder(h=length, d=internalDiameter);
            }
        }
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