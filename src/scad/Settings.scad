/// coments
//params
$fn=$preview ? 72 : 256;

///General config
tlrnc=0.1;

dz = 0.001; /// size difference for improve quick rendering

perimeter=0.45;
overlap=15;
wallThicknes=perimeter*3;
internalDiameter=35;
outerDiameter=internalDiameter + 2 * wallThicknes;
minPerimeters=2;
overlapMode=1;
frameThicknes=1.2;
rodDiam=9;

///Motors configuration
motorStopperHeigh=5;
motorCount=2;
motorDiameter=20;
motorLength=70;

///Fins configuration
finCount=4;
finRotOffest=-45;
finThicknes=perimeter*2;
finShape=[[0,7],[10,0],[40,0],[40,20],[40,30],[0,70]];
///finShape=[[0,7],[30,20],[30,40],[0,70]];
