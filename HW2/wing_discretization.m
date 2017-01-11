function [ midPoints, controlPoints, bounded_nodes, trailing_nodes, panelAngles, panelAreas, panelChords ] = wing_discretization(aspectRatio, taperRatio, quarterChordSweep, angleOfAttack, wingTipTwist, nPanels)
  % wing_discretization: Returns a vector of points along the quarter chord line of the
  % wing, each centered along the y axis of every panel. Also returns the control points
  % at 3c/4 and the angle of every panel after applying angle of attack and twist.
  midPoints = zeros(nPanels, 3);
  controlPoints = zeros(nPanels, 3);
  bounded_nodes = zeros(nPanels+1, 3);
  trailing_nodes = zeros(nPanels+1, 3);
  panelAngles = zeros(nPanels, 1);
  panelAreas = zeros(nPanels, 1);
  panelChords = zeros(nPanels, 1);
  % Compute y, which is distributed linearly
  panelWidth = 1/nPanels;
  lastY = 0.5 - panelWidth/2;
  midPoints(:, 2) = linspace(-lastY, lastY, nPanels);
  controlPoints(:, 2) = linspace(-lastY, lastY, nPanels);
  bounded_nodes(:, 2) = linspace(-0.5, 0.5, nPanels+1);
  trailing_nodes(:, 2) = linspace(-0.5, 0.5, nPanels+1);
  % Compute some needed constants
  surfaceArea = 1/aspectRatio;
  chordRoot = 2*surfaceArea/(1+taperRatio);
  chordTip = taperRatio*chordRoot;
  % Find equation of sweep(y) = x(y) for quarter chord points
  sweepSlope = tand(90-quarterChordSweep);
  sweepOrd = -sweepSlope*0.25*chordRoot;
  % Find equation for twist, which has a zero y-intercept
  twistSlope = wingTipTwist/0.5;
  for i = 1:nPanels
    panelChords(i) = chordRoot + (chordTip - chordRoot) / 0.5 * abs(midPoints(i, 2));
    panelAreas(i) = panelChords(i)*panelWidth;
    panelAngles(i) = twistSlope * abs(midPoints(i, 2)) + angleOfAttack;
    % Calculate x position, if sweep is 90 degrees, the slope will be infinity
    if isinf(sweepSlope)
      midPoints(i, 1) = 0.25*panelChords(i);
      bounded_nodes(i, 1) = 0.25*panelChords(i);
    else
      if midPoints(i, 2) > 0
        midPoints(i, 1) = (midPoints(i, 2) - sweepOrd) / sweepSlope;
        bounded_nodes(i, 1) = (bounded_nodes(i, 2) - sweepOrd) / sweepSlope;
      else
        midPoints(i, 1) = (midPoints(i, 2) + sweepOrd) / -sweepSlope;
        bounded_nodes(i, 1) = (bounded_nodes(i, 2) + sweepOrd) / -sweepSlope;
      end
    end
    trailing_nodes(i, 1) = bounded_nodes(i, 1) + 20;
    % Correction due to panel angle
    midPoints(i, 1) = midPoints(i, 1) + panelChords(i) * (1 - cosd(panelAngles(i)));
    % Calculate z position
    midPoints(i, 3) = sind(panelAngles(i)) * panelChords(i);
    % Calculate control point position
    controlPoints(i, 1) = midPoints(i, 1) + panelChords(i)/2 + (1 - cosd(panelAngles(i)))/4;
    controlPoints(i, 3) = sind(panelAngles(i)) * panelChords(i)/4;
  end
  % Last bounded and trailing node
  if isinf(sweepSlope)
    bounded_nodes(nPanels+1, 1) = 0.25*panelChords(i);
    trailing_nodes(nPanels+1, 1) = bounded_nodes(nPanels+1, 1) + 20;
  else
    bounded_nodes(nPanels+1, 1) = (bounded_nodes(nPanels+1, 2) - sweepOrd) / sweepSlope;
    trailing_nodes(nPanels+1, 1) = bounded_nodes(nPanels+1, 1) + 20;
  end
end
