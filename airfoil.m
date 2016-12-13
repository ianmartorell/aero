function camberLine = airfoil(NACA, chord, flapPosition, flapAngle, nPanels, distribution)
% AIRFOIL  Define the camber line of an airfoil with an optional flap
%
%   airfoil(NACA, chord, flapPosition, flapAngle, nPanels, distribution)
%
%   NACA: NACA 4-digit designation
%   chord: chord length
%   flapPosition: flap position as a fraction of the chord, use 1 for no flap
%   flapAngle: flap angle in degrees
%   nPanels: number of panels
%   distribution: panel distribution along the X axis, can be `linear` or `fullCosine`, defaults to `linear`

% Parse input data
maxCamber = str2double(NACA(1))/10;
maxCamberPos = str2double(NACA(2))/10;
nPoints = nPanels + 1;
% Prepare the result vectors
X = zeros(1, nPoints);
Z = zeros(1, nPoints);
if ~strcmp(distribution, 'fullCosine')
    % distribute control points linearly
    X = linspace(0, chord, nPoints);
end

for i = 1:nPoints
    if strcmp(distribution, 'fullCosine')
      % Calculate X according to the number of panels
      X(i) = (chord/2) * (1-cos(pi*(i-1)/nPanels));
    end
    % Calculate Z using NACA equations for a cambered 4-digit airfoil
    if (X(i) <= maxCamberPos*chord)
        Z(i) = (maxCamber/maxCamberPos^2)*(2*maxCamberPos*(X(i)/chord)-(X(i)/chord)^2);
    else
        Z(i) = (maxCamber/(1-maxCamberPos)^2)*(1-2*maxCamberPos+2*maxCamberPos*(X(i)/chord)-(X(i)/chord)^2);
    end
    % Rotate by flapAngle degrees if this panel is part of the flap
    if (X(i) >= flapPosition)
        Z(i) = Z(i) - tand(flapAngle) * (X(i) - flapPosition);
    end
end

camberLine = [X; Z];
