LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY data_path IS
	PORT (

		Clk, mClk : IN std_logic;
		WEN, EN : IN std_logic;
		Clr_A, Ld_A : IN std_logic;
		Clr_B, Ld_B : IN std_logic;
		Clr_C, Ld_C : IN std_logic;
		Clr_Z, Ld_Z : IN std_logic;
		ClrPC, Ld_PC : IN std_logic;
		ClrIR, Ld_IR : IN std_logic;
		Out_A : OUT std_logic_vector(31 DOWNTO 0);
		Out_B : OUT std_logic_vector(31 DOWNTO 0);
		Out_C : OUT std_logic;
		Out_Z : OUT std_logic;
		Out_PC : OUT std_logic_vector(31 DOWNTO 0);
		Out_IR : OUT std_logic_vector(31 DOWNTO 0);
		Inc_PC : IN std_logic;
		ADDR_OUT : OUT std_logic_vector(31 DOWNTO 0);
		DATA_IN : IN std_logic_vector(31 DOWNTO 0);
		DATA_BUS, MEM_OUT, MEM_IN : OUT std_logic_vector(31 DOWNTO 0);
		MEM_ADDR : OUT unsigned(7 DOWNTO 0);
		DATA_MUX : IN std_logic_vector(1 DOWNTO 0);
		REG_MUX : IN std_logic;
		A_MUX, B_MUX : IN std_logic;
		IM_MUX1 : IN std_logic;
		IM_MUX2 : IN std_logic_vector(1 DOWNTO 0);
		ALU_Op : IN std_logic_vector(2 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE Behavior OF data_path IS

	COMPONENT data_mem IS
		PORT (
			clk : IN std_logic;
			addr : IN unsigned(7 DOWNTO 0);
			data_in : IN std_logic_vector(31 DOWNTO 0);
			wen : IN std_logic;
			en : IN std_logic;
			data_out : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT register32 IS
		PORT (
			d : IN std_logic_vector(31 DOWNTO 0);
			ld : IN std_logic;
			clr : IN std_logic;
			clk : IN std_logic;
			Q : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT pc IS
		PORT (
			clr : IN std_logic;
			clk : IN std_logic;
			ld : IN std_logic;
			inc : IN std_logic;
			d : IN std_logic_vector(31 DOWNTO 0);
			q : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT LZE IS
		PORT (
			LZE_in : IN std_logic_vector(31 DOWNTO 0);
			LZE_out : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT UZE IS
		PORT (
			UZE_in : IN std_logic_vector(31 DOWNTO 0);
			UZE_out : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT RED IS
		PORT (
			RED_in : IN std_logic_vector(31 DOWNTO 0);
			RED_out : OUT unsigned(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux2to1 IS
		PORT (
			s : IN std_logic;
			w0, w1 : std_logic_vector(31 DOWNTO 0);
			f : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux4to1 IS
		PORT (
			s : IN std_logic_vector(1 DOWNTO 0);
			X1, X2, X3, X4 : IN std_logic_vector(31 DOWNTO 0);
			f : OUT std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT alu IS
		PORT (
			a, b : IN std_logic_vector(31 DOWNTO 0);
			op : IN std_logic_vector(2 DOWNTO 0);
			result : OUT std_logic_vector(31 DOWNTO 0);
			zero, cout : OUT std_logic
		);
	END COMPONENT;

	SIGNAL IR_OUT : std_logic_vector(31 DOWNTO 0);
	SIGNAL data_bus_s : std_logic_vector(31 DOWNTO 0);
	SIGNAL LZE_out_PC : std_logic_vector(31 DOWNTO 0);
	SIGNAL LZE_out_A_mux : std_logic_vector(31 DOWNTO 0);
	SIGNAL LZE_out_B_mux : std_logic_vector(31 DOWNTO 0);
	SIGNAL RED_out_data_mem : unsigned(7 DOWNTO 0);
	SIGNAL A_Mux_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL B_Mux_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL reg_A_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL reg_B_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL reg_Mux_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL data_mem_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL UZE_IM_MUX1_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL IM_MUX1_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL LZE_IM_MUX2_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL IM_MUX2_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL ALU_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL zero_flag : std_logic;
	SIGNAL carry_flag : std_logic;
	SIGNAL temp : std_logic_vector(30 DOWNTO 0) := (OTHERS => '0');
	SIGNAL out_pc_sig : std_logic_vector(31 DOWNTO 0);

BEGIN
	IR : register32
	PORT MAP(
		data_bus_s, Ld_IR, ClrIR, Clk, 
		IR_OUT
	);

	LZE_PC : LZE
	PORT MAP(
		IR_OUT, LZE_out_PC
	);

	PC0 : pc
	PORT MAP(
		CLRPC, Clk, ld_PC, INC_PC, 
		LZE_out_PC, out_pc_sig
	);

	LZE_A_Mux : LZE
	PORT MAP(
		IR_OUT, LZE_out_A_mux
	);

	A_Mux0 : mux2to1
	PORT MAP(
		A_MUX, data_bus_s, LZE_out_A_mux, A_mux_out
	);

	Reg_A : register32
	PORT MAP(
		A_mux_out, Ld_A, Clr_A, Clk, 
		reg_A_out
	);

	LZE_B_Mux : LZE
	PORT MAP(
		IR_OUT, LZE_out_B_mux
	);

	B_Mux0 : mux2to1
	PORT MAP(
		B_MUX, data_bus_s, LZE_out_B_mux, B_mux_out
	);

	Reg_B : register32
	PORT MAP(
		B_mux_out, Ld_B, Clr_B, Clk, 
		reg_B_out
	);

	Reg_Mux0 : mux2to1
	PORT MAP(
		REG_MUX, Reg_A_out, Reg_B_out, Reg_Mux_out
	);

	RED_Data_Mem : RED
	PORT MAP(
		IR_OUT, RED_out_data_mem
	);

	Data_Mem0 : data_mem
	PORT MAP(
		mClk, RED_out_data_mem, Reg_Mux_out, WEN, 
		EN, data_mem_out
	);

	UZE_IM_MUX1 : UZE
	PORT MAP(
		IR_OUT, UZE_IM_MUX1_out
	);

	IM_MUX1a : mux2to1
	PORT MAP(
		IM_MUX1, reg_A_out, UZE_IM_MUX1_out, IM_MUX1_out
	);

	LZE_IM_MUX2 : LZE
	PORT MAP(
		IR_OUT, LZE_IM_MUX2_out
	);

	IM_MUX2a : mux4to1
	PORT MAP(
		IM_MUX2, reg_B_out, LZE_IM_MUX2_out, (temp & '1'), (OTHERS => '0'), IM_MUX2_out
	);

	ALU0 : ALU
	PORT MAP(
		IM_MUX1_out, IM_MUX2_out, ALU_Op, ALU_out, 
		zero_flag, carry_flag
	);

	DATA_MUX0 : mux4to1
	PORT MAP(
		DATA_MUX, DATA_IN, data_mem_out, ALU_out, 
		(OTHERS => '0'), data_bus_s
	);

	DATA_BUS <= data_bus_s;
	OUT_A <= reg_A_out;
	OUT_B <= reg_B_out;
	OUT_IR <= IR_OUT;
	ADDR_OUT <= out_pc_sig;
	OUT_PC <= out_pc_sig;

	MEM_ADDR <= RED_out_data_mem;
	MEM_IN <= Reg_Mux_out;
	MEM_OUT <= data_mem_out;

END Behavior;