-- Los comentarios empiezan con dos guiones
ENTITY mux IS
PORT ( a:      IN bit;
       b:      IN bit;
       selec:  IN bit;
       salida: OUT bit);
END mux;
ARCHITECTURE comportamental OF mux IS
BEGIN   PROCESS(a,b,selec)   BEGIN
      IF (selec='0') THEN
         salida<=a;
      ELSE
         salida<=b;
      END IF;
   END PROCESS;
END comportamental;

ARCHITECTURE flujo1 OF mux IS
SIGNAL nosel,ax,bx: bit;
BEGIN  nosel<=NOT selec;
  ax<=a AND nosel;
  bx<=b AND selec;
  salida<=ax OR bx;
END flujo1;

ARCHITECTURE flujo2 OF mux IS
BEGIN
  salida<=a WHEN selec='0' ELSE
          b;
END flujo2;

ARCHITECTURE estructura OF mux IS
SIGNAL ax,bx,nosel: bit;
BEGIN
  u0: ENTITY inv PORT MAP(e=>selec,y=>nosel);
  u1: ENTITY and2 PORT MAP(e1=>a,e2=>nosel,y=>ax);
  u2: ENTITY and2 PORT MAP(b,selec,bx);
  u3: ENTITY or2  PORT MAP(e1=>ax,e2=>bx,y=>salida);
END estructura;
