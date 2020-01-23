
$fn=100;

length=13;
diam=5.3;
topSphereRadius=1.6;

stubBaseHeight=5;
stubBaseRadius=3.5;

stubMedHeight=2;

cylinder(h=stubBaseHeight, r=stubBaseRadius);
translate([0,0,stubBaseHeight]) {
    cylinder(h=stubMedHeight, r1=stubBaseRadius, d2=diam);
    translate([0,0,stubMedHeight]) {
        cylinder(h=length, d1=diam, r2 = topSphereRadius);
        translate([0,0,length]) sphere(topSphereRadius);
    }
}