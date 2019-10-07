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

-- DATE "10/07/2019 10:51:48"

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

-- Design Ports Information
-- instruction[10]	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[11]	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[12]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[13]	=>  Location: PIN_R1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[14]	=>  Location: PIN_D8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[15]	=>  Location: PIN_E16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- busy	=>  Location: PIN_F3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjMapFile[0]	=>  Location: PIN_T2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjMapFile[1]	=>  Location: PIN_R10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjMapFile[2]	=>  Location: PIN_F14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjMapFile[3]	=>  Location: PIN_R9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjMapFile[4]	=>  Location: PIN_T10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkMapFile[0]	=>  Location: PIN_J14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkMapFile[1]	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkMapFile[2]	=>  Location: PIN_R4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkMapFile[3]	=>  Location: PIN_T12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkMapFile[4]	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjRegFile[0]	=>  Location: PIN_P8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjRegFile[1]	=>  Location: PIN_R6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjRegFile[2]	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjRegFile[3]	=>  Location: PIN_T7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rjRegFile[4]	=>  Location: PIN_N3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkRegFile[0]	=>  Location: PIN_K15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkRegFile[1]	=>  Location: PIN_P2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkRegFile[2]	=>  Location: PIN_M7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkRegFile[3]	=>  Location: PIN_T13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rkRegFile[4]	=>  Location: PIN_T3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opCode[0]	=>  Location: PIN_R2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opCode[1]	=>  Location: PIN_P3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fuCode[0]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fuCode[1]	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fuCodeOneHot[0]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fuCodeOneHot[1]	=>  Location: PIN_F7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fuCodeOneHot[2]	=>  Location: PIN_P11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fuCodeOneHot[3]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeLine[0]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeLine[1]	=>  Location: PIN_H1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RSLineOneHot[0]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RSLineOneHot[1]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RSLineOneHot[2]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RSLineOneHot[3]	=>  Location: PIN_K14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeRS	=>  Location: PIN_H5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeAddr[0]	=>  Location: PIN_H3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeAddr[1]	=>  Location: PIN_J3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeAddr[2]	=>  Location: PIN_F4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeAddr[3]	=>  Location: PIN_G2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeAddr[4]	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeData[0]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeData[1]	=>  Location: PIN_H15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeData[2]	=>  Location: PIN_A14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- writeData[3]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- busyRs[2]	=>  Location: PIN_G3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- busyRs[3]	=>  Location: PIN_F12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- busyRs[0]	=>  Location: PIN_G13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- busyRs[1]	=>  Location: PIN_K5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_G12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[5]	=>  Location: PIN_R11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[26]	=>  Location: PIN_P1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[21]	=>  Location: PIN_K4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[22]	=>  Location: PIN_H4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[23]	=>  Location: PIN_B15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[24]	=>  Location: PIN_K16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[25]	=>  Location: PIN_J2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[27]	=>  Location: PIN_M10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[28]	=>  Location: PIN_R15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[29]	=>  Location: PIN_M13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[30]	=>  Location: PIN_N14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[31]	=>  Location: PIN_L10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[6]	=>  Location: PIN_T8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[7]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[8]	=>  Location: PIN_T4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[9]	=>  Location: PIN_R12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[16]	=>  Location: PIN_E2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[17]	=>  Location: PIN_P9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[18]	=>  Location: PIN_P7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[19]	=>  Location: PIN_T5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[20]	=>  Location: PIN_R7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[0]	=>  Location: PIN_G1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[1]	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[2]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[3]	=>  Location: PIN_E12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- instruction[4]	=>  Location: PIN_B16,	 I/O Standard: 2.5 V,	 Current Strength: Default


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
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputCLKENA0_outclk\ : std_logic;
SIGNAL \busyRs[2]~input_o\ : std_logic;
SIGNAL \busyRs[1]~input_o\ : std_logic;
SIGNAL \busyRs[3]~input_o\ : std_logic;
SIGNAL \busyRs[0]~input_o\ : std_logic;
SIGNAL \WideAnd0~combout\ : std_logic;
SIGNAL \load~input_o\ : std_logic;
SIGNAL \busy~reg0_q\ : std_logic;
SIGNAL \instruction[5]~input_o\ : std_logic;
SIGNAL \instruction[26]~input_o\ : std_logic;
SIGNAL \instruction[28]~input_o\ : std_logic;
SIGNAL \instruction[30]~input_o\ : std_logic;
SIGNAL \instruction[31]~input_o\ : std_logic;
SIGNAL \instruction[27]~input_o\ : std_logic;
SIGNAL \instruction[29]~input_o\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \instruction[22]~input_o\ : std_logic;
SIGNAL \instruction[23]~input_o\ : std_logic;
SIGNAL \instruction[21]~input_o\ : std_logic;
SIGNAL \instruction[25]~input_o\ : std_logic;
SIGNAL \instruction[24]~input_o\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
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
SIGNAL \WideAnd0~0_combout\ : std_logic;
SIGNAL \writeLine[1]~reg0_q\ : std_logic;
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
SIGNAL \lineId~0_combout\ : std_logic;
SIGNAL \writeData[0]~reg0_q\ : std_logic;
SIGNAL \lineId~1_combout\ : std_logic;
SIGNAL \writeData[1]~reg0_q\ : std_logic;
SIGNAL lineId : std_logic_vector(1 DOWNTO 0);
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
SIGNAL \ALT_INV_busyRs[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_busyRs[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_busyRs[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_busyRs[2]~input_o\ : std_logic;
SIGNAL ALT_INV_lineId : std_logic_vector(1 DOWNTO 0);
SIGNAL \ALT_INV_Equal0~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL \ALT_INV_WideAnd0~combout\ : std_logic;

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
\ALT_INV_busyRs[1]~input_o\ <= NOT \busyRs[1]~input_o\;
\ALT_INV_busyRs[0]~input_o\ <= NOT \busyRs[0]~input_o\;
\ALT_INV_busyRs[3]~input_o\ <= NOT \busyRs[3]~input_o\;
\ALT_INV_busyRs[2]~input_o\ <= NOT \busyRs[2]~input_o\;
ALT_INV_lineId(1) <= NOT lineId(1);
ALT_INV_lineId(0) <= NOT lineId(0);
\ALT_INV_Equal0~1_combout\ <= NOT \Equal0~1_combout\;
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
\ALT_INV_WideAnd0~combout\ <= NOT \WideAnd0~combout\;

-- Location: IOOBUF_X0_Y21_N56
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
	o => ww_busy);

-- Location: IOOBUF_X12_Y0_N53
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
	o => ww_rjMapFile(0));

-- Location: IOOBUF_X29_Y0_N36
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
	o => ww_rjMapFile(1));

