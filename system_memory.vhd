LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY altera_mf;
USE altera_mf.ALL;

ENTITY system_memory IS
	PORT (
		address : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		clock : IN STD_LOGIC := '1';
		data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END system_memory;
ARCHITECTURE SYN OF system_memory IS

	SIGNAL sub_wire0 : STD_LOGIC_VECTOR (31 DOWNTO 0);

	COMPONENT altsyncram
		GENERIC (
			clock_enable_input_a : STRING;
			clock_enable_output_a : STRING;
			init_file : STRING;
			intended_device_family : STRING;
			lpm_hint : STRING;
			lpm_type : STRING;
			numwords_a : NATURAL;
			operation_mode : STRING;
			outdata_aclr_a : STRING;
			outdata_reg_a : STRING;
			power_up_uninitialized : STRING;
			widthad_a : NATURAL;
			width_a : NATURAL;
			width_byteena_a : NATURAL
		);
		PORT (
			address_a : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			clock0 : IN STD_LOGIC;
			data_a : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren_a : IN STD_LOGIC;
			q_a : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;

BEGIN
	q <= sub_wire0(31 DOWNTO 0);

	altsyncram_component : altsyncram
		GENERIC MAP(
		clock_enable_input_a => "BYPASS", 
		clock_enable_output_a => "BYPASS", 
		init_file => "system_memory.mif", 
		intended_device_family => "Cyclone II", 
		lpm_hint => "ENABLE_RUNTIME_MOD=NO", 
		lpm_type => "altsyncram", 
		numwords_a => 64, 
		operation_mode => "SINGLE_PORT", 
		outdata_aclr_a => "NONE", 
		outdata_reg_a => "CLOCK0", 
		power_up_uninitialized => "FALSE", 
		widthad_a => 6, 
		width_a => 32, 
		width_byteena_a => 1
		)
		PORT MAP(
			address_a => address, 
			clock0 => clock, 
			data_a => data, 
			wren_a => wren, 
			q_a => sub_wire0
		);

END SYN;