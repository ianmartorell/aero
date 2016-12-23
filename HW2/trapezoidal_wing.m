function [ quarterChordLine, controlPoints, panelAngle ] = trapezoidal_wing(taperRatio, quarterChordSweepAngle, angleOfAttack, wingTipTwist, nPanels)

quarterChordLine = zeros(nPanels, 3);
controlPoints = zeros(nPanels, 3);
panelAngle(1) = zeros(nPanels, 1);
% y is distributed linearly
quarterChordLine(:, 2) = linspace(-0.5, 0.5, nPanels);
controlPoints(:, 2) = linspace(-0.5, 0.5, nPanels);

sweepSlope = tand(90-quarterChordSweepAngle);
sweepOrd = -sweepSlope*0.25;
twistSlope = wingTipTwist/0.5;

for i = 1:nPanels
  % Compute this panel's chord
  m = (taperRatio - 1) / 0.5;
  chord = 1 + m * abs(quarterChordLine(i, 2));
  % Calculate this panel's angle of attack
  panelAngle(1) = twistSlope * abs(quarterChordLine(i, 2)) + angleOfAttack;

  if quarterChordLine(i, 2) > 0
    quarterChordLine(i, 1) = (quarterChordLine(i, 2) - sweepOrd) / sweepSlope + chord * (1 - cosd(panelAngle(1)));
  else
    quarterChordLine(i, 1) = (quarterChordLine(i, 2) + sweepOrd) / -sweepSlope + chord * (1 - cosd(panelAngle(1)));
  end

  controlPoints(i, 1) = quarterChordLine(i, 1) + chord/2 + (1 - cosd(panelAngle(1)))/4;

  quarterChordLine(i, 3) = sind(panelAngle(1)) * chord;
  controlPoints(i, 3) = sind(panelAngle(1)) * chord/4;
end

end
