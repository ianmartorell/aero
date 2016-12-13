NACA = '2212';
chord = 1;
freestreamVelocity = 1;
angleOfAttack = 5;
flapPosition = 0.8;
flapAngle = 5;
distribution = "fullCosine";

ClArray = [];
CmLEArray = [];
nPanels = [];

iPanels = 4;
while (iPanels < 256)
  camberLine = airfoil(NACA, chord, flapPosition, flapAngle, iPanels, distribution);
  [ Cl, CmLE ] = DVM(camberLine, chord, freestreamVelocity, angleOfAttack);
  ClArray = [ ClArray Cl ];
  CmLEArray = [ CmLEArray CmLE ];
  nPanels = [ nPanels iPanels ];
  iPanels = iPanels * 2;
end

plotyy(nPanels, ClArray, nPanels, CmLEArray);
