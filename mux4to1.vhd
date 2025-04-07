LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux4to1 IS
	PORT (
		s : IN std_logic_vector(1 DOWNTO 0);
		X1 : IN std_logic_vector(31 DOWNTO 0);
		X2 : IN std_logic_vector(31 DOWNTO 0);
		X3 : IN std_logic_vector(31 DOWNTO 0);
		X4 : IN std_logic_vector(31 DOWNTO 0);
		f : OUT std_logic_vector(31 DOWNTO 0)
	);
END mux4to1;

ARCHITECTURE Behavior OF mux4to1 IS
BEGIN
	WITH s SELECT
	f <= X1 WHEN "00", 
	     X2 WHEN "01", 
	     X3 WHEN "10", 
	     X4 WHEN "11";
END Behavior;