-- Location: IOOBUF_X54_Y21_N5
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
	o => ww_rjMapFile(2));

-- Location: IOOBUF_X29_Y0_N19
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
	o => ww_rjMapFile(3));

-- Location: IOOBUF_X29_Y0_N53
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
	o => ww_rjMapFile(4));

-- Location: IOOBUF_X54_Y17_N39
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
	o => ww_rkMapFile(0));

-- Location: IOOBUF_X24_Y0_N19
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
	o => ww_rkMapFile(1));

-- Location: IOOBUF_X14_Y0_N36
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
	o => ww_rkMapFile(2));

-- Location: IOOBUF_X25_Y0_N19
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
	o => ww_rkMapFile(3));

-- Location: IOOBUF_X24_Y0_N2
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
	o => ww_rkMapFile(4));

-- Location: IOOBUF_X23_Y0_N42
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
	o => ww_rjRegFile(0));

-- Location: IOOBUF_X14_Y0_N19
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
	o => ww_rjRegFile(1));

-- Location: IOOBUF_X0_Y20_N39
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
	o => ww_rjRegFile(2));

-- Location: IOOBUF_X24_Y0_N53
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
	o => ww_rjRegFile(3));

-- Location: IOOBUF_X12_Y0_N2
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
	o => ww_rjRegFile(4));

