% Datos:
V1 = 12;
R1 = 17; R2 = 33; R3 = 1000; R4 = 512;

% Calculo de corrientes:
U = [   V1; 
        0; 
        0;
        0 ];

Z = [   R1, R2,     0,  0;
        0,  -R2,    R3,  0;
        0,  0,     -R3, R4;
        1, -1,      -1, -1 ];

I = inv(Z)*U

% Balance de potencias:
PU = V1*I(1)

PT = I(1)^2*R1 + I(2)^2*R2 + I(3)^2*(R3) + I(4)^2*(R4)

% Voltaje en R2 y R4:
UR2 = I(2)*R2
UR4 = I(4)*R4