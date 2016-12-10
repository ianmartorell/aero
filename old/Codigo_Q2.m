naca=2212;                       %Introducir el perfil NACA (4 dígitos)
f=floor((naca/1000))/100;        %Cámber máximo (centésimas)
p=floor(((naca/1000-floor(naca/1000))*10))/10;  %Posición del cámber máximo (décimas de cuerda)
t=((naca/1000-floor(naca/1000))*10-floor((naca/1000-floor(naca/1000)*10))*100);  %Espesor máximo
alpha_degree=4;                  %Ángulo de ataque (º)
alpha=(((2*pi)/360)*alpha_degree);%Ángulo de ataque (rad)
npanels=99;                      %NÚMERO DE PANELES
distrib=0;                       %DISTRIBUCIÓN DE PANELES (0=UNIFORME; 1=FULL COSINE)
flap=1;                          %ACTIVAR FLAP (1=ACTIVO)
pflap=0.8;                        %Posición de flap (tanto por uno de la cuerda)
aflap=5;                          %Ángulo de deflexión del flap (º)
i=1;
j=1;
N=npanels+1;
x=[];                            %Inicialización de x puntos de cambio de placa
z=[];                            %Inicialización de z puntos de cambio de placa
x_v=[];                          %Inicialización x de vórtices
z_v=[];                          %Inicialización z de vórtices
x_cp=[];                         %Inicialización de puntos de colocación en x
z_cp=[];                         %Inicialización de puntos de colocación en z
panellength=[];                  %Inicialización de longitud de paneles
nx=[];                           %Componente x del vector normal al panel
nz=[];                           %Componente z del vector normal al panel

if distrib==1
    while i<=N                   %x cos puntos de placa
        x(i)=1/2*(1-cos((i-1)/(N-1)*(pi)));
        i=i+1;
    end
    i=1;
    while i<=npanels             %X cos torbellinos
        x_v(i)=((x(i+1)-x(i))*0.25)+x(i);
        i=i+1;
    end
    i=1;
    j=1;
    while j<=npanels             %X cos punto de colocación
        x_cp(j)=((x(j+1)-x(j))*0.75)+x(j);
        j=j+1;
    end
    while i<=npanels && x(i)<=p     %z cos cambio de panel
        z(i)=(f/(p^2))*((2*p*x(i))-(x(i)^2));
        i=i+1;
    end
    while i<=N
        z(i)=(f/(1-p)^2)*(1-(2*p)+(2*p*x(i))-(x(i)^2));
        i=i+1;
    end
    i=1;
    while i<=npanels && x_v(i)<=p   %z cos vórtices
        z_v(i)=(f/(p^2))*((2*p*x_v(i))-(x_v(i)^2));
        i=i+1;
    end
    while i<=npanels
        z_v(i)=(f/((1-p)^2))*(1-(2*p)+(2*p*x_v(i))-(x_v(i)^2));
        i=i+1;
    end
    i=1;
    j=1;
    while j<=npanels && x_cp(j)<=p   %z cos punto de colocación vórtice
        z_cp(j)=(f/(p^2))*((2*p*x_cp(j))-(x_cp(j)^2));
        j=j+1;
    end
    while j<=npanels
        z_cp(j)=(f/((1-p)^2))*(1-(2*p)+(2*p*x_cp(j))-(x_cp(j)^2));
        j=j+1;
    end
    while i<=npanels                %Longitud de los paneles
        panellength(i)=sqrt(((x(i+1)-x(i))^2)+((z(i+1)-z(i))^2));
        i=i+1;
    end
    i=1;
    while i<=npanels                %Vector normal al panel
        nx(i)=(-z((i+1)-z(i)))/panellength(i);
        nz(i)=(x(i+1)-x(i))/panellength(i);
        i=i+1;
    end
