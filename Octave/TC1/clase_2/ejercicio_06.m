% %%% SISTEMA DE ECUACIONES %%%
%
% V1 + I1*R2 = R1*IR1 + (2*R4)*IR3
% V2 - I1*R2 =         (R3+R4)*IR3 - VL1
%        -I1 =    IR1 -        IR3
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%% RESULTADOS %%%
%
% IR1 = -6.0000
% IR2 =  10
% IR3 =  4.0000
% IR4 =  4.0000
% UR4 =  20.000
%
%%%%%%%%%%%%%%%%%%%%

% Datos
V1 = 20; V2 = 30; I1 = 10;
R1 = 5; R2 = 5; R3 = 5; R4 = 5;

% Calculo de corrientes
U = [   V1+I1*R2;
        V2-I1*R2;
             -I1];

% IR1, IR3, VL1 // VL1 es la tension de la fuente de corriente
Z = [   R1,  2*R4,    1;
         0, R3+R4,   -1;
         1,    -1,    0];

I = inv(Z)*U;

% Corrientes de cada resistencia
IR1 = I(1)
IR2 = I1
IR3 = I(2)
IR4 = IR3

% Voltaje en R4:
UR4 = I(2)*R4
