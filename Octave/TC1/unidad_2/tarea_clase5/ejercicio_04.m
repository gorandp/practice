%%%%%%%%%%%%%%%%%%%%%% Sistema de ecuaciones %%%%%%%%%%%%%%%%%%%%%%
%      G1*V1+G2*V2+G2*V4 = (G2)*VN1            +  (1)*IV1
% G2*V2+G3*V3+(G2+G3)*V4 = (G2)*VN1                       + (1)*IV4
%                 -V1*G1 =          + (G4)*VN3 + (-1)*IV1
%                     V1 = (-1)*VN1 +  (1)*VN3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Datos
V1=6; V2=12; V3=6; V4=8;
R1=220; R2=1000; R3=570; R4=570;
G1=1/R1; G2=1/R2; G3=1/R3; G4=1/R4;

% Resolución sistema de ecuaciones
U = [      G1*V1+G2*V2+G2*V4;
      G2*V2+G3*V3+(G2+G3)*V4;
                      -V1*G1;
                          V1];

Z = [  G2,  0,  1,  0;
       G2,  0,  0,  1;
        0, G4, -1,  0;
       -1,  1,  0,  0];

VN = inv(Z)*U;
VN1 = VN(1)
VN2 = V4
VN3 = VN(2)

% Diferencias de potenciales de cada resistencia
VR1 = -V1
VR2 = V2-VN1+VN2
VR3 = VN2+V3
VR4 = VN3

% Corrientes por cada resistencia
IR1 = G1*VR1
IR2 = G2*VR2
IR3 = G3*VR3
IR4 = G4*VR4

% Corrientes en las fuentes de tension ideales
IV1 = UN(3)
IV4 = UN(4)
