-- Libraries description
LIBRARY ieee;
USE ieee.std_logic_1164.all; -- allows usage of std_logic and std_logic_vector

-- Entity definition. Package of the component described.
ENTITY practica_02 IS
    -- GENERIC allows us to define the entity properties
    -- which may be modified when instatiated
    GENERIC (size, width_entity : positive);
    -- Ports (entity interconection pins) declaration
    PORT (
        A, B, C: IN std_logic;
        Y, Z: OUT std_logic
    ) ;
END practica_02;

-- Architecture declaration which defines the behaviour of the entity
ARCHITECTURE comportamiento OF practica_02 IS
    -- D
    -- SIGNAL
    BEGIN
        -- These instructions are "executed" at the same time
        Y <= (not A) or (not B) or (A and B and not C);
        Z <= (not (A and B and C));
END comportamiento;
