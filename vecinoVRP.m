function [vecino] = vecinoVRP(t)

% [vecino] = costoVRP({sol,costo})
% sol = solucion encontrada
% costo = vector de costos
% vecino = nuevas rutas y sus costos

sol=t{1}; % sol es el conjunto de rutas, la solucion
costo = t{2}; % vector con los costos

lon=length(sol); % lon = numero de rutas dentro de la solucion
% cam = vector con la(s) rutas cambiadas
% Nota, el codigo esta hecho considerando que el almacen es el cliente 1, y
% que esta al principio y fin de cada ruta

if randi([0,1]) == 0
    [sol,cam] = vecinoHeuristica1(sol,lon);
else
    [sol,cam,costo] = vecinoHeuristica2(sol,lon,costo);
end

% Calcula el nuevo vector de costos segun la(s) rutas modificadas, si es
% que las hay
if ~isempty(cam)
costo = dineros(sol,costo,cam);
end

vecino={sol,costo}; % guarda el vecino con el formato usado