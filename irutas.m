function [xi]= irutas(nc)
% nc = vector numero de clientes
global D

% Genera 1 cliente por ruta, es decir 100 rutas iniciales
nr=length(nc)-1;
sol=cell(1,nr); % array con las rutas
for i=1:nr
    sol{i}=[1,i+1,1];
end

% Calcula el vector de costos para las rutas iniciales
costo=zeros(1,nr);
for nRuta=1:nr
    din = 0;
    ruta = sol{nRuta}; % toma una ruta
    for ind=2:length(ruta)
        j = ruta(ind);
        i = ruta(ind-1);
        din = din + D(i,j);
    end    
    costo(nRuta) = din + D(ruta(end-1),ruta(end));
end
xi={sol,costo}; % guarda el vecino con el formato usado