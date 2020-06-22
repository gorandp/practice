LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE std.textio.all;

PACKAGE mi_io IS
  PROCEDURE R_std_logic(l: INOUT LINE; valor: OUT STD_LOGIC);
  PROCEDURE R_std_logic_vector(l: INOUT LINE; valor: OUT STD_LOGIC_VECTOR);
  TYPE caracteres_std_logic IS ARRAY (CHARACTER) OF STD_LOGIC;
  CONSTANT a_stdlogic : caracteres_std_logic:=
	('U'=>'U', 'X'=>'X', '0'=>'0', '1'=>'1', 'Z'=>'Z', 'W'=>'W',
	 'L'=>'L', 'H'=>'H', '-'=>'-', others=>'X');
END mi_io;

PACKAGE BODY mi_io IS
  PROCEDURE R_std_logic (l: INOUT LINE; valor: OUT STD_LOGIC) IS
  VARIABLE caracter: CHARACTER;
  VARIABLE caracter_ok: BOOLEAN;
  BEGIN
	READ(l, caracter, caracter_ok);
	IF caracter_ok THEN valor:=a_stdlogic(caracter); END IF;
  END R_std_logic;

  PROCEDURE R_std_logic_vector (l: INOUT LINE; valor: OUT STD_LOGIC_VECTOR) IS
  VARIABLE caracter: STRING(valor'RANGE);
  VARIABLE caracter_ok: BOOLEAN;
  BEGIN
	READ(l, caracter, caracter_ok);
	IF caracter_ok THEN 
		FOR i IN caracter'RANGE LOOP
			valor(i):=a_stdlogic(caracter(i));
		END LOOP;
	END IF;
  END R_std_logic_vector;
END mi_io;
