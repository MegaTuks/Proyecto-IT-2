function [xi]= irutas2tw(nc)
% Genera 1 cliente por ruta, es decir 100 rutas iniciales

% nc = vector numero de clientes
nr=length(nc)-1;
sol=cell(1,nr); % array con las rutas
for i=1:nr
    sol{i}=[1,i+1,1];
end
% Calcula el vector de costos para las rutas iniciales
costo=zeros(1,nr);
b=zeros(1,length(nc));
cam=(1:nr);
[costo,b,~]=dinerostw(sol,costo,cam,b);
xi={sol,costo,b}; % guarda el vecino con el formato usado