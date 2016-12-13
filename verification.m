NACA = '2212';
chord = 1;
freestreamVelocity = 1;
angleOfAttack = 5;
flapPosition = 0.8;
flapAngle = 5;
distribution = "fullCosine";

clArray = [];
CmLEArray = [];
nPanels = [];

iPanels = 4;
while (iPanels < 256)
  camberLine = airfoil(NACA, chord, flapPosition, flapAngle, iPanels, distribution);
  [ circulation, cl, cmLE ] = DVM(camberLine, chord, freestreamVelocity, angleOfAttack);
  clArray = [ clArray cl ];
  CmLEArray = [ CmLEArray cmLE ];
  nPanels = [ nPanels iPanels ];
  iPanels = iPanels * 2;
end

plotyy(nPanels, clArray, nPanels, CmLEArray);
