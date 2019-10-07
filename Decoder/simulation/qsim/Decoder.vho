-- Copyright (C) 2016  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 16.1.0 Build 196 10/24/2016 SJ Lite Edition"

-- DATE "10/07/2019 11:31:30"

-- 
-- Device: Altera 5CEBA2F17A7 Package FBGA256
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Decoder IS
    PORT (
	clock : IN std_logic;
	load : IN std_logic;
	instruction : IN std_logic_vector(31 DOWNTO 0);
	busyRs : IN std_logic_vector(3 DOWNTO 0);
	busy : OUT std_logic;
	rjMapFile : OUT std_logic_vector(4 DOWNTO 0);
	rkMapFile : OUT std_logic_vector(4 DOWNTO 0);
	rjRegFile : OUT std_logic_vector(4 DOWNTO 0);
	rkRegFile : OUT std_logic_vector(4 DOWNTO 0);
	opCode : OUT std_logic_vector(1 DOWNTO 0);
	fuCode : OUT std_logic_vector(1 DOWNTO 0);
	fuCodeOneHot : OUT std_logic_vector(3 DOWNTO 0);
	writeLine : OUT std_logic_vector(1 DOWNTO 0);
	RSLineOneHot : OUT std_logic_vector(3 DOWNTO 0);
	writeRS : OUT std_logic;
	writeAddr : OUT std_logic_vector(4 DOWNTO 0);
	writeData : OUT std_logic_vector(3 DOWNTO 0)
	);
END Decoder;

