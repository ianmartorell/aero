NACA = '2212';
angleOfAttack = 4;
flapPosition = 1;
flapAngle = 0;
distribution = 'fullCosine';
nPanels = 128;

clArray1 = [];
clArray2 = [];
cmLEArray1 = [];
cmLEArray2 = [];
NACAArray = [];

% Fixing p
for i = 1:9
  NACA(1) = num2str(i);
  camberLine = airfoil(NACA, flapPosition, flapAngle, nPanels, distribution);
  % Compute cl and cmLE for -4 and 4 degrees so we can draw a line
  [ circulation, cl, cmLE ] = DVM(camberLine, -4);
  clArray1 = [ clArray1 cl];
  cmLEArray1 = [ cmLEArray1 cmLE ];
  [ circulation, cl, cmLE ] = DVM(camberLine, 4);
  clArray2 = [ clArray2 cl];
  cmLEArray2 = [ cmLEArray2 cmLE ];
  NACAArray = [ NACAArray str2double(NACA) ];
end

NACA = '2212';
% Fixing f
for i = 1:9
  NACA(2) = num2str(i);
  camberLine = airfoil(NACA, flapPosition, flapAngle, nPanels, distribution);
  % Compute cl and cmLE for -4 and 4 degrees so we can draw a line
  [ circulation, cl, cmLE ] = DVM(camberLine, -4);
  clArray1 = [ clArray1 cl];
  cmLEArray1 = [ cmLEArray1 cmLE ];
  [ circulation, cl, cmLE ] = DVM(camberLine, 4);
  clArray2 = [ clArray2 cl];
  cmLEArray2 = [ cmLEArray2 cmLE ];
  NACAArray = [ NACAArray str2double(NACA) ];
end

csvwrite('data/discussion.csv', [ NACAArray; clArray1; clArray2; cmLEArray1; cmLEArray2 ]);
