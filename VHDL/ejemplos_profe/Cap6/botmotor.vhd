ENTITY conmutador IS
PORT(boton: IN bit; motor: OUT bit);
END conmutador;

ARCHITECTURE serie OF conmutador IS
SIGNAL motoraux: bit:='0';
BEGIN
  PROCESS(boton)
  BEGIN
    IF boton='1' THEN motoraux<=NOT motoraux; END IF;
  END PROCESS;
  motor<=motoraux;
END serie;

ARCHITECTURE concurrente OF conmutador IS
SIGNAL motoraux: bit:='0';
BEGIN
  motoraux<=NOT motoraux WHEN boton='1' AND boton'event
            ELSE motoraux;
  motor<=motoraux;
END concurrente;
