function [ circulation, cl, cmLE ] = DVM(camberLine, chord, freestreamVelocity, angleOfAttack)

nPanels = size(camberLine, 2) - 1;
vortices = zeros(2, nPanels);
controlPoints = zeros(2, nPanels);
% We need to at least compute the vortices' positions beforehand,
% or not all of them be defined in the inner loop
for i = 1:nPanels
    length = sqrt((camberLine(1, i+1) - camberLine(1, i))^2 + (camberLine(2, i+1) - camberLine(2, i))^2);
    angle = atand((camberLine(2, i+1) - camberLine(2, i)) / (camberLine(1, i+1) - camberLine(1, i)));
    vortices(1, i) = camberLine(1, i) + 0.25*length*(cosd(angle));
    vortices(2, i) = camberLine(2, i) + 0.25*length*(sind(angle));
    controlPoints(1, i) = camberLine(1, i) + 0.75*length*(cosd(angle));
    controlPoints(2, i) = camberLine(2, i) + 0.75*length*(sind(angle));
end
% We can now calculate the circulation
influenceCoefficients = zeros(nPanels, nPanels);
RHS = zeros(nPanels, 1);
for i = 1:nPanels
    % Find the unit normal vector at this control point
    d = zeros(2, 1);
    d(1) = (camberLine(1, i+1) - (camberLine(1, i)));
    d(2) = (camberLine(2, i+1) - (camberLine(2, i)));
    unitTangentVector = zeros(2, 1);
    unitTangentVector(1) = d(1) / sqrt(d(1)^2 + d(2)^2);
    unitTangentVector(2) = d(2) / sqrt(d(1)^2 + d(2)^2);
    unitNormalVector = zeros(2, 1);
    unitNormalVector(1) = - unitTangentVector(2);
    unitNormalVector(2) = unitTangentVector(1);
    for j = 1:nPanels
        % Compute the induced velocity at i due to a lumped vortex at j
        d(1) = controlPoints(1, i) - vortices(1, j);
        d(2) = controlPoints(2, i) - vortices(2, j);
        r = sqrt(d(1)^2 + d(2)^2);
        inducedVelocity = zeros(2, 1);
        inducedVelocity(1) = 1/(2*pi) * d(2)/r^2;
        inducedVelocity(2) = -1/(2*pi) * d(1)/(r)^2;
        % Compute the influence coefficients
        influenceCoefficients(i, j) = inducedVelocity(1) * unitNormalVector(1) + inducedVelocity(2) * unitNormalVector(2);
    end
    RHS(i) = -freestreamVelocity * ((cosd(angleOfAttack) * unitNormalVector(1)) + (sind(angleOfAttack) * unitNormalVector(2)));
end
circulation = influenceCoefficients\RHS;
% Compute the lift coefficients
clArray = 2 / chord / freestreamVelocity * circulation;
cl = sum(clArray);
% Compute the moment coefficient about the leading edge
cmLEArray = zeros(nPanels, 1);
for i = 1:nPanels
    cmLEArray(i) = -2 / freestreamVelocity / chord^2 * circulation(i) * vortices(1, i) * cosd(angleOfAttack);
end
cmLE = sum(cmLEArray);
