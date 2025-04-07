LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu IS
	PORT (
		a : IN std_logic_vector(31 DOWNTO 0);
		b : IN std_logic_vector(31 DOWNTO 0);
		op : IN std_logic_vector(2 DOWNTO 0);
		result : OUT std_logic_vector(31 DOWNTO 0);
		zero : OUT std_logic;
		cout : OUT std_logic
	);
END alu;

ARCHITECTURE Behavior OF alu IS
	COMPONENT adder32
		PORT (
			Cin : IN std_logic;
			X, Y : IN std_logic_vector(31 DOWNTO 0);
			S : OUT std_logic_vector(31 DOWNTO 0);
			Cout : OUT std_logic
		);
	END COMPONENT;

	SIGNAL result_s : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL result_add : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL result_sub : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL cout_s : std_logic := '0';
	SIGNAL cout_add : std_logic := '0';
	SIGNAL cout_sub : std_logic := '0';
	SIGNAL zero_s : std_logic;
BEGIN
	add0 : adder32
	PORT MAP(op(2), a, b, result_add, cout_add);
	sub0 : adder32
	PORT MAP(op(2), a, NOT b, result_sub, cout_sub);

	PROCESS (a, b, op)
BEGIN
	CASE (op) IS
		WHEN "000" => 
			result_s <= a AND b;
			cout_s <= '0';
		WHEN "001" => 
			result_s <= a OR b;
			cout_s <= '0';
		WHEN "010" => 
			result_s <= result_add;
			cout_s <= cout_add;
		WHEN "011" => 
			result_s <= b;
			cout_s <= '0';
		WHEN "110" => 
			result_s <= result_sub;
			cout_s <= cout_sub;
		WHEN "100" => 
			result_s <= a(30 DOWNTO 0) & '0';
			cout_s <= a(31);
		WHEN "101" => 
			result_s <= '0' & a(31 DOWNTO 1);
			cout_s <= '0';
		WHEN OTHERS => 
			result_s <= a;
			cout_s <= '0';
	END CASE;

	CASE (result_s) IS
		WHEN (OTHERS => '0') => 
			zero_s <= '1';
		WHEN OTHERS => 
			zero_s <= '0';
	END CASE;
END PROCESS;

result <= result_s;
cout <= cout_s;
zero <= zero_s;
END Behavior;