LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY rom IS
PORT( cen: IN std_logic;
      direcc: IN std_logic_vector(1 DOWNTO 0);
      dato: OUT std_logic_vector(7 DOWNTO 0));
END rom;

ARCHITECTURE modelo OF rom IS
   SIGNAL salida: std_logic_vector(7 DOWNTO 0);
   SIGNAL cenr: std_logic;
BEGIN

PROCESS(direcc)
BEGIN
-- Sea cual sea la dirección, a los 10 ns. de cambiar, debe
-- pasar a desconocido:
   salida<="XXXXXXXX" AFTER 10 ns;
   CASE direcc IS
     WHEN "00"=>salida<=TRANSPORT X"00" AFTER 100 ns;
     WHEN "01"=>salida<=TRANSPORT "00000001" AFTER 100 ns;
     WHEN "10"=>salida<=TRANSPORT "01010101" AFTER 100 ns;
     WHEN "11"=>salida<=TRANSPORT "10101010" AFTER 100 ns;
     WHEN OTHERS=> NULL;
   END CASE;
END PROCESS;

-- Este es el buffer triestado:
dato<=salida       WHEN cenr='0' ELSE 
      (OTHERS => 'Z') WHEN cenr='1' ELSE
      (OTHERS => 'X');

-- Este es el retraso del chip enable
cenr<=cen AFTER 60 ns;

END modelo;
          
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test IS
END test;

ARCHITECTURE estimulos OF test IS
COMPONENT rom
PORT( cen: IN std_logic;
      direcc: IN std_logic_vector(1 DOWNTO 0);
      dato: OUT std_logic_vector(7 DOWNTO 0));
END COMPONENT;

SIGNAL cen: std_logic;
SIGNAL direcc: std_logic_vector(1 DOWNTO 0);
SIGNAL dato: std_logic_vector(7 DOWNTO 0);      
FOR ALL: rom USE ENTITY rom;
BEGIN
  u0: rom PORT MAP(cen,direcc,dato);
  cen<='1','0' AFTER 150 ns,'1' AFTER 600 ns;
  direcc<="00","01" AFTER 200 ns,"10" AFTER 350 ns;
END estimulos;