function [ cm0 ] = hw2_5_cm0()
  NACA = '2412';
  flapPosition = 1;
  flapAngle = 0;
  nPanels = 100;
  distribution = 'fullCosine';
  angleOfAttack = 0;

  camberLine = airfoil(NACA, flapPosition, flapAngle, nPanels, distribution);
  [ circulation, cl, cmLE ] = DVM(camberLine, angleOfAttack);
  cm0 = cmLE - cl/4;
end
