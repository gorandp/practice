-- Lo primero de todo es la definición de las entidades y sus
-- arquitecturas. Esto se podría poner en un fichero aparte o
-- definirlo dentro de una biblioteca:

ENTITY inv IS PORT  (e: IN bit; y: OUT bit); END inv;
ENTITY and2 IS PORT  (e1,e2: IN bit; y: OUT bit); END and2;
ENTITY or2 IS PORT  (e1,e2: IN bit; y: OUT bit); END or2;

ARCHITECTURE rtl OF inv IS BEGIN  y<=NOT e; END rtl;
ARCHITECTURE rtl OF or2 IS BEGIN  y<=e1 OR e2; END rtl;
ARCHITECTURE rtla OF and2 IS BEGIN  y<=e1 AND e2; END rtla;
ARCHITECTURE rtlb OF and2 IS  -- dos arquitecturas diferentes
BEGIN
   y<='0' WHEN (e1='0' OR e2='0') ELSE '1';
END rtlb;

-- A continuación ya viene la entidad y arquitectura del mux:

ENTITY mux IS
PORT ( a,b,selec:  IN bit;
       salida: OUT bit);
END mux;

ARCHITECTURE estructura OF mux IS
  COMPONENT inv IS PORT(e: IN bit; y: OUT bit);     END COMPONENT;
  COMPONENT y2  IS PORT(e1,e2: IN bit; y: OUT bit); END COMPONENT;
  COMPONENT o2  IS PORT(e1,e2: IN bit; y: OUT bit); END COMPONENT;
  SIGNAL ax,bx,nosel: bit;
BEGIN
  u0: inv PORT MAP(e=>selec,y=>nosel);
  u1: y2  PORT MAP(e1=>a,e2=>nosel,y=>ax);
  u2: y2  PORT MAP(b,selec,bx);
  u3: o2  PORT MAP(e1=>ax,e2=>bx,y=>salida);
END estructura;

-- Por último, la configuración sería:

CONFIGURATION estru OF mux IS
-- poniendo USE work.ALL; aquí, no haría falta poner 'work' cada vez.
  FOR estructura
    FOR ALL:   inv USE ENTITY work.inv;        END FOR;
    FOR u1:     y2 USE ENTITY work.and2(rtla); END FOR;
    FOR OTHERS: y2 USE ENTITY work.and2(rtlb); END FOR;
    FOR ALL:    o2 USE ENTITY work.or2;        END FOR;
  END FOR;
END estru;
