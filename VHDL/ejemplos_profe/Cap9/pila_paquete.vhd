LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

PACKAGE paquete_pila IS
 COMPONENT pila PORT(apilar, desapilar, reset: IN BIT;
		     entrada : IN INTEGER RANGE 0 to 255;
		     salida  : OUT INTEGER RANGE 0 to 255);
 END COMPONENT;
END paquete_pila;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY pila IS PORT(
	apilar, desapilar, reset : IN BIT;
	entrada : IN INTEGER RANGE 0 to 255;
	salida	 : OUT INTEGER RANGE 0 to 255);
END pila;

ARCHITECTURE comportamiento OF pila IS
BEGIN
  PROCESS (apilar, desapilar, reset)
   TYPE tipo_elemento;
   TYPE tipo_puntero IS ACCESS tipo_elemento;
   TYPE tipo_elemento IS RECORD
	  siguiente : tipo_puntero;
	  numero : INTEGER RANGE 0 to 255;
	  END RECORD;
 VARIABLE n_elementos : INTEGER :=0;
 VARIABLE top : tipo_puntero := NULL;
 VARIABLE puntero : tipo_puntero ;
 VARIABLE elemento : tipo_elemento;

  BEGIN
    IF reset='1' THEN salida<=0;
      ELSIF apilar='1' AND apilar'EVENT THEN
	  n_elementos:=n_elementos+1;
	  puntero:=NEW tipo_elemento;
	  puntero.numero:=entrada;
	  puntero.siguiente:=top;
	  top:=puntero;
      ELSIF desapilar='1' AND desapilar'EVENT THEN
	 IF n_elementos /= 0
	    THEN n_elementos:=n_elementos-1;
		   salida<=top.numero;
		   top:=top.siguiente;
	    ELSE ASSERT FALSE REPORT "La pila está vacia"
		   SEVERITY WARNING;
	 END IF;
    END IF;
  END PROCESS;
END;
