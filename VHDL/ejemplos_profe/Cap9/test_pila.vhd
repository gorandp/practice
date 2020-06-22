ENTITY test2_pila IS
END test2_pila;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE STD.TEXTIO.ALL;
USE WORK.paquete_pila.all;

USE work.paquete_pila.ALL;
ARCHITECTURE test OF test2_pila IS
 SIGNAL apilar, desapilar, reset : BIT;
 SIGNAL entrada, salida : INTEGER RANGE 0 to 255;
 BEGIN
  pila1 : pila PORT MAP(apilar=>apilar, desapilar=>desapilar,
		  reset=>reset, entrada=>entrada, salida=>salida);

PROCESS
  TYPE fichero_entero IS FILE OF INTEGER;
  FILE f1: fichero_entero OPEN READ_MODE IS "C:/Jboluda/";
  VARIABLE errores: BOOLEAN:= FALSE;
  VARIABLE linea1, linea2 : LINE;
  VARIABLE v_apilar, v_desapilar, v_reset : BIT;
  VARIABLE v_entrada, v_salida : INTEGER;
  FILE f_entrada : TEXT OPEN READ_MODE IS "C:/Jboluda/Vhdl/Ejemplos_libro/in_pila";
  FILE f_salida : TEXT OPEN WRITE_MODE IS "C:/Jboluda/Vhdl/Ejemplos_libro/out_pila";
 BEGIN
 FOR i IN 0 TO 11 LOOP
   READLINE(f_entrada, linea1);
   READ(linea1, v_apilar); READ(linea1, v_desapilar); READ(linea1, v_reset);
   READ(linea1, v_entrada); READ(linea1, v_salida);
   apilar<=v_apilar; desapilar<=v_desapilar; reset<=v_reset;
   entrada<=v_entrada; 
   WAIT FOR 20 ns;
   WRITE(linea2, v_salida); WRITE(linea2, salida); 
   WRITELINE(f_salida, linea2);
 END LOOP;
 WAIT;
END PROCESS;
END;
	   