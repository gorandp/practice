% Regimen permanente con excitacion senoidal
% Ejercicio N17
clear all
close all

% Defino las tensiones conocidas y elementos del circuito.
U2 = 215 + j*0;

f = 50;
w = 2*pi*f;

PM1 = 4e3; fp1 = 0.6; % en adelanto
PM2 = 5e3; fp2 = 0.8; % en atraso

R1 = 0.2; XL1 = 0.4;
R2 = 0.2; XL2 = 0.4;

% a) Cálculo de U1
absi2 = PM2/(abs(U2)*fp2);
radi2 = -acos(fp2);
i2 = absi2*exp(j*radi2); % Polar expression
% https://csserver.evansville.edu/~richardson/courses/Tutorials/complex_numbers/octave/html/octave.html

Z2 = R2 + j*XL2;
U1 = U2 + Z2*i2

% a) Cálculo de E1
Z1 = R1 + j*XL1;
absi1 = PM1/(abs(U1)*fp1);
radi1 = acos(fp1) - angle(U1);
i1 = absi1*exp(j*radi1);

i = i1 + i2;

E1 = U1 + Z1*i

% b) P, Q y S del generador.

SE1 = abs(E1)*abs(i)
PE1 = SE1*cos(angle(E1)-angle(i))
QE1 = SE1*sin(angle(E1)-angle(i))

% c) P, Q, S de cada receptor.

SR1 = (abs(i)**2)*R1
PR1 = SR1
QR1 = 0

SL1 = (abs(i)**2)*XL1
PL1 = 0
QL1 = SL1

SM1 = abs(U1)*abs(i1)
PM1 = SM1*cos(angle(U1)-angle(i1))
QM1 = SM1*sin(angle(U1)-angle(i1))

SR2 = (abs(i2)**2)*R2
PR2 = SR2
QR2 = 0

SL2 = (abs(i2)**2)*XL2
PL2 = 0
QL2 = SL2

SM2 = abs(U2)*abs(i2)
PM2 = SM2*cos(angle(U2)-angle(i2))
QM2 = SM2*sin(angle(U2)-angle(i2))

% d) Realizar balance energético.

PE1
PT = PR1 + PL1 + PM1 + PR2 + PL2 + PM2

QE1
QT = QR1 + QL1 + QM1 + QR2 + QL2 + QM2

SE1
sqrt(PT**2 + QT**2)

% e) En caso de que el factor de potencia de
%    la carga total sea menor que 0,85 calcular
%    el elemento necesario para corregirlo y
%    graficar el nuevo circuito.

fp = cos(angle(E1)-angle(i))
angle(E1)-angle(i)

% Si el fp es menor a 0.85:
%   - si el angulo es <0 entonces es capacitivo
%     (hay que agregar una bobina en serie al
%     circuito para corregir el fp)
%
%   - si el angulo es >0 entonces es inductivo
%     (hay que agregar un capacitor en serie al
%     circuito para corregir el fp)

% fp =  0.99943 %% Es mayor a 0.85, por lo que no hace falta corregirlo
