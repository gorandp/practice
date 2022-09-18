LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY petri IS
	PORT (N1 : IN STD_LOGIC;	--Sensor Nivel Bajo
			N2 : IN STD_LOGIC;	--Sensor Nivel Medio
			N3 : IN STD_LOGIC;	--Sensor Nivel Alto
			Clk: IN STD_LOGIC;	--Señal de Clock
			Rst: IN STD_LOGIC;	--Señal de Reset
			A : OUT STD_LOGIC;	--Valvula de Agua
			J : OUT STD_LOGIC;	--Valvula de Jugo
			V : OUT STD_LOGIC;	--Valvula de Vaciado
			P : OUT STD_LOGIC		--Agitador
			);
END petri;

ARCHITECTURE behavior OF petri IS

	signal Tr1, Tr2, Tr3, Tr4, Tr5, Tr6, Tr7, Tr8, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : STD_LOGIC;	 -- Las transiciones y los Lugares
	signal Ts, Te : STD_LOGIC;						-- Salida Tiempo cumplido y habilitaciín Temporizador
	signal cuenta : INTEGER RANGE 0 to 8;		-- El temporizador lo simulamos como 9 pulsos de reloj

	BEGIN
------ Transiciones a disparar -----------
		Tr1 <= Q1 AND NOT N1;
		Tr2 <= Q1 AND N1;
		Tr3 <= Q2 AND NOT N1;
		Tr4 <= Q3 AND N3;
		Tr5 <= Q4 AND NOT N1;
		Tr6 <= Q5 AND N2;
		Tr7 <= Q6 AND N3;
		Tr8 <= Q7 AND Ts;
------------------------------------------

----- Marcado y desmarcado de Lugares ----
		PROCESS(Clk, Rst)
		BEGIN
			--- Marcado Inicial
			IF (Rst='1') THEN
				Q1 <= '1'; Q2 <= '0'; Q3 <= '0'; Q4 <= '0'; Q5 <= '0'; Q6 <= '0'; Q7 <= '0'; 

			-- evolucion sincrónica
			ELSIF (Clk'EVENT AND Clk='1') THEN
				IF TR1='1' THEN Q3 <= '1'; Q1 <= '0'; END IF;
				IF TR2='1' THEN Q2 <= '1'; Q1 <= '0'; END IF;
				IF TR3='1' THEN Q3 <= '1'; Q2 <= '0'; END IF;
				IF TR4='1' THEN Q4 <= '1'; Q3 <= '0'; END IF;
				IF TR5='1' THEN Q5 <= '1'; Q4 <= '0'; END IF;
				IF TR6='1' THEN Q6 <= '1'; Q5 <= '0'; END IF;
				IF TR7='1' THEN Q7 <= '1'; Q6 <= '0'; END IF;
				IF TR8='1' THEN Q4 <= '1'; Q7 <= '0'; END IF;
			END IF;
		END PROCESS;
------------------------------------------

----- Salidas ----------------------------
		A <= Q3 OR Q5;
		J <= Q6;
		V <= Q4 OR Q2;
		Te <= Q7;
		P <= Q7;
------------------------------------------		
		
----- Temporizador -----------------------
		PROCESS(Clk, Rst)
		BEGIN
			IF (Rst='1') THEN	
				Ts <= '0';
				cuenta <= 0; 
			ELSIF (Clk'EVENT AND Clk='1') THEN
				IF Te='1' THEN 
					IF (cuenta <= 8) THEN 
						cuenta <= cuenta + 1;
						Ts <= '0';
					ELSE
						cuenta <= 0;
						Ts <= '1';
					END IF;
				END IF;
			END IF;
		END PROCESS;
				
	END behavior;
