LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dr IS
	PORT ( Amsb, Bmsb, Smsb : IN STD_LOGIC;
			OVF : OUT STD_LOGIC
			);
	END dr;
	
ARCHITECTURE Behavior OF dr IS
	BEGIN
		OVF <= (Bmsb AND Amsb AND NOT Smsb) OR (NOT Bmsb AND NOT Amsb AND Smsb);
	END Behavior;