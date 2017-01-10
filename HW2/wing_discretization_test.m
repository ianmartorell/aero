[ midPoints, controlPoints ] = wing_discretization(8, .5, 60, 2, 0, 100);
clf;
% 2D plot
subplot(2,1,1);
plot(midPoints(:, 1), midPoints(:, 2));
hold on;
plot(controlPoints(:, 1), controlPoints(:, 2));
axis equal;
subplot(2,1,2);
plot(midPoints(:, 2), midPoints(:, 3));
hold on;
plot(controlPoints(:, 2), controlPoints(:, 3));
axis equal;
% % 3D plot
% plot3(midPoints(:, 1), midPoints(:, 2), midPoints(:, 3));
% hold on;
% plot3(controlPoints(:, 1), controlPoints(:, 2), controlPoints(:, 3));
