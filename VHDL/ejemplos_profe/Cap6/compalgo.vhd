ENTITY comp IS
  PORT(a,b: IN bit_vector(10 DOWNTO 0);
       amayb,aeqb,amenb: OUT bit);
END comp;

ARCHITECTURE abstracta1 OF comp IS
BEGIN
  PROCESS(a,b)  -- Se ejecuta cuando a o b cambian
  BEGIN
     IF a>b THEN
       amayb<='1';
       aeqb <='0';
       amenb<='0';
     ELSIF a<b THEN
       amayb<='0';
       aeqb <='0';
       amenb<='1';
     ELSE
       amayb<='0';
       aeqb <='1';
       amenb<='0';
     END IF;
  END PROCESS;
END abstracta1;

ARCHITECTURE abstracta2 OF comp IS
BEGIN
  PROCESS(a,b)  -- se ejecuta cuando a o b cambian
  BEGIN
     amayb<='0';
     aeqb <='0';
     amenb<='0';
     IF a>b THEN
       amayb<='1';
     ELSIF a<b THEN
       amenb<='1';
     ELSE
       aeqb <='1';
     END IF;
  END PROCESS;
END abstracta2;
