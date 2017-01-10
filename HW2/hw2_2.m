aspectRatio = 6;
taperRatio = 1;
leadingEdgeSweeps = 0:5:60;
wingTipTwist = 0;
nPanels = 100;
% Initialize output vectors
cLAlphas = [];
aerodynamicCenters = [];
for leadingEdgeSweep = leadingEdgeSweeps
  % Although unnecessary for a unitary taper ratio, we calculate the quarter chord sweep angle
  quarterChordSweep = quarter_chord_sweep(leadingEdgeSweep, aspectRatio, taperRatio);
  % Compute cL for -2 and 2 degrees so we can draw a line
  [ cL1 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, nPanels);
  [ cL2 ] = HVM(aspectRatio, taperRatio, quarterChordSweep, 2, wingTipTwist, nPanels);
  cLAlphas = [ cLAlphas; (cL2-cL1)/4 ];
  aerodynamicCenters = [ aerodynamicCenters; 0.25 + tand(quarterChordSweep)/6*(1+2*taperRatio)/(1+taperRatio)];
end

csvwrite('data/hw2_2.csv', [ leadingEdgeSweeps' cLAlphas aerodynamicCenters ]);
