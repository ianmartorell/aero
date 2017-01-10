function coordinates = rectangular_horseshoe(midPoint, panelAngle, nPanels)
  panelWidth = 1 / nPanels;
  coordinates = zeros(4, 3);
  % Points b, c, a, d
  coordinates(2, :) = [ midPoint(1) midPoint(2)-panelWidth/2 midPoint(3) ];
  coordinates(3, :) = [ midPoint(1) midPoint(2)+panelWidth/2 midPoint(3) ];
  coordinates(1, :) = [ midPoint(1)+20 coordinates(2,2) -sind(panelAngle)*20 ];
  coordinates(4, :) = [ midPoint(1)+20 coordinates(3,2) -sind(panelAngle)*20 ];
end
