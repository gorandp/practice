% Regimen permanente con excitacion senoidal
% Ejercicio N1A
clear all
close all

% Expreso variable temporal en funcion del periodo
T = 2*pi/100;
t = 0:T/100:2*T;
w = 50;

% Angulos en grados pasados a radianes
%deg2rad = pi/180;
rtheta1=deg2rad(15);
rtheta2=deg2rad(-25);
rtheta3=deg2rad(-55);

% Funciones. Expreso todo en radianes
i1=5*sin(w*t + rtheta1);
i2=3.5*sin(w*t + rtheta2);
i3=2*sin(w*t + rtheta3);

i = i1 + i2 + i3;

rtheta=deg2rad(-11.271);
i_ = sqrt(2)*6.596*sin(w*t + rtheta);

% Gr�ficos

figure(1)
plot(t,i1,'r'); grid on; title('i1 - r ; i2 - g ; i3 - y; i - b')
hold on
plot(t,i2,'g')
hold on
plot(t,i3, 'y')
hold on
plot(t,i,'b')

figure(2)
plot(t,i,'r'); grid on; title('i obtenida por matlab - r ; i obtenida por calculo - g')
hold on
plot(t,i_,'g')
