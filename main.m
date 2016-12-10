[X , Z] = airfoil(100, 1, '2212', 0.8, 5, 'linear');
plot(X, Z);
axis equal;
gamma = DVM(X, Z, 1, 5, 5);
disp(gamma);
Cl = (2/1*1)*gamma;
CL = sum(Cl);
