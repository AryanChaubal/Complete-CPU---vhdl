-- Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 14.0.2 Build 209 09/17/2014 SJ Full Version"

-- DATE "03/24/2025 17:22:50"

-- 
-- Device: Altera EP4CE115F23C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	reset_circuit IS
    PORT (
	reset : IN std_logic;
	clk : IN std_logic;
	enable_PD : OUT std_logic;
	clr_PC : OUT std_logic
	);
END reset_circuit;

-- Design Ports Information
-- enable_PD	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clr_PC	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_H3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_G1,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF reset_circuit IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_enable_PD : std_logic;
SIGNAL ww_clr_PC : std_logic;
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \enable_PD~output_o\ : std_logic;
SIGNAL \clr_PC~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \present_clk.clk0~0_combout\ : std_logic;
SIGNAL \present_clk.clk0~q\ : std_logic;
SIGNAL \present_clk~6_combout\ : std_logic;
SIGNAL \present_clk~9_combout\ : std_logic;
SIGNAL \present_clk.clk1~q\ : std_logic;
SIGNAL \present_clk~8_combout\ : std_logic;
SIGNAL \present_clk.clk2~q\ : std_logic;
SIGNAL \present_clk~7_combout\ : std_logic;
SIGNAL \present_clk.clk3~q\ : std_logic;
SIGNAL \enable_PD~0_combout\ : std_logic;
SIGNAL \enable_PD~reg0_q\ : std_logic;
SIGNAL \clr_PC~reg0_q\ : std_logic;
SIGNAL \ALT_INV_enable_PD~reg0_q\ : std_logic;

BEGIN

ww_reset <= reset;
ww_clk <= clk;
enable_PD <= ww_enable_PD;
clr_PC <= ww_clr_PC;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);
\ALT_INV_enable_PD~reg0_q\ <= NOT \enable_PD~reg0_q\;

-- Location: IOOBUF_X0_Y60_N16
\enable_PD~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_enable_PD~reg0_q\,
	devoe => ww_devoe,
	o => \enable_PD~output_o\);

-- Location: IOOBUF_X0_Y61_N23
\clr_PC~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \clr_PC~reg0_q\,
	devoe => ww_devoe,
	o => \clr_PC~output_o\);

-- Location: IOIBUF_X0_Y36_N8
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G2
\clk~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOIBUF_X0_Y62_N22
\reset~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: LCCOMB_X1_Y61_N28
\present_clk.clk0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_clk.clk0~0_combout\ = !\reset~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \reset~input_o\,
	combout => \present_clk.clk0~0_combout\);

-- Location: FF_X1_Y61_N29
\present_clk.clk0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \present_clk.clk0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \present_clk.clk0~q\);

-- Location: LCCOMB_X1_Y61_N16
\present_clk~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_clk~6_combout\ = (\reset~input_o\) # (!\present_clk.clk0~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \reset~input_o\,
	datad => \present_clk.clk0~q\,
	combout => \present_clk~6_combout\);

-- Location: LCCOMB_X1_Y61_N18
\present_clk~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_clk~9_combout\ = (!\reset~input_o\ & !\present_clk.clk0~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \reset~input_o\,
	datad => \present_clk.clk0~q\,
	combout => \present_clk~9_combout\);

-- Location: FF_X1_Y61_N19
\present_clk.clk1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \present_clk~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \present_clk.clk1~q\);

-- Location: LCCOMB_X1_Y61_N12
\present_clk~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_clk~8_combout\ = (\present_clk.clk0~q\ & (!\reset~input_o\ & \present_clk.clk1~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \present_clk.clk0~q\,
	datac => \reset~input_o\,
	datad => \present_clk.clk1~q\,
	combout => \present_clk~8_combout\);

-- Location: FF_X1_Y61_N13
\present_clk.clk2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \present_clk~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \present_clk.clk2~q\);

-- Location: LCCOMB_X1_Y61_N2
\present_clk~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \present_clk~7_combout\ = (!\present_clk.clk1~q\ & (!\present_clk~6_combout\ & ((\present_clk.clk2~q\) # (\present_clk.clk3~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \present_clk.clk2~q\,
	datab => \present_clk.clk1~q\,
	datac => \present_clk.clk3~q\,
	datad => \present_clk~6_combout\,
	combout => \present_clk~7_combout\);

-- Location: FF_X1_Y61_N3
\present_clk.clk3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \present_clk~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \present_clk.clk3~q\);

-- Location: LCCOMB_X1_Y61_N14
\enable_PD~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \enable_PD~0_combout\ = (\reset~input_o\) # (\present_clk.clk3~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \reset~input_o\,
	datad => \present_clk.clk3~q\,
	combout => \enable_PD~0_combout\);

-- Location: FF_X1_Y61_N17
\enable_PD~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \present_clk~6_combout\,
	ena => \enable_PD~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \enable_PD~reg0_q\);

-- Location: FF_X1_Y61_N15
\clr_PC~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \reset~input_o\,
	sload => VCC,
	ena => \enable_PD~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clr_PC~reg0_q\);

ww_enable_PD <= \enable_PD~output_o\;

ww_clr_PC <= \clr_PC~output_o\;
END structure;


