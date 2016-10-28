function [xi]= irutas(nc)
% Es un greedy algorithm basado en first-fit approach
% nc = vector numero de clientes
global D  C  d

% Genera la semilla
nclientes=length(nc)-1;    % numero de clientes (sin el almacen)
prueba=true(1,nclientes);  % vector lógico para el algoritmo
prueba(1)=0;    % el primero es falso porque es el almacen
semilla = cell(1);
i=0;  % contador para las rutas

while any(prueba)
    i=i+1;
    ractual=1;    % iniciador de rutas
    pos=find(prueba); % indices de los clientes no ruteados
    for j=1:length(pos)
        if sum(d(ractual))+ d(pos(j)) <= C
            ractual=[ractual,pos(j)];
            prueba(pos(j))=0;
        end
    end
    ractual=[ractual,1];
    semilla{i}=ractual;
end
nrutas=i;   % numero de rutas generadas
% Calcula el vector de costos para las rutas iniciales
costo=zeros(1,nrutas);
for nRuta=1:nrutas
    din = 0;
    ruta = semilla{nRuta}; % toma una ruta
    for ind=2:length(ruta)
        j = ruta(ind);
        i = ruta(ind-1);
        din = din + D(i,j);
    end
    costo(nRuta) = din + D(ruta(end-1),ruta(end));
end
xi={semilla,costo}; % guarda el vecino con el formato usado