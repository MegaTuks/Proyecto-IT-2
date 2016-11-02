function imprime(varargin)
% imprime(nRutas, costo, intentos, c)

% Imprime el mejor encontrado (y el actual) de una corrida de recocido.

fprintf(' nRutas=%d',varargin{1});
fprintf(' Costo=%0.3f',varargin{2});
fprintf(' Intentos=%d',varargin{3})
fprintf(' c=%0.3f',varargin{4});
fprintf('\n')