function [xi]= irutas(nc)
% nc = vector numero de clientes
global D , C , d

% Genera 1 cliente por ruta, es decir 100 rutas iniciales
nr=length(nc)-1;
sol=cell(1,nr); % array con las rutas
start = cell(1);
i = 2;
j=1;

while(i > nr)
  start{j}(end+1) = 1;
  while(C>sum(d(start)))
    start{j}(end+1)= i;
    i+1;
   end 
   start{j}(end+1)= 1;
   j+1;
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