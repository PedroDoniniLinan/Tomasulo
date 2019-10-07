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

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "10/07/2019 11:31:29"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Decoder
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Decoder_vhd_vec_tst IS
END Decoder_vhd_vec_tst;
ARCHITECTURE Decoder_arch OF Decoder_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL busy : STD_LOGIC;
SIGNAL busyRs : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL clock : STD_LOGIC;
SIGNAL fuCode : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL fuCodeOneHot : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL load : STD_LOGIC;
SIGNAL opCode : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL rjMapFile : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rjRegFile : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rkMapFile : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rkRegFile : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL RSLineOneHot : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL writeAddr : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL writeData : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL writeLine : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL writeRS : STD_LOGIC;
COMPONENT Decoder
	PORT (
	busy : OUT STD_LOGIC;
	busyRs : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	clock : IN STD_LOGIC;
	fuCode : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	fuCodeOneHot : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	load : IN STD_LOGIC;
	opCode : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	rjMapFile : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	rjRegFile : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	rkMapFile : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	rkRegFile : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	RSLineOneHot : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	writeAddr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	writeData : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	writeLine : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	writeRS : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : Decoder
	PORT MAP (
-- list connections between master ports and signals
	busy => busy,
	busyRs => busyRs,
	clock => clock,
	fuCode => fuCode,
	fuCodeOneHot => fuCodeOneHot,
	instruction => instruction,
	load => load,
	opCode => opCode,
	rjMapFile => rjMapFile,
	rjRegFile => rjRegFile,
	rkMapFile => rkMapFile,
	rkRegFile => rkRegFile,
	RSLineOneHot => RSLineOneHot,
	writeAddr => writeAddr,
	writeData => writeData,
	writeLine => writeLine,
	writeRS => writeRS
	);
-- busyRs[3]
t_prcs_busyRs_3: PROCESS
BEGIN
	busyRs(3) <= '1';
WAIT;
END PROCESS t_prcs_busyRs_3;
-- busyRs[2]
t_prcs_busyRs_2: PROCESS
BEGIN
	busyRs(2) <= '0';
WAIT;
END PROCESS t_prcs_busyRs_2;
-- busyRs[1]
t_prcs_busyRs_1: PROCESS
BEGIN
	busyRs(1) <= '1';
WAIT;
END PROCESS t_prcs_busyRs_1;
-- busyRs[0]
t_prcs_busyRs_0: PROCESS
BEGIN
	busyRs(0) <= '1';
WAIT;
END PROCESS t_prcs_busyRs_0;

-- clock
t_prcs_clock: PROCESS
BEGIN
	clock <= '0';
	WAIT FOR 30000 ps;
	clock <= '1';
	WAIT FOR 50000 ps;
	clock <= '0';
WAIT;
END PROCESS t_prcs_clock;
-- instruction[31]
t_prcs_instruction_31: PROCESS
BEGIN
	instruction(31) <= '1';
WAIT;
END PROCESS t_prcs_instruction_31;
-- instruction[30]
t_prcs_instruction_30: PROCESS
BEGIN
	instruction(30) <= '0';
WAIT;
END PROCESS t_prcs_instruction_30;
-- instruction[29]
t_prcs_instruction_29: PROCESS
BEGIN
	instruction(29) <= '0';
WAIT;
END PROCESS t_prcs_instruction_29;
-- instruction[28]
t_prcs_instruction_28: PROCESS
BEGIN
	instruction(28) <= '0';
WAIT;
END PROCESS t_prcs_instruction_28;
-- instruction[27]
t_prcs_instruction_27: PROCESS
BEGIN
	instruction(27) <= '1';
WAIT;
END PROCESS t_prcs_instruction_27;
-- instruction[26]
t_prcs_instruction_26: PROCESS
BEGIN
	instruction(26) <= '0';
WAIT;
END PROCESS t_prcs_instruction_26;
-- instruction[25]
t_prcs_instruction_25: PROCESS
BEGIN
	instruction(25) <= '1';
WAIT;
END PROCESS t_prcs_instruction_25;
-- instruction[24]
t_prcs_instruction_24: PROCESS
BEGIN
	instruction(24) <= '1';
WAIT;
END PROCESS t_prcs_instruction_24;
-- instruction[23]
t_prcs_instruction_23: PROCESS
BEGIN
	instruction(23) <= '0';
WAIT;
END PROCESS t_prcs_instruction_23;
-- instruction[22]
t_prcs_instruction_22: PROCESS
BEGIN
	instruction(22) <= '0';
WAIT;
END PROCESS t_prcs_instruction_22;
-- instruction[21]
t_prcs_instruction_21: PROCESS
BEGIN
	instruction(21) <= '0';
WAIT;
END PROCESS t_prcs_instruction_21;
-- instruction[20]
t_prcs_instruction_20: PROCESS
BEGIN
	instruction(20) <= '1';
WAIT;
END PROCESS t_prcs_instruction_20;
-- instruction[19]
t_prcs_instruction_19: PROCESS
BEGIN
	instruction(19) <= '1';
WAIT;
END PROCESS t_prcs_instruction_19;
-- instruction[18]
t_prcs_instruction_18: PROCESS
BEGIN
	instruction(18) <= '1';
WAIT;
END PROCESS t_prcs_instruction_18;
-- instruction[17]
t_prcs_instruction_17: PROCESS
BEGIN
	instruction(17) <= '1';
WAIT;
END PROCESS t_prcs_instruction_17;
-- instruction[16]
t_prcs_instruction_16: PROCESS
BEGIN
	instruction(16) <= '0';
WAIT;
END PROCESS t_prcs_instruction_16;
-- instruction[15]
t_prcs_instruction_15: PROCESS
BEGIN
	instruction(15) <= '0';
WAIT;
END PROCESS t_prcs_instruction_15;
-- instruction[14]
t_prcs_instruction_14: PROCESS
BEGIN
	instruction(14) <= '0';
WAIT;
END PROCESS t_prcs_instruction_14;
-- instruction[13]
t_prcs_instruction_13: PROCESS
BEGIN
	instruction(13) <= '0';
WAIT;
END PROCESS t_prcs_instruction_13;
-- instruction[12]
t_prcs_instruction_12: PROCESS
BEGIN
	instruction(12) <= '0';
WAIT;
END PROCESS t_prcs_instruction_12;
-- instruction[11]
t_prcs_instruction_11: PROCESS
BEGIN
	instruction(11) <= '0';
WAIT;
END PROCESS t_prcs_instruction_11;
-- instruction[10]
t_prcs_instruction_10: PROCESS
BEGIN
	instruction(10) <= '0';
WAIT;
END PROCESS t_prcs_instruction_10;
-- instruction[9]
t_prcs_instruction_9: PROCESS
BEGIN
	instruction(9) <= '1';
WAIT;
END PROCESS t_prcs_instruction_9;
-- instruction[8]
t_prcs_instruction_8: PROCESS
BEGIN
	instruction(8) <= '0';
WAIT;
END PROCESS t_prcs_instruction_8;
-- instruction[7]
t_prcs_instruction_7: PROCESS
BEGIN
	instruction(7) <= '1';
WAIT;
END PROCESS t_prcs_instruction_7;
-- instruction[6]
t_prcs_instruction_6: PROCESS
BEGIN
	instruction(6) <= '0';
WAIT;
END PROCESS t_prcs_instruction_6;
-- instruction[5]
t_prcs_instruction_5: PROCESS
BEGIN
	instruction(5) <= '1';
WAIT;
END PROCESS t_prcs_instruction_5;
-- instruction[4]
t_prcs_instruction_4: PROCESS
BEGIN
	instruction(4) <= '1';
WAIT;
END PROCESS t_prcs_instruction_4;
-- instruction[3]
t_prcs_instruction_3: PROCESS
BEGIN
	instruction(3) <= '1';
WAIT;
END PROCESS t_prcs_instruction_3;
-- instruction[2]
t_prcs_instruction_2: PROCESS
BEGIN
	instruction(2) <= '1';
WAIT;
END PROCESS t_prcs_instruction_2;
-- instruction[1]
t_prcs_instruction_1: PROCESS
BEGIN
	instruction(1) <= '0';
WAIT;
END PROCESS t_prcs_instruction_1;
-- instruction[0]
t_prcs_instruction_0: PROCESS
BEGIN
	instruction(0) <= '0';
WAIT;
END PROCESS t_prcs_instruction_0;

-- load
t_prcs_load: PROCESS
BEGIN
	load <= '1';
WAIT;
END PROCESS t_prcs_load;
END Decoder_arch;
