function [X, Z] = airfoil(nPanels, chord, NACA, flapPosition, flapAngle, isFullCosine)
% AIRFOIL  Define the camber line of an airfoil with an optional flap
%
%   airfoil(M, c, NACA, flapPosition, flapAngle, isFullCosine)
%
%   nPanels: number of panels
%   chord: chord length
%   NACA: NACA 4-digit designation
%   flapPosition: flap position as a fraction of the chord, use 1 for no flap
%   flapAngle: flap angle in degrees
%   isFullCosine: wether to use a full cosine or a linear distribution

maxCamber = str2double(NACA(1))/10;
maxCamberPos = str2double(NACA(2))/10;
nPoints = nPanels + 1; % number of control points

X = zeros(nPoints, 1);
Z = zeros(nPoints, 1);

if ~isFullCosine
    % distribute control points linearly
    X = linspace(0, chord, nPoints);
end

for i = 1:nPoints
    if isFullCosine
      % Calculate X according to the number of panels
      X(i) = (c/2) * (1-cos((i-1)*pi/(M)));
    end
    % Calculate Z using NACA equations for a cambered 4-digit airfoil
    if (X(i) <= maxCamberPos)
        Z(i) = (maxCamber/maxCamberPos^2)*(2*maxCamberPos*(X(i))-(X(i))^2);
    else
        Z(i) = (maxCamber/(1-maxCamberPos)^2)*(1-2*maxCamberPos+2*maxCamberPos*(X(i))-(X(i))^2);
    end
    % Rotate by flapAngle degrees if this panel is part of the flap
    if (X(i) >= flapPosition)
        Z(i) = Z(i) - tand(flapAngle) * (X(i)-flapPosition);
    end
end
