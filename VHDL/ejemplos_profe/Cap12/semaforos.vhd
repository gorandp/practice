LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY semaforo IS
PORT (sensor,reset,clk: IN std_logic;
      semcamin,semcarr: OUT std_logic_vector(0 TO 2));
END semaforo;

ARCHITECTURE descripcion OF semaforo IS
  TYPE estado IS
     (inicial,carramarillo,caminverde,caminamarillo,espera);
  CONSTANT verde:    std_logic_vector(0 TO 2):="001";
  CONSTANT amarillo: std_logic_vector(0 TO 2):="010";
  CONSTANT rojo:     std_logic_vector(0 TO 2):="100";
  SIGNAL presente: estado:=inicial;
  SIGNAL rescont: boolean:=false;      -- Pone a cero la cuenta
  SIGNAL fin_largo,fin_corto: boolean; -- Indica fin de  cuenta
  SIGNAL cuenta: integer RANGE 0 TO 63;
BEGIN

-- Lo primero es definir la máquina de estados:
maquina:
PROCESS(clk,reset)
BEGIN
  IF reset='1' THEN
    presente<=inicial;
  ELSIF clk='1' AND clk'event THEN
     CASE presente IS
       WHEN inicial=>
          IF sensor='1' THEN
             presente<=carramarillo;
          END IF;
       WHEN carramarillo=>
             presente<=caminverde;
       WHEN caminverde=>
          IF fin_corto THEN
             presente<=caminamarillo;
          END IF;
       WHEN caminamarillo=>
             presente<=espera;
       WHEN espera=>
          IF fin_largo THEN
             presente<=inicial;
          END IF;
     END CASE;
  END IF;
END PROCESS maquina;

salida:
PROCESS(presente)  -- No depende de las entradas
BEGIN
     CASE presente IS
       WHEN inicial=>
          semcarr<=verde;
          semcamin<=rojo;
          rescont<=true;
       WHEN carramarillo=>
          semcarr<=amarillo;
          semcamin<=rojo;
          rescont<=true;
       WHEN caminverde=>
          semcarr<=rojo;
          semcamin<=verde;
          rescont<=false;
       WHEN caminamarillo=>
          semcarr<=rojo;
          semcamin<=amarillo;
          rescont<=true;
       WHEN espera=>
          semcarr<=verde;
          semcamin<=rojo;
          rescont<=false;
     END CASE;
END PROCESS salida;

-- El siguiente proceso define el contador:
contador:
PROCESS(clk)
BEGIN
   IF clk='1' THEN
     IF rescont THEN cuenta<=0;
     ELSE cuenta<=cuenta+1;
     END IF;
   END IF;
END PROCESS contador;

-- Queda la detección de los tiempos largos y cortos:
fin_largo<=true WHEN cuenta=29 ELSE false;
fin_corto<=true WHEN cuenta=9  ELSE false;

END descripcion;
