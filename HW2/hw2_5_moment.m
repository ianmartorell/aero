aspectRatio = 8;
taperRatio = 0.5;
% 0 degree sweep at c/2 equals 10.61 degrees at the leading edge
quarterChordSweep = quarter_chord_sweep(10.61, aspectRatio, taperRatio);
angleOfAttack = 2;
wingTipTwist = 0;
horseshoeShape = 'rectangular';
nPanels = 100;
% cm0 taken from airfoil_data.pdf
cm0 = -0.047;
% We transform panels to wing span from -0.5 to 0.5
wingSpan = linspace(-0.5, 0.5, nPanels)';
[ midPoints, controlPoints, bounded_nodes, trailing_nodes, panelAngles, panelAreas, chords ] = wing_discretization(aspectRatio, taperRatio, quarterChordSweep, angleOfAttack, wingTipTwist, nPanels);
integral = 0;
for i=1:nPanels
  integral = integral+chords(i)^2;
end
cM0 = cm0*integral
aerodynamicCenter = 0.25 + tand(quarterChordSweep)/6*(1+2*taperRatio)/(1+taperRatio)
