camberLine = airfoil('0112', 1, 1, 0, 5, 'linear');
circulation = DVM(camberLine, 1, 5, 5);
circulation = circulation/sind(5)*5/pi;
disp('Γ/(π*∆c*U*sin(a))=');
disp(circulation);
