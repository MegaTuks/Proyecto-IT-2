% Codigo base del proyecto
%% Entrada de datos
clear; clc;

global C d D

% Leo datos del problema
fname = 'r101';                % archivo de datos: r101 o r102
A = importdata(strcat(fname,'.txt'), ' ',9);
v = sscanf(A.textdata{5},'%d');
numeroVehiculos = v(1);
C = v(2); % capacidad de los vehiculos
nc = A.data(:,1); % numero de cliente
x = A.data(:,2); % coordenada x 
y = A.data(:,3); % coordenada y
d = A.data(:,4); % demanda
e = A.data(:,5); % ready time
l = A.data(:,6); % due date
s = A.data(:,7); % service time

fprintf('Problema %5s, Capacidad=%d, Número max de vehículos=%d\n',...
    fname,C,numeroVehiculos)

D = zeros(length(nc)); % matriz con distancias
   for i=1:length(nc)
      for j=i+1:length(nc)
         D(i,j) = norm([x(i) y(i)]-[x(j) y(j)]);
         D(j,i) = D(i,j);
      end
   end
   
%% Inicializar las rutas
xi = irutas(nc); %Plata: seria cuestion de modificar irutas para
                         % que de unas mejores rutas iniciales


%% Llamado a Recocido
clc;
c0 = 2400;               % temperatura inicial
p.cadIntAcep = 100;
p.cadInt = 400;
p.maxCad = 3;
p.frecImp = 50;
p.alfa = 0.98;
p.variarC = 0;
% para optimizar, se guarda en la x la solucion (las rutas) y el vector con
% los costos de cada ruta.
p.x0 = xi;  % xi = {sol,costo} sol = array rutas, costo = vector costos
p.FcnObj = @fobjVRP;         % funcion objetivo
p.FcnVec = @vecinoVRP;    % funcion de vecindad
p.Imp = @imprime;      % funcion de impresion
p.min = 1;

r=recocido(p,c0,338);