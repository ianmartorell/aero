[ quarterChordLine, controlPoints ] = trapezoidal_wing(8, .5, 60, 2, 0, 100);
clf;
% 2D plot
subplot(2,1,1);
plot(quarterChordLine(:, 1), quarterChordLine(:, 2));
hold on;
plot(controlPoints(:, 1), controlPoints(:, 2));
axis equal;
subplot(2,1,2);
plot(quarterChordLine(:, 2), quarterChordLine(:, 3));
hold on;
plot(controlPoints(:, 2), controlPoints(:, 3));
axis equal;
% % 3D plot
% plot3(quarterChordLine(:, 1), quarterChordLine(:, 2), quarterChordLine(:, 3));
% hold on;
% plot3(controlPoints(:, 1), controlPoints(:, 2), controlPoints(:, 3));
