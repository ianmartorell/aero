function [ quarterChordLine, controlPoints, panelAngles ] = trapezoidal_wing(aspectRatio, taperRatio, quarterChordSweepAngle, angleOfAttack, wingTipTwist, nPanels)
  quarterChordLine = zeros(nPanels, 3);
  controlPoints = zeros(nPanels, 3);
  panelAngles = zeros(nPanels, 1);
  % y is distributed linearly
  lastY = 0.5 - 1/nPanels/2;
  quarterChordLine(:, 2) = linspace(-lastY, lastY, nPanels);
  controlPoints(:, 2) = linspace(-lastY, lastY, nPanels);

  surfaceArea = 1/aspectRatio;
  chordRoot = 2*surfaceArea/(1+taperRatio);
  chordTip = taperRatio*chordRoot;

  sweepSlope = tand(90-quarterChordSweepAngle);
  sweepOrd = -sweepSlope*0.25*chordRoot;
  twistSlope = wingTipTwist/0.5;

  for i = 1:nPanels
    % Compute this panel's chord
    m = (chordTip - chordRoot) / 0.5;
    chord = chordRoot + m * abs(quarterChordLine(i, 2));
    % Calculate this panel's angle of attack
    panelAngles(i) = twistSlope * abs(quarterChordLine(i, 2)) + angleOfAttack;
    % Calculate x position
    if isinf(sweepSlope)
      quarterChordLine(i, 1) = 0.25*chord;
    else
      if quarterChordLine(i, 2) > 0
        quarterChordLine(i, 1) = (quarterChordLine(i, 2) - sweepOrd) / sweepSlope;
      else
        quarterChordLine(i, 1) = (quarterChordLine(i, 2) + sweepOrd) / -sweepSlope;
      end
    end
    % Correction due to z axis
    quarterChordLine(i, 1) = quarterChordLine(i, 1) + chord * (1 - cosd(panelAngles(i)));
    % Calculate z position
    quarterChordLine(i, 3) = sind(panelAngles(i)) * chord;
    % Calculate control point position
    controlPoints(i, 1) = quarterChordLine(i, 1) + chord/2 + (1 - cosd(panelAngles(i)))/4;
    controlPoints(i, 3) = sind(panelAngles(i)) * chord/4;
  end
end
