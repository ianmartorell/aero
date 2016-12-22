function [ quarterChordLine, controlPoints ] = trapezoidal_wing(taperRatio, quarterChordSweepAngle, angleOfAttack, wingTipTwist, nPanels)

quarterChordLine = zeros(nPanels, 3);
% y is distributed linearly
quarterChordLine(:, 2) = linspace(-0.5, 0.5, nPanels);
controlPoints(:, 2) = linspace(-0.5, 0.5, nPanels);

sweepSlope = tand(90-quarterChordSweepAngle);
sweepOrd = -sweepSlope*0.25;
twistSlope = tand(wingTipTwist/0.5);

for i = 1:nPanels
  if quarterChordLine(i, 2) > 0
    quarterChordLine(i, 1) = (quarterChordLine(i, 2) - sweepOrd) / sweepSlope;
  else
    quarterChordLine(i, 1) = (quarterChordLine(i, 2) + sweepOrd) / -sweepSlope;
  end
  % Compute the controlPoint position
  m = (taperRatio - 1) / 0.5;
  chord = 1 + m * abs(quarterChordLine(i, 2));
  controlPoints(i, 1) = quarterChordLine(i, 1) + chord / 2;
end

end
