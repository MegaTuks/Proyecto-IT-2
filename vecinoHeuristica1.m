function [vecin,cam] =  vecinoHeuristica1(sol,len)

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
 vecin = sol