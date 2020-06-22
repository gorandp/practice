ENTITY conmutador IS
PORT (boton: IN bit; motor: OUT bit);
END conmutador;

ARCHITECTURE moore OF conmutador IS
  TYPE estado IS (apagado1,apagado2,encendido1,encendido2);
  SIGNAL presente: estado:=apagado1;
BEGIN
  PROCESS(boton,presente)
  BEGIN
     CASE presente IS
       WHEN apagado1 =>
         motor<='0';
         IF boton='1' THEN presente<=encendido2;
         END IF;
       WHEN encendido2 =>
         motor<='1';
         IF boton='0' THEN presente<=encendido1;
         END IF;
       WHEN encendido1 =>
         motor<='1';
         IF boton='1' THEN presente<=apagado2;
         END IF;
       WHEN apagado2 =>
         motor<='0';
         IF boton='0' THEN presente<=apagado1;
         END IF;
     END CASE;
  END PROCESS;
END moore;

ARCHITECTURE pseudomaquina OF conmutador IS
  TYPE estado IS (apagado,encendido);
  SIGNAL presente: estado:=apagado;
BEGIN
  PROCESS(boton)
  BEGIN
     CASE presente IS
       WHEN apagado =>
         motor<='0';
         IF boton='1' THEN
             presente<=encendido;
             motor<='1';  -- Esto es salida futura, por tanto, opuesta.
        END IF;
       WHEN encendido =>
         motor<='1';
         IF boton='1' THEN
             presente<=apagado;
             motor<='0';  -- Lo mismo, salida futura.
      END IF;
     END CASE;
  END PROCESS;
END pseudomaquina;

ARCHITECTURE para_sintesis OF conmutador IS
  TYPE estado IS (apagado,encendido);
  SIGNAL presente: estado:=apagado;
BEGIN
  PROCESS(boton)
  BEGIN
     IF boton='1'    -- o boton='1' AND boton'event
       CASE presente IS
       WHEN apagado =>
         motor<='0';
         presente<=encendido;
        END IF;
       WHEN encendido =>
         motor<='1';
         presente<=apagado;
       END CASE;
     END IF;
  END PROCESS;
END para_sintesis;

ARCHITECTURE para_sintesis2 OF conmutador IS
  TYPE estado IS (apagado,encendido);
  SIGNAL presente: estado:=apagado;
BEGIN

 maquina:
 PROCESS(boton)
 BEGIN
   IF boton='1' THEN 
     CASE presente IS
     WHEN apagado=>
       presente<=encendido;
     WHEN encendido=>
       presente<=apagado;
     END CASE;
   END IF;
 END PROCESS maquina;

 salida:
 PROCESS(presente)
 BEGIN
   CASE presente IS
   WHEN apagado=>
     motor<='0';
   WHEN encendido=>
     motor<='1';
   END CASE;
 END PROCESS salida;
END para_sintesis2;
