LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder32 IS
	PORT (
		Cin : IN std_logic;
		X, Y : IN std_logic_vector(31 DOWNTO 0);
		S : OUT std_logic_vector(31 DOWNTO 0);
		Cout : OUT std_logic
	);
END adder32;

ARCHITECTURE Behavior OF adder32 IS
	COMPONENT adder16
		PORT (
			Cin : IN std_logic;
			X, Y : IN std_logic_vector(15 DOWNTO 0);
			S : OUT std_logic_vector(15 DOWNTO 0);
			Cout : OUT std_logic
		);
	END COMPONENT;

	SIGNAL C : std_logic;
BEGIN
	stage0 : adder16
	PORT MAP(Cin, X(15 DOWNTO 0), Y(15 DOWNTO 0), S(15 DOWNTO 0), C);
	stage1 : adder16
	PORT MAP(C, X(31 DOWNTO 16), Y(31 DOWNTO 16), S(31 DOWNTO 16), Cout);
END Behavior;