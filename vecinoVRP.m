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
        % Hacer inversion de una parte de ruta
        cam = randi([1,lon]); % el numero de la ruta a cambiar
        n = length(sol{cam})-2; % longitud de dicha ruta menos dos por el
        % almacen
        if n>2 % No tiene caso permutar una ruta con menos de 3 clientes
            % Se obtienen dos ciudades para hacer la inversion (parte copiada
            % del archivo vecinoTSP) m1 y m2 son siempre distintos
            m1 = randi([1,n]);
            m2 = mod(randi([0,n-2])+m1, n)+1;
            n1 = min([m1 m2])+1; % se le agrega 1 por el almacen
            n2 = max([m1 m2])+1;
            
            % Realiza la inversion de la subruta desde n1 hasta n2
            sol{cam}(n1:n2) = sol{cam}(n2:-1:n1);
            v = 1; % permutacion, siempre se cumple la restriccion
        end
    else
        % Intercambio de elemento entre rutas
        % Se obtienen dos rutas para hacer la inversion, de la primera se
        % quitara un elemento de la posicion a y se pondra en la posicion b
        % de la segunda ruta
        m1 = randi([1,lon]);
        m2 = mod(randi([0,lon-2])+m1, lon)+1;
        ruta1 = sol{m1};
        ruta2 = sol{m2};
        a=randi([2,length(ruta1)-1]);   % empieza en 2 por el almacen
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
                costo(m1)=[];
                if m1<m2 % si se elimino una ruta de antes, ruta 2 baja
                    cam = m2-1;
                else
                    cam = m2;
                end
            end
            v=1;
        end
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