%% Definición de los paneles y aplicación DVM

%Condiciones iniciales

% Velocidad (m/s)
u=200;

%Ángulo de ataque (degrees)
alpha=5;

%Buscamos control point y punto aplicación torbellino

xcp = ones(npaneles);
zcp = ones(npaneles);

xt = ones(npaneles);
zt = ones(npaneles);

for i = 1:npaneles
        xcp(i) = x(i) + 0.75*(cos(theta(i)));          %Incrementos de (i) de 'x' y 'z' dados por hipotenusa y theta del panel
        zcp(i) = z(i) + 0.75*(sin(theta(i)));          %para encontrar punto aplicación de los otros torbellinos
        xt(i) = x(i) + 0.25*(cos(theta(i)));           %Incrementos de (i) de 'x' y 'z' dados por hipotenusa y theta del panel
        zt(i) = z(i) + 0.25*(sin(theta(i)));           %para encontrar punto aplicación del torbellino de ese panel
end

%Buscamos velocidades inducidas

vecpanelx = ones(npaneles);                                   %Creamos inicialmente las matrices para optimizar rendimiento
vecpanelz = ones(npaneles);                                   %ya que si no se hiciera ocuparia mucha memoria y daría
nperpx = ones(npaneles);                                      %más trabajo de lo necesario. Al hacer un for, cada vez se
nperpz = ones(npaneles);                                      %aumenta el data del programa.
RHSi = ones(npaneles);

for i = 1:npaneles
    vecpanelx(i) = ((xcp(i)) - (x(i)));                       %Para cada vector panel, se necesitará la componente
    vecpanelz(i) = ((zcp(i))- (z(i)));                        %normal a este para calcular la velocidad inducida
    nperpx(i) = -vecpanelz(i);                                %por Vinf y que nos dará la RHSmatrix.
    nperpz(i) = vecpanelx(i);
    
    Vecpanelx = ones(npaneles);                               %se hace la misma optimización que anteriormente
    Vecpanelz = ones(npaneles);
    R = ones(npaneles);
    v = ones(npaneles);
    w = ones(npaneles);
    LHSi = ones(npaneles);
    
    for j = 1:npaneles
        Vecpanelx(j,npaneles) = ((xt(j)) - (xcp(i)));               %Para calcular las velocidades inducidas en los paneles 'i'
        Vecpanelz(j,npaneles) = ((zt(j)) - (zcp(i)));               %se necesitan los incrementos de 'x' y 'z' debidos a los 
                                                                    %vórtices de los paneles 'j'. 
        R(j,npaneles) = sqrt ((Vecpanelx(j))^2 + (Vecpanelz(j))^2);
        v(j,npaneles) = ((1/(2*pi))*((Vecpanelz(j))/(R(j))^2));                %Velocidades inducidas eje x.
        w(j,npaneles) = ((1/(2*pi))*((Vecpanelx(j))/(R(j))^2));                %Velocidades inducidas eje z.
        LHSi(j,npaneles) = (v(j)*nperpx(i)) + (w(j)*nperpz(i));                %Montamos matriz Vind para cada j.
    end
    
    RHSi(i,npaneles) = -(u)*((cos(aplha)*nperpx(i)) + (sin(alpha)*nperpz(i)));    %Montamos matriz de Vinf inducida p/c panel
end