-- Location: IOOBUF_X54_Y17_N5
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
	o => ww_rkRegFile(0));

-- Location: IOOBUF_X11_Y0_N36
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
	o => ww_rkRegFile(1));

-- Location: IOOBUF_X11_Y0_N19
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
	o => ww_rkRegFile(2));

-- Location: IOOBUF_X25_Y0_N2
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
	o => ww_rkRegFile(3));

-- Location: IOOBUF_X14_Y0_N53
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
	o => ww_rkRegFile(4));

-- Location: IOOBUF_X12_Y0_N36
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
	o => ww_opCode(0));

-- Location: IOOBUF_X12_Y0_N19
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
	o => ww_opCode(1));

-- Location: IOOBUF_X32_Y45_N93
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
	o => ww_fuCode(0));

-- Location: IOOBUF_X18_Y45_N19
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
	o => ww_fuCode(1));

-- Location: IOOBUF_X16_Y45_N59
\fuCodeOneHot[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_fuCodeOneHot(0));

-- Location: IOOBUF_X22_Y45_N19
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
	o => ww_fuCodeOneHot(1));

-- Location: IOOBUF_X38_Y0_N19
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
	o => ww_fuCodeOneHot(2));

-- Location: IOOBUF_X33_Y0_N76
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
	o => ww_fuCodeOneHot(3));

-- Location: IOOBUF_X54_Y19_N56
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
	o => ww_writeLine(0));

-- Location: IOOBUF_X0_Y18_N96
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
	o => ww_writeLine(1));

-- Location: IOOBUF_X32_Y45_N76
\RSLineOneHot[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_RSLineOneHot(0));

-- Location: IOOBUF_X20_Y45_N2
\RSLineOneHot[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_RSLineOneHot(1));

-- Location: IOOBUF_X20_Y45_N36
\RSLineOneHot[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_RSLineOneHot(2));

-- Location: IOOBUF_X54_Y14_N62
\RSLineOneHot[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_RSLineOneHot(3));

-- Location: IOOBUF_X0_Y20_N5
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
	o => ww_writeRS);

-- Location: IOOBUF_X0_Y21_N5
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
	o => ww_writeAddr(0));

-- Location: IOOBUF_X0_Y19_N5
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
	o => ww_writeAddr(1));

-- Location: IOOBUF_X0_Y21_N39
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
	o => ww_writeAddr(2));

-- Location: IOOBUF_X0_Y19_N39
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
	o => ww_writeAddr(3));

-- Location: IOOBUF_X10_Y0_N59
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
	o => ww_writeAddr(4));

-- Location: IOOBUF_X54_Y21_N56
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
	o => ww_writeData(0));

-- Location: IOOBUF_X54_Y17_N56
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
	o => ww_writeData(1));

-- Location: IOOBUF_X38_Y45_N53
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
	o => ww_writeData(2));

-- Location: IOOBUF_X34_Y45_N53
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
	o => ww_writeData(3));

-- Location: IOIBUF_X54_Y18_N61
\clock~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G9
\clock~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clock~input_o\,
	outclk => \clock~inputCLKENA0_outclk\);

-- Location: IOIBUF_X0_Y21_N21
\busyRs[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_busyRs(2),
	o => \busyRs[2]~input_o\);

-- Location: IOIBUF_X0_Y18_N44
\busyRs[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_busyRs(1),
	o => \busyRs[1]~input_o\);

-- Location: IOIBUF_X54_Y18_N44
\busyRs[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_busyRs(3),
	o => \busyRs[3]~input_o\);

-- Location: IOIBUF_X54_Y20_N21
\busyRs[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_busyRs(0),
	o => \busyRs[0]~input_o\);

