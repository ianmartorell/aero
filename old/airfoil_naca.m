function [X, Z] = airfoil(M, c, NACA, xh, eta)
% AIRFOIL  Define the camber line of an airfoil with an optional flap
%
%   airfoil(M, c, NACA, xh, eta)
%
%   M: number of panels
%   c: chord length
%   NACA: NACA 4-digit designation
%   xh: flap position as a fraction of the chord, use 1 for no flap
%   eta: flap angle in degrees

maxCamber = str2double(NACA(1))/10;
maxCamberPos = str2double(NACA(2))/10;
N = M + 1; % number of control points
X = zeros(N, 1);
Z = zeros(N, 1);

for i = 1:N
    % Calculate X according to the number of panels
    X(i) = (c/2) * (1-cos((i-1)*pi/(M)));
    % Calculate Z using NACA equations for a cambered 4-digit airfoil
    if (X(i) <= maxCamberPos)
        Z(i) = (maxCamber/maxCamberPos^2)*(2*maxCamberPos*(X(i))-(X(i))^2);
    else
        Z(i) = (maxCamber/(1-maxCamberPos)^2)*(1-2*maxCamberPos+2*maxCamberPos*(X(i))-(X(i))^2);
    end
    % Rotate by eta degrees if this panel is part of the flap
    if (X(i) >= xh)
        Z(i) = Z(i) - tand(eta) * (X(i)-xh);
    end
end
