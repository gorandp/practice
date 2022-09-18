LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bin2bcd_stb8bits IS
	PORT ( AN, BN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			CIN : IN STD_LOGIC;
			ONES : out  STD_LOGIC_VECTOR (3 downto 0);
			TENS : out  STD_LOGIC_VECTOR (3 downto 0);
			HUNDREDS : out  STD_LOGIC_VECTOR (3 downto 0)
			);
	END bin2bcd_stb8bits;

ARCHITECTURE Behavior OF bin2bcd_stb8bits IS

	-- instanciado del objeto sumador total binario de 8 bits
	COMPONENT stb_8bits_generate
		PORT (	An, Bn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				Cin : IN STD_LOGIC;
				Cout : OUT STD_LOGIC;
				Sn : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
				OVF : OUT STD_LOGIC
			);
	END COMPONENT;

	-- intanciado del objeto conversor de binario a bcd
	COMPONENT bin2bcd_12bit is
		Port (	binIN : in  STD_LOGIC_VECTOR (11 downto 0);
				error_indicator : in std_logic;
				ones : out  STD_LOGIC_VECTOR (3 downto 0);
				tens : out  STD_LOGIC_VECTOR (3 downto 0);
				hundreds : out  STD_LOGIC_VECTOR (3 downto 0);
				thousands : out  STD_LOGIC_VECTOR (3 downto 0)
				);
	end COMPONENT;

	-- bit para detectar el overflow
	SIGNAL overflow : STD_LOGIC;

	-- señal para tirar la salida de "miles" del conversor bin2bcd
	SIGNAL trash : STD_LOGIC_VECTOR (3 DOWNTO 0);

	-- señal para conexión entre stb y el bin2bcd
	-- la hago de 9 bits para incluir el acarreo de salida
	SIGNAL binSignal : STD_LOGIC_VECTOR (8 downto 0);
	SIGNAL extraBits : STD_LOGIC_VECTOR (2 downto 0) := "000";

	BEGIN
		stb8 : stb_8bits_generate PORT MAP(
			An => AN,
			Bn => BN,
			Cin => CIN,
			Cout => binSignal(8), -- 9no bit
			Sn => binSignal(7 downto 0),
			OVF => overflow
		);

		bin2bcd : bin2bcd_12bit PORT MAP(
			binIN => extraBits & binSignal,
			error_indicator => overflow,
			ones => ONES,
			tens => TENS,
			hundreds => HUNDREDS,
			thousands => trash
		);

END Behavior;