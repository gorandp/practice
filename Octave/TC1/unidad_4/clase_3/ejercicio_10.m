% Regimen permanente con excitacion senoidal
% Ejercicio N10
clear all
close all

% Defino las fuentes y elementos del circuito.
U1 = 15.38+j*7.17;

f = 50;
w = 2*pi*f;

R1 = 12; L1 = 10e-3;                
R2 = 1e3; L2 = 15e-3;               
R3 = 750; L3 = 25e-3;               
R4 = 270; L4 = 500e-6; C1 = 25e-6;  

% a. Impedancias.
Z1 = R1 + j*w*L1
Z2 = R2 + j*w*L2
Z3 = R3 + j*w*L3
Z4 = R4 + j*(w*L4 - 1/(w*C1))

% c. Corrientes de rama.
ZP = (Z2*Z3)/(Z2+Z3);
ZT = Z1 + ZP + Z4

I1 = U1/ZT
I4 = I1
I2 = I1*ZP/Z2
I3 = I1*ZP/Z3

% b. Voltajes de impedancia
UZ1 = I1*Z1
UZP = I1*ZP
UZ4 = I1*Z4

UZ1+UZP+UZ4 % compruebo que la suma sea igual a la de la fuente.
U1

% d. Potencias.
% Activa
PZ1 = abs(UZ1)*abs(I1)*cos(angle(Z1))
PZ2 = abs(UZP)*abs(I2)*cos(angle(Z2))
PZ3 = abs(UZP)*abs(I3)*cos(angle(Z3))
PZ4 = abs(UZ4)*abs(I1)*cos(angle(Z4))
 
% Reactiva
QZ1 = abs(UZ1)*abs(I1)*sin(angle(Z1))
QZ2 = abs(UZP)*abs(I2)*sin(angle(Z2))
QZ3 = abs(UZP)*abs(I3)*sin(angle(Z3))
QZ4 = abs(UZ4)*abs(I1)*sin(angle(Z4))

% Aparente
SZ1 = abs(UZ1)*abs(I1)
SZ2 = abs(UZP)*abs(I2)
SZ3 = abs(UZP)*abs(I3)
SZ4 = abs(UZ4)*abs(I1)

% Balance de potencias
PU1 = abs(U1)*abs(I1)*cos(angle(U1)-angle(I1))
QU1 = abs(U1)*abs(I1)*sin(angle(U1)-angle(I1))
SU1 = abs(U1)*abs(I1)

PZT = PZ1+PZ2+PZ3+PZ4
QZT = QZ1+QZ2+QZ3+QZ4
SZT = abs(PZT + j*QZT)

% Factor de potencia de la red.
% Si el angulo es positivo, el factor de potencia es en atraso.
% de lo contrario es en adelanto.
angulo = angle(U1)-angle(I1); 
ang_grad = angulo*180/pi

fp = cos(angulo);
fp_grad = fp*180/pi
