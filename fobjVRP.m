function [c] = fobjVRP(t)

% [c] = fobjVRP({sol,costo})
% sol = solucion encontrada
% costo = vector de costos
% c = costo total

costo=t{2};
c=sum(costo);