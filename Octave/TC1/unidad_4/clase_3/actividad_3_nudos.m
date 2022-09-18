% Regimen permanente con excitacion senoidal
% Actividad clase 3
clear all
close all

% Defino las fuentes y elementos del circuito.
%U1 = complex(217.7889, 0)
U1 = 217.79+j*0 % Vp=308 / fi=0 degree
Ii = 0.341506+j*0.091506; % Seria la I del circuito

f = 50;
w = 2*pi*f;

R1 = 120; L1 = 250e-6; C1 = 500e-6;
R2 = 1e3; L2 = 10e-3;  C2 = 250e-6;
R3 = 270;              C3 = 750e-6;
          L4 = 2e-3;   C4 = 1200e-6;
R5 = 570; L5 = 1e-3;

% a. Impedancias.
Z1 = R1 + j*(w*L1-1/(w*C1))
Z2 = R2 + j*(w*L2-1/(w*C2))
Z3 = R3 + j*(-1/(w*C3))
Z4 = j*(w*L4-1/(w*C4))
Z5 = R5 + j*w*L5

% Admitancias
Y1 = 1/Z1;
Y2 = 1/Z2;
Y3 = 1/Z3;
Y4 = 1/Z4;
Y5 = 1/Z5;

% Calculo de tensiones en nudos
U = [  U1*Y1;
           0;
          Ii];

Z = [   Y1+Y3+Y5, -Y3,   -Y5;
        -Y3, Y2+Y3+Y4,   -Y4;
        -Y5,      -Y4, Y4+Y5];

VN = inv(Z)*U;

% Tensiones de nudos
VNA = VN(1);
VNB = VN(2);
VNC = VN(3);

% b. Voltajes de impedancias
UZ1 = U1-VNA
UZ2 = VNB
UZ3 = VNA-VNB
UZ4 = VNC-VNB
UZ5 = VNA-VNC
UIi = VNC

% Corrientes por cada rama
I1 = UZ1*Y1
I2 = UZ2*Y2
I3 = UZ3*Y3
I4 = UZ4*Y4
I5 = UZ5*Y5
Ii


UZ1+UZ3+UZ2 % compruebo que la suma sea igual a la de la fuente.
U1

% d. Potencias.
% Activa
PZ1 = abs(UZ1)*abs(I1)*cos(angle(Z1))
PZ2 = abs(UZ2)*abs(I2)*cos(angle(Z2))
PZ3 = abs(UZ3)*abs(I3)*cos(angle(Z3))
PZ4 = abs(UZ4)*abs(I4)*cos(angle(Z4))
PZ5 = abs(UZ5)*abs(I5)*cos(angle(Z5))

% Reactiva
QZ1 = abs(UZ1)*abs(I1)*sin(angle(Z1))
QZ2 = abs(UZ2)*abs(I2)*sin(angle(Z2))
QZ3 = abs(UZ3)*abs(I3)*sin(angle(Z3))
QZ4 = abs(UZ4)*abs(I4)*sin(angle(Z4))
QZ5 = abs(UZ5)*abs(I5)*sin(angle(Z5))

% Aparente
SZ1 = abs(UZ1)*abs(I1)
SZ2 = abs(UZ2)*abs(I2)
SZ3 = abs(UZ3)*abs(I3)
SZ4 = abs(UZ4)*abs(I4)
SZ5 = abs(UZ5)*abs(I5)

% Balance de potencias
PU1 = abs(U1)*abs(I1)*cos(angle(U1)-angle(I1));
QU1 = abs(U1)*abs(I1)*sin(angle(U1)-angle(I1));
SU1 = abs(U1)*abs(I1);

PIi = abs(UIi)*abs(Ii)*cos(angle(UIi)-angle(Ii));
QIi = abs(UIi)*abs(Ii)*sin(angle(UIi)-angle(Ii));
SIi = abs(UIi)*abs(Ii);

PTfuentes = PU1+PIi
QTfuentes = QU1+QIi
STfuentes = abs(PTfuentes + j*QTfuentes)

PZT = PZ1+PZ2+PZ3+PZ4+PZ5
QZT = QZ1+QZ2+QZ3+QZ4+QZ5
SZT = abs(PZT + j*QZT)
