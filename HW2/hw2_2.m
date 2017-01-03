aspectRatio = 6;
taperRatio = 1;
wingTipTwist = 0;
nPanels = 100;
% Initialize output vectors
leadingEdgeSweepAngles = [];
cLAlphas = [];
aerodynamicCenters = [];
for leadingEdgeSweepAngle = 0:5:60
  leadingEdgeSweepAngles = [ leadingEdgeSweepAngles; leadingEdgeSweepAngle ];
  % Although unnecessary for a unitary taper ratio, we calculate the quarter chord sweep angle
  quarterChordSweepAngle = quarter_chord_sweep_angle(leadingEdgeSweepAngle, aspectRatio, taperRatio);
  % Compute cL for -2 and 2 degrees so we can draw a line
  [ cL1 ] = HVM(aspectRatio, taperRatio, quarterChordSweepAngle, -2, wingTipTwist, nPanels);
  [ cL2 ] = HVM(aspectRatio, taperRatio, quarterChordSweepAngle, 2, wingTipTwist, nPanels);
  cLAlphas = [ cLAlphas; (cL2-cL1)/4 ];
  aerodynamicCenters = [ aerodynamicCenters; tand(quarterChordSweepAngle)/6*(1+2*taperRatio)/(1+taperRatio)];
end

csvwrite('data/hw2_2.csv', [ leadingEdgeSweepAngles cLAlphas aerodynamicCenters ]);
