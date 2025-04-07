LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY data_mem IS
	PORT (
		clk : IN std_logic;
		addr : IN unsigned(7 DOWNTO 0);
		data_in : IN std_logic_vector(31 DOWNTO 0);
		wen : IN std_logic;
		en : IN std_logic;
		data_out : OUT std_logic_vector(31 DOWNTO 0)
	);
END data_mem;

ARCHITECTURE Behavior OF data_mem IS
	TYPE RAM IS ARRAY (0 TO 255) OF std_logic_vector(31 DOWNTO 0);
	SIGNAL DATAMEM : RAM;
BEGIN
	PROCESS (clk, en, wen)
	BEGIN
		IF (clk'EVENT AND clk = '0') THEN
			IF (en = '0') THEN
				data_out <= (OTHERS => '0');
			ELSE
				IF (wen = '0') THEN
					data_out <= DATAMEM(to_integer(addr));
				END IF;
				IF (wen = '1') THEN
					DATAMEM(to_integer(addr)) <= data_in;
					data_out <= (OTHERS => '0');
				END IF;
			END IF;
		END IF;
	END PROCESS;
END Behavior;