else if distrib==0                   %DISTRIBUCIÓN UNIFORME
        x=0:(1/npanels):1;          %Puntos cambio de placa dist. uniforme
        x_v=(0.25/npanels):(1/npanels):1; %Vórtices
        x_cp=(0.75/npanels):(1/npanels):1; %Puntos de colocación
        while i<=npanels && x(i)<=p         % Puntos z de cambio de panel
            z(i)=(f/(p^2))*((2*p*x(i))-(x(i)^2));
            i=i+1;
        end
        if flap==1
            while i<=N*pflap
                z(i)=(f/((1-p)^2)*(1-(2*p)+(2*p*x(i))-x(i)^2));
                i=i+1;
            end
            for i=N*pflap:N       %x>p
                z(i)=(f/((1-p)^2))*(1-(2*p)+(2*p*x(i))-(x(i)^2))-tand(aflap)*(x(i)-pflap); %zflap
            end
        else
            while i<=N
                z(i)=(f/((1-p)^2))*(1-(2*p)+(2*p*x(i))-(x(i)^2));
                i=i+1;
            end
        end               %x>p
        i=1;
        while i<=npanels && x_v(i)<=p                %z uniforme vórtices
            z_v(i)=(f/(p^2))*((2*p*x_v(i))-(x_v(i)^2));
            i=i+1;
        end
        while i<=npanels
            z_v(i)=(f/((1-p)^2))*(1-(2*p)+(2*p*x_v(i))-(x_v(i)^2));
            i=i+1;
        end   %x>p
        j=1;
        i=1;
        while j<=npanels && x_cp(j)<=p     %z uniforme punto de colocación del vórtice
            z_cp(j)=(f/(p^2))*((2*p*x_cp(j))-(x_cp(j)^2));
            j=j+1;
        end
        while j<=npanels
            z_cp(j)=(f/((1-p)^2))*(1-(2*p)+(2*p*x_cp(j))-(x_cp(j)^2));
            j=j+1;
        end
        while i<=npanels   %Longitud de los paneles (uniforme)
            panellength(i)=sqrt(((x(i+1)-x(i))^2)+((z(i+1)-z(i))^2));
            i=i+1;
        end
        i=1;
        while i<=npanels    %Vector normal al panel (uniforme)
            nx(i)=(-(z(i+1)-z(i)))/panellength(i);
            nz(i)=(x(i+1)-x(i))/panellength(i);
            i=i+1;
        end
    end
end
u=[];
w=[];
i=1;
while i<=npanels  %Componentes u y w de la velocidad
    j=1;
    while j<=npanels
        u(i,j)=(1/(2*pi))*(z_cp(i)-z_v(j))/(((x_cp(i)-x_v(j))^2)+((z_cp(i)-z_v(j))^2));
        w(i,j)=-(1/(2*pi))*(x_cp(i)-x_v(j))/(((x_cp(i)-x_v(j))^2)+((z_cp(i)-z_v(j))^2));
        j=j+1;
    end
    i=i+1;
end
rhs=[];
i=1;
while i<=npanels
    rhs(i)=-(cos(alpha)*nx(i)+sin(alpha)*nz(i));
    i=i+1;
end                    %rhs
A=[];
i=1;
while i<=npanels
    j=1;
    while j<=npanels
        A(i,j)=u(i,j)*nx(j)+w(i,j)*nz(j);
        j=j+1;
    end
    i=i+1;
end           %Aij
circulation=[];
circulation=inv(A)*transpose(rhs);
cl=0;
i=1;

while i<=npanels          %Circulación
    cl=cl+2*circulation(i);
    i=i+1;
end
cm_le=0;
i=1;
while i<=npanels         %Cm_LE
cm_le=cm_le+(-2*circulation(i)*x_v(i)*cos(alpha));
i=i+1;
end
dCp=[];
i=1;
while i<=npanels        %Delta Cp
    dCp(i)=2*circulation(i)*(1/panellength(i));
    i=i+1;
end

    
plot (x,z)

          
        
            