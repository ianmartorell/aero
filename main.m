[X , Z] = airfoil(5, 1, '0112', 0.8, 0, 'linear');
plot(X, Z);
axis equal;
gamma = DVM(X, Z, 1, 5, 5);
disp(gamma);
Cl = (2/1*1)*gamma;
CL = sum(Cl);
