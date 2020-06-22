ENTITY comp IS
  PORT(a,b: IN bit_vector(10 DOWNTO 0);
       amayb,aeqb,amenb: OUT bit);
END comp;

ARCHITECTURE flujo OF comp IS
BEGIN  amayb<='1' WHEN a>b ELSE '0';
  aeqb <='1' WHEN a=b ELSE '0';
  amenb<='1' WHEN a<b ELSE '0';
END flujo;
