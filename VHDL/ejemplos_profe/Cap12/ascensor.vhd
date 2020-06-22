ENTITY ascensor IS
PORT(boton: IN bit_vector(0 TO 3);
     piso:  IN bit_vector(1 DOWNTO 0);
     clk,reset,celula: IN bit;
     motor:  OUT bit_vector(0 TO 1);
     puerta: OUT bit);
END ascensor;

ARCHITECTURE mover OF ascensor IS
   TYPE estado IS (inicial,cerrar,voy);
   SIGNAL presente: estado:=inicial;
   SIGNAL bot: bit_vector(1 DOWNTO 0); -- Almacena el botón pulsado

FUNCTION codifica(pulso: bit_vector(0 TO 3)) RETURN bit_vector IS
BEGIN
   CASE pulso IS
     WHEN "0001"=>RETURN "00";
     WHEN "0010"=>RETURN "01";
     WHEN "0100"=>RETURN "10";
     WHEN "1000"=>RETURN "11";
     WHEN OTHERS=>RETURN "00";
   END CASE;
END codifica;

BEGIN

fsm:
PROCESS(reset,clk)
BEGIN
   IF reset='1' THEN presente<=inicial;
   ELSIF clk='1' AND clk'event THEN
     CASE presente IS
       WHEN inicial=>
          IF boton/="0000" AND bot/=piso THEN presente<=cerrar;
          END IF;
       WHEN cerrar=>
          IF celula='0' THEN presente<=voy;  -- Sin obstáculos
          END IF;
       WHEN voy=>
          IF bot=piso THEN presente<=inicial;
          END IF;
     END CASE;
   END IF;
END PROCESS fsm;

salida:
PROCESS(presente,boton)
BEGIN
   CASE presente IS
     WHEN inicial=>
        motor<="00";           -- Parado
        puerta<='1';           -- Abierta
        bot<=codifica(boton);  -- Captura el botón
     WHEN cerrar=>
        motor<="00";
        puerta<='1';
     WHEN voy=>
        puerta<='0';           -- Cerrada
        IF bot>piso THEN 
             motor<="10";      -- Subir
        ELSE motor<="01";      -- Bajar
        END IF;
   END CASE;
END PROCESS salida;

END mover;
