aspectRatio = 8;
taperRatio = 0.5;
quarterChordSweep = quarter_chord_sweep(10.61, aspectRatio, taperRatio);
angleOfAttack = 5;
wingTipTwist = 0;
nPanels = 100;

[ midPoints, controlPoints, bounded_nodes, trailing_nodes ] = wing_discretization(aspectRatio, taperRatio, quarterChordSweep, angleOfAttack, wingTipTwist, nPanels);
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
