function [vecin,cam,c] = vecinoHeuristica2(sol,lon,costo)

global C d
c=costo;
% Intercambio de elemento entre rutas
% Se obtienen dos rutas para hacer la inversion, de la primera se
% quitara un elemento de la posicion a y se pondra en la posicion b
% de la segunda ruta
m1 = randi([1,lon]);
m2 = mod(randi([0,lon-2])+m1, lon)+1;
ruta1 = sol{m1};
ruta2 = sol{m2};
vectorT = 1:lon;
vectorT(m1) = [];
if m1<m2
    vectorT(m2-1) = [];
else
    vectorT(m2) = [];
end
a=randi([2,length(ruta1)-1]);   % empieza en 2 por el almacen
while (sum(d(ruta2)) + d(ruta1(a)) > C && ~isempty(vectorT))
    m3 = randi([1,length(vectorT)]);
    m2 = vectorT(m3);
    ruta2 = sol{m2};
    vectorT(m3) = [];
end
b=randi([2,length(ruta2)-1]);   % se le resta 1 por el almacen
ruta2=[ruta2(1:b),ruta1(a),ruta2(b+1:end)];
if sum(d(ruta2)) <= C  % Comprobar que no se viole la restriccion
    ruta1(a) = []; % elimina el valor que se movio
    if length(ruta1) > 2 % si es mayor que 2 hay elementos en la
        % ruta que no sean el almacen
        sol{m1} = ruta1;
        sol{m2} = ruta2;
        cam = [m1 , m2];
    else
        sol{m2} = ruta2;
        sol(m1)=[];
        c(m1)=[];
        if m1<m2 % si se elimino una ruta de antes, ruta 2 baja
            cam = m2-1;
        else
            cam = m2;
        end
    end
else
    cam=[]; % no se hizo ningun intercambio
end
vecin = sol;