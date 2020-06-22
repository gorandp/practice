LIBRARY ieee;
USE ieee.std_logic_1164.ALL

ENTITY ff IS
PORT(d,clk: IN std_logic;
     q: OUT std_logic);
BEGIN
  PROCESS(clk,d)
    VARIABLE tiempo_d_cambio: time := 0 ns;
    VARIABLE clk_ultimo, d_ultimo: std_logic := 'X';
  BEGIN
    IF d/=d_ultimo THEN
      tiempo_d_cambio:=now;
      d_ultimo:=d;
    END IF;
    IF clk/=clk_ultimo THEN
      IF clk='1' THEN
        ASSERT (now-tiempo_d_cambio>=5 ns)
          REPORT "Error en el tiempo de establecimiento"
          SEVERITY warning;
      END IF;
      clk_ultimo:=clk;
    END IF;
  END PROCESS;
END ff;

ARCHITECTURE ejemplo OF ff IS
SIGNAL daux: std_logic;
BEGIN
  PROCESS(clk)
  BEGIN
    IF clk='1' THEN
      q<=daux AFTER 10 ns;  -- Retraso respecto del reloj
    END IF;
  END PROCESS;
  daux<=d AFTER 5 ns;       -- Tiempo de establecimiento (set-up)
END ejemplo;
