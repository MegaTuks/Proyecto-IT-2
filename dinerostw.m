function [newcosto,newb,mal] = dinerostw(sol,costo,cam,b)
% Funcion para calcular vector de costos, dada la solucion, el vector de
% costos, y el vector cam con las rutas cambiadas;

global D e l s

newcosto=costo;
newb=b;

for nRuta=1:length(cam)
    din = 0;
    ruta = sol{cam(nRuta)}; % toma una de las rutas cambiadas
    for ind=2:(length(ruta)-1)
        j = ruta(ind);
        i = ruta(ind-1);
        b(j) = max(e(j),b(i)+s(i)+D(i,j));
        if b(j)<e(j) || b(j)>l(j)
            mal=1;
            return
        end
        din = din + D(i,j);
    end
    din = din + D(ruta(end-1),ruta(end));
    costo(cam(nRuta))=din;
end
newcosto=costo;
newb=b;
mal=0;