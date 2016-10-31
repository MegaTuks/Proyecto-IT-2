function [vecino] = vecinoVRP(t)

% [vecino] = costoVRP({sol,costo})
% sol = solucion encontrada
% costo = vector de costos
% vecino = nuevas rutas y sus costos

sol=t{1}; % sol es el conjunto de rutas, la solucion
costo = t{2}; % vector con los costos

% Hacer global el vector de demandas (d) y la matriz de distancias (D)
global C d D

v = 0; % condicion de paro que indica si se cumple la restriccion
lon=length(sol); % lon = numero de rutas dentro de la solucion
% cam = vector con la(s) rutas cambiadas
% Nota, el codigo esta hecho considerando que el almacen es el cliente 1, y
% que esta al principio y fin de cada ruta
while v == 0
    if randi([0,1]) == 0
       [sol,cam] = vecinoHeuristica1(sol,lon);
    else
        [sol,cam] = vecinoHeuristica2(sol,lon);
    end
end
% Calcula el nuevo vector de costos segun la(s) rutas modificadas

for nRuta=1:length(cam)
    din = 0;
    ruta = sol{cam(nRuta)}; % toma una de las rutas cambiadas
    for ind=2:length(ruta)
        j = ruta(ind);
        i = ruta(ind-1);
        din = din + D(i,j);
    end
    din = din + D(ruta(end-1),ruta(end));
    if din>0
        costo(cam(nRuta))=din;
    else
        sol(cam(nRuta))=[]; % elimina esa ruta ya que se quedo vacioa
        costo(cam(nRuta))=[]; % 0 costo = no hay ruta
    end
end
vecino={sol,costo}; % guarda el vecino con el formato usado