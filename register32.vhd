LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY register32 IS
	PORT (
		d : IN std_logic_vector(31 DOWNTO 0);
		ld : IN std_logic;
		clr : IN std_logic;
		clk : IN std_logic;
		Q : OUT std_logic_vector(31 DOWNTO 0)
	);
END register32;

ARCHITECTURE Behavior OF register32 IS
BEGIN
	PROCESS (ld, clr, clk)
	BEGIN
		IF clr = '1' THEN
			Q <= (OTHERS => '0');
		ELSIF ((clk'EVENT AND clk = '1') AND (ld = '1')) THEN
			Q <= d;
		END IF;
	END PROCESS;
END Behavior;