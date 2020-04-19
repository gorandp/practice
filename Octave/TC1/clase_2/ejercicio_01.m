% Datos:
V1 = 12; V2 = 6; V3 = 18; V4 = 4;
R1 = 170; R2 = 270; R3 = 1.7e3; R4 = 220; R5 = 1e3; R6 = 570;

% Calculo de corrientes:
U = [   V1-V4; 
        -V2; 
        V4+V3;
        0;
        0;
        0 ];
    
Z = [   R1, 0,      0,  -R4,    R5,     0;
        0,  -R2,    0,  0,      -R5,    -R6;
        0,  0,      R3, R4,     0,      R6;
        1,  1,      0,  0,      -1,     0;
        0, -1,     -1,  0,      0,      1;
        0,  0,      0,  1,      1,     -1 ];

I = inv(Z)*U

% Balance de potencias:
PU = V1*I(1) + V2*I(2) + V3*I(3) + V4*I(4)

PT = I(1)^2*R1 + I(2)^2*R2 + I(3)^2*(R3) + I(4)^2*(R4) + I(5)^2*(R5) + I(6)^2*(R6)

% Voltaje en R2:
UR5 = I(5)*R5
UR6 = I(6)*R6