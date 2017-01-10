function [ cL, cLY, cDi ] = HVM(aspectRatio, taperRatio, quarterChordSweep, angleOfAttack, wingTipTwist, horseshoeShape, nPanels)
  % HVM: Computes the lift coefficient of a wing using the Horseshoe Vortex Method
  % horseshoeShape: can be 'rectangular' or 'trapezoidal'
  density = 1.25;
  freestreamVelocity = [ 1 0 0 ];
  % Perform wing discretization
  [ midPoints, controlPoints, bounded_nodes, trailing_nodes, panelAngles, panelAreas ] = wing_discretization(aspectRatio, taperRatio, quarterChordSweep, angleOfAttack, wingTipTwist, nPanels);
  % Initialize variables
  influenceCoefficients = zeros(nPanels, nPanels);
  RHS = zeros(nPanels, 1);
  for i = 1:nPanels
    midPoint = [ midPoints(i, 1) midPoints(i, 2) midPoints(i, 3) ];
    normalUnitVector = [ sind(panelAngles(i)) 0 cosd(panelAngles(i)) ];
    for j = 1:nPanels
      midPoint = [ midPoints(j, 1) midPoints(j, 2) midPoints(j, 3) ];
      if strcmp(horseshoeShape, 'rectangular')
        horseshoe = rectangular_horseshoe(midPoint, panelAngles(j), nPanels);
      else
        horseshoe = [ trailing_nodes(j,:); bounded_nodes(j,:); bounded_nodes(j+1,:); trailing_nodes(j+1,:)];
      end
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
  % Compute lift coefficient
  cL = 2 / freestreamVelocity(1) * aspectRatio * sum(circulation/nPanels);
  % Compute local lift distribution
  cLY = 2*circulation./panelAreas/nPanels/freestreamVelocity(1);
  % Compute moment
  momentLE = zeros(nPanels);
  for i = 1:nPanels
    momentLE(i) = lift(i) * midPoints(i, 1) * cosd(panelAngles(i));
  end
  chordRoot = 2/aspectRatio/(1+taperRatio);
  geometricChord = (2/3)*chordRoot*((1+taperRatio+taperRatio^2)/(1+taperRatio));
  cMLE = ((-2)/(freestreamVelocity(1)/aspectRatio*geometricChord))*sum(momentLE);
  [ alpha_i local_drag cDi ] = compute_cdi(nPanels, midPoints, panelAngles, circulation, 1/aspectRatio);
end
