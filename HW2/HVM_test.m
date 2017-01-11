aspectRatio = 8;
taperRatio = 0.5;
quarterChordSweep = 60;
angleOfAttack = 2;
wingTipTwist = 0;
horseshoeShape = 'trapezoidal';
nPanels = 4;
[ cL cLY cDi ] = HVM(aspectRatio, taperRatio, quarterChordSweep, angleOfAttack, wingTipTwist, horseshoeShape, nPanels);
cL
cLY
cDi
