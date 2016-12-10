[X , Z] = airfoil(5, 1, '0112', 1, 0, 'linear');
gamma = DVM(X, Z, 1, 5, 5);
disp(gamma);
