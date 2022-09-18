LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY stb_8bits_generate IS
	PORT ( An, Bn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			Cin : IN STD_LOGIC;
			Cout : OUT STD_LOGIC;
			Sn : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			OVF : OUT STD_LOGIC
			);
	END stb_8bits_generate;
	
ARCHITECTURE Behavior OF stb_8bits_generate IS

	-- Instanciamos el objeto sumador total binario de 1 bit
	COMPONENT STB
		PORT ( AN, BN, CNI : IN STD_LOGIC;
				CNO, SN : OUT STD_LOGIC
				);
	END COMPONENT;

	-- Instanciamos el objeto Detector de Rebasamiento
	COMPONENT dr
		PORT ( Amsb, Bmsb, Smsb : IN STD_LOGIC;
				OVF : OUT STD_LOGIC
				);
	END COMPONENT;

	-- Creo las señales de conexion entre los Cout y los Ci. Necesito 1 de mas
	-- por el uso de GENERATE
	SIGNAL CarryTmp : STD_LOGIC_VECTOR (8 DOWNTO 0);
	-- Dado que necesito LEER el MSb de la suma, almaceno la misma en una señal
	SIGNAL Suma : STD_LOGIC_VECTOR (7 DOWNTO 0);

	BEGIN	
		--El Carry In del Sumador de 8 bits lo meto en el array de carrys
		CarryTmp(0) <= Cin;
		-- Genereo 8 Sumadores Totales binarios y hago la interconexion entre ellos
		arrrayOfSTB: FOR I IN 0 TO 7 GENERATE
			adder_i: 
				STB PORT MAP ( AN => An(I), 
									BN => Bn(I), 	
									CNI => CarryTmp(I), 
									CNO => CarryTmp(I+1), 
									SN => Suma(I) 
								  );
		END GENERATE arrrayOfSTB;
		-- El ultimo CarryTmp es el carry out
		Cout <= CarryTmp(8);
		-- Conecto el Arry Suma con la salida propiamente dicha
		Sn <= Suma;
		-- Conecto el Detector de rebasamiento
		DetecOVF: dr PORT MAP ( An(7), Bn(7), Suma(7), OVF );
		
	END Behavior;