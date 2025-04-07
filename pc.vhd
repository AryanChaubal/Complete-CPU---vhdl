LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY pc IS
	PORT (
		clr : IN std_logic;
		clk : IN std_logic;
		ld : IN std_logic;
		inc : IN std_logic;
		d : IN std_logic_vector(31 DOWNTO 0);
		q : OUT std_logic_vector(31 DOWNTO 0)
	);
END pc;

ARCHITECTURE Behavior OF pc IS
	COMPONENT add
		PORT (
			A : IN std_logic_vector(31 DOWNTO 0);
			B : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux2to1
		PORT (
			s : IN std_logic;
			w0, w1 : IN std_logic_vector(31 DOWNTO 0);
			f : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT register32
		PORT (
			d : IN std_logic_vector(31 DOWNTO 0);
			ld : IN std_logic;
			clr : IN std_logic;
			clk : IN std_logic;
			Q : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL add_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL mux_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL q_out : std_logic_vector(31 DOWNTO 0);

BEGIN
	add0 : add
	PORT MAP(q_out, add_out);
	mux0 : mux2to1
	PORT MAP(inc, d, add_out, mux_out);
	reg0 : register32
	PORT MAP(mux_out, ld, clr, clk, q_out);
q <= q_out;

END Behavior;