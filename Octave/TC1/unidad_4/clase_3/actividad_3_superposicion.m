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

%%%%%%%%%%%%%%%%%%
%%% Circuito 1 %%%
%%%%%%%%%%%%%%%%%%

Y45 = 1/(Z5+Z4);
ZPparalelo = 1/(Y3+Y45);
ZEQp = Z1 + ZPparalelo + Z2;
I1p = U1/ZEQp;
I2p = I1p;
I3p = I1p*ZPparalelo*Y3;
I4p = I1p*ZPparalelo*Y45;
I5p = I4p;
UIip = I2p*Z2+I4p*Z4;

%%%%%%%%%%%%%%%%%%
%%% Circuito 2 %%%
%%%%%%%%%%%%%%%%%%

ZA = (Y3+Y4+Y2)*Z3*Z4;
ZB = (Y3+Y4+Y2)*Z3*Z2;
ZC = (Y3+Y4+Y2)*Z2*Z4;
YA = 1/ZA;
YB = 1/ZB;
YC = 1/ZC;

ZA5=1/(YA+Y5);
Z1B=1/(Y1+YB);
ZEQpp = 1/(YC+1/(ZA5+Z1B));
UIipp = Ii*ZEQpp;

I5pp=Ii*(ZEQpp*YC-1)*ZA5*Y5;
I1pp=Ii*(ZEQpp*YC-1)*Z1B*Y1;
I3pp=I1pp-I5pp;
I2pp=I1pp+Ii;
I4pp=I5pp+Ii;

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Circuito Original %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

% Corrientes por cada rama
I1 = I1p+I1pp
I2 = I2p+I2pp
I3 = I3p+I3pp
I4 = I4p+I4pp
I5 = I5p+I5pp
UIi = UIip+UIipp
Ii

% b. Voltajes de impedancia
UZ1 = I1*Z1
UZ2 = I2*Z2
UZ3 = I3*Z3
UZ4 = I4*Z4
UZ5 = I5*Z5

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
