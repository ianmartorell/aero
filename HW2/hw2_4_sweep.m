aspectRatio = 8;
taperRatios = 0.1:0.1:1;
quarterChordSweeps = [ 0 30 60 ];
wingTipTwist = 0;
horseshoeShape = 'rectangular';
nPanels = 100;
% Initialize output vector
oswaldFactors = [];
for quarterChordSweep = quarterChordSweeps
  oswaldFactorsColumn = [];
  for taperRatio = taperRatios
    [ cL, cLY, cDi ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, horseshoeShape, nPanels);
    oswaldFactorsColumn = [ oswaldFactorsColumn; cL^2/cDi/pi/aspectRatio ];
  end
  oswaldFactors = [ oswaldFactors oswaldFactorsColumn ];
end

csvwrite('data/hw2_4_sweep.csv', [ [ -1 quarterChordSweeps ]; taperRatios' oswaldFactors ]);
