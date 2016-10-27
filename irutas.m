function [xi]= irutas(nc)
% nc = vector numero de clientes
global D  C  d

% Genera la semilla
nr=length(nc)-1;    %numero de clientes (sin el almacen)
semilla = cell(1);
i = 2;
j=0;

while(i <= nr)
    j=j+1;
    ractual=1;    % iniciador de rutas
    while(C>=sum(d(ractual)+d(i)) && i<=101)
        ractual(end+1)= i;
        i=i+1;
    end
    ractual(end+1)=1;
    semilla{j}=ractual;
end
nrutas=j;   % numero de rutas generadas
% Calcula el vector de costos para las rutas iniciales
costo=zeros(1,nrutas);
for nRuta=1:nrutas
    din = 0;
    ruta = semilla{nRuta}; % toma una ruta
    for ind=2:length(ruta)
        j = ruta(ind);
        i = ruta(ind-1);
        din = din + D(i,j);
    end
    costo(nRuta) = din + D(ruta(end-1),ruta(end));
end
xi={semilla,costo}; % guarda el vecino con el formato usado