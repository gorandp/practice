LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY procesador IS
PORT(clk,rst: IN std_logic;
     r_w: OUT std_logic;
     dir: OUT std_logic_vector(7 DOWNTO 0);
     dat: INOUT std_logic_vector(7 DOWNTO 0));
END procesador;

ARCHITECTURE descripcion OF procesador IS
  TYPE estado IS (inicial,busqueda,ejec,ldxxa,ldaxx,anda,adda,suba);
  SIGNAL a,pc,carga_a,carga_pc: std_logic_vector(7 DOWNTO 0);
  SIGNAL rdat_in,dat_in,dat_out: std_logic_vector(7 DOWNTO 0);
  SIGNAL rwaux: std_logic;
  SIGNAL presente: estado:=inicial;

  FUNCTION "+"(d1,d2: std_logic_vector(7 DOWNTO 0)) RETURN
    std_logic_vector IS
  VARIABLE sal: std_logic_vector(7 DOWNTO 0);
  VARIABLE carry: std_logic:='0';
  VARIABLE ind: INTEGER;
  BEGIN
     FOR ind IN 0 TO 7 LOOP
         sal(ind):=d1(ind) XOR d2(ind) XOR carry;
         carry:=(d1(ind) AND d2(ind)) OR (d1(ind) AND carry) OR (d2(ind) AND carry);
     END LOOP; 
     RETURN sal;
  END "+";

  FUNCTION "-"(d1,d2: std_logic_vector(7 DOWNTO 0)) RETURN
    std_logic_vector IS
  BEGIN
     RETURN d1+((NOT d2)+"00000001");
  END "-";
  
BEGIN

fsm:
PROCESS(clk,rst)
BEGIN
 IF rst='1' THEN
    presente<=inicial;
 ELSIF clk='1' AND clk'event THEN
  CASE presente IS
  WHEN inicial =>
     presente<=busqueda;
  WHEN busqueda=>
     IF dat_in(2 DOWNTO 0)="111" THEN presente<=busqueda;
     ELSE presente<=ejec;
     END IF;
  WHEN ejec =>
     CASE rdat_in(2 DOWNTO 0) IS
     WHEN "000" =>
        presente<=ldaxx;
     WHEN "001" =>
        presente<=ldxxa;
     WHEN "010" =>
        presente<=anda;
     WHEN "011" =>
        presente<=adda;
     WHEN "100" =>
        presente<=suba;
     WHEN OTHERS =>      -- jz,jmp
        presente<=busqueda;
     END CASE;
  WHEN OTHERS=>
     presente<=busqueda;
  END CASE;
 END IF;
END PROCESS fsm;

salida:
PROCESS(presente,pc,a,rdat_in,dat_in)
BEGIN
  CASE presente IS
  WHEN inicial =>
    carga_pc<="00000000";     -- PC a 0
    carga_a<="00000000";      -- Acumulador a 0
    dir<=pc;                  -- Dirección a 0;
    rwaux<='1';               -- Lectura
  WHEN busqueda=>
    carga_pc<=pc+"00000001";  -- Incrementa PC
    carga_a<=a;               -- Deja A como estaba 
    dir<=pc;
    rwaux<='1';
  WHEN ejec =>
    CASE rdat_in(2 DOWNTO 0) IS
    WHEN "101" =>  -- jz
       dir<=pc;
       IF a="00000000" THEN
         carga_pc<=dat_in;   -- Salta si A=0
       END IF;
       rwaux<='1';
       carga_a<=a;
    WHEN "110" =>  --jmp
       dir<=pc;
       carga_pc<=dat_in;     -- Salta siempre
       rwaux<='1';
       carga_a<=a;
    WHEN OTHERS =>   -- Por defecto para el resto:
       rwaux<='1';   -- Leer
       dir<=pc;      -- Dirección del operando    
       carga_pc<=pc;
       carga_a<=a;
    END CASE;
  WHEN ldaxx =>
    rwaux<='1';
    carga_a<=dat_in;
    carga_pc<=pc+"00000001";
    dir<=rdat_in;
  WHEN ldxxa =>
    rwaux<='0';   -- Único que escribe
    carga_a<=a;
    carga_pc<=pc+"00000001";
    dir<=rdat_in;
  WHEN anda =>
    rwaux<='1';
    carga_a<=a AND dat_in;
    carga_pc<=pc+"00000001";
    dir<=rdat_in;
  WHEN adda =>
    rwaux<='1';
    carga_a<=a+dat_in;
    carga_pc<=pc+"00000001";
    dir<=rdat_in;
  WHEN suba =>
    rwaux<='1';
    carga_a<=a-dat_in;
    carga_pc<=pc+"00000001";
    dir<=rdat_in;
  END CASE;
END PROCESS salida;

registro_de_entrada:
PROCESS(clk,rst)
BEGIN
  IF rst='1' THEN rdat_in<="00000000";
  ELSIF clk='1' AND clk'event THEN rdat_in<=dat_in;
  END IF;
END PROCESS registro_de_entrada;

regs_con_carga:
PROCESS(clk,rst)
BEGIN
  IF rst='1' THEN
    a <="00000000";
    pc<="00000000";
  ELSIF clk='1' AND clk'event THEN
    a <=carga_a;
    pc<=carga_pc;
  END IF;
END PROCESS regs_con_carga;

r_w<=rwaux;   -- Para leer la salida.

-- Triestado de salida:
dat_in<=dat;
dat_out<=a;
dat<=dat_out WHEN rwaux='0' ELSE "ZZZZZZZZ";

END descripcion;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY test IS
END test;

ARCHITECTURE estimulos OF test IS
 SIGNAL clk: std_logic:='1';
 SIGNAL rst: std_logic:='1';
 SIGNAL r_w: std_logic;
 SIGNAL dir: std_logic_vector(7 DOWNTO 0);
COMPONENT procesador
PORT(clk,rst: IN std_logic;
     r_w: OUT std_logic;
     dir: OUT std_logic_vector(7 DOWNTO 0);
     dat: INOUT std_logic_vector(7 DOWNTO 0));
END COMPONENT;
 SIGNAL dat: std_logic_vector(7 DOWNTO 0);

 FOR proc: procesador USE ENTITY work.procesador;
BEGIN
 proc: procesador PORT MAP(clk,rst,r_w,dir,dat);
 clk<=NOT clk AFTER 50 ns;
 rst<='0' AFTER 70 ns;
 dat<="00000000",
      "00010100" AFTER 210 ns, 
      "00000100" AFTER 310 ns,
      "00000001" AFTER 410 ns,
      "00010101" AFTER 510 ns,
      "ZZZZZZZZ" AFTER 610 ns,
      "00000110" AFTER 710 ns,
      "00000010" AFTER 810 ns,
      "00000001" AFTER 910 ns;
END estimulos;

