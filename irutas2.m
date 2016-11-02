function [xi]= irutas2(nc)
% Genera 1 cliente por ruta, es decir 100 rutas iniciales

% nc = vector numero de clientes
nr=length(nc)-1;
sol=cell(1,nr); % array con las rutas
for i=1:nr
    sol{i}=[1,i+1,1];
end
% Calcula el vector de costos para las rutas iniciales
costo=zeros(1,nr);
cam=(1:nr);
costo=dineros(sol,costo,cam);
xi={sol,costo}; % guarda el vecino con el formato usado