-- Location: LABCELL_X6_Y19_N36
WideAnd0 : cyclonev_lcell_comb
-- Equation(s):
-- \WideAnd0~combout\ = ( \busyRs[0]~input_o\ & ( (\busyRs[2]~input_o\ & (\busyRs[1]~input_o\ & \busyRs[3]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000001000000010000000100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[2]~input_o\,
	datab => \ALT_INV_busyRs[1]~input_o\,
	datac => \ALT_INV_busyRs[3]~input_o\,
	dataf => \ALT_INV_busyRs[0]~input_o\,
	combout => \WideAnd0~combout\);

-- Location: IOIBUF_X11_Y0_N1
\load~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load,
	o => \load~input_o\);

-- Location: FF_X6_Y19_N13
\busy~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \WideAnd0~combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \busy~reg0_q\);

-- Location: IOIBUF_X25_Y0_N52
\instruction[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(5),
	o => \instruction[5]~input_o\);

-- Location: IOIBUF_X10_Y0_N75
\instruction[26]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(26),
	o => \instruction[26]~input_o\);

-- Location: IOIBUF_X33_Y0_N92
\instruction[28]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(28),
	o => \instruction[28]~input_o\);

-- Location: IOIBUF_X34_Y0_N35
\instruction[30]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(30),
	o => \instruction[30]~input_o\);

-- Location: IOIBUF_X34_Y0_N1
\instruction[31]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(31),
	o => \instruction[31]~input_o\);

-- Location: IOIBUF_X34_Y0_N18
\instruction[27]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(27),
	o => \instruction[27]~input_o\);

-- Location: IOIBUF_X34_Y0_N52
\instruction[29]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(29),
	o => \instruction[29]~input_o\);

-- Location: MLABCELL_X34_Y2_N39
\Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = ( \instruction[27]~input_o\ & ( !\instruction[29]~input_o\ & ( (!\instruction[28]~input_o\ & (!\instruction[30]~input_o\ & \instruction[31]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000010000000100000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[28]~input_o\,
	datab => \ALT_INV_instruction[30]~input_o\,
	datac => \ALT_INV_instruction[31]~input_o\,
	datae => \ALT_INV_instruction[27]~input_o\,
	dataf => \ALT_INV_instruction[29]~input_o\,
	combout => \Equal0~1_combout\);

-- Location: IOIBUF_X0_Y20_N21
\instruction[22]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(22),
	o => \instruction[22]~input_o\);

-- Location: IOIBUF_X54_Y20_N38
\instruction[23]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(23),
	o => \instruction[23]~input_o\);

-- Location: IOIBUF_X0_Y18_N61
\instruction[21]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(21),
	o => \instruction[21]~input_o\);

-- Location: IOIBUF_X0_Y19_N21
\instruction[25]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(25),
	o => \instruction[25]~input_o\);

-- Location: IOIBUF_X54_Y17_N21
\instruction[24]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(24),
	o => \instruction[24]~input_o\);

