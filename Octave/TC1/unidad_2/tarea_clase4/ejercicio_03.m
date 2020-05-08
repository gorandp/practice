% Datos
V3=220; V4=170;
R1=1000; R2=2700; R3=270; R4=1700;
G1=1/R1; G2=1/R2; G3=1/R3; G4=1/R4;

% Calculo de corrientes
U = [     V3*G1;
          V4];

Z = [     G1+G2+G3,   -G3;
                 0,     1];

VN = inv(Z)*U;
VN1 = VN(1)
VN2 = VN(2)
VN3 = 0

% Diferencias de potenciales de cada resistencia
VR1 = VN3+V3-VN1
VR2 = VN1-VN3
VR3 = VN1-VN2
VR4 = VN2-VN3

% Corrientes por cada resistencia
IR1 = VR1*G1
IR2 = VR2*G2
IR3 = VR3*G3
IR4 = VR4*G4

% Corriente de rama para V4
IV4 = IR4-IR3
