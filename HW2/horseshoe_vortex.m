function coordinates = horsheshoe_vortex (midPoint, nPanels)

panelLength = 1 / nPanels;
coordinates = zeros(4, 2);

coordinates(2, 1) = midPoint(1);
coordinates(2, 2) = midPoint(2) - panelLength/2;
coordinates(3, 1) = midPoint(1);
coordinates(3, 2) = midPoint(2) - panelLength/2;

coordinates(1, 1) = midPoint(1) + 20;
coordinates(4, 1) = midPoint(1) + 20;
coordinates(1, 2) = coordinates(2, 2);
coordinates(4, 2) = coordinates(3, 2);

end
