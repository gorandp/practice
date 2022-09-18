LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY petri IS
	PORT (
			-- Entradas
			S1 : IN STD_LOGIC;	--Sensor temperatura < a la mínima
			S2 : IN STD_LOGIC;	--Sensor temperatura > a la máxima
			SV : IN STD_LOGIC;	--Sensor resistencia calefactora
			SH1 : IN STD_LOGIC;	--Sensor humedad alta
			SH2 : IN STD_LOGIC;	--Sensor humedad baja

			-- Clock y reset
			Clk: IN STD_LOGIC;	--Señal de Clock
			Rst: IN STD_LOGIC;	--Señal de Reset

			-- Salidas
			V  : OUT STD_LOGIC;	--Válvula
			M1 : OUT STD_LOGIC;	--Motor izquierda
			M2 : OUT STD_LOGIC;	--Motor derecha
			RC : OUT STD_LOGIC;	--Resistencia calefactora
			RV : OUT STD_LOGIC	--Resistencia vaporización

			-- Temporizadores (externos)
			-- F1 : IN STD_LOGIC;	--salida temporizador 1
			-- C1 : OUT STD_LOGIC;	--entrada temporizador 1
			-- F2 : IN STD_LOGIC;	--salida temporizador 2
			-- C2 : OUT STD_LOGIC;	--entrada temporizador 2
			-- F3 : IN STD_LOGIC;	--salida temporizador 3
			-- C3 : OUT STD_LOGIC;	--entrada temporizador 3
			-- F4 : IN STD_LOGIC;	--salida temporizador 4
			-- C4 : OUT STD_LOGIC;	--entrada temporizador 4
			);
END petri;

ARCHITECTURE behavior OF petri IS

	-- Declaración transiciones
	signal TEMP_TR1, TEMP_TR2 : STD_LOGIC; -- subred temperatura
	signal HUMV_TR1, HUMV_TR2 : STD_LOGIC; -- subred humedad/válvula
	signal HUMTVAP_TR1, HUMTVAP_TR2 : STD_LOGIC; -- subred humedad/temperaturaVaporizador
	signal ROT_TR1, ROT_TR2, ROT_TR3, ROT_TR4, ROT_TR5, ROT_TR6, ROT_TR7, ROT_TR8, ROT_TR9 : STD_LOGIC; -- subred rotación

	-- Declaración lugares
	signal TEMP_Q1, TEMP_Q2 : STD_LOGIC; -- subred temperatura
	signal HUMV_Q1, HUMV_Q2 : STD_LOGIC; -- subred humedad/válvula
	signal HUMTVAP_Q1, HUMTVAP_Q2 : STD_LOGIC; -- subred humedad/temperaturaVaporizador
	signal ROT_Q1, ROT_Q2, ROT_Q3, ROT_Q4, ROT_Q5, ROT_Q6, ROT_Q7, ROT_Q8 : STD_LOGIC; -- subred rotación

	-- Temporizadores (internos) entrada/salida
	signal C1, F1 : STD_LOGIC; -- temporizador 1
	signal C2, F2 : STD_LOGIC; -- temporizador 2
	signal C3, F3 : STD_LOGIC; -- temporizador 3
	signal C4, F4 : STD_LOGIC; -- temporizador 4

	-- Contadores Temporizadores (para simularlos como N pulsos de reloj)
	signal tm1 : INTEGER RANGE 0 to 1800; 	-- temporizador 1 (1800 pulsos)
	signal tm2 : INTEGER RANGE 0 to 15; 	-- temporizador 2 (15 pulsos)
	signal tm3 : INTEGER RANGE 0 to 300; 	-- temporizador 3 (300 pulsos)
	signal tm4 : INTEGER RANGE 0 to 10; 	-- temporizador 4 (10 pulsos)


	BEGIN
------ Transiciones a disparar -----------
		-- subred temperatura
		TEMP_TR1 <= TEMP_Q1 AND ((S1 AND (NOT S2)) OR V);
		TEMP_TR2 <= TEMP_Q2 AND ((NOT S1) AND S2 AND (NOT V));

		-- subred humedad/válvula
		HUMV_TR1 <= HUMV_Q1 AND ((NOT SH1) OR SH2) AND ((F3 AND (NOT M1) AND (NOT M2)) OR ((NOT SH1) AND SH2));
		HUMV_TR2 <= HUMV_Q2 AND (F2 OR ((SH1 OR (NOT SH2)) AND (M1 OR M2)));

		-- subred humedad/temperaturaVaporizador
		HUMTVAP_TR1 <= HUMTVAP_Q1 AND NOT SV;
		HUMTVAP_TR2 <= HUMTVAP_Q2 AND SV;

		-- subred rotación
		ROT_TR1 <= ROT_Q1 AND F1;
		ROT_TR2 <= ROT_Q2 AND F4;
		ROT_TR3 <= ROT_Q3 AND (NOT F1) AND (NOT F4);
		ROT_TR4 <= ROT_Q4 AND F4;
		ROT_TR5 <= ROT_Q5 AND (NOT F1) AND (NOT F4);
		ROT_TR6 <= ROT_Q6 AND (NOT F1);
		ROT_TR7 <= ROT_Q3 AND ROT_Q7 AND F1;
		ROT_TR8 <= ROT_Q5 AND ROT_Q7 AND F1;
		ROT_TR9 <= ROT_Q8 AND (NOT F1);
------------------------------------------

