LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY lavadora IS
PORT (color,centrifuga,start,jabon_listo,vacio,lleno,clk: IN std_logic;
      jabon,llenar,vaciar,rapido,lento,direccion: OUT std_logic);
END lavadora;

ARCHITECTURE sincrona OF lavadora IS
-- Para simular se han quitado 3 ceros a cada uno de estos:
  CONSTANT diezsec: integer:=1;      -- Estos tiempos han sido
  CONSTANT cincomin: integer:=30;    -- calculados suponiendo una frecuencia
  CONSTANT diezmin: integer:=60;     -- de reloj de 100 Hz.
  CONSTANT veintemin: integer:=120;
  TYPE estados IS (inicial,lavado,vacia1,aclarado,vacia2,centrifugado);
  SIGNAL presente: estados:=inicial;
  SIGNAL coloraux,centriaux,diraux: std_logic:='0';
  SIGNAL tiempo: integer RANGE 0 TO 16#1FFFF# :=0;
  SIGNAL subtiempo: integer RANGE 0 TO 1023 :=0;
BEGIN
  maquina:
  PROCESS(clk)
  BEGIN
    IF clk='1' THEN
      CASE presente IS
      WHEN inicial=>
        IF start='1' THEN presente<=lavado; END IF;
        jabon<='0'; llenar<='0'; vaciar<='1';
        lento<='0'; rapido<='0'; diraux<='0';
        tiempo<=0;
        subtiempo<=0;
      WHEN lavado=>
        vaciar<='0';
        IF jabon_listo='0' THEN jabon<='1';
        ELSE jabon<='0';
        END IF;
        IF lleno='0' THEN
          llenar<='1';
        ELSE
          llenar<='0';
          lento<='1';
          IF subtiempo=diezsec THEN
            diraux<=NOT diraux;
            subtiempo<=0;
          ELSE
            subtiempo<=subtiempo+1;
          END IF;
          tiempo<=tiempo+1;
          IF coloraux='1' AND tiempo=diezmin THEN presente<=vacia1;
          ELSIF tiempo=veintemin THEN presente<=vacia1;
          END IF;
        END IF;
      WHEN vacia1=>
        vaciar<='1';
        lento<='0';
        IF vacio='1' THEN presente<=aclarado;
        END IF;
        subtiempo<=0;
        tiempo<=0;
      WHEN aclarado=>
        vaciar<='0';
        IF lleno='0' THEN
          llenar<='1';
        ELSE
          llenar<='0';
          lento<='1';
          IF subtiempo=diezsec THEN
            diraux<=NOT diraux;
            subtiempo<=0;
          ELSE
            subtiempo<=subtiempo+1;
          END IF;
          tiempo<=tiempo+1;
          IF tiempo=cincomin THEN presente<=vacia2;
          END IF;
        END IF;
      WHEN vacia2=>
        vaciar<='1';
        lento<='0';
        IF vacio='1' THEN
          IF centriaux='1' THEN presente<=centrifugado;
          ELSE presente<=inicial;
          END IF;
        END IF;
        tiempo<=0;
      WHEN centrifugado=>
        rapido<='1';
        tiempo<=tiempo+1;
        IF tiempo=diezmin THEN presente<=inicial; END IF;
      END CASE;
    END IF;
  END PROCESS maquina;
  
  PROCESS(centrifuga)
  BEGIN
    IF centrifuga='1' THEN centriaux<=NOT centriaux; END IF;
  END PROCESS;

  PROCESS(color)
  BEGIN
    IF color='1' THEN coloraux<=NOT coloraux; END IF;
  END PROCESS;

  direccion<=diraux;

END sincrona;

