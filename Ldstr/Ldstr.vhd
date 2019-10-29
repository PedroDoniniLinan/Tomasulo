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

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 16.1.0 Build 196 10/24/2016 SJ Lite Edition"
-- CREATED		"Mon Oct 28 23:10:58 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Ldstr IS 
	PORT
	(
		clock :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		load :  IN  STD_LOGIC;
		reg_write :  IN  STD_LOGIC;
		busyRs :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		cdb :  IN  STD_LOGIC_VECTOR(34 DOWNTO 0);
		inst_in :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		reg_write_data :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		write_reg :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		start_mem :  OUT  STD_LOGIC;
		start_mem10 :  OUT  STD_LOGIC;
		address :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END Ldstr;

ARCHITECTURE bdf_type OF Ldstr IS 

COMPONENT ldstrqueue
GENERIC (dt_addressSize : INTEGER;
			FUTagSize : INTEGER;
			nbOfLines : INTEGER;
			opBits : INTEGER;
			tagSize : INTEGER;
			wordSize : INTEGER
			);
	PORT(clock : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 load : IN STD_LOGIC;
		 done : IN STD_LOGIC;
		 alu_op_i : IN STD_LOGIC_VECTOR(0 TO 0);
		 cdb : IN STD_LOGIC_VECTOR(34 DOWNTO 0);
		 dt_address_in : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 q_n : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 q_t : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 v_n_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 v_t_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 start : OUT STD_LOGIC;
		 alu_op_o : OUT STD_LOGIC_VECTOR(0 TO 0);
		 busy : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 dt_address_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 tag : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 v_n_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 v_t_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT addermem
GENERIC (n_cycles : INTEGER;
			wordSize : INTEGER
			);
	PORT(clock : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 start : IN STD_LOGIC;
		 data_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 r_n : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 start_mem : OUT STD_LOGIC;
		 s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mem
GENERIC (addressSize : INTEGER;
			n_cycles : INTEGER;
			wordSize : INTEGER
			);
	PORT(clock : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 start_mem : IN STD_LOGIC;
		 wr : IN STD_LOGIC;
		 addr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 done : OUT STD_LOGIC;
		 data_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT decoderldstr
GENERIC (dt_addressSize : INTEGER;
			fuBits : INTEGER;
			ldstrBits : INTEGER;
			n_lines_ldstr : INTEGER;
			nb_lines : INTEGER;
			opBits : INTEGER;
			regBits : INTEGER;
			rsBits : INTEGER;
			tagSize : INTEGER;
			wordSize : INTEGER
			);
	PORT(clock : IN STD_LOGIC;
		 load : IN STD_LOGIC;
		 busyLDSTR : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 busyRs : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 busy : OUT STD_LOGIC;
		 ldstr : OUT STD_LOGIC;
		 writeMapRS : OUT STD_LOGIC;
		 ldstr_write : OUT STD_LOGIC;
		 dt_address : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		 fuCodeOneHot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 opCode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 rjFiles : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rkFiles : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 RSLineOneHot : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 writeMapAddr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 writeMapData : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT maptable
GENERIC (regNum : INTEGER;
			regNumBits : INTEGER;
			tagSize : INTEGER
			);
	PORT(reset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 tag_write : IN STD_LOGIC;
		 read_tag_1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 read_tag_2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 write_tag : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 write_tag_data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 tag_1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 tag_2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT regfiletomasulo
GENERIC (regNum : INTEGER;
			regNumBits : INTEGER;
			wordSize : INTEGER
			);
	PORT(reset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 reg_write : IN STD_LOGIC;
		 read_reg_1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 read_reg_2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 write_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 write_reg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 r5_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 read_data_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 read_data_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(2 DOWNTO 0);


BEGIN 
start_mem <= SYNTHESIZED_WIRE_11;
start_mem10 <= SYNTHESIZED_WIRE_8;
address <= SYNTHESIZED_WIRE_13;



b2v_inst : ldstrqueue
GENERIC MAP(dt_addressSize => 9,
			FUTagSize => 2,
			nbOfLines => 2,
			opBits => 1,
			tagSize => 3,
			wordSize => 32
			)
PORT MAP(clock => clock,
		 reset => reset,
		 load => SYNTHESIZED_WIRE_0,
		 done => SYNTHESIZED_WIRE_1,
		 alu_op_i(0) => SYNTHESIZED_WIRE_2,
		 cdb => cdb,
		 dt_address_in => SYNTHESIZED_WIRE_3,
		 q_n => SYNTHESIZED_WIRE_4,
		 q_t => SYNTHESIZED_WIRE_5,
		 v_n_in => SYNTHESIZED_WIRE_6,
		 v_t_in => SYNTHESIZED_WIRE_7,
		 start => SYNTHESIZED_WIRE_8,
		 alu_op_o(0) => SYNTHESIZED_WIRE_12,
		 busy => SYNTHESIZED_WIRE_15,
		 dt_address_out => SYNTHESIZED_WIRE_9,
		 v_n_out => SYNTHESIZED_WIRE_10,
		 v_t_out => SYNTHESIZED_WIRE_14);


b2v_inst1 : addermem
GENERIC MAP(n_cycles => 4,
			wordSize => 32
			)
PORT MAP(clock => clock,
		 reset => reset,
		 start => SYNTHESIZED_WIRE_8,
		 data_address => SYNTHESIZED_WIRE_9,
		 r_n => SYNTHESIZED_WIRE_10,
		 start_mem => SYNTHESIZED_WIRE_11,
		 s => SYNTHESIZED_WIRE_13);


b2v_inst2 : mem
GENERIC MAP(addressSize => 16,
			n_cycles => 10,
			wordSize => 32
			)
PORT MAP(clock => clock,
		 reset => reset,
		 start_mem => SYNTHESIZED_WIRE_11,
		 wr => SYNTHESIZED_WIRE_12,
		 addr => SYNTHESIZED_WIRE_13,
		 data_i => SYNTHESIZED_WIRE_14,
		 done => SYNTHESIZED_WIRE_1);


b2v_inst3 : decoderldstr
GENERIC MAP(dt_addressSize => 9,
			fuBits => 2,
			ldstrBits => 1,
			n_lines_ldstr => 2,
			nb_lines => 2,
			opBits => 4,
			regBits => 5,
			rsBits => 1,
			tagSize => 3,
			wordSize => 32
			)
PORT MAP(clock => clock,
		 load => load,
		 busyLDSTR => SYNTHESIZED_WIRE_15,
		 busyRs => busyRs,
		 instruction => inst_in,
		 ldstr => SYNTHESIZED_WIRE_2,
		 writeMapRS => SYNTHESIZED_WIRE_16,
		 ldstr_write => SYNTHESIZED_WIRE_0,
		 dt_address => SYNTHESIZED_WIRE_3,
		 rjFiles => SYNTHESIZED_WIRE_23,
		 rkFiles => SYNTHESIZED_WIRE_24,
		 writeMapAddr => SYNTHESIZED_WIRE_19,
		 writeMapData => SYNTHESIZED_WIRE_20);


b2v_inst5 : maptable
GENERIC MAP(regNum => 32,
			regNumBits => 5,
			tagSize => 3
			)
PORT MAP(reset => reset,
		 clock => clock,
		 tag_write => SYNTHESIZED_WIRE_16,
		 read_tag_1 => SYNTHESIZED_WIRE_23,
		 read_tag_2 => SYNTHESIZED_WIRE_24,
		 write_tag => SYNTHESIZED_WIRE_19,
		 write_tag_data => SYNTHESIZED_WIRE_20,
		 tag_1 => SYNTHESIZED_WIRE_4,
		 tag_2 => SYNTHESIZED_WIRE_5);


b2v_inst6 : regfiletomasulo
GENERIC MAP(regNum => 32,
			regNumBits => 5,
			wordSize => 32
			)
PORT MAP(reset => reset,
		 clock => clock,
		 reg_write => reg_write,
		 read_reg_1 => SYNTHESIZED_WIRE_23,
		 read_reg_2 => SYNTHESIZED_WIRE_24,
		 write_data => reg_write_data,
		 write_reg => write_reg,
		 read_data_1 => SYNTHESIZED_WIRE_6,
		 read_data_2 => SYNTHESIZED_WIRE_7);


END bdf_type;