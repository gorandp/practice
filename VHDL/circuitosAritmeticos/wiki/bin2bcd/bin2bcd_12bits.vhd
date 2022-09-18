library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity bin2bcd_12bit is
    Port ( binIN : in  STD_LOGIC_VECTOR (11 downto 0);
           ones : out  STD_LOGIC_VECTOR (3 downto 0);
           tens : out  STD_LOGIC_VECTOR (3 downto 0);
           hundreds : out  STD_LOGIC_VECTOR (3 downto 0);
           thousands : out  STD_LOGIC_VECTOR (3 downto 0)
          );
end bin2bcd_12bit;

architecture Behavioral of bin2bcd_12bit is

begin

bcd1: process(binIN)

  -- variable temporal
  variable temp : STD_LOGIC_VECTOR (11 downto 0);


  -- Variable para guardar el numero en BCD
  -- organizado de la siguiente manera
  -- thousands = bcd(15 downto 12)
  -- hundreds = bcd(11 downto 8)
  -- tens = bcd(7 downto 4)
  -- units = bcd(3 downto 0)
  variable bcd : UNSIGNED (15 downto 0) := (others => '0');

  -- by
  -- https://en.wikipedia.org/wiki/Double_dabble

  begin
    -- zero the bcd variable
    bcd := (others => '0'); -- se setea/inicializa todos los bits a cero

    -- se lee la entrada en la variable temp
    temp(11 downto 0) := binIN;

    -- repetir 12 veces ya que tenemos 12 bits de entrada
    -- esto podría ser optimizado, ya que los primeros 3 ciclos
    -- no hace falta fijarse si añadir 3 o no, ya que el número no puede
    -- ser nunca mayor a 4
    for i in 0 to 11 loop

      if bcd(3 downto 0) > 4 then 
        bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;

      if bcd(7 downto 4) > 4 then 
        bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;

      if bcd(11 downto 8) > 4 then  
        bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;

      -- los millares no pueden ser nunca mayor a 4 para
      -- un número de 12 bit de entrada, por lo tanto
      -- no necesitamos hacer nada para los 4 bits mayores
      -- de la salida en BCD

      -- se hace shift del registro BCD hacia la izquierda 1 bit
      -- y se agrega el MSB de la señal temp en el LSB de BCD
      bcd := bcd(14 downto 0) & temp(11);

      -- shift temp 1 bit hacia la izquierda
      temp := temp(10 downto 0) & '0';

    end loop;

    -- set salidas entidad
    ones <= STD_LOGIC_VECTOR(bcd(3 downto 0));
    tens <= STD_LOGIC_VECTOR(bcd(7 downto 4));
    hundreds <= STD_LOGIC_VECTOR(bcd(11 downto 8));
    thousands <= STD_LOGIC_VECTOR(bcd(15 downto 12));

  end process bcd1;

end Behavioral;
