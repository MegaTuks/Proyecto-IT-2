function [X,prom,desv,mruta,mcosto] = plotRecocido(p,n,varargin)
% [x,prom,desv] = plotrecocido(p,n,c0)
% [x,prom,desv] = plotrecocido(p,n,c0,semilla)
%
% Llama repetidamente a recocido(p) para generar una curva
% de mejor encontrado.
%          p: par�metros para recocido
%          n: numero de corridas
%         c0: temperatura inicial
%    semilla: semilla del generador de numeros aleatorios
%
% See also: recocido, blocal, plotBlocal

%*****************************************************************
%*                                                               *
%*   Recocido: Una implemetaci�n de recocido simulado en MATLAB  *
%*                                                               *
%*   Copyright (c) Derechos Reservados                           *
%*   Manuel Valenzuela Rend�n                                    *
%*   valenzuela@itesm.mx                                         *
%*   http://homepages.mty.itesm.mx/valenzuela                    *
%*                                                               *
%*   Tecnol�gico de Monterrey, Campus Monterrey                  *
%*   Monterrey, N.L., M�xico                                     *
%*                                                               *
%*****************************************************************

if length(varargin)>=1
   c0 = varargin{1};
else
   c0 = 0;
end

if length(varargin)>=2
   semilla = varargin{2};
else
   semilla = sum(100*clock);
end

fprintf('\n*** Iniciando corrida #1 ***\n')
res = recocido(p,c0,semilla);
mruta = res.x{end-1};    % modificacion para guardar la mejor ruta
mcosto = sum(res.x{end}); % modificacion para guardar el mejor costo
X = res.intentos;
Y = res.f;
nx = length(X);
for i=2:n
fprintf('\n*** Iniciando corrida #%d ***\n', i)
   res = recocido(p,c0);
   acosto=sum(res.x{end});
   if acosto < mcosto
      mcosto=acosto;
      mruta = res.x{end-1};
   end
   mx = length(res.intentos);
   if mx < nx
      res.f = [res.f; res.f(mx)*ones(nx-mx,1)];
   end
   if mx > nx
      X = res.intentos;
      Y = [Y; ones(mx-nx,1)*Y(nx,:)];
      nx = mx;
   end
   Y = [Y res.f];
end
prom = mean(Y,2);
desv = std(Y,0,2);
plot(X,prom+desv,X,prom,'.-',X,prom-desv)
xlabel('intentos')
ylabel('f(x)')
legend('promedio+desv est','promedio','promedio-desv est','Location','Best')
obj = p.FcnObj;
if isa(obj,'function_handle')
   obj = func2str(obj);
end
title(['curva de mejor encontrado para la funci�n "',obj,'"'])