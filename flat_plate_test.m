NACA = '0112';
freestreamVelocity = 1;
angleOfAttack = 5;
flapPosition = 1;
flapAngle = 0;
nPanels = 5;
distribution = 'linear';
circulationExample = [2.46094; 1.09375; 0.70312; 0.46875; 0.27344];

camberLine = airfoil(NACA, flapPosition, flapAngle, nPanels, distribution);
[ circulation ] = DVM(camberLine, freestreamVelocity, angleOfAttack);
circulation = circulation/sind(5)*5/pi;
disp('Γ/(π*∆c*U*sin(a))=');
disp(circulation);
disp('Should be:');
disp(circulationExample);
