ENTITY shifter IS
PORT( shftin:  IN  bit_vector(0 TO 3);
      shftout: OUT bit_vector(0 TO 3);
      shftctl: IN  bit_vector(0 TO 1));
END shifter;

ARCHITECTURE flujo1 OF shifter IS
BEGIN
 shftout<=shftin                  WHEN shftctl="00" ELSE
          shftin(1 TO 3)&'0'      WHEN shftctl="01" ELSE
          '0'&shftin(0 TO 2)      WHEN shftctl="10" ELSE
          shftin(3)&shftin(0 TO 2);
END flujo1;

ARCHITECTURE flujo2 OF shifter IS
BEGIN
  WITH shftctl SELECT
   shftout<=shftin                   WHEN "00",
            shftin(1 TO 3)&'0'       WHEN "01",
            '0'&shftin(0 TO 2)       WHEN "10",
            shftin(3)&shftin(0 TO 2) WHEN "11";
END flujo2;
