% Codigo base del proyecto
%% Entrada de datos
clear; clc; close all

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

%% Gráfica de clientes
dg=5;
deltax = -1.35;
deltay = +0.2;
clf
plot(x(1),y(1),'sr',x(2:end),y(2:end),'ob','MarkerSize',12)
xlim([min(x)-dg max(x)+dg])
ylim([min(y)-dg max(y)+dg])
legend('     almacen','      clientes','Location','BestOutside')
xlabel('x')
ylabel('y')
title(sprintf('distribucion de clientes VRP: %s',fname))
hold on
for i=1:length(x)
    text(x(i)+deltax,y(i)+deltay,sprintf('%2d',nc(i)),'FontSize',8)
end
hold off

%% Inicializar las rutas
% Funciones disponibles: irutas, irutas2
% irutas usa un algoritmo de first fit
% irutas2 genera 100 rutas iniciales
xi = irutas(nc);

%% Llamado a Recocido
clc
c0 = 300;               % temperatura inicial
%p.beta=1.2;            % descomentar beta, minRaz, y poner c0=0 si se
%p.minRazAcep=0.95;     % quiere calcular una buena c0
p.cadIntAcep = 150;
p.cadInt = 500;
p.maxCad = 5;
p.frecImp = 500;
p.alfa = 0.95;
p.variarC = 0;
p.x0 = xi;  % xi = {sol,costo} sol = array rutas, costo = vector costos
p.FcnObj = @fobjVRP;         % funcion objetivo
p.FcnVec = @vecinoVRP;    % funcion de vecindad
p.Imp = @imprime;      % funcion de impresion
p.min = 1;

tipo = 1;
if tipo == 0
    res = recocido(p,c0,338);
else
    [xp,prom,desv,mruta,mcosto] = plotRecocido(p,3,c0,8799);
end

%% Gráfica y evaluación de una solución u
clc
if tipo == 0
    u=res.x{length(res.x)-1}; % Guarda la mejor solucion desde recocido
    costo=sum(res.x{length(res.x)}); % Es el costo total
else
    u=mruta;
    costo=mcosto;
end
dg=5;
cap=zeros(length(u),1);
for i=1:length(u)
    cap(i)=sum(d(u{i}));
end
delta = 0.5;
clf
colores = {'m','r','b','k','g'};
formas = {'.','o','x','+','s','d','v','^','p','<','>','h'};
nformas = length(formas);
ncolores = length(colores);
plot(x(1),y(1),'sb', 'MarkerEdgeColor','b','MarkerFaceColor','b',...
    'MarkerSize',10)
xlim([min(x)-dg max(x)+dg])
ylim([min(y)-dg max(y)+dg])
xlabel('x')
ylabel('y')
title(sprintf('VRP-%s, %d clientes, costo=%f, %d rutas',fname,...
    length(nc)-1,costo,length(u)))
hold on
leg = {};
leg{1} = '     almacen';
for i=1:length(u)
    str = sprintf('%c-%c',formas{mod(i,nformas)+1},...
        colores{mod(i,ncolores)+1});
    plot(x(u{i}),y(u{i}),str,'MarkerSize',6)
    leg{i+1} = sprintf('%2d: (%d) %3d',i,length(u{i})-2,cap(i));
end
plot(x(1),y(1),'sb', 'MarkerEdgeColor','b','MarkerFaceColor',...
    'b','MarkerSize',10)
legend(leg,'Location','BestOutside')
for i=1:length(x)
    text(x(i)+delta,y(i)+delta,sprintf('%2d',nc(i)),'FontSize',8)
end
hold off
%% Tabulación de solución
clc
fprintf('\n')
fprintf('  Costo total: %f\n',costo)
fprintf('    Capacidad: %d\n',C)
fprintf('Rutas:\n')
for i=1:length(u)
    fprintf('%3d: (%2d)',i,length(u{i})-2)
    fprintf(' [cap=%3d] ',cap(i))
    fprintf(' %d',nc(u{i}(2:end-1)))
    fprintf('\n')
end
fprintf('\n')