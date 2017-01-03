function coordinates = compute_horseshoe(midPoint, panelAngle, nPanels)
  panelWidth = 1 / nPanels;
  coordinates = zeros(4, 3);
  % Compute points b and c
  coordinates(2, 1) = midPoint(1);
  coordinates(3, 1) = midPoint(1);
  coordinates(2, 2) = midPoint(2) - panelWidth/2;
  coordinates(3, 2) = midPoint(2) + panelWidth/2;
  coordinates(2, 3) = midPoint(3);
  coordinates(3, 3) = midPoint(3);
  % Compute a and d
  coordinates(1, 1) = midPoint(1) + 20;
  coordinates(4, 1) = coordinates(1, 1);
  coordinates(1, 2) = coordinates(2, 2);
  coordinates(4, 2) = coordinates(3, 2);
  coordinates(1, 3) = -sind(panelAngle) * (20);
  coordinates(4, 3) = coordinates(1, 3);
end
