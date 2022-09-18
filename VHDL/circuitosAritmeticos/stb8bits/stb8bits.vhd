LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY stb8bits IS
	PORT ( An, Bn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			Cin : IN STD_LOGIC;
			Cout : OUT STD_LOGIC;
			Sn : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
	END stb8bits;

ARCHITECTURE Behavior OF stb8bits IS

	-- Insatanciamos el objeto sumador total binario de 1 bit
	COMPONENT STB
		PORT ( AN, BN, CNI : IN STD_LOGIC;
				CNO, SN : OUT STD_LOGIC
				);
	END COMPONENT;
	
	-- Creo las señales de conexion entre los Cout y los Cin
	SIGNAL tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7 : STD_LOGIC;

	BEGIN	
		--Mapeamos los puertos del STB de 1 bit con los puertos y señales del STB de 8 bits
		stb_0 : STB PORT MAP(
				AN => An(0),
				BN => Bn(0),
				SN => Sn(0),
				CNI => Cin,
				CNO => tmp1
		);
		stb_1 : STB PORT MAP(
				AN => An(1),
				BN => Bn(1),
				SN => Sn(1),
				CNI => tmp1,
				CNO => tmp2
		);
      stb_2 : STB PORT MAP(
				AN => An(2),
				BN => Bn(2),
				SN => Sn(2),
				CNI => tmp2,
				CNO => tmp3
		);
      stb_3 : STB PORT MAP(
				AN => An(3),
				BN => Bn(3),
				SN => Sn(3),
				CNI => tmp3,
				CNO => tmp4
		);
      stb_4 : STB PORT MAP(
				AN => An(4),
				BN => Bn(4),
				SN => Sn(4),
				CNI => tmp4,
				CNO => tmp5
		);
      stb_5 : STB PORT MAP(
				AN => An(5),
				BN => Bn(5),
				SN => Sn(5),
				CNI => tmp5,
				CNO => tmp6
		);
      stb_6 : STB PORT MAP(
				AN => An(6),
				BN => Bn(6),
				SN => Sn(6),
				CNI => tmp6,
				CNO => tmp7
		);
      stb_7 : STB PORT MAP(
				AN => An(7),
				BN => Bn(7),
				SN => Sn(7),
				CNI => tmp7,
				CNO => Cout
		);
	END Behavior;