----- Marcado y desmarcado de Lugares ----
		PROCESS(Clk, Rst)
		BEGIN
			--- Marcado Inicial
			IF (Rst='1') THEN
				TEMP_Q1 <= '1'; TEMP_Q2 <= '0';
				HUMV_Q1 <= '1'; HUMV_Q2 <= '0';
				HUMTVAP_Q1 <= '1'; HUMTVAP_Q2 <= '0';
				ROT_Q1 <= '1'; ROT_Q2 <= '0'; ROT_Q3 <= '0'; ROT_Q4 <= '0'; ROT_Q5 <= '0'; ROT_Q6 <= '0'; ROT_Q7 <= '0'; ROT_Q8 <= '0';

			-- evolución sincrónica
			ELSIF (Clk'EVENT AND Clk='1') THEN
				-- subred temperatura
				IF TEMP_TR1='1' THEN TEMP_Q1 <= '0'; TEMP_Q2 <= '1'; END IF;
				IF TEMP_TR2='1' THEN TEMP_Q1 <= '1'; TEMP_Q2 <= '0'; END IF;

				-- subred humedad/válvula
				IF HUMV_TR1='1' THEN HUMV_Q1 <= '0'; HUMV_Q2 <= '1'; END IF;
				IF HUMV_TR2='1' THEN HUMV_Q1 <= '1'; HUMV_Q2 <= '0'; END IF;

				-- subred humedad/temperaturaVaporizador
				IF HUMTVAP_TR1='1' THEN HUMTVAP_Q1 <= '0'; HUMTVAP_Q2 <= '1'; END IF;
				IF HUMTVAP_TR2='1' THEN HUMTVAP_Q1 <= '1'; HUMTVAP_Q2 <= '0'; END IF;

				-- subred rotación
				IF ROT_TR1='1' THEN ROT_Q1 <= '0'; ROT_Q2 <= '1'; ROT_Q6 <= '1'; END IF;
				IF ROT_TR2='1' THEN ROT_Q2 <= '0'; ROT_Q3 <= '1'; END IF;
				IF ROT_TR3='1' THEN ROT_Q3 <= '0'; ROT_Q4 <= '1'; END IF;
				IF ROT_TR4='1' THEN ROT_Q4 <= '0'; ROT_Q5 <= '1'; END IF;
				IF ROT_TR5='1' THEN ROT_Q5 <= '0'; ROT_Q2 <= '1'; END IF;
				IF ROT_TR6='1' THEN ROT_Q6 <= '0'; ROT_Q7 <= '1'; END IF;
				IF ROT_TR7='1' THEN ROT_Q3 <= '0'; ROT_Q7 <= '0'; ROT_Q8 <= '1'; END IF;
				IF ROT_TR8='1' THEN ROT_Q5 <= '0'; ROT_Q7 <= '0'; ROT_Q8 <= '1'; END IF;
				IF ROT_TR9='1' THEN ROT_Q8 <= '0'; ROT_Q1 <= '1'; END IF;

			END IF;
		END PROCESS;
------------------------------------------

----- Salidas ----------------------------
		-- subred temperatura
		RC <= TEMP_Q2

		-- subred humedad/válvula
		C3 <= HUMV_Q1
		C2 <= HUMV_Q2
		V <= HUMV_Q2

		-- subred humedad/temperaturaVaporizador
		RV <= HUMTVAP_Q2

		-- subred rotación
		C1 <= ROT_Q1 OR ROT_Q7
		C4 <= ROT_Q2 OR ROT_Q4
		M1 <= ROT_Q2
		M2 <= ROT_Q4
------------------------------------------

----- Temporizador 1 -----------------------
		PROCESS(Clk, Rst)
		BEGIN
			IF (Rst='1') THEN
				F1 <= '0';
				tm1 <= 0;
			ELSIF (Clk'EVENT AND Clk='1') THEN
				IF C1='1' THEN
					IF (tm1 <= 1800) THEN
						tm1 <= tm1 + 1;
						F1 <= '0';
					ELSE
						tm1 <= 0;
						F1 <= '1';
					END IF;
				-- ELSE
				-- 	F1 <= '0' -- vemos que onda después
				END IF;
			END IF;
		END PROCESS;

	END behavior;

----- Temporizador 2 -----------------------
		PROCESS(Clk, Rst)
		BEGIN
			IF (Rst='1') THEN
				F2 <= '0';
				tm2 <= 0;
			ELSIF (Clk'EVENT AND Clk='1') THEN
				IF C2='1' THEN
					IF (tm2 <= 15) THEN
						tm2 <= tm2 + 1;
						F2 <= '0';
					ELSE
						tm2 <= 0;
						F2 <= '1';
					END IF;
				-- ELSE
				-- 	F2 <= '0' -- vemos que onda después
				END IF;
			END IF;
		END PROCESS;

		END behavior;

----- Temporizador 3 -----------------------
		PROCESS(Clk, Rst)
		BEGIN
			IF (Rst='1') THEN
				F3 <= '0';
				tm3 <= 0;
			ELSIF (Clk'EVENT AND Clk='1') THEN
				IF C3='1' THEN
					IF (tm3 <= 300) THEN
						tm3 <= tm3 + 1;
						F3 <= '0';
					ELSE
						tm3 <= 0;
						F3 <= '1';
					END IF;
				-- ELSE
				-- 	F3 <= '0' -- vemos que onda después
				END IF;
			END IF;
		END PROCESS;

		END behavior;

----- Temporizador 4 -----------------------
		PROCESS(Clk, Rst)
		BEGIN
			IF (Rst='1') THEN
				F4 <= '0';
				tm4 <= 0;
			ELSIF (Clk'EVENT AND Clk='1') THEN
				IF C4='1' THEN
					IF (tm4 <= 10) THEN
						tm4 <= tm4 + 1;
						F4 <= '0';
					ELSE
						tm4 <= 0;
						F4 <= '1';
					END IF;
				-- ELSE
				-- 	F4 <= '0' -- vemos que onda después
				END IF;
			END IF;
		END PROCESS;

		END behavior;
