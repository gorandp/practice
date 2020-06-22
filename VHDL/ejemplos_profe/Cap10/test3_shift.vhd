--Metodologia procedural

ENTITY test3_shift is 
END test3_shift;

LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE WORK.registros.desplazamiento;

ARCHITECTURE test OF test3_shift IS
   SIGNAL clk, rst, ed, ei : STD_LOGIC;
   SIGNAL m : STD_LOGIC_VECTOR(1 DOWNTO 0);
   SIGNAL e : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL s : STD_LOGIC_VECTOR(3 DOWNTO 0);
   CONSTANT valor : STD_LOGIC_VECTOR(3 DOWNTO 0):= "1011";
   BEGIN
    --Se instancia un componente para testearlo
    registro1 : desplazamiento PORT MAP(clk=>clk, rst=>rst, ed=>ed,
					ei=>ei,	m=>m, e=>e, s=>s);

    --Se genera el test y se verifica el resultado
   PROCESS
   VARIABLE reg_aux : STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";

   BEGIN
	--Inicialmente se hace un reset
	rst<='1'; WAIT FOR 20 ns;
	ASSERT (s=reg_aux) REPORT "Reset incorrecto" SEVERITY ERROR;
	WAIT FOR 20 ns;

	--Se desplaza un '1' hacia la izquierda
	FOR i IN 0 TO 3 LOOP
		clk<='0'; rst<='0'; ed<='1'; m<="10"; 
		WAIT FOR 10 ns;
		clk<='1'; rst<='0'; ed<='1'; m<="10"; reg_aux:=reg_aux(2 DOWNTO 0) & '1';
		WAIT FOR 10 ns;
		ASSERT (s=reg_aux) REPORT "Desplazamiento a la izquierda incorrecto"
		SEVERITY ERROR;
	END LOOP;

	--Se desplaza un '0' hacia la derecha
	FOR i IN 0 TO 3 LOOP
		clk<='0'; rst<='0'; ei<='0'; m<="01"; 
		WAIT FOR 10 ns;
		clk<='1'; rst<='0'; ei<='0'; m<="01"; reg_aux:='0' & reg_aux(3 DOWNTO 1);
		WAIT FOR 10 ns;
		ASSERT (s=reg_aux) REPORT "Desplazamiento a la izquierda incorrecto"
		SEVERITY ERROR;
	END LOOP;

	--Se prueba la carga en paralelo
	clk<='0'; rst<='0'; e<=valor; m<="11"; 
	WAIT FOR 10 ns;
	clk<='1'; rst<='0'; e<=valor; m<="11"; 
	WAIT FOR 10 ns;
	ASSERT (s=valor) REPORT "Carga incorrecta" SEVERITY ERROR;

	ASSERT FALSE REPORT "Test finalizado" SEVERITY NOTE;
   END PROCESS;
END;