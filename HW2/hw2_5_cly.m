aspectRatio = 8;
taperRatio = 0.5;
quarterChordSweep = quarter_chord_sweep(10.61, aspectRatio, taperRatio);
angleOfAttack = 0;
wingTipTwist = 0;
horseshoeShape = 'rectangular';
nPanels = 100;
% We transform panels to wing span from -0.5 to 0.5
% wingSpan = ((1:nPanels)'-nPanels/2)/100;
wingSpan = (1:nPanels)';
[ cL1, cLY1 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, horseshoeShape, nPanels);
[ cL2, cLY2 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, 2, wingTipTwist, horseshoeShape, nPanels);

csvwrite('data/hw2_5_cly.csv', [ wingSpan (cLY1-cLY2)/(cL1-cL2) ]);
