LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY pingball IS
PORT (p_uno,p_dos,falta,nueva,pierde,clk : IN std_logic;
      marcador: OUT integer RANGE 0 TO 4095;   -- 12 bits
      bloqueo,fin: OUT std_logic);
END pingball;

ARCHITECTURE sincrono OF pingball IS
  TYPE estado IS (insertar,inicia,juega,suma_cinco,suma_diez,trampa,resta);
  SIGNAL marcaux: integer RANGE 0 TO 4095 :=0; -- Auxiliar para leer la salida
  SIGNAL cien: integer RANGE 0 TO 127 :=0;     -- Servira para las bolas extras
  SIGNAL bolas: integer RANGE 0 TO 31 :=0;     -- Almacena el numero de bolas
  SIGNAL d_p_uno,d_p_dos,d_pierde: std_logic;  -- Auxiliares para esas entradas
  SIGNAL presente: estado:=insertar;
BEGIN
  maquina:
  PROCESS(clk)
  BEGIN
    IF clk='1' THEN
      CASE presente IS
      WHEN insertar=>
        IF nueva='1' THEN presente<=inicia;
        END IF;
        fin<='1';
        bloqueo<='1';
      WHEN inicia=>
        presente<=juega;
        fin<='0';
        marcaux<=0;
        cien<=0;
        bloqueo<='0';
        bolas<=5;
      WHEN juega=>
        IF d_pierde='1' THEN presente<=resta; END IF;
        IF falta='1' THEN presente<=trampa; END IF;
        IF bolas=0 THEN presente<=insertar; END IF;
        IF d_p_uno='1' THEN presente<=suma_cinco; END IF;
        IF d_p_dos='1' THEN presente<=suma_diez; END IF;
        IF cien>=100 THEN
          cien<=0;
          bolas<=bolas+1;
        END IF;
        IF bolas=0 THEN presente<=insertar; END IF;
        bloqueo<='0';
      WHEN suma_cinco=>
        presente<=juega;
        marcaux<=marcaux+5;
        cien<=cien+5;
      WHEN suma_diez=>
        presente<=juega;
        marcaux<=marcaux+10;
        cien<=cien+10;
      WHEN resta=>
        bolas<=bolas-1;
        presente<=juega;
      WHEN trampa=>
        IF d_pierde='1' THEN presente<=resta; END IF;
        bloqueo<='1';
      END CASE;
    END IF;
  END PROCESS maquina;

-- Como estos pulsos de entrada son mucho mas largos que el periodo del reloj
-- se crean estas senyales que son lo mismo pero duran un 'unico pulso.
  PROCESS(pierde,presente)
  BEGIN
    IF presente=resta OR presente=inicia THEN d_pierde<='0';
    ELSIF pierde='1' AND pierde'EVENT THEN d_pierde<='1';
    END IF;
  END PROCESS;

  PROCESS(p_uno,presente)
  BEGIN
    IF presente=suma_cinco OR presente=inicia THEN d_p_uno<='0';
    ELSIF p_uno='1' AND p_uno'EVENT THEN d_p_uno<='1';
    END IF;
  END PROCESS;

  PROCESS(p_dos,presente)
  BEGIN
    IF presente=suma_diez OR presente=inicia THEN d_p_dos<='0';
    ELSIF p_dos='1' AND p_dos'EVENT THEN d_p_dos<='1';
    END IF;
  END PROCESS;

-- Finalmente se pone el marcador igual a su auxiliar.
  marcador<=marcaux;

END sincrono;
