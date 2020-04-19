% Datos:
V1 = 12; Il = 0.12;
R1 = 20; R2 = 6; R3 = 5;

% Calculo de corrientes + Uil:
U = [   V1;
        0;
        -Il;
        0 ];

Z = [   R1,  R2,     0,  0;
        0,  -R2,    R3,  0;
        1,   -1,    -1,  0;
        0,    0,    -R3,  1 ];

I = inv(Z)*U
Uil = I(4)

% Calculo de corrientes solamente:
U = [   V1;
        0;
        -Il ];

Z = [   R1,  R2,     0;
        0,  -R2,    R3;
        1,   -1,    -1 ];

I = inv(Z)*U

% Voltaje en R1 y R2:
UR1 = I(1)*R1
UR2 = I(2)*R2

% Balance de potencias:
PU = V1*I(1) + Il*Uil
PT = I(1)^2*R1 + I(2)^2*R2 + I(3)^2*(R3)
