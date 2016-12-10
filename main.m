camberLine = airfoil(1, '2212', 0.8, 5, 100, 'linear');
plot(camberLine(1), camberLine(2));
axis equal;
circulation = DVM(camberLine, 1, 5, 5);
disp(circulation);
Cl = (2/1*1)*circulation;
CL = sum(Cl);
