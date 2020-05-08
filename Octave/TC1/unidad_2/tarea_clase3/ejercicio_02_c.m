% Datos
V1=24; V2=12;
R1=220; R2=25; R3=170; R4=270; R5=750; R6=1000;
G1=1/R1; G2=1/R2; G3=1/R3; G4=1/R4; G5=1/R5; G6=1/R6;

% Calculo de corrientes
U = [     V1*G1+V2*G2;
                    0;
               -V1*G1];

Z = [     G1+G2+G3, -G3,      -G1;
          -G3, G3+G4+G5,      -G5;
          -G1,      -G5, G1+G5+G6];

VN = inv(Z)*U;
VN1 = VN(1)
VN3 = VN(2)
VN4 = VN(3)

% Diferencias de potenciales de cada resistencia
VR1 = VN4+V1-VN1
VR2 = -(VN1-V2)
VR3 = VN1-VN3
VR4 = VN3
VR5 = VN3-VN4
VR6 = -VN4

% Corrientes por cada resistencia
IR1 = VR1*G1
IR2 = VR2*G2
IR3 = VR3*G3
IR4 = VR4*G4
IR5 = VR5*G5
IR6 = VR1*G6
