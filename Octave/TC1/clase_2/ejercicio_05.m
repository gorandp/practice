% Datos:
V1 = 12; V2 = 6; V3 = 12;
R1 = 170; R2 = 330; R3 = 220; R4 = 17; R5 = 170; R6 = 512;

% Calculo de corrientes:
U = [   V1;
       -V2;
        V3;
        0;
        0;
        0 ];

Z = [   R1,  R2,    0,  R4,    0,     0;
        0,  -R2,  -R3,   0,   R5,     0;
        0,    0,    0, -R4,  -R5,    R6;
        1,   -1,    1,   0,    0,     0;
        0,    1,    0,  -1,    1,     0;
        0,    0,   -1,   0,   -1,    -1 ];

I = inv(Z)*U

% Balance de potencias:
PU = V1*I(1) + V2*I(3) + V3*I(6)

PT = I(1)^2*R1 + I(2)^2*R2 + I(3)^2*(R3) + I(4)^2*(R4) + I(5)^2*(R5) + I(6)^2*(R6)

% Voltaje en R2:
UR2 = I(2)*R2