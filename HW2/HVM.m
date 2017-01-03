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
  horseshoe = compute_horseshoe(midPoint, panelAngles(i), nPanels);
  v1 = [ horseshoe(3,1)-horseshoe(2,1) horseshoe(3,2)-horseshoe(2,2) horseshoe(3,3)-horseshoe(2,3) ];
  v2 = [ horseshoe(3,1)-controlPoints(i,1) horseshoe(3,2)-controlPoints(i,2) horseshoe(3,3)-controlPoints(i,3) ];
  normalUnitVector = cross(v1, v2) / norm(cross(v1, v2));
  for j = 1:nPanels
    midPoint = [ quarterChordLine(j, 1) quarterChordLine(j, 2) quarterChordLine(j, 3) ];
    horseshoe = compute_horseshoe(midPoint, panelAngles(j), nPanels);
    inducedVelocity = zeros(3,1);
    for k = 1:3
      inducedVelocity = inducedVelocity + vortxl(horseshoe(k,:), horseshoe(k+1,:), controlPoints(i,:), 1);
    end
    influenceCoefficients(i, j) = dot(inducedVelocity, normalUnitVector);
  end
  RHS(i) = -dot(freestreamVelocity, normalUnitVector);
end
circulation = influenceCoefficients \ RHS;

lift = zeros(nPanels);
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
% cMLE = - 2 / freestreamVelocity(1) * aspectRatio^2 * sum(circulation*quarterChordLine(i, 1)/nPanels*cos(panelAngles));
% cl = 2 * circulation / nPanels / freestreamVelocity(1) / panelSurface;
