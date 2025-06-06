LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RED IS
	PORT (
		RED_in : IN std_logic_vector(31 DOWNTO 0);
		RED_out : OUT unsigned(7 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE Behavior OF RED IS
BEGIN
	RED_out <= unsigned (RED_in(7 DOWNTO 0));
END Behavior;