% Regimen permanente con excitacion senoidal
% Ejercicio N1A
clear all
close all

% Expreso variable temporal en funcion del periodo
T = 2*pi/100;
t = 0:T/100:2*T;

% Funciones. Expreso todo en radianes
u1=20*cos(100*t + 0.52359);
u2=30*cos(100*t + 1.0472);

u = u1 + u2;

u_ = sqrt(2)*34.19*sin(100*t + 2.4103);

% Gr�ficos

figure(1)
plot(t,u1,'r'); grid on; title('u1 - r ; u2 - g ; u - b')
hold on
plot(t,u2,'g')
hold on
plot(t,u,'b')

figure(2)
plot(t,u,'r'); grid on; title('u obtenida por matlab - r ; u obtenida por calculo - g')
hold on
plot(t,u_,'g')