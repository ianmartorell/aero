NACA = '2212';
chord = 1;
freestreamVelocity = 1;
angleOfAttack = 5;
flapPosition = 0.8;
flapAngle = 5;
distribution = "fullCosine";

CLArray = [];
CMArray = [];
nPanels = [];

iPanels = 4;
while (iPanels < 256)
  camberLine = airfoil(NACA, chord, flapPosition, flapAngle, iPanels, distribution);
  [ CL, CM ] = DVM(camberLine, chord, freestreamVelocity, angleOfAttack);
  CLArray = [ CLArray CL ];
  CMArray = [ CMArray CM ];
  nPanels = [ nPanels iPanels ];
  iPanels = iPanels * 2;
end

plotyy(nPanels, CLArray, nPanels, CMArray);