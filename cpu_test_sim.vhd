LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cpu_test_sim IS
	PORT (
		cpuClk : IN std_logic;
		memClk : IN std_logic;
		rst : IN std_logic;

		outA, outB : OUT std_logic_vector(31 DOWNTO 0);
		outC, outZ : OUT std_logic;
		outIR : OUT std_logic_vector(31 DOWNTO 0);
		outPC : OUT std_logic_vector(31 DOWNTO 0);

		addrOut : OUT std_logic_vector(5 DOWNTO 0);
		wEn : OUT std_logic;
		memDataOut : OUT std_logic_vector(31 DOWNTO 0);
		memDataIn : OUT std_logic_vector(31 DOWNTO 0);

		T_Info : OUT std_logic_vector(2 DOWNTO 0);

		wen_mem, en_mem : OUT std_logic
	);
END cpu_test_sim;

ARCHITECTURE behavior OF cpu_test_sim IS
	COMPONENT system_memory
		PORT (
			address : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			clock : IN STD_LOGIC;
			data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT cpu1
		PORT (
			clk : IN std_logic;
			mem_clk : IN std_logic;
			rst : IN std_logic;
			dataIn : IN std_logic_vector(31 DOWNTO 0);
			dataOut : OUT std_logic_vector(31 DOWNTO 0);
			addrOut : OUT std_logic_vector(31 DOWNTO 0);
			wEn : OUT std_logic;
			dOutA, dOutB : OUT std_logic_vector(31 DOWNTO 0);
			dOutC, dOutZ : OUT std_logic;
			dOutIR : OUT std_logic_vector(31 DOWNTO 0);
			dOutPC : OUT std_logic_vector(31 DOWNTO 0);
			outT : OUT std_logic_vector(2 DOWNTO 0);
			wen_mem, en_mem : OUT std_logic
		);
	END COMPONENT;

	SIGNAL cpu_to_mem : std_logic_vector(31 DOWNTO 0);
	SIGNAL mem_to_cpu : std_logic_vector(31 DOWNTO 0);
	SIGNAL add_from_cpu : std_logic_vector(31 DOWNTO 0);
	SIGNAL wen_from_cpu : std_logic;

BEGIN
	main_memory : system_memory
	PORT MAP(
		address => add_from_cpu(5 DOWNTO 0), 
		clock => memClk, 
		data => cpu_to_mem, 
		wren => wen_from_cpu, 
		q => mem_to_cpu
	);
	main_processor : cpu1
	PORT MAP(
		clk => cpuClk, 
		mem_clk => memClk, 
		rst => rst, 
		dataIn => mem_to_cpu, 
		dataOut => cpu_to_mem, 
		addrOut => add_from_cpu, 
		wEn => wen_from_cpu, 
		dOutA => outA, 
		dOutB => outB, 
		dOutC => outC, 
		dOutZ => outZ, 
		dOutIR => outIR, 
		dOutPC => outPC, 
		outT => T_Info, 
		wen_mem => wen_mem, 
		en_mem => en_mem
	);

	addrOut <= add_from_cpu(5 DOWNTO 0);
	wEn <= wen_from_cpu;
	memDataOut <= mem_to_cpu;
	memDataIn <= cpu_to_mem;
END behavior;