LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fulladd IS
	PORT (
		Cin, x, y : IN std_logic;
		s, Cout : OUT std_logic
	);
END fulladd;

ARCHITECTURE Behavior OF fulladd IS
BEGIN
	s <= x XOR y XOR Cin;
	Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y);
END Behavior;