-- Location: LABCELL_X6_Y19_N27
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( \instruction[24]~input_o\ & ( (!\instruction[22]~input_o\ & (!\instruction[23]~input_o\ & (!\instruction[21]~input_o\ & \instruction[25]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000001000000000000000000000000000000010000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[22]~input_o\,
	datab => \ALT_INV_instruction[23]~input_o\,
	datac => \ALT_INV_instruction[21]~input_o\,
	datad => \ALT_INV_instruction[25]~input_o\,
	datae => \ALT_INV_instruction[24]~input_o\,
	combout => \Equal0~0_combout\);

-- Location: MLABCELL_X18_Y2_N51
\rj~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~0_combout\ = ( \Equal0~0_combout\ & ( (\instruction[5]~input_o\ & (!\instruction[26]~input_o\ & \Equal0~1_combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000001000000010000000000000000000000010000000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[5]~input_o\,
	datab => \ALT_INV_instruction[26]~input_o\,
	datac => \ALT_INV_Equal0~1_combout\,
	datae => \ALT_INV_Equal0~0_combout\,
	combout => \rj~0_combout\);

-- Location: FF_X18_Y2_N49
\rjMapFile[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rj~0_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[0]~reg0_q\);

-- Location: IOIBUF_X24_Y0_N35
\instruction[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(6),
	o => \instruction[6]~input_o\);

-- Location: MLABCELL_X18_Y2_N42
\rj~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~1_combout\ = ( \Equal0~1_combout\ & ( (\instruction[6]~input_o\ & (\Equal0~0_combout\ & !\instruction[26]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000110000000000000000000000000000001100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_instruction[6]~input_o\,
	datac => \ALT_INV_Equal0~0_combout\,
	datad => \ALT_INV_instruction[26]~input_o\,
	datae => \ALT_INV_Equal0~1_combout\,
	combout => \rj~1_combout\);

-- Location: FF_X18_Y2_N46
\rjMapFile[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rj~1_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[1]~reg0_q\);

-- Location: IOIBUF_X54_Y19_N21
\instruction[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(7),
	o => \instruction[7]~input_o\);

-- Location: LABCELL_X6_Y19_N3
\rj~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~2_combout\ = ( \instruction[7]~input_o\ & ( (\Equal0~0_combout\ & (\Equal0~1_combout\ & !\instruction[26]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000010000000100000001000000010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~0_combout\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_instruction[26]~input_o\,
	dataf => \ALT_INV_instruction[7]~input_o\,
	combout => \rj~2_combout\);

-- Location: FF_X6_Y19_N22
\rjMapFile[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rj~2_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[2]~reg0_q\);

-- Location: IOIBUF_X23_Y0_N75
\instruction[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(8),
	o => \instruction[8]~input_o\);

-- Location: MLABCELL_X18_Y2_N27
\rj~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~3_combout\ = ( !\instruction[26]~input_o\ & ( (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[8]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000000000000000000000001000000010000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~0_combout\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_instruction[8]~input_o\,
	datae => \ALT_INV_instruction[26]~input_o\,
	combout => \rj~3_combout\);

-- Location: FF_X18_Y2_N25
\rjMapFile[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rj~3_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[3]~reg0_q\);

-- Location: IOIBUF_X25_Y0_N35
\instruction[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(9),
	o => \instruction[9]~input_o\);

-- Location: MLABCELL_X18_Y2_N57
\rj~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \rj~4_combout\ = ( !\instruction[26]~input_o\ & ( \instruction[9]~input_o\ & ( (\Equal0~0_combout\ & \Equal0~1_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000101000001010000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datae => \ALT_INV_instruction[26]~input_o\,
	dataf => \ALT_INV_instruction[9]~input_o\,
	combout => \rj~4_combout\);

-- Location: FF_X18_Y2_N55
\rjMapFile[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rj~4_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjMapFile[4]~reg0_q\);

-- Location: IOIBUF_X0_Y20_N55
\instruction[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(16),
	o => \instruction[16]~input_o\);

-- Location: LABCELL_X6_Y19_N45
\rk~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~0_combout\ = ( \Equal0~0_combout\ & ( (\instruction[16]~input_o\ & (!\instruction[26]~input_o\ & \Equal0~1_combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000001000000010000000000000000000000010000000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[16]~input_o\,
	datab => \ALT_INV_instruction[26]~input_o\,
	datac => \ALT_INV_Equal0~1_combout\,
	datae => \ALT_INV_Equal0~0_combout\,
	combout => \rk~0_combout\);

-- Location: FF_X6_Y19_N19
\rkMapFile[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rk~0_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[0]~reg0_q\);

-- Location: IOIBUF_X29_Y0_N1
\instruction[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(17),
	o => \instruction[17]~input_o\);

-- Location: MLABCELL_X18_Y2_N36
\rk~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~1_combout\ = ( !\instruction[26]~input_o\ & ( (\instruction[17]~input_o\ & (\Equal0~1_combout\ & \Equal0~0_combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000000000000000000000001000000010000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_instruction[17]~input_o\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_Equal0~0_combout\,
	datae => \ALT_INV_instruction[26]~input_o\,
	combout => \rk~1_combout\);

-- Location: FF_X18_Y2_N40
\rkMapFile[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rk~1_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[1]~reg0_q\);

-- Location: IOIBUF_X14_Y0_N1
\instruction[18]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(18),
	o => \instruction[18]~input_o\);

-- Location: MLABCELL_X18_Y2_N33
\rk~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~2_combout\ = ( !\instruction[26]~input_o\ & ( (\Equal0~0_combout\ & (\Equal0~1_combout\ & \instruction[18]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000000000000000000000001000000010000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~0_combout\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_instruction[18]~input_o\,
	datae => \ALT_INV_instruction[26]~input_o\,
	combout => \rk~2_combout\);

-- Location: FF_X18_Y2_N31
\rkMapFile[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rk~2_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[2]~reg0_q\);

-- Location: IOIBUF_X23_Y0_N92
\instruction[19]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(19),
	o => \instruction[19]~input_o\);

-- Location: MLABCELL_X18_Y2_N12
\rk~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~3_combout\ = ( \Equal0~1_combout\ & ( (\Equal0~0_combout\ & (!\instruction[26]~input_o\ & \instruction[19]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000001000000010000000000000000000000010000000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~0_combout\,
	datab => \ALT_INV_instruction[26]~input_o\,
	datac => \ALT_INV_instruction[19]~input_o\,
	datae => \ALT_INV_Equal0~1_combout\,
	combout => \rk~3_combout\);

-- Location: FF_X18_Y2_N16
\rkMapFile[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rk~3_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[3]~reg0_q\);

-- Location: IOIBUF_X23_Y0_N58
\instruction[20]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(20),
	o => \instruction[20]~input_o\);

-- Location: MLABCELL_X18_Y2_N21
\rk~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \rk~4_combout\ = ( !\instruction[26]~input_o\ & ( \instruction[20]~input_o\ & ( (\Equal0~0_combout\ & \Equal0~1_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000101000001010000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~0_combout\,
	datac => \ALT_INV_Equal0~1_combout\,
	datae => \ALT_INV_instruction[26]~input_o\,
	dataf => \ALT_INV_instruction[20]~input_o\,
	combout => \rk~4_combout\);

-- Location: FF_X18_Y2_N19
\rkMapFile[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \rk~4_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkMapFile[4]~reg0_q\);

-- Location: FF_X18_Y2_N52
\rjRegFile[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rj~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[0]~reg0_q\);

-- Location: FF_X18_Y2_N43
\rjRegFile[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rj~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[1]~reg0_q\);

-- Location: FF_X6_Y19_N5
\rjRegFile[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rj~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[2]~reg0_q\);

-- Location: FF_X18_Y2_N28
\rjRegFile[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rj~3_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[3]~reg0_q\);

-- Location: FF_X18_Y2_N58
\rjRegFile[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rj~4_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rjRegFile[4]~reg0_q\);

-- Location: FF_X6_Y19_N46
\rkRegFile[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rk~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[0]~reg0_q\);

-- Location: FF_X18_Y2_N37
\rkRegFile[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rk~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[1]~reg0_q\);

-- Location: FF_X18_Y2_N34
\rkRegFile[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rk~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[2]~reg0_q\);

-- Location: FF_X18_Y2_N13
\rkRegFile[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rk~3_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[3]~reg0_q\);

-- Location: FF_X18_Y2_N22
\rkRegFile[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \rk~4_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rkRegFile[4]~reg0_q\);

-- Location: MLABCELL_X18_Y2_N0
\Equal0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = ( \instruction[26]~input_o\ ) # ( !\instruction[26]~input_o\ & ( (!\Equal0~1_combout\) # (!\Equal0~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111110011111100111111111111111111111100111111001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_Equal0~0_combout\,
	datae => \ALT_INV_instruction[26]~input_o\,
	combout => \Equal0~2_combout\);

-- Location: FF_X18_Y2_N4
\opCode[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \Equal0~2_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \opCode[0]~reg0_q\);

-- Location: FF_X18_Y2_N1
\opCode[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Equal0~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \opCode[1]~reg0_q\);

-- Location: LABCELL_X6_Y19_N33
\writeLine~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeLine~0_combout\ = (!\busyRs[3]~input_o\) # ((!\busyRs[1]~input_o\ & \busyRs[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101011111010101010101111101010101010111110101010101011111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[3]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	combout => \writeLine~0_combout\);

-- Location: FF_X6_Y19_N34
\writeLine[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \writeLine~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeLine[0]~reg0_q\);

-- Location: LABCELL_X6_Y19_N6
\WideAnd0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \WideAnd0~0_combout\ = ( \busyRs[2]~input_o\ & ( !\busyRs[3]~input_o\ ) ) # ( !\busyRs[2]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111111110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_busyRs[3]~input_o\,
	dataf => \ALT_INV_busyRs[2]~input_o\,
	combout => \WideAnd0~0_combout\);

-- Location: FF_X6_Y19_N7
\writeLine[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \WideAnd0~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeLine[1]~reg0_q\);

-- Location: LABCELL_X6_Y19_N0
\writeRS~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeRS~0_combout\ = !\WideAnd0~combout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000111100001111000011110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_WideAnd0~combout\,
	combout => \writeRS~0_combout\);

-- Location: FF_X6_Y19_N1
\writeRS~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \writeRS~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeRS~reg0_q\);

-- Location: IOIBUF_X0_Y19_N55
\instruction[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(0),
	o => \instruction[0]~input_o\);

-- Location: LABCELL_X6_Y19_N9
\writeAddr~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~0_combout\ = ( \Equal0~1_combout\ & ( (\Equal0~0_combout\ & (\instruction[0]~input_o\ & (!\instruction[26]~input_o\ & !\WideAnd0~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000010000000000000001000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~0_combout\,
	datab => \ALT_INV_instruction[0]~input_o\,
	datac => \ALT_INV_instruction[26]~input_o\,
	datad => \ALT_INV_WideAnd0~combout\,
	dataf => \ALT_INV_Equal0~1_combout\,
	combout => \writeAddr~0_combout\);

-- Location: FF_X6_Y19_N10
\writeAddr[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \writeAddr~0_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[0]~reg0_q\);

-- Location: IOIBUF_X0_Y18_N78
\instruction[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(1),
	o => \instruction[1]~input_o\);

-- Location: LABCELL_X6_Y19_N48
\writeAddr~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~1_combout\ = ( \Equal0~0_combout\ & ( (!\WideAnd0~combout\ & (\Equal0~1_combout\ & (\instruction[1]~input_o\ & !\instruction[26]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000010000000000000001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_WideAnd0~combout\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_instruction[1]~input_o\,
	datad => \ALT_INV_instruction[26]~input_o\,
	dataf => \ALT_INV_Equal0~0_combout\,
	combout => \writeAddr~1_combout\);

-- Location: FF_X6_Y19_N50
\writeAddr[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \writeAddr~1_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[1]~reg0_q\);

-- Location: IOIBUF_X54_Y20_N4
\instruction[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(2),
	o => \instruction[2]~input_o\);

-- Location: LABCELL_X6_Y19_N57
\writeAddr~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~2_combout\ = ( \Equal0~0_combout\ & ( (!\WideAnd0~combout\ & (\Equal0~1_combout\ & (\instruction[2]~input_o\ & !\instruction[26]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000010000000000000001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_WideAnd0~combout\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_instruction[2]~input_o\,
	datad => \ALT_INV_instruction[26]~input_o\,
	dataf => \ALT_INV_Equal0~0_combout\,
	combout => \writeAddr~2_combout\);

-- Location: FF_X6_Y19_N58
\writeAddr[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \writeAddr~2_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[2]~reg0_q\);

-- Location: IOIBUF_X54_Y19_N4
\instruction[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(3),
	o => \instruction[3]~input_o\);

-- Location: LABCELL_X6_Y19_N51
\writeAddr~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~3_combout\ = ( \Equal0~0_combout\ & ( (!\WideAnd0~combout\ & (\Equal0~1_combout\ & (\instruction[3]~input_o\ & !\instruction[26]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000010000000000000001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_WideAnd0~combout\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_instruction[3]~input_o\,
	datad => \ALT_INV_instruction[26]~input_o\,
	dataf => \ALT_INV_Equal0~0_combout\,
	combout => \writeAddr~3_combout\);

-- Location: FF_X6_Y19_N52
\writeAddr[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \writeAddr~3_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[3]~reg0_q\);

-- Location: IOIBUF_X54_Y19_N38
\instruction[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(4),
	o => \instruction[4]~input_o\);

-- Location: LABCELL_X6_Y19_N54
\writeAddr~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \writeAddr~4_combout\ = ( \Equal0~0_combout\ & ( (!\WideAnd0~combout\ & (\Equal0~1_combout\ & (\instruction[4]~input_o\ & !\instruction[26]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000010000000000000001000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_WideAnd0~combout\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_instruction[4]~input_o\,
	datad => \ALT_INV_instruction[26]~input_o\,
	dataf => \ALT_INV_Equal0~0_combout\,
	combout => \writeAddr~4_combout\);

-- Location: FF_X6_Y19_N55
\writeAddr[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \writeAddr~4_combout\,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeAddr[4]~reg0_q\);

-- Location: FF_X6_Y19_N26
\lineId[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \lineId~0_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => lineId(0));

-- Location: LABCELL_X6_Y19_N21
\lineId~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \lineId~0_combout\ = ( \busyRs[3]~input_o\ & ( lineId(0) & ( (\busyRs[2]~input_o\ & ((!\busyRs[1]~input_o\) # (\busyRs[0]~input_o\))) ) ) ) # ( !\busyRs[3]~input_o\ & ( lineId(0) ) ) # ( \busyRs[3]~input_o\ & ( !lineId(0) & ( (\busyRs[2]~input_o\ & 
-- !\busyRs[1]~input_o\) ) ) ) # ( !\busyRs[3]~input_o\ & ( !lineId(0) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111010101010000000011111111111111110101010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[2]~input_o\,
	datac => \ALT_INV_busyRs[0]~input_o\,
	datad => \ALT_INV_busyRs[1]~input_o\,
	datae => \ALT_INV_busyRs[3]~input_o\,
	dataf => ALT_INV_lineId(0),
	combout => \lineId~0_combout\);

-- Location: FF_X6_Y19_N16
\writeData[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \lineId~0_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeData[0]~reg0_q\);

-- Location: FF_X6_Y19_N44
\lineId[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \lineId~1_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => lineId(1));

-- Location: LABCELL_X6_Y19_N15
\lineId~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \lineId~1_combout\ = ( lineId(1) & ( (!\busyRs[3]~input_o\) # ((!\busyRs[2]~input_o\) # ((\busyRs[0]~input_o\ & \busyRs[1]~input_o\))) ) ) # ( !lineId(1) & ( (!\busyRs[3]~input_o\) # (!\busyRs[2]~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111110101010111111111010101011111111101010111111111110101011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_busyRs[3]~input_o\,
	datab => \ALT_INV_busyRs[0]~input_o\,
	datac => \ALT_INV_busyRs[1]~input_o\,
	datad => \ALT_INV_busyRs[2]~input_o\,
	dataf => ALT_INV_lineId(1),
	combout => \lineId~1_combout\);

-- Location: FF_X6_Y19_N31
\writeData[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \lineId~1_combout\,
	sload => VCC,
	ena => \load~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \writeData[1]~reg0_q\);

-- Location: IOIBUF_X34_Y45_N18
\instruction[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(10),
	o => \instruction[10]~input_o\);

-- Location: IOIBUF_X54_Y20_N55
\instruction[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(11),
	o => \instruction[11]~input_o\);

-- Location: IOIBUF_X34_Y45_N35
\instruction[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(12),
	o => \instruction[12]~input_o\);

-- Location: IOIBUF_X11_Y0_N52
\instruction[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(13),
	o => \instruction[13]~input_o\);

-- Location: IOIBUF_X18_Y45_N1
\instruction[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(14),
	o => \instruction[14]~input_o\);

-- Location: IOIBUF_X54_Y18_N78
\instruction[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_instruction(15),
	o => \instruction[15]~input_o\);

-- Location: LABCELL_X2_Y21_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


