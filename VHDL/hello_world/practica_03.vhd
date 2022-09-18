LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY practica_03 IS
    GENERIC (size, width_entity : positive);
    PORT (
        bus_in: in std_logic_vector(0 to 3);
        control: in std_logic_vector(0 to 1);
        bus_out: out std_logic_vector(0 to 3)
    ) ;
END practica_03;

-- with select architecture (Lo vincula directamente con multiplexores)
architecture with_select of practica_03 is
    begin
        with control select
            bus_out <= bus_in when "00"
                       bus_in(1 to 3) & '0' when "01"
                       '0' & bus_in(0 to 2) when "10"
                       bus_in(3) & bus_in(0 to 2) when others
end with_select ; -- with_select

-- when else architecture (No lo vincula directamente con multiplexores)
architecture when_else of practica_03 is
    begin
        bus_out <= bus_in when control="00" else -- no se desplaza
                   bus_in(1 to 3) & '0' when control="01" else -- desplazamiento a la izquierda
                   '0' & bus_in(0 to 2) when control="10" else -- desplazamiento a la derecha
                   bus_in(3) & bus_in(0 to 2) when control="11" -- rotacion a la derecha
end when_else ; -- when_else
