use <components/Fittings.scad>

/// coments
//params

$fn=100;
tlrnc=0.1;
overlap=15;
internalDiameter=27;
perimeter = 0.4;
wallThicknes = 3* perimeter;
length=72;
holderBarLength = 3*internalDiameter/5;
holderBarDiameter=5;

type=""; //"Power";//"TO";//"Conic";

/**
Parabola Type	K′ Value
--------------------------
Cone	0
Half	1/2
Three Quarter	3/4
Full	1
**/
K=1;

/**
Power Type	N Value
-----------------
Cylinder	0
Half (Parabola)	1/2
Three Quarter	3/4
Cone	1
**/
N=3/4;

/**
Haack Series Type	C Value
-------------------------
LD-Haack (Von Kármán)	0
LV-Haack	1/3
Tangent	2/3
**/
C=1/3;

NoseCone(length, internalDiameter);

module NoseCone(l, internalDiameter) {
    translate([0,0,overlap])  {
        cone(l,(internalDiameter+2*wallThicknes)/2);
    }
    holderBar(overlap,internalDiameter,wallThicknes,holderBarLength,holderBarDiameter);
    fitting(overlap, internalDiameter, wallThicknes, tlrnc);
}

module holderBar(overlap,internalDiameter,wallThicknes,holderBarLength,holderBarDiameter,tlrnc=0.1) {
    difference() {
        cylinder(h = overlap, d = internalDiameter);
        sphere(d = holderBarLength);
    }
    translate([0,holderBarLength/2,holderBarDiameter/2]) rotate([90, 0, 0]) cylinder(h=holderBarLength, d=holderBarDiameter);
}
module cone(l,r) {
    translate([0,0,l]) rotate([180,0,0]) {
        st=l/$fn;
        for(i=[0:st:l]) {
            translate([0, 0, i]) {
                if(type=="Conic") {
                    r1 = coneF(i, r, l);
                    r2 = coneF(i + st, r, l);
                    cylinder(h = st,r1=r1, r2=r2 );
                } else if(type=="Ogive") {
                    r1 = tangOgiveF(i, r, l);
                    r2 = tangOgiveF(i + st, r, l);
                    cylinder(h = st,r1=r1, r2=r2 );
                } else if(type=="Elliptical") {
                    r1 = elliptF(i, r, l);
                    r2 = elliptF(i + st, r, l);
                    cylinder(h = st,r1=r1, r2=r2 );
                } else if(type=="Parabolic") {
                    r1 = parabF(i, r, l);
                    r2 = parabF(i + st, r, l);
                    cylinder(h = st,r1=r1, r2=r2 );
                } else if(type=="Power") {
                    r1 = powerF(i, r, l);
                    r2 = powerF(i + st, r, l);
                    cylinder(h = st,r1=r1, r2=r2 );
                } else {
                    r1 = haackF(i, r, l);
                    r2 = haackF(i + st, r, l);
                    cylinder(h = st,r1=r1, r2=r2 );
                }
            }
        }
    }
}

function coneF(x,r,l) = x*r/l;
function tangOgiveF(x,r,l) = sqrt(pow(tangOgiveQ(r,l),2) - pow(l - x,2)) + r -tangOgiveQ(r,l);
function tangOgiveQ(r,l) = (r*r + l*l)/(2*r);
function elliptF(x, r, l) = r * sqrt(1-pow(l - x, 2)/pow(l, 2));
function parabF(x,r,l) = r * ((2*x/l -K*pow(x/l,2))/(2-K));
function powerF(x,r,l) = r * pow(x/l, N);
function hA(x,l) = acos(1-2*x/l);
function haackF(x,r,l) = r * sqrt(hA(x,l)*PI/180 - sin(2*hA(x,l))/2 + C * pow(sin(hA(x,l)),3))/sqrt(PI);
