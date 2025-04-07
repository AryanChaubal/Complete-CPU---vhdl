LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY reset_circuit IS
	PORT (
		reset : IN std_logic;
		clk : IN std_logic;
		enable_PD : OUT std_logic := '1';
		clr_PC : OUT std_logic
	);
END reset_circuit;

ARCHITECTURE Behavior OF reset_circuit IS
	TYPE clkNum IS (clk0, clk1, clk2, clk3);
	SIGNAL present_clk : clkNum;
BEGIN
	PROCESS (clk)BEGIN
	IF rising_edge(clk) THEN
		IF reset = '1' THEN
			clr_PC <= '1';
			enable_PD <= '0';
			present_clk <= clk0;
		ELSIF present_clk <= clk0 THEN
			present_clk <= clk1;
		ELSIF present_clk <= clk1 THEN
			present_clk <= clk2;
		ELSIF present_clk <= clk2 THEN
			present_clk <= clk3;
		ELSIF present_clk <= clk3 THEN
			clr_PC <= '0';
			enable_PD <= '1';
		END IF;
	END IF;
END PROCESS;
END Behavior;