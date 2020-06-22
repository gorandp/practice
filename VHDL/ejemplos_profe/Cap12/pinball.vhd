LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY pinball IS
PORT (p_uno,p_dos,falta,nueva,pierde,clk,reset : IN std_logic;
      marcador: OUT integer RANGE 0 TO 4095;   -- 12 bits
      bloqueo,fin: OUT std_logic);
END pinball;

ARCHITECTURE sincrono OF pinball IS
  TYPE estado IS
     (insertar,inicia,juega,suma_cinco,suma_diez,trampa,resta,espera);
  SIGNAL marcaux: integer RANGE 0 TO 4095 :=0; -- Leer la salida
  SIGNAL cien: integer RANGE 0 TO 127 :=0;     -- Para bola extra
  SIGNAL bolas: integer RANGE 0 TO 31 :=0;     -- Número de bolas
  SIGNAL presente: estado:=insertar;
BEGIN
  maquina:
  PROCESS(clk,reset)
  BEGIN
    IF reset='1' THEN
      presente<=insertar;
      marcaux<=0;
      fin<='1';
      bloqueo<='1';
      cien<=0;
    ELSIF clk='1' AND clk'event THEN
      CASE presente IS
      WHEN insertar=>
        IF nueva='1' THEN presente<=inicia;
        END IF;
        fin<='1';
        bloqueo<='1';
        cien<=0;
      WHEN inicia=>
        presente<=juega;
        fin<='0';
        marcaux<=0;
        cien<=0;
        bloqueo<='0';
        bolas<=5;
      WHEN juega=>
        IF pierde='1' THEN presente<=resta; END IF;
        IF falta='1' THEN presente<=trampa; END IF;
        IF bolas=0 THEN presente<=insertar; END IF;
        IF p_uno='1' THEN presente<=suma_cinco; END IF;
        IF p_dos='1' THEN presente<=suma_diez; END IF;
        IF cien>=100 THEN
          cien<=0;
          bolas<=bolas+1;
        END IF;
        IF bolas=0 THEN presente<=insertar; END IF;
        bloqueo<='0';
      WHEN suma_cinco=>
        presente<=espera;
        marcaux<=marcaux+5;
        cien<=cien+5;
      WHEN suma_diez=>
        presente<=espera;
        marcaux<=marcaux+10;
        cien<=cien+10;
      WHEN resta=>
        bolas<=bolas-1;
        presente<=espera;
      WHEN espera=>
        IF p_uno='0' AND p_dos='0' AND pierde='0' THEN
          presente<=juega;
        END IF;
      WHEN trampa=>
        IF pierde='1' THEN presente<=resta; END IF;
        bloqueo<='1';
      END CASE;
    END IF;
  END PROCESS maquina;

-- Finalmente se pone el marcador igual a su auxiliar.
  marcador<=marcaux;

END sincrono;
