aspectRatio = 8;
taperRatio = 0.5;
quarterChordSweep = quarter_chord_sweep(10.61, aspectRatio, taperRatio);
angleOfAttack = 0;
wingTipTwist = 0;
horseshoeShape = 'trapezoidal';
nPanels = 100;
% We transform panels to wing span from -0.5 to 0.5
% wingSpan = ((1:nPanels)'-nPanels/2)/nPanels;
wingSpan = (1:nPanels)';
[ cL, cLY, cDi, alpha_i ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, horseshoeShape, nPanels);

shit = -0.30665*alpha_i+0.509039;
sum(shit)
csvwrite('data/hw2_5_alpha_i.csv', [ wingSpan shit ]);
