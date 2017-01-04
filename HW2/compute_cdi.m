function [ alpha_i local_drag cDi ]= compute_cdi(nPanels, quarterChordLine, panelAngles, circulation, surfaceArea)
alpha_i = zeros(nPanels,1);
local_drag = zeros(nPanels,1);
for i=1:nPanels
    xp = [ quarterChordLine(i, 1) quarterChordLine(i, 2) quarterChordLine(i, 3) ];
    normalUnitVector = [ sind(panelAngles(i)); 0; cosd(panelAngles(i)) ];
    wi = 0;
    for j = 1:nPanels
        midPoint = [ quarterChordLine(j, 1) quarterChordLine(j, 2) quarterChordLine(j, 3) ];
        horseshoe = compute_horseshoe(midPoint, panelAngles(j), nPanels);
        u1 = compute_induced_velocity(horseshoe(1,:), horseshoe(2,:), xp, circulation(i));
        u3 = compute_induced_velocity(horseshoe(3,:), horseshoe(4,:), xp, circulation(i));
        utot = u1 + u3;
        wi = wi + dot(utot, normalUnitVector);
    end
    alpha_i(i) = -wi;
    local_drag(i) = circulation(i)*alpha_i(i)/nPanels;
end
cDi = 2*sum(local_drag)/surfaceArea;