ARCHITECTURE structure OF Decoder IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_load : std_logic;
SIGNAL ww_instruction : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_busyRs : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_busy : std_logic;
SIGNAL ww_rjMapFile : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_rkMapFile : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_rjRegFile : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_rkRegFile : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_opCode : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_fuCode : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_fuCodeOneHot : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_writeLine : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_RSLineOneHot : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_writeRS : std_logic;
SIGNAL ww_writeAddr : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_writeData : std_logic_vector(3 DOWNTO 0);
SIGNAL \instruction[10]~input_o\ : std_logic;
SIGNAL \instruction[11]~input_o\ : std_logic;
SIGNAL \instruction[12]~input_o\ : std_logic;
SIGNAL \instruction[13]~input_o\ : std_logic;
SIGNAL \instruction[14]~input_o\ : std_logic;
SIGNAL \instruction[15]~input_o\ : std_logic;
SIGNAL \busy~output_o\ : std_logic;
SIGNAL \rjMapFile[0]~output_o\ : std_logic;
SIGNAL \rjMapFile[1]~output_o\ : std_logic;
SIGNAL \rjMapFile[2]~output_o\ : std_logic;
SIGNAL \rjMapFile[3]~output_o\ : std_logic;
SIGNAL \rjMapFile[4]~output_o\ : std_logic;
SIGNAL \rkMapFile[0]~output_o\ : std_logic;
SIGNAL \rkMapFile[1]~output_o\ : std_logic;
SIGNAL \rkMapFile[2]~output_o\ : std_logic;
SIGNAL \rkMapFile[3]~output_o\ : std_logic;
SIGNAL \rkMapFile[4]~output_o\ : std_logic;
SIGNAL \rjRegFile[0]~output_o\ : std_logic;
SIGNAL \rjRegFile[1]~output_o\ : std_logic;
SIGNAL \rjRegFile[2]~output_o\ : std_logic;
SIGNAL \rjRegFile[3]~output_o\ : std_logic;
SIGNAL \rjRegFile[4]~output_o\ : std_logic;
SIGNAL \rkRegFile[0]~output_o\ : std_logic;
SIGNAL \rkRegFile[1]~output_o\ : std_logic;
SIGNAL \rkRegFile[2]~output_o\ : std_logic;
SIGNAL \rkRegFile[3]~output_o\ : std_logic;
SIGNAL \rkRegFile[4]~output_o\ : std_logic;
SIGNAL \opCode[0]~output_o\ : std_logic;
SIGNAL \opCode[1]~output_o\ : std_logic;
SIGNAL \fuCode[0]~output_o\ : std_logic;
SIGNAL \fuCode[1]~output_o\ : std_logic;
SIGNAL \fuCodeOneHot[0]~output_o\ : std_logic;
SIGNAL \fuCodeOneHot[1]~output_o\ : std_logic;
SIGNAL \fuCodeOneHot[2]~output_o\ : std_logic;
SIGNAL \fuCodeOneHot[3]~output_o\ : std_logic;
SIGNAL \writeLine[0]~output_o\ : std_logic;
SIGNAL \writeLine[1]~output_o\ : std_logic;
SIGNAL \RSLineOneHot[0]~output_o\ : std_logic;
SIGNAL \RSLineOneHot[1]~output_o\ : std_logic;
SIGNAL \RSLineOneHot[2]~output_o\ : std_logic;
SIGNAL \RSLineOneHot[3]~output_o\ : std_logic;
SIGNAL \writeRS~output_o\ : std_logic;
SIGNAL \writeAddr[0]~output_o\ : std_logic;
SIGNAL \writeAddr[1]~output_o\ : std_logic;
SIGNAL \writeAddr[2]~output_o\ : std_logic;
SIGNAL \writeAddr[3]~output_o\ : std_logic;
SIGNAL \writeAddr[4]~output_o\ : std_logic;
SIGNAL \writeData[0]~output_o\ : std_logic;
SIGNAL \writeData[1]~output_o\ : std_logic;
SIGNAL \writeData[2]~output_o\ : std_logic;
SIGNAL \writeData[3]~output_o\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \busyRs[0]~input_o\ : std_logic;
SIGNAL \busyRs[3]~input_o\ : std_logic;
SIGNAL \busyRs[1]~input_o\ : std_logic;
SIGNAL \busyRs[2]~input_o\ : std_logic;
SIGNAL \WideAnd0~combout\ : std_logic;
SIGNAL \load~input_o\ : std_logic;
SIGNAL \busy~reg0_q\ : std_logic;
SIGNAL \instruction[5]~input_o\ : std_logic;
SIGNAL \instruction[26]~input_o\ : std_logic;
SIGNAL \instruction[21]~input_o\ : std_logic;
SIGNAL \instruction[22]~input_o\ : std_logic;
SIGNAL \instruction[23]~input_o\ : std_logic;
SIGNAL \instruction[24]~input_o\ : std_logic;
SIGNAL \instruction[25]~input_o\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \instruction[27]~input_o\ : std_logic;
SIGNAL \instruction[28]~input_o\ : std_logic;
SIGNAL \instruction[29]~input_o\ : std_logic;
SIGNAL \instruction[30]~input_o\ : std_logic;
SIGNAL \instruction[31]~input_o\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \rj~0_combout\ : std_logic;
SIGNAL \rjMapFile[0]~reg0_q\ : std_logic;
SIGNAL \instruction[6]~input_o\ : std_logic;
SIGNAL \rj~1_combout\ : std_logic;
SIGNAL \rjMapFile[1]~reg0_q\ : std_logic;
SIGNAL \instruction[7]~input_o\ : std_logic;
SIGNAL \rj~2_combout\ : std_logic;
SIGNAL \rjMapFile[2]~reg0_q\ : std_logic;
SIGNAL \instruction[8]~input_o\ : std_logic;
SIGNAL \rj~3_combout\ : std_logic;
SIGNAL \rjMapFile[3]~reg0_q\ : std_logic;
SIGNAL \instruction[9]~input_o\ : std_logic;
SIGNAL \rj~4_combout\ : std_logic;
SIGNAL \rjMapFile[4]~reg0_q\ : std_logic;
SIGNAL \instruction[16]~input_o\ : std_logic;
SIGNAL \rk~0_combout\ : std_logic;
SIGNAL \rkMapFile[0]~reg0_q\ : std_logic;
SIGNAL \instruction[17]~input_o\ : std_logic;
SIGNAL \rk~1_combout\ : std_logic;
SIGNAL \rkMapFile[1]~reg0_q\ : std_logic;
SIGNAL \instruction[18]~input_o\ : std_logic;
SIGNAL \rk~2_combout\ : std_logic;
SIGNAL \rkMapFile[2]~reg0_q\ : std_logic;
SIGNAL \instruction[19]~input_o\ : std_logic;
SIGNAL \rk~3_combout\ : std_logic;
SIGNAL \rkMapFile[3]~reg0_q\ : std_logic;
SIGNAL \instruction[20]~input_o\ : std_logic;
SIGNAL \rk~4_combout\ : std_logic;
SIGNAL \rkMapFile[4]~reg0_q\ : std_logic;
SIGNAL \rjRegFile[0]~reg0_q\ : std_logic;
SIGNAL \rjRegFile[1]~reg0_q\ : std_logic;
SIGNAL \rjRegFile[2]~reg0_q\ : std_logic;
SIGNAL \rjRegFile[3]~reg0_q\ : std_logic;
SIGNAL \rjRegFile[4]~reg0_q\ : std_logic;
SIGNAL \rkRegFile[0]~reg0_q\ : std_logic;
SIGNAL \rkRegFile[1]~reg0_q\ : std_logic;
SIGNAL \rkRegFile[2]~reg0_q\ : std_logic;
SIGNAL \rkRegFile[3]~reg0_q\ : std_logic;
SIGNAL \rkRegFile[4]~reg0_q\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \opCode[0]~reg0_q\ : std_logic;
SIGNAL \opCode[1]~reg0_q\ : std_logic;
SIGNAL \writeLine~0_combout\ : std_logic;
SIGNAL \writeLine[0]~reg0_q\ : std_logic;
SIGNAL \writeLine~1_combout\ : std_logic;
SIGNAL \writeLine[1]~reg0_q\ : std_logic;
SIGNAL \lineId~1_combout\ : std_logic;
SIGNAL \lineId~0_combout\ : std_logic;
SIGNAL \Decoder0~0_combout\ : std_logic;
SIGNAL \RSLineOneHot[0]~reg0_q\ : std_logic;
SIGNAL \Decoder0~1_combout\ : std_logic;
SIGNAL \RSLineOneHot[1]~reg0_q\ : std_logic;
SIGNAL \Decoder0~2_combout\ : std_logic;
SIGNAL \RSLineOneHot[2]~reg0_q\ : std_logic;
SIGNAL \Decoder0~3_combout\ : std_logic;
SIGNAL \RSLineOneHot[3]~reg0_q\ : std_logic;
SIGNAL \writeRS~0_combout\ : std_logic;
SIGNAL \writeRS~reg0_q\ : std_logic;
SIGNAL \instruction[0]~input_o\ : std_logic;
SIGNAL \writeAddr~0_combout\ : std_logic;
SIGNAL \writeAddr[0]~reg0_q\ : std_logic;
SIGNAL \instruction[1]~input_o\ : std_logic;
SIGNAL \writeAddr~1_combout\ : std_logic;
SIGNAL \writeAddr[1]~reg0_q\ : std_logic;
SIGNAL \instruction[2]~input_o\ : std_logic;
SIGNAL \writeAddr~2_combout\ : std_logic;
SIGNAL \writeAddr[2]~reg0_q\ : std_logic;
SIGNAL \instruction[3]~input_o\ : std_logic;
SIGNAL \writeAddr~3_combout\ : std_logic;
SIGNAL \writeAddr[3]~reg0_q\ : std_logic;
SIGNAL \instruction[4]~input_o\ : std_logic;
SIGNAL \writeAddr~4_combout\ : std_logic;
SIGNAL \writeAddr[4]~reg0_q\ : std_logic;
SIGNAL \writeData[0]~reg0_q\ : std_logic;
SIGNAL \writeData[1]~reg0_q\ : std_logic;
SIGNAL lineId : std_logic_vector(1 DOWNTO 0);
SIGNAL ALT_INV_lineId : std_logic_vector(1 DOWNTO 0);
SIGNAL \ALT_INV_Equal0~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL \ALT_INV_WideAnd0~combout\ : std_logic;
SIGNAL \ALT_INV_instruction[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[20]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[19]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[18]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[17]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[16]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[9]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[8]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[31]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[30]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[29]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[28]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[27]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[25]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[24]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[23]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[22]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[21]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[26]~input_o\ : std_logic;
SIGNAL \ALT_INV_instruction[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_busyRs[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_busyRs[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_busyRs[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_busyRs[0]~input_o\ : std_logic;

BEGIN

ww_clock <= clock;
ww_load <= load;
ww_instruction <= instruction;
ww_busyRs <= busyRs;
busy <= ww_busy;
rjMapFile <= ww_rjMapFile;
rkMapFile <= ww_rkMapFile;
rjRegFile <= ww_rjRegFile;
rkRegFile <= ww_rkRegFile;
opCode <= ww_opCode;
fuCode <= ww_fuCode;
fuCodeOneHot <= ww_fuCodeOneHot;
writeLine <= ww_writeLine;
RSLineOneHot <= ww_RSLineOneHot;
writeRS <= ww_writeRS;
writeAddr <= ww_writeAddr;
writeData <= ww_writeData;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
ALT_INV_lineId(0) <= NOT lineId(0);
ALT_INV_lineId(1) <= NOT lineId(1);
\ALT_INV_Equal0~1_combout\ <= NOT \Equal0~1_combout\;
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
\ALT_INV_WideAnd0~combout\ <= NOT \WideAnd0~combout\;
\ALT_INV_instruction[4]~input_o\ <= NOT \instruction[4]~input_o\;
\ALT_INV_instruction[3]~input_o\ <= NOT \instruction[3]~input_o\;
\ALT_INV_instruction[2]~input_o\ <= NOT \instruction[2]~input_o\;
\ALT_INV_instruction[1]~input_o\ <= NOT \instruction[1]~input_o\;
\ALT_INV_instruction[0]~input_o\ <= NOT \instruction[0]~input_o\;
\ALT_INV_instruction[20]~input_o\ <= NOT \instruction[20]~input_o\;
\ALT_INV_instruction[19]~input_o\ <= NOT \instruction[19]~input_o\;
\ALT_INV_instruction[18]~input_o\ <= NOT \instruction[18]~input_o\;
\ALT_INV_instruction[17]~input_o\ <= NOT \instruction[17]~input_o\;
\ALT_INV_instruction[16]~input_o\ <= NOT \instruction[16]~input_o\;
\ALT_INV_instruction[9]~input_o\ <= NOT \instruction[9]~input_o\;
\ALT_INV_instruction[8]~input_o\ <= NOT \instruction[8]~input_o\;
\ALT_INV_instruction[7]~input_o\ <= NOT \instruction[7]~input_o\;
\ALT_INV_instruction[6]~input_o\ <= NOT \instruction[6]~input_o\;
\ALT_INV_instruction[31]~input_o\ <= NOT \instruction[31]~input_o\;
\ALT_INV_instruction[30]~input_o\ <= NOT \instruction[30]~input_o\;
\ALT_INV_instruction[29]~input_o\ <= NOT \instruction[29]~input_o\;
\ALT_INV_instruction[28]~input_o\ <= NOT \instruction[28]~input_o\;
\ALT_INV_instruction[27]~input_o\ <= NOT \instruction[27]~input_o\;
\ALT_INV_instruction[25]~input_o\ <= NOT \instruction[25]~input_o\;
\ALT_INV_instruction[24]~input_o\ <= NOT \instruction[24]~input_o\;
\ALT_INV_instruction[23]~input_o\ <= NOT \instruction[23]~input_o\;
\ALT_INV_instruction[22]~input_o\ <= NOT \instruction[22]~input_o\;
\ALT_INV_instruction[21]~input_o\ <= NOT \instruction[21]~input_o\;
\ALT_INV_instruction[26]~input_o\ <= NOT \instruction[26]~input_o\;
\ALT_INV_instruction[5]~input_o\ <= NOT \instruction[5]~input_o\;
\ALT_INV_busyRs[2]~input_o\ <= NOT \busyRs[2]~input_o\;
\ALT_INV_busyRs[1]~input_o\ <= NOT \busyRs[1]~input_o\;
\ALT_INV_busyRs[3]~input_o\ <= NOT \busyRs[3]~input_o\;
\ALT_INV_busyRs[0]~input_o\ <= NOT \busyRs[0]~input_o\;

\busy~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \busy~reg0_q\,
	devoe => ww_devoe,
	o => \busy~output_o\);

\rjMapFile[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjMapFile[0]~reg0_q\,
	devoe => ww_devoe,
	o => \rjMapFile[0]~output_o\);

\rjMapFile[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjMapFile[1]~reg0_q\,
	devoe => ww_devoe,
	o => \rjMapFile[1]~output_o\);

\rjMapFile[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjMapFile[2]~reg0_q\,
	devoe => ww_devoe,
	o => \rjMapFile[2]~output_o\);

\rjMapFile[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjMapFile[3]~reg0_q\,
	devoe => ww_devoe,
	o => \rjMapFile[3]~output_o\);

\rjMapFile[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjMapFile[4]~reg0_q\,
	devoe => ww_devoe,
	o => \rjMapFile[4]~output_o\);

\rkMapFile[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkMapFile[0]~reg0_q\,
	devoe => ww_devoe,
	o => \rkMapFile[0]~output_o\);

\rkMapFile[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkMapFile[1]~reg0_q\,
	devoe => ww_devoe,
	o => \rkMapFile[1]~output_o\);

\rkMapFile[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkMapFile[2]~reg0_q\,
	devoe => ww_devoe,
	o => \rkMapFile[2]~output_o\);

\rkMapFile[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkMapFile[3]~reg0_q\,
	devoe => ww_devoe,
	o => \rkMapFile[3]~output_o\);

\rkMapFile[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkMapFile[4]~reg0_q\,
	devoe => ww_devoe,
	o => \rkMapFile[4]~output_o\);

\rjRegFile[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjRegFile[0]~reg0_q\,
	devoe => ww_devoe,
	o => \rjRegFile[0]~output_o\);

\rjRegFile[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjRegFile[1]~reg0_q\,
	devoe => ww_devoe,
	o => \rjRegFile[1]~output_o\);

\rjRegFile[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjRegFile[2]~reg0_q\,
	devoe => ww_devoe,
	o => \rjRegFile[2]~output_o\);

\rjRegFile[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjRegFile[3]~reg0_q\,
	devoe => ww_devoe,
	o => \rjRegFile[3]~output_o\);

\rjRegFile[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rjRegFile[4]~reg0_q\,
	devoe => ww_devoe,
	o => \rjRegFile[4]~output_o\);

\rkRegFile[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkRegFile[0]~reg0_q\,
	devoe => ww_devoe,
	o => \rkRegFile[0]~output_o\);

\rkRegFile[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkRegFile[1]~reg0_q\,
	devoe => ww_devoe,
	o => \rkRegFile[1]~output_o\);

\rkRegFile[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkRegFile[2]~reg0_q\,
	devoe => ww_devoe,
	o => \rkRegFile[2]~output_o\);

\rkRegFile[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkRegFile[3]~reg0_q\,
	devoe => ww_devoe,
	o => \rkRegFile[3]~output_o\);

\rkRegFile[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rkRegFile[4]~reg0_q\,
	devoe => ww_devoe,
	o => \rkRegFile[4]~output_o\);

\opCode[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \opCode[0]~reg0_q\,
	devoe => ww_devoe,
	o => \opCode[0]~output_o\);

\opCode[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \opCode[1]~reg0_q\,
	devoe => ww_devoe,
	o => \opCode[1]~output_o\);

\fuCode[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \fuCode[0]~output_o\);

\fuCode[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \fuCode[1]~output_o\);

\fuCodeOneHot[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \fuCodeOneHot[0]~output_o\);

\fuCodeOneHot[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \fuCodeOneHot[1]~output_o\);

\fuCodeOneHot[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \fuCodeOneHot[2]~output_o\);

\fuCodeOneHot[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \fuCodeOneHot[3]~output_o\);

\writeLine[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeLine[0]~reg0_q\,
	devoe => ww_devoe,
	o => \writeLine[0]~output_o\);

\writeLine[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeLine[1]~reg0_q\,
	devoe => ww_devoe,
	o => \writeLine[1]~output_o\);

\RSLineOneHot[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RSLineOneHot[0]~reg0_q\,
	devoe => ww_devoe,
	o => \RSLineOneHot[0]~output_o\);

\RSLineOneHot[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RSLineOneHot[1]~reg0_q\,
	devoe => ww_devoe,
	o => \RSLineOneHot[1]~output_o\);

\RSLineOneHot[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RSLineOneHot[2]~reg0_q\,
	devoe => ww_devoe,
	o => \RSLineOneHot[2]~output_o\);

\RSLineOneHot[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RSLineOneHot[3]~reg0_q\,
	devoe => ww_devoe,
	o => \RSLineOneHot[3]~output_o\);

\writeRS~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeRS~reg0_q\,
	devoe => ww_devoe,
	o => \writeRS~output_o\);

\writeAddr[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeAddr[0]~reg0_q\,
	devoe => ww_devoe,
	o => \writeAddr[0]~output_o\);

\writeAddr[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeAddr[1]~reg0_q\,
	devoe => ww_devoe,
	o => \writeAddr[1]~output_o\);

\writeAddr[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeAddr[2]~reg0_q\,
	devoe => ww_devoe,
	o => \writeAddr[2]~output_o\);

\writeAddr[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeAddr[3]~reg0_q\,
	devoe => ww_devoe,
	o => \writeAddr[3]~output_o\);

\writeAddr[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeAddr[4]~reg0_q\,
	devoe => ww_devoe,
	o => \writeAddr[4]~output_o\);

\writeData[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeData[0]~reg0_q\,
	devoe => ww_devoe,
	o => \writeData[0]~output_o\);

\writeData[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \writeData[1]~reg0_q\,
	devoe => ww_devoe,
	o => \writeData[1]~output_o\);

\writeData[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \writeData[2]~output_o\);

\writeData[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \writeData[3]~output_o\);

\clock~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

\busyRs[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_busyRs(0),
	o => \busyRs[0]~input_o\);

\busyRs[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_busyRs(3),
	o => \busyRs[3]~input_o\);

\busyRs[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_busyRs(1),
	o => \busyRs[1]~input_o\);

\busyRs[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_busyRs(2),
	o => \busyRs[2]~input_o\);

WideAnd0 : cyclonev_lcell_comb
-- Equation(s):
-- \WideAnd0~combout\ = (\busyRs[0]~input_o\ & (\busyRs[3]~input_o\ & (\busyRs[1]~input_o\ & \busyRs[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000001000000000000000100000000000000010000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[0]~input_o\,
	datab => \ALT_INV_busyRs[3]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	combout => \WideAnd0~combout\);

\load~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load,
	o => \load~input_o\);

\busy~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \WideAnd0~combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \busy~reg0_q\);

\instruction[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(5),
	o => \instruction[5]~input_o\);

\instruction[26]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(26),
	o => \instruction[26]~input_o\);

\instruction[21]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(21),
	o => \instruction[21]~input_o\);

\instruction[22]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(22),
	o => \instruction[22]~input_o\);

\instruction[23]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(23),
	o => \instruction[23]~input_o\);

