-- Puerta OR complicada
ENTITY ornousar IS
PORT (a,b: IN bit; s: OUT bit);
END ornousar;

ARCHITECTURE una OF ornousar IS
BEGIN
 PROCESS
 BEGIN
   s<='0';
   WAIT UNTIL (a='1' OR b='1');
   s<='1';
   WAIT UNTIL (a='0' AND b='0');
 END PROCESS;
END una;