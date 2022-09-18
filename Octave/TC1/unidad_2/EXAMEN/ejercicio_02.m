% Datos
V1=12; V2=6; I3 = 0.25;
R1=220; R2=570; R3=100; R4=170; R5=270; R6=12;
G1=1/R1; G2=1/R2; G5=1/R5; G6=1/R6;
G34 = 1/(R3+R4);

% Calculo por nudos
U = [     -V1*G1-I3+V2*G5;
          V1*G1+V2*G2];

Z = [     G1+G5, -G1;
          -G1, G1+G2+G34];

VN = inv(Z)*U;
VN1 = VN(1)
VN2 = VN(2)
VN3 = V2

% Corrientes
IR1 = (VN1-VN2+V1)*G1
IR2 = (VN2-VN3)*G2
IR3 = VN2*G34
IR4 = IR3
IR5 = (VN3-VN1)*G5
IR6 = I3
IV2 = IR2 - IR5
