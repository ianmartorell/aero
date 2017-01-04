function inducedVelocity =  compute_induced_velocity(xa, xb, xp, circulation)
    % Cross products
    x = (xp(2)-xa(2))*(xp(3)-xb(3)) - (xp(3)-xa(3))*(xp(2)-xb(2));
    y = -(xp(1)-xa(1))*(xp(3)-xb(3)) + (xp(3)-xa(3))*(xp(1)-xb(1));
    z = (xp(1)-xa(1))*(xp(2)-xb(2)) - (xp(2)-xa(2))*(xp(1)-xb(1));
    d = x*x + y*y + z*z;
    r1 = sqrt((xp(1)-xa(1))*(xp(1)-xa(1)) + (xp(2)-xa(2))*(xp(2)-xa(2)) + (xp(3)-xa(3))*(xp(3)-xa(3)));
    r2 = sqrt((xp(1)-xb(1))*(xp(1)-xb(1)) + (xp(2)-xb(2))*(xp(2)-xb(2)) + (xp(3)-xb(3))*(xp(3)-xb(3)));
    % We set the induced velocity to zero if r1, r2 or their cross product is less
    % than a small constant, to avoid dividing by zero
    if(d>(10^-6) && r2>(10^-6) && r1>(10^-6))
        ror1 = (xb(1)-xa(1))*(xp(1)-xa(1)) + (xb(2)-xa(2))*(xp(2)-xa(2)) + (xb(3)-xa(3))*(xp(3)-xa(3));
        ror2 = (xb(1)-xa(1))*(xp(1)-xb(1)) + (xb(2)-xa(2))*(xp(2)-xb(2)) + (xb(3)-xa(3))*(xp(3)-xb(3));
        com = (circulation/(4*pi*d))*((ror1/r1)-(ror2/r2));
        u = x*com;
        v = y*com;
        w = z*com;
    else
        u = 0;
        v = 0;
        w = 0;
    end
    inducedVelocity = [u; v; w];
end
