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
-- CREATED		"Sat Nov 02 18:15:36 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use IEEE.STD_LOGIC_SIGNED.all; 
--use ieee.numeric_std.all; -- necessario para converter em integer

--LIBRARY work;

ENTITY Tomasulo IS 
	PORT
	(
		rd_fifo: buffer std_logic;
		inst_fifo: buffer std_logic_vector(31 downto 0);
		fifo_has : buffer std_logic;

		opCopeDec : buffer STD_LOGIC_VECTOR(3 DOWNTO 0);
		rjDec : buffer STD_LOGIC_VECTOR(4 DOWNTO 0);
		rkDec : buffer STD_LOGIC_VECTOR(4 DOWNTO 0); 		 
		rs1hot : buffer STD_LOGIC_VECTOR(5 DOWNTO 0);
		regTagAddr : buffer STD_LOGIC_VECTOR(4 DOWNTO 0);
		regTag : buffer STD_LOGIC_VECTOR(2 DOWNTO 0);

		r010 : 		buffer std_logic_vector(138 downto 0);
		r011 : 		buffer std_logic_vector(138 downto 0);
		r100 : 		buffer std_logic_vector(138 downto 0);
		r101 : 		buffer std_logic_vector(138 downto 0);		
		r110 : 		buffer std_logic_vector(138 downto 0);
		r111 : 		buffer std_logic_vector(138 downto 0);

		A01 : 		buffer std_logic_vector(63 downto 0);
		B01 : 		buffer std_logic_vector(63 downto 0);
		F01 : 		buffer std_logic_vector(63 downto 0);

		A10 : 		buffer std_logic_vector(63 downto 0);
		B10 : 		buffer std_logic_vector(63 downto 0);
		F10 : 		buffer std_logic_vector(63 downto 0);		

		A11 : 		buffer std_logic_vector(63 downto 0);
		B11 : 		buffer std_logic_vector(63 downto 0);
		F11 : 		buffer std_logic_vector(63 downto 0);

		cdb_b: buffer STD_LOGIC_VECTOR(66 DOWNTO 0);
		
		alu_done1 : buffer std_logic;
		alu_done2 : buffer std_logic;
		load_cdbs : buffer std_logic_vector(2 downto 0);
		
		reset :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC
	);
END Tomasulo;

ARCHITECTURE bdf_type OF Tomasulo IS 

