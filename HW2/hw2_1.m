aspectRatios = 6:12;
taperRatio = 1;
quarterChordSweep = 0;
wingTipTwist = 0;
horseshoeShape = 'rectangular';
nPanels = 100;
% Initialize output vector
cLAlphas = [];
for aspectRatio = aspectRatios
  % Compute cL for -2 and 2 degrees so we can draw a line
  [ cL1 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, horseshoeShape, nPanels);
  [ cL2 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, 2, wingTipTwist, horseshoeShape, nPanels);
  cLAlphas = [ cLAlphas; (cL2-cL1)/4 ];
end

csvwrite('data/hw2_1.csv', [ aspectRatios' cLAlphas ]);
