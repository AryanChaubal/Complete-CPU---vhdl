LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY UZE IS
	PORT (
		UZE_in : IN std_logic_vector(31 DOWNTO 0);
		UZE_out : OUT std_logic_vector(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE Behavior OF UZE IS
	SIGNAL zeros : std_logic_vector(15 DOWNTO 0) := (OTHERS => '0');
BEGIN
	UZE_out <= UZE_in(15 DOWNTO 0) & zeros;
END Behavior;