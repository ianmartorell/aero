function circulation = DVM(camberLine, freestreamVelocity, angleOfAttack, nPanels)

vortices = zeros(2, nPanels);
controlPoints = zeros(2, nPanels);

for i = 1:nPanels
    length = sqrt((camberLine(1, i+1) - camberLine(1, i))^2 + (camberLine(2, i+1) - camberLine(2, i))^2);
    angle = atand((camberLine(2, i+1) - camberLine(2, i)) / (camberLine(1, i+1) - camberLine(1, i)));
    vortices(1, i) = camberLine(1, i) + 0.25*length*(cos(angle));
    vortices(2, i) = camberLine(2, i) + 0.25*length*(sin(angle));
    controlPoints(1, i) = camberLine(1, i) + 0.75*length*(cos(angle));
    controlPoints(2, i) = camberLine(2, i) + 0.75*length*(sin(angle));
end

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
