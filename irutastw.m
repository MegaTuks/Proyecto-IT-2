function [xi]= irutastw(nc)
% Algoritmo basado en las distancias al almacen y entre clientes

% nc = vector numero de clientes
global C d D e s l

% Genera la semilla
nclientes=length(nc);    % numero de clientes (sin el almacen)
prueba=true(1,nclientes);  % vector lógico para el algoritmo
prueba(1)=0;    % el primero es falso porque es el almacen
sol = cell(1);
i=0;  % contador para las rutas
b=zeros(1,length(nc));

while any(prueba)
    i=i+1;
    ractual=1;    % iniciador de rutas
    pos=find(prueba); % indices de los clientes no ruteados
    norut=length(pos);
    j=1;
    for t=1:norut
        [~,q]=min(D(j,pos));
        k=pos(q);  % el cliente k mas cercano al j
        if sum(d(ractual))+ d(k)<=C
            tiempo = max(e(k),b(j)+s(j)+D(j,k));
            if tiempo>=e(k) && tiempo<=l(k)
                ractual=[ractual,k];
                b(k)=tiempo;
                prueba(k)=0;
                j=k;
            end
        end
        pos(q)=[];
    end
    ractual=[ractual,1];
    sol{i}=ractual;
end
nrutas=i;   % numero de rutas generadas
% Calcula el vector de costos para las rutas iniciales
costo=zeros(1,nrutas);
b=zeros(1,length(nc));
cam=(1:nrutas);
costo=dineros(sol,costo,cam);
[costo,b,~]=dinerostw(sol,costo,cam,b);
xi={sol,costo,b}; % guarda el vecino con el formato usado