COMPONENT decoder
GENERIC (fuBits : INTEGER;
			nb_lines : INTEGER;
			opBits : INTEGER;
			regBits : INTEGER;
			rsBits : INTEGER;
			tagSize : INTEGER;
			wordSize : INTEGER
			);
	PORT(
--	clock : IN STD_LOGIC;
		 load : IN STD_LOGIC;
		 busyRs : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 busy : OUT STD_LOGIC;
		 writeMapRS : OUT STD_LOGIC;
--		 fuCodeOneHot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 opCode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 rjFiles : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rkFiles : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 RSLineOneHot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 writeMapAddr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 writeMapData : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fifo
GENERIC (regNum : INTEGER;
			wordSize : INTEGER
			);
	PORT(reset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 wr : IN STD_LOGIC;
		 rd : IN STD_LOGIC;
		 write_inst : IN STD_LOGIC_VECTOR(31 DOWNTO 0);	 
		 
		 notEmpty : OUT STD_LOGIC;
		 full : OUT STD_LOGIC;
		 read_inst : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu
GENERIC (delay : INTEGER;
			wordSize : INTEGER
			);
	PORT(reset : IN STD_LOGIC;
	 clock : in std_logic;
	 execute : in std_logic;
    A  : in  std_logic_vector(wordSize-1 downto 0); -- inputs
	 B : in  std_logic_vector(wordSize-1 downto 0); -- inputs
    F    : out std_logic_vector(wordSize-1 downto 0); -- output
    S    : in  std_logic_vector (3 downto 0); -- ALUop selection
    --Z    : out STD_LOGIC -- zero flag
	 ready : out std_logic
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
		 cdb_tag : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 read_tag_1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 read_tag_2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 write_tag : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 write_tag_data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 tag_1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 tag_2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 write_reg : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
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
		 write_data : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 write_reg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 read_data_1 : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
		 read_data_2 : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fp
GENERIC (delay : INTEGER;
			wordSize : INTEGER
			);
	PORT(reset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 execute : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 S : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ready : OUT STD_LOGIC;
		 F : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cdb
GENERIC (FUTagSize : INTEGER;
			nbOfLines : INTEGER;
			nFU : INTEGER;
			tagSize : INTEGER;
			wordSize : INTEGER
			);
	PORT(clock : IN STD_LOGIC;
		 data_i : IN STD_LOGIC_VECTOR(191 DOWNTO 0);
		 load : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 tag_i : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 busy : OUT STD_LOGIC;
		 cdb_o : OUT STD_LOGIC_VECTOR(66 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rs
GENERIC (FUTagSize : INTEGER;
			nbOfLines : INTEGER;
			opBits : INTEGER;
			tagSize : INTEGER;
			wordSize : INTEGER
			);
	PORT(clock : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
--		 loadFU : IN STD_LOGIC;
		 alu_op_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 cdb : IN STD_LOGIC_VECTOR(66 DOWNTO 0);
		 FU_tag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 load : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 q_j_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 q_k_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 v_j_i : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 v_k_i : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 ready : OUT STD_LOGIC;
		 alu_done:				in std_logic;
		 load_cdb:				out std_logic;
		 alu_op_o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 busy : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 tag : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 
		 r0 : 		buffer std_logic_vector(138 downto 0);
		 r1 : 		buffer std_logic_vector(138 downto 0);
		 
		 v_j_o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
		 v_k_o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	busyRS :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	cdb_o :  STD_LOGIC_VECTOR(66 DOWNTO 0);
SIGNAL	data_i :  STD_LOGIC_VECTOR(191 DOWNTO 0);
SIGNAL	FU1H :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	load_cdb :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	RegFile1 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	RegFile2 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	RS1H :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	tag_1 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	tag_2 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	tag_i :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	write_reg :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC := '0';
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC := '0';
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL	alu_done01 :  STD_LOGIC;
SIGNAL	alu_done10 :  STD_LOGIC;

BEGIN 



rd_fifo <= SYNTHESIZED_WIRE_2;
inst_fifo <= SYNTHESIZED_WIRE_1;
fifo_has <= SYNTHESIZED_WIRE_0;

opCopeDec <= SYNTHESIZED_WIRE_28;
rjDec <= SYNTHESIZED_WIRE_26;
rkDec <= SYNTHESIZED_WIRE_27; 		 
rs1hot <= RS1H;
regTagAddr <= SYNTHESIZED_WIRE_14;
regTag <= SYNTHESIZED_WIRE_15;

A01 <= SYNTHESIZED_WIRE_4;
B01 <= SYNTHESIZED_WIRE_5;
F01 <= data_i(63 DOWNTO 0);		 

A10 <= SYNTHESIZED_WIRE_8;
B10 <= SYNTHESIZED_WIRE_9;
F10 <= data_i(127 DOWNTO 64);		 

A11 <= SYNTHESIZED_WIRE_20;
B11 <= SYNTHESIZED_WIRE_21;
F11 <= data_i(191 DOWNTO 128);		 

cdb_b <= cdb_o;

alu_done1 <= alu_done01;
alu_done2 <= alu_done10;
load_cdbs <= load_cdb;


b2v_decoder : decoder
GENERIC MAP(fuBits => 2,
			nb_lines => 6,
			opBits => 4,
			regBits => 5,
			rsBits => 1,
			tagSize => 3,
			wordSize => 32
			)
PORT MAP(
--clock => clock,
		 load => SYNTHESIZED_WIRE_0,
		 busyRs => busyRS,
		 instruction => SYNTHESIZED_WIRE_1,
		 busy => SYNTHESIZED_WIRE_2,
		 writeMapRS => SYNTHESIZED_WIRE_11,
--		 fuCodeOneHot => FU1H,
		 opCode => SYNTHESIZED_WIRE_28,
		 rjFiles => SYNTHESIZED_WIRE_26,
		 rkFiles => SYNTHESIZED_WIRE_27,
		 RSLineOneHot => RS1H,
		 writeMapAddr => SYNTHESIZED_WIRE_14,
		 writeMapData => SYNTHESIZED_WIRE_15);

b2v_fifo : fifo
GENERIC MAP(regNum => 32,
			wordSize => 32
			)
PORT MAP(reset => reset,
		 clock => clock,
		 rd => SYNTHESIZED_WIRE_2,
		 wr => '0',
		 write_inst => (others => '0'),
		 notEmpty => SYNTHESIZED_WIRE_0,
		 read_inst => SYNTHESIZED_WIRE_1);
		 
b2v_inst : alu
GENERIC MAP(delay => 2,
			wordSize => 64
			)
PORT MAP(reset => reset,
		 clock => clock,
		 execute => SYNTHESIZED_WIRE_3,
		 A => SYNTHESIZED_WIRE_4,
		 B => SYNTHESIZED_WIRE_5,
		 S => SYNTHESIZED_WIRE_6,
		 ready => alu_done01,
		 F => data_i(63 DOWNTO 0));	 
		 
b2v_inst1 : alu
GENERIC MAP(delay => 2,
			wordSize => 64
			)
PORT MAP(reset => reset,
		 clock => clock,
		 execute => SYNTHESIZED_WIRE_7,
		 A => SYNTHESIZED_WIRE_8,
		 B => SYNTHESIZED_WIRE_9,
		 S => SYNTHESIZED_WIRE_10,
		 ready => alu_done10,
		 F => data_i(127 DOWNTO 64));		 	 

b2v_inst2 : maptable
GENERIC MAP(regNum => 32,
			regNumBits => 5,
			tagSize => 3
			)
PORT MAP(reset => reset,
		 clock => clock,
		 tag_write => SYNTHESIZED_WIRE_11,
		 cdb_tag => cdb_o(66 DOWNTO 64),
		 read_tag_1 => SYNTHESIZED_WIRE_26,
		 read_tag_2 => SYNTHESIZED_WIRE_27,
		 write_tag => SYNTHESIZED_WIRE_14,
		 write_tag_data => SYNTHESIZED_WIRE_15,
		 tag_1 => tag_1,
		 tag_2 => tag_2,
		 write_reg => write_reg);


b2v_inst3 : regfiletomasulo
GENERIC MAP(regNum => 32,
			regNumBits => 5,
			wordSize => 64
			)
PORT MAP(reset => reset,
		 clock => clock,
		 reg_write => SYNTHESIZED_WIRE_16,
		 read_reg_1 => SYNTHESIZED_WIRE_26,
		 read_reg_2 => SYNTHESIZED_WIRE_27,
		 write_data => cdb_o(63 DOWNTO 0),
		 write_reg => write_reg,
		 read_data_1 => RegFile1,
		 read_data_2 => RegFile2);

b2v_inst4 : fp
GENERIC MAP(delay => 5,
			wordSize => 64
			)
PORT MAP(reset => reset,
		 clock => clock,
		 execute => SYNTHESIZED_WIRE_19,
		 A => SYNTHESIZED_WIRE_20,
		 B => SYNTHESIZED_WIRE_21,
		 S => SYNTHESIZED_WIRE_22,
		 ready => load_cdb(2),
		 F => data_i(191 DOWNTO 128));		  

b2v_inst5 : cdb
GENERIC MAP(FUTagSize => 2,
			nbOfLines => 2,
			nFU => 3,
			tagSize => 3,
			wordSize => 64
			)
PORT MAP(clock => clock,
		 data_i => data_i,
		 load => load_cdb,
		 tag_i => tag_i,
		 busy => SYNTHESIZED_WIRE_16,
		 cdb_o => cdb_o);


b2v_RS_Add1 : rs
GENERIC MAP(FUTagSize => 2,
			nbOfLines => 2,
			opBits => 4,
			tagSize => 3,
			wordSize => 64
			)
PORT MAP(clock => clock,
		 reset => reset,
		 FU_Tag => "01",		 
--		 loadFU => FU1H(0),
		 alu_op_i => SYNTHESIZED_WIRE_28,
		 cdb => cdb_o,
		 load => RS1H(1 DOWNTO 0),
		 q_j_i => tag_1,
		 q_k_i => tag_2,
		 v_j_i => RegFile1,
		 v_k_i => RegFile2,
		 alu_done=>alu_done01,
		 load_cdb=>load_cdb(0),
		 ready => SYNTHESIZED_WIRE_3,
		 alu_op_o => SYNTHESIZED_WIRE_6,
		 busy => busyRS(1 DOWNTO 0),
		 tag => tag_i(2 DOWNTO 0),
		 
		 r0=>r010,
		 r1=>r011,
		 
		 v_j_o => SYNTHESIZED_WIRE_4,
		 v_k_o => SYNTHESIZED_WIRE_5);

		 

b2v_RS_Add2 : rs
GENERIC MAP(FUTagSize => 2,
			nbOfLines => 2,
			opBits => 4,
			tagSize => 3,
			wordSize => 64
			)
PORT MAP(clock => clock,
		 reset => reset,
		 FU_Tag => "10",
--		 loadFU => FU1H(1),
		 alu_op_i => SYNTHESIZED_WIRE_28,
		 cdb => cdb_o,
		 load => RS1H(3 DOWNTO 2),
		 q_j_i => tag_1,
		 q_k_i => tag_2,
		 v_j_i => RegFile1,
		 v_k_i => RegFile2,
		 alu_done=>alu_done10,
		 load_cdb=>load_cdb(1),
		 ready => SYNTHESIZED_WIRE_7,
		 alu_op_o => SYNTHESIZED_WIRE_10,
		 busy => busyRS(3 DOWNTO 2),
		 tag => tag_i(5 DOWNTO 3),
		 		 
		 r0=>r100,
		 r1=>r101,		 
		 
		 v_j_o => SYNTHESIZED_WIRE_8,
		 v_k_o => SYNTHESIZED_WIRE_9);


b2v_RS_Mult : rs
GENERIC MAP(FUTagSize => 2,
			nbOfLines => 2,
			opBits => 4,
			tagSize => 3,
			wordSize => 64
			)
PORT MAP(clock => clock,
		 reset => reset,
		 FU_Tag => "11",
--		 loadFU => FU1H(2),
		 alu_op_i => SYNTHESIZED_WIRE_28,
		 cdb => cdb_o,
		 load => RS1H(5 DOWNTO 4),
		 q_j_i => tag_1,
		 q_k_i => tag_2,
		 v_j_i => RegFile1,
		 v_k_i => RegFile2,
		 ready => SYNTHESIZED_WIRE_19,
		 alu_op_o => SYNTHESIZED_WIRE_22,
		 busy => busyRS(5 DOWNTO 4),
		 tag => tag_i(8 DOWNTO 6),
		 alu_done=>'0',
--		 load_cdb=>load_cdb(2),
		 r0=>r110,
		 r1=>r111,		 
		 
		 v_j_o => SYNTHESIZED_WIRE_20,
		 v_k_o => SYNTHESIZED_WIRE_21);


END bdf_type;