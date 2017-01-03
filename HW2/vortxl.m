function inducedVelocity =  vortxl(xa, xb, xp, circulation)
    %Productos vectoriales
    x = (xp(2)-xa(2)) * (xp(3)-xb(3))-(xp(3)-xa(3)) * (xp(2)-xb(2));
    y = -(xp(1)-xa(1)) * (xp(3)-xb(3)) + (xp(3)-xa(3)) * (xp(1)-xb(1));
    z = (xp(1)-xa(1)) * (xp(2)-xb(2))-(xp(2)-xa(2)) * (xp(1)-xb(1));

    % Producto escalar denominador (ecuación de velocidades en el control point)
    d = x * x + y * y + z * z;
    r1 = sqrt((xp(1)-xa(1)) * (xp(1)-xa(1)) + (xp(2)-xa(2)) * (xp(2)-xa(2)) + (xp(3)-xa(3)) * (xp(3)-xa(3)));
    r2 = sqrt((xp(1)-xb(1)) * (xp(1)-xb(1)) + (xp(2)-xb(2)) * (xp(2)-xb(2)) + (xp(3)-xb(3)) * (xp(3)-xb(3)));

    % d = constante pequeña --> evitar dividir entre 0
    if(d>(10^-6) && r2>(10^-6) && r1>(10^-6))
        ror1 = (xb(1)-xa(1)) * (xp(1)-xa(1)) + (xb(2)-xa(2)) * (xp(2)-xa(2)) + (xb(3)-xa(3)) * (xp(3)-xa(3));
        ror2 = (xb(1)-xa(1)) * (xp(1)-xb(1)) + (xb(2)-xa(2)) * (xp(2)-xb(2)) + (xb(3)-xa(3)) * (xp(3)-xb(3));
        % Parte común de la ecuación de velocidades en el punto de control a 3/4c
        com = (circulation/(4 * pi * d)) * ((ror1/r1)-(ror2/r2));
        u = x * com;
        v = y * com;
        w = z * com;
    else
        u = 0;
        v = 0;
        w = 0;
    end
    inducedVelocity = [u; v; w];
end
