ENTITY ajugar IS
PORT (
-- Reloj de frecuencia fija 1024 Hz;
        clk: IN bit;
-- Diferentes pulsadores o botones del operador:
        reset,pregunta: IN bit;
-- Contiene la respuesta correcta:
        correcto: IN bit_vector(1 TO 3);
-- Pulsadores de los jugadores A,B,C respectivamente:
        pulsaA, pulsaB, pulsaC: IN bit_vector(1 TO 3);
-- Marcadores de cada jugador A, B y C:
        marcaA, marcaB, marcaC: OUT integer RANGE 0 TO 255;
-- Líneas para indicar quien de todos ganó:
        ganaA, ganaB, ganaC: OUT bit);
END ajugar;

ARCHITECTURE una_solucion OF ajugar IS
 TYPE estado IS (inicial,responde,evalua,tiempo,espera,final);
 SIGNAL cuenta: integer RANGE 0 TO 8191;
 SIGNAL marcauxA,marcauxB,marcauxC: integer RANGE 0 TO 255;
 SIGNAL timeout: boolean;  -- Para indicar paso de 5 segundos.
 SIGNAL pulsaron: boolean; -- Para saber si alguien pulso.
 SIGNAL fin: boolean;      -- Para saber cuando se llega al final.
 SIGNAL rescont: boolean;  -- Pone a cero la cuenta.
 SIGNAL presente: estado;

BEGIN
 marcaA<=marcauxA;   -- Señales auxiliares para poder
 marcaB<=marcauxB;   -- leer la salida
 marcaC<=marcauxC;

 contador:
 PROCESS(clk)
 BEGIN
   IF clk='1' THEN
     IF rescont THEN cuenta<=0; -- Para inicializar la cuenta
     ELSE cuenta<=cuenta+1;
     END IF;
   END IF;
 END PROCESS contador;

 timeout<=true WHEN cuenta=5120 ELSE false; -- pasaron 5 segundos
 pulsaron<=true WHEN (pulsaA/="000" OR pulsaB/="000" OR pulsaC/="000")
      ELSE false;
 fin<=true WHEN (marcauxA>=100 OR marcauxB>=100 OR marcauxC>=100)
      ELSE false;
 ganaA<='1' WHEN marcauxA>=100 ELSE '0';
 ganaB<='1' WHEN marcauxB>=100 ELSE '0';
 ganaC<='1' WHEN marcauxC>=100 ELSE '0';

 maquina:
 PROCESS(reset,clk) -- señales que cambian
 BEGIN                                           -- el estado presente.
   IF reset='1' THEN presente<=inicial;
   ELSIF clk='1' AND clk'event THEN
     CASE presente IS
       WHEN inicial=>
         IF pregunta='1' THEN presente<=responde; END IF;
       WHEN responde=>
         IF pulsaron THEN presente<=evalua;
         ELSIF timeout THEN presente<=tiempo;
         END IF;
       WHEN evalua=>
         presente<=espera;
       WHEN tiempo=>
         presente<=espera;
       WHEN espera=>
         IF fin THEN presente<=final;
         ELSIF pregunta='1' THEN presente<=responde;
         END IF;
       WHEN final=>
         NULL;
     END CASE;
   END IF;
 END PROCESS maquina;

 salida:
 PROCESS(presente)
 BEGIN
   CASE presente IS
     WHEN inicial=>
       rescont<=true;
     WHEN responde=>
       rescont<=false;
     WHEN evalua=>
       rescont<=true;
     WHEN tiempo=>
       rescont<=true;
     WHEN espera=>
       rescont<=true;
     WHEN final=>
       rescont<=true;
   END CASE;
 END PROCESS salida;

 marcadores:
 PROCESS(clk,reset)
 BEGIN
   IF reset='1' THEN
     marcauxA<=0;
     marcauxB<=0;
     marcauxC<=0;
   ELSIF clk='1' AND clk'event THEN
     CASE presente IS
     WHEN evalua=>
       IF pulsaA/="000" THEN
         IF pulsaA=correcto THEN marcauxA<=marcauxA+10;
         ELSIF marcauxA>=5 THEN marcauxA<=marcauxA-5;
         END IF;
       END IF;
       IF pulsaB/="000" THEN
         IF pulsaB=correcto THEN marcauxB<=marcauxB+10;
         ELSIF marcauxB>=5 THEN marcauxB<=marcauxB-5;
         END IF;
       END IF;
       IF pulsaC/="000" THEN
         IF pulsaC=correcto THEN marcauxC<=marcauxC+10;
         ELSIF marcauxC>=5 THEN marcauxC<=marcauxC-5;
         END IF;
       END IF;
     WHEN tiempo=>
       IF marcauxA>=5 AND marcauxA>=marcauxB AND marcauxA>=marcauxC
          THEN marcauxA<=marcauxA-5;
       END IF;
       IF marcauxB>=5 AND marcauxB>=marcauxA AND marcauxB>=marcauxC
          THEN marcauxB<=marcauxB-5;
       END IF;
       IF marcauxC>=5 AND marcauxC>=marcauxB AND marcauxC>=marcauxA
          THEN marcauxC<=marcauxC-5;
       END IF;
     WHEN final=>
       IF marcauxA>=100 THEN
         marcauxB<=0;
         marcauxC<=0;
       END IF;
       IF marcauxB>=100 THEN
         marcauxA<=0;
         marcauxC<=0;
       END IF;
       IF marcauxC>=100 THEN
         marcauxB<=0;
         marcauxA<=0;
       END IF;
     WHEN OTHERS=> NULL;
     END CASE;
   END IF;
 END PROCESS marcadores;

END una_solucion;
