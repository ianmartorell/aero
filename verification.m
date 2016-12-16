NACA = '2212';
chord = 1;
freestreamVelocity = 1;
angleOfAttack = 4;
flapPosition = 1;
flapAngle = 5;
distribution = "fullCosine";

clArray = [];
cmLEArray = [];
nPanels = [];

iPanels = 4;
while (iPanels < 256)
  camberLine = airfoil(NACA, chord, flapPosition, flapAngle, iPanels, distribution);
  [ circulation, cl, cmLE ] = DVM(camberLine, chord, freestreamVelocity, angleOfAttack);
  clArray = [ clArray cl ];
  cmLEArray = [ cmLEArray cmLE ];
  nPanels = [ nPanels iPanels ];
  iPanels = iPanels * 2;
end

% disp(clArray);
% disp(cmLEArray);
plotyy(nPanels, clArray, nPanels, cmLEArray);
