camberLine = airfoil(1, '0112', 1, 0, 5, 'linear');
circulation = DVM(camberLine, 1, 5, 5);
disp('circulation:');
disp(circulation);
