function [ quarterChordLine, controlPoints, panelAngles, panelAreas ] = trapezoidal_wing(aspectRatio, taperRatio, quarterChordSweepAngle, angleOfAttack, wingTipTwist, nPanels)
  % trapezoidal_wing: Returns a vector of points along the quarter chord line of the wing,
  % each centered along the y axis of every panel. Also returns the control points at 3c/4 and
  % the angle of every panel after applying angle of attack and twist.
  quarterChordLine = zeros(nPanels, 3);
  controlPoints = zeros(nPanels, 3);
  panelAngles = zeros(nPanels, 1);
  panelAreas = zeros(nPanels, 1);
  % Compute y, which is distributed linearly
  panelWidth = 1/nPanels;
  lastY = 0.5 - panelWidth/2;
  quarterChordLine(:, 2) = linspace(-lastY, lastY, nPanels);
  controlPoints(:, 2) = linspace(-lastY, lastY, nPanels);
  % Compute some needed constants
  surfaceArea = 1/aspectRatio;
  chordRoot = 2*surfaceArea/(1+taperRatio);
  chordTip = taperRatio*chordRoot;
  % Find equation of sweep(y) = x(y) for quarter chord points
  sweepSlope = tand(90-quarterChordSweepAngle);
  sweepOrd = -sweepSlope*0.25*chordRoot;
  % Find equation for twist, which has a zero y-intercept
  twistSlope = wingTipTwist/0.5;
  for i = 1:nPanels
    % Compute the panel's chord
    chord = chordRoot + (chordTip - chordRoot) / 0.5 * abs(quarterChordLine(i, 2));
    % Compute the panel's surface area
    panelAreas(i) = chord*panelWidth;
    % Compute the panel's angle of attack
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
    % Correction due to panel angle
    quarterChordLine(i, 1) = quarterChordLine(i, 1) + chord * (1 - cosd(panelAngles(i)));
    % Calculate z position
    quarterChordLine(i, 3) = sind(panelAngles(i)) * chord;
    % Calculate control point position
    controlPoints(i, 1) = quarterChordLine(i, 1) + chord/2 + (1 - cosd(panelAngles(i)))/4;
    controlPoints(i, 3) = sind(panelAngles(i)) * chord/4;
  end
end
