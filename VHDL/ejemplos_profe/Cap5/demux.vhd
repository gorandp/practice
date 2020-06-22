ENTITY demux IS
PORT(a: IN bit;
     sel: IN bit_vector(2 DOWNTO 0);
     sal: OUT bit_vector(0 TO 7));
END demux;

ARCHITECTURE flujo OF demux IS
  SIGNAL aux: bit_vector(0 TO 3);
BEGIN  WITH sel SELECT
  aux<="0001" WHEN "00",
       "0010" WHEN "01",
       "0100" WHEN "10",
       "1000" WHEN "11";
  sal<=aux AND a&a&a&a;
END flujo;

ARCHITECTURE otro_flujo OF demux IS
BEGIN
  WITH sel SELECT
  sal<="000"&a WHEN "00",
       "00"&a&"0" WHEN "01",
       "0"&a&"00" WHEN "10",
       a&"000" WHEN "11";
END otro_flujo;
