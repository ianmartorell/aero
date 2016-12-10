function gamma = DVM(X, Z, u, alpha, M)
% Buscamos control point y punto aplicación torbellino
xcp = ones(M,1);
zcp = ones(M,1);
xt = ones(M,1);
zt = ones(M,1);
theta = zeros(M,1);

for i = 1:M
    theta(i) = atand((Z(i+1)-Z(i))/(X(i+1)-X(i)));
end

lpanel = zeros(M,1);

for i = 1:M
    lpanel(i) = sqrt(((X(i+1)-X(i))^2)+((Z(i+1)-Z(i))^2));
end

for i = 1:M
    xcp(i) = X(i) + 0.75*lpanel(i)*(cos(theta(i)));          %Incrementos de (i) de 'x' y 'z' dados por hipotenusa y theta del panel
    zcp(i) = Z(i) + 0.75*lpanel(i)*(sin(theta(i)));          %para encontrar punto aplicaci�n de los otros torbellinos
    xt(i) = X(i) + 0.25*lpanel(i)*(cos(theta(i)));           %Incrementos de (i) de 'x' y 'z' dados por hipotenusa y theta del panel
    zt(i) = Z(i) + 0.25*lpanel(i)*(sin(theta(i)));           %para encontrar punto aplicaci�n del torbellino de ese panel
end

vecpanelx = ones(M,1);                                   %Creamos inicialmente las matrices para optimizar rendimiento
vecpanelz = ones(M,1);                                   %ya que si no se hiciera ocuparia mucha memoria y dar�a
vecpanelxp = ones(M,1);                                      %m�s trabajo de lo necesario. Al hacer un for, cada vez se
vecpanelzp = ones(M,1);
nperpx = ones(M,1);                                      %m�s trabajo de lo necesario. Al hacer un for, cada vez se
nperpz = ones(M,1);                                      %aumenta el data del programa.

%Buscamos velocidades inducidas                                     %aumenta el data del programa.
Vecpanelx = ones(M,1);                               %se hace la misma optimizaci�n que anteriormente
Vecpanelz = ones(M,1);
R = ones(M,M);
v = ones(M,M);
w = ones(M,M);
LHS = ones(M,M);
RHS = zeros(M,1);

for i = 1:M
    vecpanelxp(i) = (X(i+1)-(X(i)));                       %Para cada vector panel, se necesitar� la componente
    vecpanelzp(i) = (Z(i+1)-(Z(i)));                        %normal a este para calcular la velocidad inducidA                                %por Vinf y que nos dar� la RHSmatrix.
    vecpanelx(i)=vecpanelxp(i)/sqrt((vecpanelxp(i)^2)+(vecpanelzp(i)^2));
    vecpanelz(i)=vecpanelzp(i)/sqrt((vecpanelxp(i)^2)+(vecpanelzp(i)^2));
    nperpx(i)=-vecpanelz(i);
    nperpz(i)=vecpanelx(i);
    for j = 1:M
        Vecpanelx(i,j) = (-(xt(j))+xcp(i));               %Para calcular las velocidades inducidas en los paneles 'i'
        Vecpanelz(i,j) = (-(zt(j))+zcp(i));               %se necesitan los incrementos de 'x' y 'z' debidos a los
                                                                    %v�rtices de los paneles 'j'.
        R(i,j) = sqrt ((Vecpanelx(i,j))^2 + (Vecpanelz(i,j))^2);
        v(i,j) = ((1/(2*pi))*((Vecpanelz(i,j))/(R(i,j))^2));                %Velocidades inducidas eje x.
        w(i,j) = (-(1/(2*pi))*((Vecpanelx(i,j))/(R(i,j))^2));                %Velocidades inducidas eje z.
        LHS(i,j) = (v(i,j)*nperpx(i)) + (w(i,j)*nperpz(i));                %Montamos matriz Vind para cada j.
    end
    RHS(i) = (-u)*((cosd(alpha)*nperpx(i)) + (sind(alpha)*nperpz(i)));    %Montamos matriz de Vinf inducida p/c panel
end
disp(xcp);
disp(xt);
disp(theta);
disp(LHS);
gamma = LHS\RHS;
disp(RHS);
end
