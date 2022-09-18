% Regimen permanente con excitacion senoidal
% Ejercicio N10
clear all
close all

% Defino las fuentes y elementos del circuito.
U1 = 220 + j*0; % ya definida como eficaz.

f = 50;
w = 2*pi*f;

PM1e = 1e3;     n1 = 0.75;  fp1 = 0.8;
PM2e = 1.5e3;   n2 = 0.8;   fp2 = 0.65;
PM3e = 2e3;     n3 = 0.67;  fp3 = 0.7;

% b. Potencias absorbidas.
% n = Pe / Pa
PM1a = PM1e/n1
PM2a = PM2e/n2
PM3a = PM3e/n3

PMTa = PM1a + PM2a + PM3a

% c. Potencias aparentes y reactivas.
SM1 = PM1a/fp1
SM2 = PM2a/fp2
SM3 = PM3a/fp3

ang1 = acosd(fp1)
ang2 = acosd(fp2)
ang3 = acosd(fp3)

QM1 = SM1*sind(ang1)
QM2 = SM2*sind(ang2)
QM3 = SM3*sind(ang3)

QMT = QM1 + QM2 + QM3
SMT = abs(PMTa + QMT*j)

% d. Corrientes.
IM1_ = PM1a / (abs(U1)*fp1); angI1 = angle(U1)-acos(fp1); % Trabajo en radianes porque la función angle devuelve radianes. 
IM1 = IM1_*cos(angI1) + j*IM1_*sin(angI1)

IM2_ = PM2a / (abs(U1)*fp2); angI2 = angle(U1)-acos(fp2); % Trabajo en radianes porque la función angle devuelve radianes. 
IM2 = IM2_*cos(angI2) + j*IM2_*sin(angI2)

IM3_ = PM3a / (abs(U1)*fp3); angI3 = angle(U1)-acos(fp3); % Trabajo en radianes porque la función angle devuelve radianes. 
IM3 = IM3_*cos(angI3) + j*IM3_*sin(angI3)

IMT = IM1 + IM2 + IM3

% E. Compensacion de factor de potencia.

angT = angle(U1)- angle(IMT)
angT*180/pi

C = PMTa*(tan(angT) - tan(acos(0.85)))/(abs(U1)^2*w)

% G. Corriente total.

XC = -j/(w*C);
IT = IMT + U1/XC
abs(IT)
angle(IT)*180/pi


