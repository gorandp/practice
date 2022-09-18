% Datos
R = 12; L = 1/1000; U = 12; I0 = exp(-1.2);
TAU = L/R;

% Dominio
PASO = 1/70; % milisegundos
FIN = 7/10; % milisegundos
t = [0:PASO:FIN];

% Funcion
it = U/R + (I0 - U/R) * exp(-t/(1000*TAU)); % t está en milisegundos

plot(t, it)
