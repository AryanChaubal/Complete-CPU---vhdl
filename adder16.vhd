LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder16 IS
	PORT (
		Cin : IN std_logic;
		X, Y : IN std_logic_vector(15 DOWNTO 0);
		S : OUT std_logic_vector(15 DOWNTO 0);
		Cout : OUT std_logic
	);
END adder16;

ARCHITECTURE Behavior OF adder16 IS
	COMPONENT adder4
		PORT (
			Cin : IN std_logic;
			X, Y : IN std_logic_vector(3 DOWNTO 0);
			S : OUT std_logic_vector(3 DOWNTO 0);
			Cout : OUT std_logic
		);
	END COMPONENT;

	SIGNAL C : std_logic_vector(1 TO 3);
BEGIN
	stage0 : adder4
	PORT MAP(Cin, X(3 DOWNTO 0), Y(3 DOWNTO 0), S(3 DOWNTO 0), C(1));
	stage1 : adder4
	PORT MAP(C(1), X(7 DOWNTO 4), Y(7 DOWNTO 4), S(7 DOWNTO 4), C(2));
	stage2 : adder4
	PORT MAP(C(2), X(11 DOWNTO 8), Y(11 DOWNTO 8), S(11 DOWNTO 8), C(3));
stage3 : adder4
PORT MAP(C(3), X(15 DOWNTO 12), Y(15 DOWNTO 12), S(15 DOWNTO 12), Cout);
END Behavior;