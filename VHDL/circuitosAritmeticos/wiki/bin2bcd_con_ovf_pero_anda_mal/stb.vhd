LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY stb IS
	PORT ( AN, BN, CNI : IN STD_LOGIC;
			CNO, SN : OUT STD_LOGIC
			);
	END stb;

	
ARCHITECTURE Behavior OF stb IS
	BEGIN
		SN <= AN XOR BN XOR CNI;
		CNO <= (AN AND BN) OR (AN AND CNI) OR (CNI AND BN);
		
	END Behavior;