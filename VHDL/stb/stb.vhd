LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY stb IS
	PORT ( AN, BN, CN : IN STD_LOGIC;
			CN1, SN : OUT STD_LOGIC
			);
	END stb;

ARCHITECTURE Behavior OF stb IS
	BEGIN
		SN <= AN XOR BN XOR CN;
		CN1 <= (AN AND BN) OR (AN AND CN) OR (CN AND BN);
		
	END Behavior;