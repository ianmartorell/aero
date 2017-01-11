NACA = '2412';
flapPosition = 1;
flapAngle = 0;
nPanels = 100;
distribution = 'fullCosine';
angleOfAttack = 0;
chordPoly = [ -0.0833 0.16666 ];

alphas = -1.7:0.01:-1.6;
clArray = [];
for i=alphas
  camberLine = airfoil(NACA, flapPosition, flapAngle, nPanels, distribution);
  [ circulation, cl ] = DVM(camberLine, i);
  clArray = [ clArray; cl ];
end
csvwrite('data/hw2_5_cl.csv', [ alphas' clArray ]);
