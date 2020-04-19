% Datos:
I1 = 1;
R1 = 10; R2 = 10; R3 = 100;

% Calculo de corrientes:
U = [   0;
        0;
        -I1 ];

Z = [ -10*R1,  R2,     0;
        9*R1,   0,    R3;
          -1,  -1,     0];

IR = inv(Z)*U
