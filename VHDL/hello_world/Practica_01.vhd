LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY practica13 IS
  PORT (
    A, B, C: IN std_logic;
    Y, Z: OUT std_logic
  ) ;
END practica13;

ARCHITECTURE comportamiento OF practica13 IS
    BEGIN
        Y <= (not A) or (not B) or (A and B and not C);
        Z <= (not (A and B and C));
END comportamiento;
