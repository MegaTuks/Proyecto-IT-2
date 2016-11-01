function [costo] = dineros(sol,costo,cam)
% Funcion para calcular vector de costos, dada la solucion, el vector de
% costos, y el vector cam con las rutas cambiadas;

global D

for nRuta=1:length(cam)
    din = 0;
    ruta = sol{cam(nRuta)}; % toma una de las rutas cambiadas
    for ind=2:(length(ruta)-1)
        j = ruta(ind);
        i = ruta(ind-1);
        din = din + D(i,j);
    end
    din = din + D(ruta(end-1),ruta(end));    
    costo(cam(nRuta))=din;
end