aspectRatio = 8;
taperRatio = 0.5;
quarterChordSweep = quarter_chord_sweep(10.61, aspectRatio, taperRatio);
angleOfAttack = 0;
wingTipTwist = 0;
horseshoeShape = 'trapezoidal';
nPanels = 100;

[ cL1 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, horseshoeShape, nPanels);
[ cL2 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, 2, wingTipTwist, horseshoeShape, nPanels);

cLalpha = (cL2-cL1)/4
