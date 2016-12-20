function [ clArray, clErrorArray, cmLEArray, nPanels ] = verification_helper(distribution)
  clReference = 0.63590677;

  NACA = '2212';
  angleOfAttack = 4;
  flapPosition = 1;
  flapAngle = 0;

  clArray = [];
  clErrorArray = [];
  cmLEArray = [];
  nPanels = [];
  iPanels = 4;
  while (iPanels <= 256)
    camberLine = airfoil(NACA, flapPosition, flapAngle, iPanels, distribution);
    [ circulation, cl, cmLE ] = DVM(camberLine, angleOfAttack);
    clArray = [ clArray; cl ];
    clErrorArray = [ clErrorArray; (abs(cl-clReference))/clReference*100 ];
    cmLEArray = [ cmLEArray; cmLE ];
    nPanels = [ nPanels; iPanels ];
    iPanels = iPanels * 2;
  end
end
