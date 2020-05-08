% %%% SISTEMA DE ECUACIONES %%%
%
%      -V1 = R4*IA
%       V3 =        (R1+R3)*IB +   (-R3)*IC 
% V1+R2*I2 =          (-R3)*IB + (R2+R3)*IC
%   -R2*I2 =                       (-R2)*IC + VI2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%% RESULTADOS %%%
%
% IR1 =  0.18759
% IR2 = -0.21082
% IR3 = -0.10159
% IR4 = -0.016000
% IV1 =  0.30518
% I2 =  0.50000
%
% PI2 =  2.6352
% PV1 =  3.6622
% PV3 =  4.5022
% PR1 =  7.7420
% PR2 =  1.1111
% PR3 =  1.7545
% PR4 =  0.19200
%
%%%%%%%%%%%%%%%%%%%%

% Datos
V1 = 12; V3 = 24; I2 = 0.5;
R1 = 220; R2 = 25; R3 = 170; R4 = 750;

% Calculo de corrientes
U = [     -V1;
           V3;
     V1+I2*R2;
       -I2*R2];

Z = [     R4,      0,      0,   0;
           0,  R1+R3,    -R3,   0;
           0,    -R3,  R2+R3,   0;
	         0,      0,    -R2,  -1];

I = inv(Z)*U;

% Corrientes de mallas
IA = I(1);
IB = I(2);
IC = I(3);
VI2 = I(4);

% Corrientes por cada rama
IR1 = IB
IR2 = IC-I2
IR3 = IB-IC
IR4 = IA
IV1 = IC-IA
I2

% Balance de potencias
PI2 = -I2*VI2
PV1 = -IV1*V1
PV3 = -IR1*V3

PR1 = R1*IR1*IR1
PR2 = R2*IR2*IR2
PR3 = R3*IR3*IR3
PR4 = R4*IR4*IR4

PST = PI2+PV1+PV3; % POWER SOURCE TOTAL
PLT = PR1+PR2+PR3+PR4; % POWER LOAD TOTAL