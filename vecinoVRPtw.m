function [vecino] = vecinoVRPtw(t)

% [vecino] = costoVRP({sol,costo})
% sol = solucion encontrada
% costo = vector de costos
% vecino = nuevas rutas y sus costos

sol=t{1}; % sol es el conjunto de rutas, la solucion
costo = t{2}; % vector con los costos
b=t{3}; % vector con los tiempos

% cam = vector con la(s) rutas cambiadas
% Nota, el codigo esta hecho considerando que el almacen es el cliente 1, y
% que esta al principio y fin de cada ruta

lon=length(sol); % lon = numero de rutas dentro de la solucion
mal=1;
cont=0;
while mal == 1 && cont<50
    cont=cont+1;
    [newsol,cam,newcosto] = vecinoHeuristica2(sol,lon,costo);
    % Calcula el nuevo vector de costos segun la(s) rutas modificadas, si es
    % que las hay
    if ~isempty(cam)
        [newcosto,newb,mal] = dinerostw(newsol,newcosto,cam,b);
    end
end
if mal == 0
    vecino={newsol,newcosto,newb}; % guarda el vecino con el formato usado
else
    vecino = {sol,costo,b};
end