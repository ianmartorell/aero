aspectRatios = [ 4 8 10 ];
taperRatios = 0.1:0.1:1;
quarterChordSweep = 0;
wingTipTwist = 0;
horseshoeShape = 'rectangular';
nPanels = 100;
% Initialize output vector
oswaldFactors = [];
for aspectRatio = aspectRatios
  oswaldFactorsColumn = [];
  for taperRatio = taperRatios
    [ cL, cLY, cDi ] = HVM(aspectRatio, taperRatio, quarterChordSweep, -2, wingTipTwist, horseshoeShape, nPanels);
    oswaldFactorsColumn = [ oswaldFactorsColumn; cL^2/cDi/pi/aspectRatio ];
  end
  oswaldFactors = [ oswaldFactors oswaldFactorsColumn ];
end

csvwrite('data/hw2_4_aspect.csv', [ [ -1 aspectRatios ]; taperRatios' oswaldFactors ]);
