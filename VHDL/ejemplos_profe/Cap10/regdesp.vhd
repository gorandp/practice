LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

PACKAGE registros IS 
  COMPONENT desplazamiento PORT(clk, rst, ed, ei : IN STD_LOGIC;
				m : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				e : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				s : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0));
  END COMPONENT;
END registros;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
ENTITY desplazamiento IS PORT(clk, rst, ed, ei : IN STD_LOGIC;
				m : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				e : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				s : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0));
END desplazamiento;

ARCHITECTURE comportamiento OF desplazamiento IS
BEGIN
  PROCESS (clk,rst)
  BEGIN
	IF rst='1' THEN s<="0000";
	ELSIF (clk'EVENT AND clk='1') THEN
		CASE 	m IS
		  WHEN	"01"   => s(3)<=ei; s(2)<=s(3);   --Desplazamiento a
			          s(1)<=s(2); s(0)<=s(1); --la derecha
		  WHEN	"10"   => s(3)<=s(2); s(2)<=s(1); --Desplazamiento a 
			          s(1)<=s(0); s(0)<=ed;   --la izquierda
		  WHEN	"11"   => s<=e;		          --Carga en paralelo
		  WHEN	OTHERS => s<=s;		          --La salida no cambia
		END CASE;
	END IF;
  END PROCESS;
END comportamiento;
	