function [u, v, w]  =  vortxl(x1, y1, z1, x2, y2, z2, xp, yp, zp, gamma)
    % Esta función devuelve los valores de velocidad inducida por un vortice en % un panel

    %Productos vectoriales (a = x,  b = y,  c = z)
    a = (yp-y1) * (zp-z2)-(zp-z1) * (yp-y2);
    b = -(xp-x1) * (zp-z2) + (zp-z1) * (xp-x2);
    c = (xp-x1) * (yp-y2)-(yp-y1) * (xp-x2);

    %Producto escalar denominador (ecuación de velocidades en el control point)
    d = a * a + b * b + c * c;
    r1 = sqrt((xp-x1) * (xp-x1) + (yp-y1) * (yp-y1) + (zp-z1) * (zp-z1));
    r2 = sqrt((xp-x2) * (xp-x2) + (yp-y2) * (yp-y2) + (zp-z2) * (zp-z2));

    %d = constante pequeña --> evitar dividir entre 0
    if(d>(10^-6) && r2>(10^-6) && r1>(10^-6))
        ror1 = (x2-x1) * (xp-x1) + (y2-y1) * (yp-y1) + (z2-z1) * (zp-z1);
        ror2 = (x2-x1) * (xp-x2) + (y2-y1) * (yp-y2) + (z2-z1) * (zp-z2);
        %Parte común de la ecuación de velocidades en el punto de control a 3/4c
        com = (gamma/(4 * pi * d)) * ((ror1/r1)-(ror2/r2));
        u = a * com;
        v = b * com;
        w = c * com;
    else
        u = 0;
        v = 0;
        w = 0;
    end
end
