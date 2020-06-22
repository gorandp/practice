ENTITY test2_shift is 
END test2_shift;

LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE std.textio.all;
USE work.mi_io.all;
USE WORK.registros.desplazamiento;

ARCHITECTURE test OF test2_shift IS
   SIGNAL clk, rst, ed, ei : STD_LOGIC;
   SIGNAL m : STD_LOGIC_VECTOR(1 DOWNTO 0);
   SIGNAL e : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL s : STD_LOGIC_VECTOR(3 DOWNTO 0);

   BEGIN
    --Se instancia un componente para testearlo
    registro1 : desplazamiento PORT MAP(clk=>clk, rst=>rst, ed=>ed,
					ei=>ei,	m=>m, e=>e, s=>s);

    --Se aplican los vectores de test y se verifica el resultado
   PROCESS
   VARIABLE errores : BOOLEAN := FALSE;
   FILE fichero : TEXT OPEN read_mode IS "shift_ve.inp";
   VARIABLE invector : LINE;
   VARIABLE ok : BOOLEAN;
   VARIABLE ch : CHARACTER;
   VARIABLE vclk, vrst, ved, vei : STD_LOGIC;
   VARIABLE vm : STD_LOGIC_VECTOR(1 DOWNTO 0);
   VARIABLE ve, vs : STD_LOGIC_VECTOR(3 DOWNTO 0);
   BEGIN
	WHILE NOT ENDFILE(fichero) LOOP
	  READLINE(fichero,invector); 	--Se lee una linea del fichero
	  READ(invector,ch);		--Se leen los TABs y los valores
	  R_std_logic(invector,vclk);	--de la línea como std_logic
	  READ(invector,ch); R_std_logic(invector,vrst);
	  READ(invector,ch); R_std_logic(invector,ved);
	  READ(invector,ch); R_std_logic(invector,vei);
	  READ(invector,ch); R_std_logic_vector(invector,vm);
	  READ(invector,ch); R_std_logic_vector(invector,ve);
	  READ(invector,ch); R_std_logic_vector(invector,vs);
	  --Se aplica el vector de test
	  clk<=vclk; rst<=vrst; ed<=ved; ei<=vei; m<=vm; e<=ve;
	  WAIT FOR 20 ns;
	  IF vs/=s THEN ASSERT FALSE REPORT "Salida incorrecta" SEVERITY WARNING;
			errores:=TRUE;
	  END IF;
	END LOOP;
	ASSERT NOT errores	REPORT "Error en el test. " SEVERITY ERROR;
	ASSERT errores		REPORT "Test superado. " SEVERITY NOTE;
	WAIT;
   END PROCESS;
END;