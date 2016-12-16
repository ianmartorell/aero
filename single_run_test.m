NACA = '2112';
freestreamVelocity = 1;
angleOfAttack = 4;
flapPosition = 1;
flapAngle = 0;
distribution = 'linear';
nPanels = 99;

camberLine = airfoil(NACA, flapPosition, flapAngle, nPanels, distribution);
[ circulation, cl, cmLE ] = DVM(camberLine, freestreamVelocity, angleOfAttack);
disp('cl:');
disp(cl);
disp('cmLE:');
disp(cmLE);
