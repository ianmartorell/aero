function [ cL, cLY ] = HVM(aspectRatio, taperRatio, quarterChordSweepAngle, angleOfAttack, wingTipTwist, nPanels)
  % HVM: Computes the lift coefficient of a wing using the Horseshoe Vortex Method
  density = 1.25;
  freestreamVelocity = [ 1 0 0 ];
  % Perform wing discretization
  [ quarterChordLine, controlPoints, panelAngles, panelAreas ] = trapezoidal_wing(aspectRatio, taperRatio, quarterChordSweepAngle, angleOfAttack, wingTipTwist, nPanels);
  % Initialize variables
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
  circulation = influenceCoefficients \ RHS;
  % Compute lift
  lift = zeros(nPanels, 1);
  for i = 1:nPanels
    lift(i) = density * freestreamVelocity(1) * circulation(i) / nPanels;
  end
  wingLift = sum(lift);
  % Compute moment
  momentLE = zeros(nPanels);
  for i = 1:nPanels
    momentLE(i) = lift(i) * quarterChordLine(i, 1) * cosd(panelAngles(i));
  end
  wingMomentLE = -sum(momentLE);
  % Compute lift coefficient
  cL = 2 / freestreamVelocity(1) * aspectRatio * sum(circulation/nPanels);
  % Compute local lift distribution
  cLY = 2*circulation./panelAreas/nPanels/freestreamVelocity(1);
end
