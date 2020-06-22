LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
ENTITY test_shift is
END test_shift;

USE WORK.registros.desplazamiento;
ARCHITECTURE test OF test_shift IS
   SIGNAL clk, rst, ed, ei : STD_LOGIC;
   SIGNAL m : STD_LOGIC_VECTOR(1 DOWNTO 0);
   SIGNAL e : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL s : STD_LOGIC_VECTOR(3 DOWNTO 0);
   TYPE tipo_vtest IS RECORD
	clk, rst, ed, ei : STD_LOGIC;
	m : STD_LOGIC_VECTOR(1 DOWNTO 0);
	e : STD_LOGIC_VECTOR(3 DOWNTO 0);
	s : STD_LOGIC_VECTOR(3 DOWNTO 0);
   END RECORD;
   TYPE lista_vtest IS ARRAY(0 TO 10) OF tipo_vtest;
   CONSTANT varios_v : lista_vtest :=(
	--Reset del registro
	(clk=>'0', rst=>'1', ed=>'-', ei=>'-', m=>"--", e=>"----", s=>"0000"),
	(clk=>'1', rst=>'1', ed=>'-', ei=>'-', m=>"--", e=>"----", s=>"0000"),
	(clk=>'0', rst=>'0', ed=>'-', ei=>'-', m=>"00", e=>"----", s=>"0000"),
	--Se comprueba que no se carga nada en el modo 0
	(clk=>'1', rst=>'0', ed=>'-', ei=>'-', m=>"00", e=>"1011", s=>"0000"),
	(clk=>'0', rst=>'0', ed=>'-', ei=>'-', m=>"00", e=>"1011", s=>"0000"),
	--Se carga el código 1010 en paralelo
	(clk=>'1', rst=>'0', ed=>'-', ei=>'-', m=>"11", e=>"1011", s=>"1011"),
	(clk=>'0', rst=>'0', ed=>'-', ei=>'-', m=>"11", e=>"1011", s=>"1011"),
	--Se desplaza hacia la derecha 0->101
	(clk=>'1', rst=>'0', ed=>'-', ei=>'0', m=>"01", e=>"----", s=>"0101"),
	(clk=>'0', rst=>'0', ed=>'-', ei=>'0', m=>"01", e=>"----", s=>"0101"),
	--Se desplaza hacia la izquierda 101<-1
	(clk=>'1', rst=>'0', ed=>'1', ei=>'-', m=>"10", e=>"----", s=>"1011"),
	(clk=>'0', rst=>'0', ed=>'1', ei=>'-', m=>"10", e=>"----", s=>"1011"));
   BEGIN
    --Se instancia un componente para testearlo
    registro1 : desplazamiento PORT MAP(clk=>clk, rst=>rst, ed=>ed,
					ei=>ei,	m=>m, e=>e, s=>s);
    --Se aplican los vectores de test y se verifica el resultado
   PROCESS
    VARIABLE vector : tipo_vtest;
    VARIABLE errores : BOOLEAN := FALSE;
    BEGIN
	FOR i IN 0 TO 10 LOOP
	 vector:=varios_v(i);
	 clk<=vector.clk; rst<=vector.rst; ed<=vector.ed; ei<=vector.ei;
	 m<=vector.m; e<=vector.e;
	 WAIT FOR 20 ns;
	 IF s /= vector.s THEN 	ASSERT FALSE REPORT "Salida incorrecta. ";
	 			errores:=TRUE;
	 END IF;
	END LOOP;
	ASSERT NOT errores	REPORT "Error en el test. ";
	ASSERT errores		REPORT "Test superado. ";
	WAIT;
   END PROCESS;
END;

	
