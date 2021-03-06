aspectRatio = 5;
taperRatios = 0.1:0.1:1;
quarterChordSweep = 0;
wingTipTwist = 0;
horseshoeShape = 'rectangular';
nPanels = 100;
% Initialize output vectors
wingSpan = linspace(-0.5, 0.5, nPanels)';
cLYs = [];
for taperRatio = taperRatios
  % Compute cL for -2 and 2 degrees so we can draw a line
  [ cL1 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, horseshoeShape, nPanels);
  [ cL2 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, 2, wingTipTwist, horseshoeShape, nPanels);
  cLAlpha = (cL2-cL1)/4;
  % Find angle of attack for a 0.25 lift coefficient
  alpha = 0.25/cLAlpha;
  % Find local lift distribution for computed angle of attack
  [ cL, cLY ] = HVM(aspectRatio, taperRatio, quarterChordSweep, alpha, wingTipTwist, horseshoeShape, nPanels);
  cLYs = [ cLYs cLY ];
end

csvwrite('data/hw2_3.csv', [ [ -1 taperRatios ]; wingSpan cLYs ]);
