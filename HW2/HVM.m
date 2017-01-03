aspectRatio = 8;
taperRatio = 0.5;
quarterChordSweepAngle = 60;
angleOfAttack = 2;
wingTipTwist = 0;
nPanels = 4;

density = 1.25;
freestreamVelocity = [ 1 0 0 ];

[ quarterChordLine, controlPoints, panelAngles ] = trapezoidal_wing(aspectRatio, taperRatio, quarterChordSweepAngle, angleOfAttack, wingTipTwist, nPanels);

influenceCoefficients = zeros(nPanels, nPanels);
RHS = zeros(nPanels, 1);

for i = 1:nPanels
  midPoint = [ quarterChordLine(i, 1) quarterChordLine(i, 2) quarterChordLine(i, 3) ];
  normalUnitVector = [ sind(panelAngles(i)) 0 cosd(panelAngles(i)) ];
  for j = 1:nPanels
    midPoint = [ quarterChordLine(j, 1) quarterChordLine(j, 2) quarterChordLine(j, 3) ];
    horseshoe = compute_horseshoe(midPoint, panelAngles(j), nPanels);
    inducedVelocity = zeros(3,1);
    for k = 1:3
      inducedVelocity = inducedVelocity + compute_induced_velocity(horseshoe(k,:), horseshoe(k+1,:), controlPoints(i,:), 1);
    end
    influenceCoefficients(i, j) = dot(inducedVelocity, normalUnitVector);
  end
  RHS(i) = -dot(freestreamVelocity, normalUnitVector);
end
influenceCoefficients
RHS
circulation = influenceCoefficients \ RHS

lift = zeros(nPanels, 1);
for i = 1:nPanels
  lift(i) = density * freestreamVelocity(1) * circulation(i) / nPanels;
end
wingLift = sum(lift);

momentLE = zeros(nPanels);
for i = 1:nPanels
  momentLE(i) = lift(i) * quarterChordLine(i, 1) * cosd(panelAngles(i));
end
wingMomentLE = -sum(momentLE);

cL = 2 / freestreamVelocity(1) * aspectRatio * sum(circulation/nPanels);
% cMLE = - 2 / freestreamVelocity(1) * aspectRatio^2 * sum(circulation*quarterChordLine(:, 1)/nPanels*cos(panelAngles));
% cl = 2 * circulation / nPanels / freestreamVelocity(1) / panelSurface;
