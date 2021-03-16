
camera();

module
camera()
{
    objLength = 8;
    objD = 12;
    camW = 14;
    camL = 14;
    camH = 8;

    union()
    {
        translate([ 0, -objLength - camH / 2, 0 ]) rotate([ 90, 0, 0 ])
            cube([ camL, camW, camH ], center = true);
        rotate([ 90, 0, 0 ]) translate([ 0, 0, -objLength ]) cylinder(h = 2 * objLength, d = objD);
        translate([ 0, -4, 0 ]) rotate([ 90, 0, 0 ]) viewField();
    }
}

module
viewField()
{
    hAng1 = 60;
    hAng2 = 60;
    vAng1 = 82 - 45;
    vAng2 = 45;
    coneHeight = 100;

    w1 = tan(hAng1) * coneHeight;
    w2 = -tan(hAng2) * coneHeight;
    h1 = tan(vAng1) * coneHeight;
    h2 = -tan(vAng2) * coneHeight;

    translate([ 0, 0, -coneHeight ]) polyhedron(
        points = [[w1, h1, 0], [w1, h2, 0], [w2, h2, 0], [w2, h1, 0], [0, 0, coneHeight]],
        faces = [ [ 0, 1, 4 ], [ 1, 2, 4 ], [ 2, 3, 4 ], [ 3, 0, 4 ], [ 1, 0, 3 ], [ 2, 1, 3 ] ]);
}