\instruction[24]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(24),
	o => \instruction[24]~input_o\);

\instruction[25]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(25),
	o => \instruction[25]~input_o\);

\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( \instruction[25]~input_o\ & ( (!\instruction[21]~input_o\ & (!\instruction[22]~input_o\ & (!\instruction[23]~input_o\ & \instruction[24]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000001000000000000000000000000000000010000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[21]~input_o\,
	datab => \ALT_INV_instruction[22]~input_o\,
	datac => \ALT_INV_instruction[23]~input_o\,
	datad => \ALT_INV_instruction[24]~input_o\,
	datae => \ALT_INV_instruction[25]~input_o\,
	combout => \Equal0~0_combout\);

\instruction[27]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(27),
	o => \instruction[27]~input_o\);

\instruction[28]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(28),
	o => \instruction[28]~input_o\);

\instruction[29]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(29),
	o => \instruction[29]~input_o\);

\instruction[30]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(30),
	o => \instruction[30]~input_o\);

\instruction[31]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(31),
	o => \instruction[31]~input_o\);

\Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = ( \instruction[31]~input_o\ & ( (\instruction[27]~input_o\ & (!\instruction[28]~input_o\ & (!\instruction[29]~input_o\ & !\instruction[30]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010000000000000000000000000000000100000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[27]~input_o\,
	datab => \ALT_INV_instruction[28]~input_o\,
	datac => \ALT_INV_instruction[29]~input_o\,
	datad => \ALT_INV_instruction[30]~input_o\,
	datae => \ALT_INV_instruction[31]~input_o\,
	combout => \Equal0~1_combout\);

\rj~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~0_combout\ = (\instruction[5]~input_o\ & (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & \Equal0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000100000000000000010000000000000001000000000000000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[5]~input_o\,
	datab => \ALT_INV_instruction[26]~input_o\,
	datac => \ALT_INV_Equal0~0_combout\,
	datad => \ALT_INV_Equal0~1_combout\,
	combout => \rj~0_combout\);

\rjMapFile[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[0]~reg0_q\);

\instruction[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(6),
	o => \instruction[6]~input_o\);

\rj~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~1_combout\ = (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[6]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[6]~input_o\,
	combout => \rj~1_combout\);

\rjMapFile[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[1]~reg0_q\);

\instruction[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(7),
	o => \instruction[7]~input_o\);

\rj~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~2_combout\ = (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[7]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[7]~input_o\,
	combout => \rj~2_combout\);

\rjMapFile[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[2]~reg0_q\);

\instruction[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(8),
	o => \instruction[8]~input_o\);

\rj~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~3_combout\ = (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[8]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[8]~input_o\,
	combout => \rj~3_combout\);

\rjMapFile[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~3_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[3]~reg0_q\);

\instruction[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(9),
	o => \instruction[9]~input_o\);

\rj~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~4_combout\ = (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[9]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[9]~input_o\,
	combout => \rj~4_combout\);

\rjMapFile[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~4_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[4]~reg0_q\);

\instruction[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(16),
	o => \instruction[16]~input_o\);

\rk~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~0_combout\ = (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[16]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[16]~input_o\,
	combout => \rk~0_combout\);

\rkMapFile[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[0]~reg0_q\);

\instruction[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(17),
	o => \instruction[17]~input_o\);

\rk~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~1_combout\ = (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[17]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[17]~input_o\,
	combout => \rk~1_combout\);

\rkMapFile[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[1]~reg0_q\);

\instruction[18]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(18),
	o => \instruction[18]~input_o\);

\rk~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~2_combout\ = (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[18]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[18]~input_o\,
	combout => \rk~2_combout\);

\rkMapFile[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[2]~reg0_q\);

\instruction[19]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(19),
	o => \instruction[19]~input_o\);

\rk~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~3_combout\ = (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[19]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[19]~input_o\,
	combout => \rk~3_combout\);

\rkMapFile[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~3_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[3]~reg0_q\);

\instruction[20]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(20),
	o => \instruction[20]~input_o\);

\rk~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~4_combout\ = (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[20]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[20]~input_o\,
	combout => \rk~4_combout\);

\rkMapFile[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~4_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[4]~reg0_q\);

\rjRegFile[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[0]~reg0_q\);

\rjRegFile[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[1]~reg0_q\);

\rjRegFile[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[2]~reg0_q\);

\rjRegFile[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~3_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[3]~reg0_q\);

\rjRegFile[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rj~4_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[4]~reg0_q\);

\rkRegFile[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[0]~reg0_q\);

\rkRegFile[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[1]~reg0_q\);

\rkRegFile[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[2]~reg0_q\);

\rkRegFile[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~3_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[3]~reg0_q\);

\rkRegFile[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \rk~4_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[4]~reg0_q\);

\Equal0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = ((!\Equal0~0_combout\) # (!\Equal0~1_combout\)) # (\instruction[26]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111110111111101111111011111110111111101111111011111110111111101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	combout => \Equal0~2_combout\);

\opCode[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \Equal0~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \opCode[0]~reg0_q\);

\opCode[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \Equal0~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \opCode[1]~reg0_q\);

\writeLine~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeLine~0_combout\ = (\busyRs[3]~input_o\ & ((!\busyRs[2]~input_o\) # ((!\busyRs[0]~input_o\ & \busyRs[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100000010001100110000001000110011000000100011001100000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[0]~input_o\,
	datab => \ALT_INV_busyRs[3]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	combout => \writeLine~0_combout\);

\writeLine[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \writeLine~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeLine[0]~reg0_q\);

\writeLine~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeLine~1_combout\ = (\busyRs[3]~input_o\ & ((!\busyRs[1]~input_o\) # (!\busyRs[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010001010100010101000101010001010100010101000101010001010100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[3]~input_o\,
	datab => \ALT_INV_busyRs[1]~input_o\,
	datac => \ALT_INV_busyRs[2]~input_o\,
	combout => \writeLine~1_combout\);

\writeLine[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \writeLine~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeLine[1]~reg0_q\);

\lineId~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \lineId~1_combout\ = ( lineId(1) & ( (\busyRs[3]~input_o\ & (((!\busyRs[1]~input_o\) # (!\busyRs[2]~input_o\)) # (\busyRs[0]~input_o\))) ) ) # ( !lineId(1) & ( (\busyRs[3]~input_o\ & ((!\busyRs[1]~input_o\) # (!\busyRs[2]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110000001100110011000100110011001100000011001100110001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[0]~input_o\,
	datab => \ALT_INV_busyRs[3]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	datae => ALT_INV_lineId(1),
	combout => \lineId~1_combout\);

\lineId[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \lineId~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => lineId(1));

\lineId~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \lineId~0_combout\ = ( lineId(0) & ( (\busyRs[3]~input_o\ & ((!\busyRs[2]~input_o\) # (\busyRs[1]~input_o\))) ) ) # ( !lineId(0) & ( (\busyRs[3]~input_o\ & ((!\busyRs[2]~input_o\) # ((!\busyRs[0]~input_o\ & \busyRs[1]~input_o\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100000010001100110000001100110011000000100011001100000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[0]~input_o\,
	datab => \ALT_INV_busyRs[3]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	datae => ALT_INV_lineId(0),
	combout => \lineId~0_combout\);

\lineId[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \lineId~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => lineId(0));

\Decoder0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Decoder0~0_combout\ = ( lineId(1) & ( lineId(0) & ( (!\busyRs[0]~input_o\ & (\busyRs[3]~input_o\ & (\busyRs[1]~input_o\ & \busyRs[2]~input_o\))) ) ) ) # ( !lineId(1) & ( lineId(0) & ( (\busyRs[3]~input_o\ & (\busyRs[1]~input_o\ & \busyRs[2]~input_o\)) ) 
-- ) ) # ( lineId(1) & ( !lineId(0) & ( (!\busyRs[0]~input_o\ & (\busyRs[3]~input_o\ & (\busyRs[1]~input_o\ & \busyRs[2]~input_o\))) ) ) ) # ( !lineId(1) & ( !lineId(0) & ( (!\busyRs[0]~input_o\ & (\busyRs[3]~input_o\ & (\busyRs[1]~input_o\ & 
-- \busyRs[2]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000110000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[0]~input_o\,
	datab => \ALT_INV_busyRs[3]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	datae => ALT_INV_lineId(1),
	dataf => ALT_INV_lineId(0),
	combout => \Decoder0~0_combout\);

\RSLineOneHot[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \Decoder0~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RSLineOneHot[0]~reg0_q\);

\Decoder0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Decoder0~1_combout\ = ( lineId(1) & ( lineId(0) & ( (\busyRs[3]~input_o\ & (!\busyRs[1]~input_o\ & \busyRs[2]~input_o\)) ) ) ) # ( !lineId(1) & ( lineId(0) & ( (\busyRs[3]~input_o\ & (!\busyRs[1]~input_o\ & \busyRs[2]~input_o\)) ) ) ) # ( lineId(1) & ( 
-- !lineId(0) & ( (\busyRs[3]~input_o\ & (\busyRs[2]~input_o\ & ((!\busyRs[1]~input_o\) # (\busyRs[0]~input_o\)))) ) ) ) # ( !lineId(1) & ( !lineId(0) & ( (\busyRs[3]~input_o\ & (!\busyRs[1]~input_o\ & \busyRs[2]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110000000000000011000100000000001100000000000000110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[0]~input_o\,
	datab => \ALT_INV_busyRs[3]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	datae => ALT_INV_lineId(1),
	dataf => ALT_INV_lineId(0),
	combout => \Decoder0~1_combout\);

\RSLineOneHot[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \Decoder0~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RSLineOneHot[1]~reg0_q\);

\Decoder0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Decoder0~2_combout\ = ( lineId(1) & ( lineId(0) & ( (\busyRs[3]~input_o\ & ((!\busyRs[2]~input_o\) # ((\busyRs[0]~input_o\ & \busyRs[1]~input_o\)))) ) ) ) # ( !lineId(1) & ( lineId(0) & ( (\busyRs[3]~input_o\ & !\busyRs[2]~input_o\) ) ) ) # ( lineId(1) & 
-- ( !lineId(0) & ( (\busyRs[3]~input_o\ & !\busyRs[2]~input_o\) ) ) ) # ( !lineId(1) & ( !lineId(0) & ( (\busyRs[3]~input_o\ & !\busyRs[2]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100000000001100110000000000110011000000000011001100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[0]~input_o\,
	datab => \ALT_INV_busyRs[3]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	datae => ALT_INV_lineId(1),
	dataf => ALT_INV_lineId(0),
	combout => \Decoder0~2_combout\);

\RSLineOneHot[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \Decoder0~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RSLineOneHot[2]~reg0_q\);

\Decoder0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Decoder0~3_combout\ = ( lineId(1) & ( lineId(0) & ( !\busyRs[3]~input_o\ ) ) ) # ( !lineId(1) & ( lineId(0) & ( !\busyRs[3]~input_o\ ) ) ) # ( lineId(1) & ( !lineId(0) & ( !\busyRs[3]~input_o\ ) ) ) # ( !lineId(1) & ( !lineId(0) & ( 
-- (!\busyRs[3]~input_o\) # ((\busyRs[0]~input_o\ & (\busyRs[1]~input_o\ & \busyRs[2]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100110011001101110011001100110011001100110011001100110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[0]~input_o\,
	datab => \ALT_INV_busyRs[3]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	datae => ALT_INV_lineId(1),
	dataf => ALT_INV_lineId(0),
	combout => \Decoder0~3_combout\);

\RSLineOneHot[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \Decoder0~3_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RSLineOneHot[3]~reg0_q\);

\writeRS~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeRS~0_combout\ = !\WideAnd0~combout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_WideAnd0~combout\,
	combout => \writeRS~0_combout\);

\writeRS~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \writeRS~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeRS~reg0_q\);

\instruction[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(0),
	o => \instruction[0]~input_o\);

\writeAddr~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~0_combout\ = ( !\WideAnd0~combout\ & ( (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[0]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000000000000000000000100000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_instruction[0]~input_o\,
	datae => \ALT_INV_WideAnd0~combout\,
	combout => \writeAddr~0_combout\);

\writeAddr[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \writeAddr~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[0]~reg0_q\);

\instruction[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(1),
	o => \instruction[1]~input_o\);

\writeAddr~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~1_combout\ = ( \instruction[1]~input_o\ & ( (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & !\WideAnd0~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000100000000000000000000000000000001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_WideAnd0~combout\,
	datae => \ALT_INV_instruction[1]~input_o\,
	combout => \writeAddr~1_combout\);

\writeAddr[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \writeAddr~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[1]~reg0_q\);

\instruction[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(2),
	o => \instruction[2]~input_o\);

\writeAddr~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~2_combout\ = ( \instruction[2]~input_o\ & ( (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & !\WideAnd0~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000100000000000000000000000000000001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_WideAnd0~combout\,
	datae => \ALT_INV_instruction[2]~input_o\,
	combout => \writeAddr~2_combout\);

\writeAddr[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \writeAddr~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[2]~reg0_q\);

\instruction[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(3),
	o => \instruction[3]~input_o\);

\writeAddr~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~3_combout\ = ( \instruction[3]~input_o\ & ( (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & !\WideAnd0~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000100000000000000000000000000000001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_WideAnd0~combout\,
	datae => \ALT_INV_instruction[3]~input_o\,
	combout => \writeAddr~3_combout\);

\writeAddr[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \writeAddr~3_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[3]~reg0_q\);

\instruction[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(4),
	o => \instruction[4]~input_o\);

\writeAddr~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~4_combout\ = ( \instruction[4]~input_o\ & ( (!\instruction[26]~input_o\ & (\Equal0~0_combout\ & (\Equal0~1_combout\ & !\WideAnd0~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000100000000000000000000000000000001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[26]~input_o\,
	datab => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datad => \ALT_INV_WideAnd0~combout\,
	datae => \ALT_INV_instruction[4]~input_o\,
	combout => \writeAddr~4_combout\);

\writeAddr[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \writeAddr~4_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[4]~reg0_q\);

\writeData[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \lineId~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeData[0]~reg0_q\);

\writeData[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \lineId~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeData[1]~reg0_q\);

\instruction[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(10),
	o => \instruction[10]~input_o\);

\instruction[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(11),
	o => \instruction[11]~input_o\);

\instruction[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(12),
	o => \instruction[12]~input_o\);

\instruction[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(13),
	o => \instruction[13]~input_o\);

\instruction[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(14),
	o => \instruction[14]~input_o\);

\instruction[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(15),
	o => \instruction[15]~input_o\);

ww_busy <= \busy~output_o\;

ww_rjMapFile(0) <= \rjMapFile[0]~output_o\;

ww_rjMapFile(1) <= \rjMapFile[1]~output_o\;

ww_rjMapFile(2) <= \rjMapFile[2]~output_o\;

ww_rjMapFile(3) <= \rjMapFile[3]~output_o\;

ww_rjMapFile(4) <= \rjMapFile[4]~output_o\;

ww_rkMapFile(0) <= \rkMapFile[0]~output_o\;

ww_rkMapFile(1) <= \rkMapFile[1]~output_o\;

ww_rkMapFile(2) <= \rkMapFile[2]~output_o\;

ww_rkMapFile(3) <= \rkMapFile[3]~output_o\;

ww_rkMapFile(4) <= \rkMapFile[4]~output_o\;

ww_rjRegFile(0) <= \rjRegFile[0]~output_o\;

ww_rjRegFile(1) <= \rjRegFile[1]~output_o\;

ww_rjRegFile(2) <= \rjRegFile[2]~output_o\;

ww_rjRegFile(3) <= \rjRegFile[3]~output_o\;

ww_rjRegFile(4) <= \rjRegFile[4]~output_o\;

ww_rkRegFile(0) <= \rkRegFile[0]~output_o\;

ww_rkRegFile(1) <= \rkRegFile[1]~output_o\;

ww_rkRegFile(2) <= \rkRegFile[2]~output_o\;

ww_rkRegFile(3) <= \rkRegFile[3]~output_o\;

ww_rkRegFile(4) <= \rkRegFile[4]~output_o\;

ww_opCode(0) <= \opCode[0]~output_o\;

ww_opCode(1) <= \opCode[1]~output_o\;

ww_fuCode(0) <= \fuCode[0]~output_o\;

ww_fuCode(1) <= \fuCode[1]~output_o\;

ww_fuCodeOneHot(0) <= \fuCodeOneHot[0]~output_o\;

ww_fuCodeOneHot(1) <= \fuCodeOneHot[1]~output_o\;

ww_fuCodeOneHot(2) <= \fuCodeOneHot[2]~output_o\;

ww_fuCodeOneHot(3) <= \fuCodeOneHot[3]~output_o\;

ww_writeLine(0) <= \writeLine[0]~output_o\;

ww_writeLine(1) <= \writeLine[1]~output_o\;

ww_RSLineOneHot(0) <= \RSLineOneHot[0]~output_o\;

ww_RSLineOneHot(1) <= \RSLineOneHot[1]~output_o\;

ww_RSLineOneHot(2) <= \RSLineOneHot[2]~output_o\;

ww_RSLineOneHot(3) <= \RSLineOneHot[3]~output_o\;

ww_writeRS <= \writeRS~output_o\;

ww_writeAddr(0) <= \writeAddr[0]~output_o\;

ww_writeAddr(1) <= \writeAddr[1]~output_o\;

ww_writeAddr(2) <= \writeAddr[2]~output_o\;

ww_writeAddr(3) <= \writeAddr[3]~output_o\;

ww_writeAddr(4) <= \writeAddr[4]~output_o\;

ww_writeData(0) <= \writeData[0]~output_o\;

ww_writeData(1) <= \writeData[1]~output_o\;

ww_writeData(2) <= \writeData[2]~output_o\;

ww_writeData(3) <= \writeData[3]~output_o\;
END structure;


