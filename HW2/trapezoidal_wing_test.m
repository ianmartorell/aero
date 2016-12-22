[ quarterChordLine, controlPoints ] = trapezoidal_wing(0.8, 5, 0, 0, 100);
clf;
plot(quarterChordLine(:, 1), quarterChordLine(:, 2));
hold on;
plot(controlPoints(:, 1), controlPoints(:, 2));
axis equal;
