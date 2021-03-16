/// coments
//params
$fn=$preview ? 72 : 256;

///General config
tlrnc=0.1;

perimeter=0.5;
overlap=15;
wallThicknes=perimeter*2;
internalDiameter=35;
minPerimeters=2;
frameThicknes=1.2;
rodDiam=9;
tubeLength=100;

// Nose cone
holderBarLength = 3*internalDiameter/5;
holderBarDiameter=5;
//"Power";//"Parabolic";//"Conic";//"Elliptical";//"Ogive";//"Haak";
noseConeType="Haak";

///Motors configuration
motorStopperHeigh=5;
motorCount=1;
motorDiameter=20;
motorLength=70;

///Fins configuration
finCount=4;
finRotOffest=0;
finThicknes=perimeter*2;
finShape=[[0,7],[10,0],[40,0],[40,20],[40,30],[0,70]];
///finShape=[[0,7],[30,20],[30,40],[0,70]];
