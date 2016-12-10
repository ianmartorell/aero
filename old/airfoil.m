function [X, Y] = airfoil(M, c, f, p, xh, eta)
% AIRFOIL  Define the upper half of an airfoil with an optional flap
%
%   airfoil(M, c, f, p, xh, eta)
%
%   M: amount of panels
%   c: chord length
%   f: maximum camber as a fraction of the chord
%   p: maximum camber position as a fraction of the chord
%   xh: flap position as a fraction of the chord, use 1 for no flap
%   eta: flap angle in degrees

N = M + 1;
X = zeros(N, 1);
Y = zeros(N, 1);

for i = 1:N
    % Calculate X according to the number of panels
    X(i) = (c/2) * (1-cos((i-1)*pi/(M)));
    % Calculate Y using NACA equations for a cambered 4-digit airfoil
    if (X(i) <= p)
        Y(i) = (f/p^2)*(2*p*(X(i))-(X(i))^2);
    else
        Y(i) = (f/(1-p)^2)*(1-2*p+2*p*(X(i))-(X(i))^2);
    end
    % Rotate by eta degrees if this panel is part of the flap
    if (X(i) >= xh)
        Y(i) = Y(i) - tand(eta) * (X(i)-xh);
    end
end
