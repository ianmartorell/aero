aspectRatios = 6:11;
taperRatio = 1;
quarterChordSweep = 0;
wingTipTwist = 0;
nPanels = 100;
% Initialize output vector
cLAlphas = [];
for aspectRatio = aspectRatios
  % Compute cL for -2 and 2 degrees so we can draw a line
  [ cL1 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, nPanels);
  [ cL2 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, 2, wingTipTwist, nPanels);
  cLAlphas = [ cLAlphas; (cL2-cL1)/4 ];
end

csvwrite('data/hw2_1.dat', [ aspectRatios cLAlphas ]);
