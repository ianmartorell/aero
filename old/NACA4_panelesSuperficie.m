
%Posibilidad de tener flap
%% Valores iniciales

% Tipo de perfil NACA4

tipoNACA = '2412';

% Leemos valores del perfil

ti = str2double (tipoNACA(3:4));
Pi = str2double (tipoNACA(2));
fi = str2double (tipoNACA(1));

%Pasamos a estudiar el perfil

npaneles = 700;

%Pasamos propiedades perfil a valores con los que tratar

t = ti/100;
p = Pi/10;
f = fi/10;

% Creamos la malla dónde situaremos el panel (espaciado cosenoidal)

beta = linspace(0,pi,npaneles);
v1 = cos(beta);
v2 = 1-v1;
x = 0.5*(v2);

% Característcas flap

char flap;
flap = 's';                                                                 % Hay flap 's', no hay 'n'
Xflap = 45;                                                                 % Posición x del flap
alphaflap = 20;                                                            % Ángulo flap
xflap = double (Xflap/100);                                                                                    


z = ones (npaneles,1);
dz_x = ones (npaneles,1);
theta = ones (npaneles,1);

if flap == 's'
    
    zf1 = (f/(p^2))*(2*p*(xflap)-(xflap)^2);                                % Altura flap para posición antes de p
    zf2 = (f/((1-p)^2))*(1-2*p+2*p*(xflap)-((xflap)^2));                    % Altura flap para posición después de p
    
    for i = 1:npaneles
        if x(i) >= 0 && x(i) < p
            if x(i) > xflap
                z(i) = ( zf1 - (x(i)-(xflap))*(tand(alphaflap)));
                dz_x(i) = tand(alphaflap);
            elseif x(i) <= xflap
                z(i) = (f/(p^2))*(2*p*x(i)-(x(i))^2);
                dz_x(i) = ((2*f/(p^2))*(p-x(i))); 
            end
        elseif x(i) >= p && x(i) <= 1
            if x(i) > xflap
               z(i) = ( zf2 - (x(i)-(xflap))*(tand(alphaflap)));
               dz_x(i) = tand(alphaflap);
            elseif x(i) <= xflap
                z(i) = ((f/((1-p)^2))*(1-2*p+2*p*x(i)-(x(i))^2));
                dz_x(i) = ((2*f/((1-p)^2))*(p-x(i)));
            end
        end
        theta(i) = atand(dz_x(i));                    %La derivada es la pendiente del panel=~la tangente si long. panel pequeña
    end
else
    for i = 1:1:npaneles
        if (x(i) >= 0 && x(i) < p)
        z(i) = (f/(p^2))*(2*p*x(i)-(x(i))^2);
        dz_x(i) = ((2*f/(p^2))*(p-x(i)));
        elseif (x(i) >= p && x(i) <= 1);
        z(i) = ((f/((1-p)^2))*(1-2*p+2*p*x(i)-(x(i))^2));
        dz_x(i) = ((2*f/((1-p)^2))*(p-x(i)));
        end
    end
end

% Plot del perfil
f1 = figure (1);
hold on;
grid on;
axis equal;
plot(x,z);                                       
