LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY lavadora2 IS
PORT (color,centrifuga,start,jabon_listo,vacio,lleno,clk: IN std_logic;
      jabon,llenar,vaciar,rapido,lento,direccion: OUT std_logic);
END lavadora2;

ARCHITECTURE sincrona2 OF lavadora2 IS
-- Para simular se han quitado 3 ceros a cada uno de estos:
  CONSTANT diezsec: integer:=1;      -- Estos tiempos han sido
  CONSTANT cincomin: integer:=30;    -- calculados suponiendo una frecuencia
  CONSTANT diezmin: integer:=60;     -- de reloj de 100 Hz.
  CONSTANT veintemin: integer:=120;
  TYPE estados IS (inicial,lavado,vacia1,aclarado,vacia2,centrifugado);
  SIGNAL presente: estados:=inicial;
  SIGNAL coloraux,centriaux,dirauxd,diraux: std_logic:='0';
  SIGNAL tiempo: integer RANGE 0 TO 16#1FFFF# :=0;
  SIGNAL subtiempo: integer RANGE 0 TO 1023 :=0;
  SIGNAL subtiempores, tiempores: boolean :=TRUE;
BEGIN
  maquina:
  PROCESS(clk)
  BEGIN
    IF clk='1' THEN
      CASE presente IS
      WHEN inicial=>
        IF start='1' THEN presente<=lavado; END IF;
      WHEN lavado=>
          IF coloraux='1' AND tiempo=diezmin THEN presente<=vacia1;
          ELSIF tiempo=veintemin THEN presente<=vacia1;
          END IF;
      WHEN vacia1=>
        IF vacio='1' THEN presente<=aclarado;
        END IF;
      WHEN aclarado=>
          IF tiempo=cincomin THEN presente<=vacia2;
          END IF;
      WHEN vacia2=>
        IF vacio='1' THEN
          IF centriaux='1' THEN presente<=centrifugado;
          ELSE presente<=inicial;
          END IF;
        END IF;
      WHEN centrifugado=>
        IF tiempo=diezmin THEN presente<=inicial; END IF;
      END CASE;
    END IF;
  END PROCESS maquina;

salida:
  PROCESS(presente)
  BEGIN
      CASE presente IS
      WHEN inicial=>
        jabon<='0'; llenar<='0'; vaciar<='1';
        lento<='0'; rapido<='0';  dirauxd<='0';
        tiempores<=TRUE; subtiempores<=TRUE;
      WHEN lavado=>
        vaciar<='0';
        rapido<='0';
        IF jabon_listo='0' THEN jabon<='1';
        ELSE jabon<='0';
        END IF;
        IF lleno='0' THEN
          llenar<='1';
          lento<='0';
          tiempores<=TRUE;
        ELSE
          llenar<='0';
          lento<='1';
          jabon<='0';
          tiempores<=FALSE;
        END IF;
        IF subtiempo=diezsec THEN
          dirauxd<=NOT diraux;
          subtiempores<=TRUE;
        ELSE
          subtiempores<=FALSE;
        END IF;
      WHEN vacia1=>
        jabon<='0';
        vaciar<='1';
        lento<='0';
        rapido<='0';
        subtiempores<=TRUE;
        tiempores<=TRUE;
        llenar<='0';
        dirauxd<='0';
      WHEN aclarado=>
        jabon<='0';
        vaciar<='0';
        rapido<='0';
        IF lleno='0' THEN
          llenar<='1';
          lento<='0';
          tiempores<=TRUE;
        ELSE
          llenar<='0';
          lento<='1';
          tiempores<=FALSE;
        END IF;
        IF subtiempo=diezsec THEN
          dirauxd<=NOT diraux;
          subtiempores<=TRUE;
        ELSE
          subtiempores<=FALSE;
        END IF;
      WHEN vacia2=>
        jabon<='0';
        dirauxd<='0';
        vaciar<='1';
        lento<='0';
        rapido<='0';
        llenar<='0';
        subtiempores<=TRUE;
        tiempores<=TRUE;
      WHEN centrifugado=>
        jabon<='0';
        dirauxd<='0';
        llenar<='0';
        vaciar<='1';
        rapido<='1';
        lento<='0';
        subtiempores<=TRUE;
        tiempores<=FALSE;
      END CASE;
  END PROCESS salida;
  
  contador:
  PROCESS(clk)
  BEGIN
    IF clk='1' THEN
      IF subtiempores THEN
        subtiempo<=0;
      ELSE
        subtiempo<=subtiempo+1;
      END IF;
      IF tiempores THEN
        tiempo<=0;
      ELSE
        tiempo<=tiempo+1;
      END IF;
    END IF;
  END PROCESS contador;
    
  PROCESS(centrifuga)
  BEGIN
    IF centrifuga='1' THEN centriaux<=NOT centriaux; END IF;
  END PROCESS;

  PROCESS(color)
  BEGIN
    IF color='1' THEN coloraux<=NOT coloraux; END IF;
  END PROCESS;

  PROCESS(clk)
  BEGIN
    IF clk='1' THEN diraux<=dirauxd;
    END IF;
  END PROCESS;

  direccion<=diraux;

END sincrona2;

