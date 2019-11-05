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

-- ************************** READ ***************************************
-- All buffers were used to verify the that the circuit functions properly
ENTITY Tomasulo IS 
	PORT
	(
		-- DECODER OUTPUT
		opCopeDec : buffer STD_LOGIC_VECTOR(3 DOWNTO 0);
		rjDec : buffer STD_LOGIC_VECTOR(4 DOWNTO 0);
		rkDec : buffer STD_LOGIC_VECTOR(4 DOWNTO 0); 		 
		rs1hot : buffer STD_LOGIC_VECTOR(5 DOWNTO 0);
		regTagAddr : buffer STD_LOGIC_VECTOR(4 DOWNTO 0);
		regTag : buffer STD_LOGIC_VECTOR(3 DOWNTO 0);

		-- RS
		r010 : 		buffer std_logic_vector(140 downto 0);
		r011 : 		buffer std_logic_vector(140 downto 0);
		r100 : 		buffer std_logic_vector(140 downto 0);
		r101 : 		buffer std_logic_vector(140 downto 0);		
		r110 : 		buffer std_logic_vector(140 downto 0);
		r111 : 		buffer std_logic_vector(140 downto 0);
		rMem1s : buffer std_logic_vector(146 downto 0);
		rMem2s : buffer std_logic_vector(146 downto 0);

		-- FU'S 
		A01 : 		buffer std_logic_vector(63 downto 0);
		B01 : 		buffer std_logic_vector(63 downto 0);
		F01 : 		buffer std_logic_vector(63 downto 0);

		A10 : 		buffer std_logic_vector(63 downto 0);
		B10 : 		buffer std_logic_vector(63 downto 0);
		F10 : 		buffer std_logic_vector(63 downto 0);		

		A11 : 		buffer std_logic_vector(63 downto 0);
		B11 : 		buffer std_logic_vector(63 downto 0);
		F11 : 		buffer std_logic_vector(63 downto 0);

		-- CDB
		cdb_b: buffer STD_LOGIC_VECTOR(67 DOWNTO 0);
		
		-- MAP FILE WITH REGISTERS TAGS
		t0 : buffer std_logic_vector (3 downto 0);
		t1 : buffer std_logic_vector (3 downto 0);
		t2 : buffer std_logic_vector (3 downto 0);
		t3 : buffer std_logic_vector (3 downto 0);
		t4 : buffer std_logic_vector (3 downto 0);
		t5 : buffer std_logic_vector (3 downto 0);
		
		-- REGISTERS 
		r0 : buffer std_logic_vector (63 downto 0);
		r1 : buffer std_logic_vector (63 downto 0);
	   r2 : buffer std_logic_vector (63 downto 0); 
	   r3 : buffer std_logic_vector (63 downto 0); 
	   r4 : buffer std_logic_vector (63 downto 0); 
	   r5 : buffer std_logic_vector (63 downto 0);

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
			wordSize : INTEGER;
			ldstrBits:INTEGER;
			n_lines_ldstr: INTEGER;
			dt_addressSize:INTEGER
			);
	PORT(
		 load : IN STD_LOGIC;
		 busyRs : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 busy : OUT STD_LOGIC;
		 busyLDSTR:		in		 std_logic_vector(n_lines_ldstr-1 downto 0);		 
		 writeMapRS : OUT STD_LOGIC;
		 opCode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 rjFiles : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 rkFiles : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 RSLineOneHot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 writeMapAddr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 writeMapData : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 ldstr:			out	 std_logic; -- 1 if load or store
		 ldstr_write:	out	std_logic; -- in case it is an str or ld instruction
		 dt_address:	out   std_logic_vector(dt_addressSize-1 downto 0) -- immediate for str and ld			 
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
	 ready : out std_logic
	);
END COMPONENT;

COMPONENT maptable
GENERIC (regNum : INTEGER;
			regNumBits : INTEGER;
			tagSize : INTEGER
			);
	PORT(
	 reset : in std_logic;
	 clock : in std_logic;
	 
	 read_tag_1 : in std_logic_vector (regNumBits-1 downto 0);	-- sinal do endereco de leitura 1
	 read_tag_2 : in std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de leitura 2
	 
	 tag_write : in std_logic; -- controle de escrita
	 
	 write_tag : in std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de escrita 
	 write_tag_data : in std_logic_vector (tagSize-1 downto 0) ; -- sinal de escrita da tag
	 
	 cdb_tag : in std_logic_vector (tagSize-1 downto 0);
	 cdb_busy: in std_logic;
	 
	 tag_1  : out std_logic_vector (tagSize-1 downto 0); -- sinal de saida do tag da leitura 1
	 tag_2  : out std_logic_vector (tagSize-1 downto 0);   -- sinal de saida do tag da leitura 2
	 
	 t0 : buffer std_logic_vector (tagSize-1 downto 0);  
	 t1 : buffer std_logic_vector (tagSize-1 downto 0); 
	 t2 : buffer std_logic_vector (tagSize-1 downto 0); 
	 t3 : buffer std_logic_vector (tagSize-1 downto 0); 
	 t4 : buffer std_logic_vector (tagSize-1 downto 0); 
	 t5 : buffer std_logic_vector (tagSize-1 downto 0); 
	 
	 reg_write : out std_logic;
	 write_reg : buffer std_logic_vector (regNumBits-1 downto 0)
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
		
		r0 : buffer std_logic_vector (63 downto 0); 
		r1 : buffer std_logic_vector (63 downto 0);
	   r2 : buffer std_logic_vector (63 downto 0); 
	   r3 : buffer std_logic_vector (63 downto 0); 
	   r4 : buffer std_logic_vector (63 downto 0); 
	   r5 : buffer std_logic_vector (63 downto 0); 	 		 
		 
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
		 data_i : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
		 load : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 tag_i : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 busy : OUT STD_LOGIC;
		 cdb_o : OUT STD_LOGIC_VECTOR(67 DOWNTO 0)
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
		 alu_op_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 cdb : IN STD_LOGIC_VECTOR(67 DOWNTO 0);
		 FU_tag : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 load : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 q_j_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 q_k_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 v_j_i : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 v_k_i : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 ready : OUT STD_LOGIC;
		 alu_done:				in std_logic;
		 load_cdb:				out std_logic;
		 alu_op_o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 busy : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 tag : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 
		 r0 : 		buffer std_logic_vector(140 downto 0);
		 r1 : 		buffer std_logic_vector(140 downto 0);
		 
		 v_j_o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
		 v_k_o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

COMPONENT LdstrQueue 
GENERIC (wordSize:INTEGER;
			tagSize:INTEGER;  
			nbOfLines:INTEGER;  
			opBits:INTEGER; 
			FUTagSize: INTEGER;	
			dt_addressSize:INTEGER  
			);
	PORT (clock:    		in 	 std_logic; 
			reset:	 		in 	 std_logic; 
			load:			   in 	 std_logic;	
			alu_op_i:   	in		 std_logic; 		
			v_n_in:  		in		 std_logic_vector(63 downto 0);
			v_t_in:  		in		 std_logic_vector(63 downto 0);
			q_n:  		 	in		 std_logic_vector(3 downto 0);
			q_t:  		 	in		 std_logic_vector(3 downto 0);
			done:				in		 std_logic;
			cdb:				in		 std_logic_vector(67 downto 0);
			dt_address_in:	in		 std_logic_vector(8 downto 0);
			busy_adder_in: in		 std_logic;
			busy:				out	 std_logic_vector(1 downto 0);
			alu_op_o:   	out	 std_logic; 
			v_n_out:  		out	 std_logic_vector(63 downto 0);
			v_t_out:			out	 std_logic_vector(63 downto 0);
			dt_address_out:out	 std_logic_vector(63 downto 0);
			start:			out 	 std_logic; 
			tag:  		 	out	 std_logic_vector(3 downto 0);
			point_reads: 	out   integer; 
			point_writes: 	out   integer;
			done_cdbs:		out  	integer;
			read_instr_0: 	out	std_logic_vector(146 downto 0);
			read_instr_1: 	out	std_logic_vector(146 downto 0)
	);
end COMPONENT;

COMPONENT AdderMem
  	GENERIC(
		wordSize: INTEGER;
		n_cycles: INTEGER
	);
  PORT (
	 clock:    		in 	 std_logic;
	 reset:	 		in 	 std_logic; 
    r_n: 			in  std_logic_vector(63 downto 0); 
	 data_address: in std_logic_vector(63 downto 0);
	 start: 			in std_logic; 
    s    : 			out  std_logic_vector(63 downto 0);
	 start_mem : 	out std_logic;
	 counter_out : 	out integer;
	 busy_out : 	out std_logic
    );
end COMPONENT;

COMPONENT Mem
  GENERIC (
    addressSize : INTEGER;
    wordSize    : INTEGER;
	 n_cycles: INTEGER
  );
  PORT (
    clock: in  std_logic;
	 reset: in std_logic;
	 start_mem : in std_logic; 
	 wr: in std_logic;
    addr   : in  std_logic_vector(63 downto 0); 
    data_i : in  std_logic_vector(63 downto 0); 
    data_o : out std_logic_vector(63 downto 0);
	 busy_mem : out std_logic;
	 addr_out : out integer; 
	 counter_mem : out integer;
	 load_cdb: out std_logic;
	 done : out std_logic 
  );
end COMPONENT;

SIGNAL	busyRS :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	cdb_o :  STD_LOGIC_VECTOR(67 DOWNTO 0);
SIGNAL	data_i :  STD_LOGIC_VECTOR(255 DOWNTO 0);
SIGNAL	load_cdb :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	RegFile1 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	RegFile2 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	RS1H :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	tag_1 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	tag_2 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	tag_i :  STD_LOGIC_VECTOR(15 DOWNTO 0);
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
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_22 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL	reg_write :  STD_LOGIC;

SIGNAL	alu_done01 :  STD_LOGIC;
SIGNAL	alu_done10 :  STD_LOGIC;
SIGNAL	alu_done11 :  STD_LOGIC;

signal busyLDSTR:	std_logic_vector(1 downto 0);		 
signal ldstr: std_logic; 
signal ldstr_write: std_logic; 
signal dt_address: std_logic_vector(8 downto 0);
signal done_ldstr: std_logic; 
signal busy_adder_in: std_logic;
signal ldstr_op: std_logic; 
signal v_n_out: std_logic_vector(63 downto 0);
signal v_t_out: std_logic_vector(63 downto 0);
signal dt_address_out: std_logic_vector(63 downto 0);
signal start_ldstr: std_logic; 
signal tag_ldstr: std_logic_vector(3 downto 0);
signal rMem1: std_logic_vector(146 downto 0);
signal rMem2: std_logic_vector(146 downto 0);
signal result_adder: std_logic_vector(63 downto 0);	
signal start_mem: std_logic;
signal mem_result: std_logic_vector(63 downto 0);
signal point_read:integer;	
signal point_write:integer;
signal busy_adder:std_logic;	
signal counter_out:integer;
signal busy_mem : std_logic;	
signal addr_out : integer; 
signal counter_mem : integer;
signal done_cdbs : integer;

BEGIN 


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

rMem1s <= rMem1;
rMem2s <= rMem2;


b2v_decoder : decoder
GENERIC MAP(fuBits => 3,
			nb_lines => 6,
			opBits => 4,
			regBits => 5,
			rsBits => 1,
			tagSize => 4,
			wordSize => 32,
			ldstrBits => 1,
			n_lines_ldstr => 2, 
			dt_addressSize => 9			
			)
PORT MAP(
		 load => SYNTHESIZED_WIRE_0,
		 busyRs => busyRS,
		 busyLDSTR=>busyLDSTR,
		 instruction => SYNTHESIZED_WIRE_1,
		 busy => SYNTHESIZED_WIRE_2,
		 writeMapRS => SYNTHESIZED_WIRE_11,
		 opCode => SYNTHESIZED_WIRE_28,
		 rjFiles => SYNTHESIZED_WIRE_26,
		 rkFiles => SYNTHESIZED_WIRE_27,
		 RSLineOneHot => RS1H,
		 writeMapAddr => SYNTHESIZED_WIRE_14,
		 writeMapData => SYNTHESIZED_WIRE_15,
		 ldstr=>ldstr,
		 ldstr_write=>ldstr_write,
		 dt_address=>dt_address
		 );
		 
b2v_ldstrQueue : LdstrQueue
GENERIC MAP(wordSize => 64,
			tagSize => 4,  
			nbOfLines => 2,  
			opBits => 1,
			FUTagSize => 3,		
			dt_addressSize => 9  		
			)
PORT MAP(
			clock => clock, 
			reset => reset, 
			load => ldstr_write,	
			alu_op_i => ldstr, 		
			v_n_in => RegFile1,
			v_t_in => RegFile2,
			q_n => tag_1,
			q_t => tag_2,
			done => done_ldstr,
			cdb => cdb_o,
			dt_address_in => dt_address,
			busy_adder_in => busy_adder_in,
			busy => busyLDSTR,
			alu_op_o => ldstr_op,
			v_n_out => v_n_out,
			v_t_out => v_t_out,
			dt_address_out => dt_address_out,
			start => start_ldstr,
			tag => tag_i(15 DOWNTO 12),
			point_reads => point_read,
			point_writes => point_write,
			done_cdbs => done_cdbs,
			read_instr_0 => rMem1,
			read_instr_1 => rMem2
		 );

b2v_addermem : AdderMem
  GENERIC MAP(
		wordSize => 64,
		n_cycles => 5
	)
  PORT MAP(
	 clock => clock,
	 reset => reset,
    r_n => v_n_out,
	 data_address => dt_address_out,
	 start => start_ldstr,
    s => result_adder,
	 start_mem => start_mem,
	 counter_out => counter_out,
	 busy_out => busy_adder_in
    );

b2c_mem : Mem
  GENERIC MAP (
    addressSize => 16,
    wordSize    => 64,
	 n_cycles => 7
  )
  PORT MAP(
    clock => clock,
	 reset => reset,
	 start_mem => start_mem, 
	 wr => ldstr_op,
    addr => result_adder,
    data_i => v_t_out, 
    data_o => data_i(255 DOWNTO 192),
	 busy_mem => busy_mem,
	 addr_out => addr_out,
	 counter_mem => counter_mem,
	 load_cdb => load_cdb(3),
	 done => done_ldstr);

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
			tagSize => 4
			)
PORT MAP(reset => reset,
		 clock => clock,
		 tag_write => SYNTHESIZED_WIRE_11,
		 cdb_tag => cdb_o(67 DOWNTO 64),
		 cdb_busy=>SYNTHESIZED_WIRE_16,
		 read_tag_1 => SYNTHESIZED_WIRE_26,
		 read_tag_2 => SYNTHESIZED_WIRE_27,
		 write_tag => SYNTHESIZED_WIRE_14,
		 write_tag_data => SYNTHESIZED_WIRE_15,
		 tag_1 => tag_1,
		 tag_2 => tag_2,
		 
		 t0=>t0,
		 t1=>t1,
		 t2=>t2,
		 t3=>t3,
		 t4=>t4,
		 t5=>t5,
		 
		 reg_write => reg_write,
		 write_reg => write_reg);


b2v_inst3 : regfiletomasulo
GENERIC MAP(regNum => 32,
			regNumBits => 5,
			wordSize => 64
			)
PORT MAP(reset => reset,
		 clock => clock,
		 reg_write => reg_write,
		 read_reg_1 => SYNTHESIZED_WIRE_26,
		 read_reg_2 => SYNTHESIZED_WIRE_27,
		 write_data => cdb_o(63 DOWNTO 0),
		 write_reg => write_reg,
		 
		 r0=>r0,
		 r1=>r1,
		 r2=>r2,
		 r3=>r3,
		 r4=>r4,
		 r5=>r5,
		 
		 read_data_1 => RegFile1,
		 read_data_2 => RegFile2);
 		 
		 
b2v_inst4 : fp
GENERIC MAP(delay => 2,
			wordSize => 64
			)
PORT MAP(reset => reset,
		 clock => clock,
		 execute => SYNTHESIZED_WIRE_19,
		 A => SYNTHESIZED_WIRE_20,
		 B => SYNTHESIZED_WIRE_21,
		 S => SYNTHESIZED_WIRE_22,
		 ready => alu_done11,
		 F => data_i(191 DOWNTO 128));		  

b2v_inst5 : cdb
GENERIC MAP(FUTagSize => 3,
			nbOfLines => 2,
			nFU => 4,
			tagSize => 4,
			wordSize => 64
			)
PORT MAP(clock => clock,
		 data_i => data_i,
		 load => load_cdb,
		 tag_i => tag_i,
		 busy => SYNTHESIZED_WIRE_16,
		 cdb_o => cdb_o);


b2v_RS_Add1 : rs
GENERIC MAP(FUTagSize => 3,
			nbOfLines => 2,
			opBits => 4,
			tagSize => 4,
			wordSize => 64
			)
PORT MAP(clock => clock,
		 reset => reset,
		 FU_Tag => "001",		 
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
		 tag => tag_i(3 DOWNTO 0),
		 
		 r0=>r010,
		 r1=>r011,
		 
		 v_j_o => SYNTHESIZED_WIRE_4,
		 v_k_o => SYNTHESIZED_WIRE_5);

		 

b2v_RS_Add2 : rs
GENERIC MAP(FUTagSize => 3,
			nbOfLines => 2,
			opBits => 4,
			tagSize => 4,
			wordSize => 64
			)
PORT MAP(clock => clock,
		 reset => reset,
		 FU_Tag => "010",
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
		 tag => tag_i(7 DOWNTO 4),
		 		 
		 r0=>r100,
		 r1=>r101,		 
		 
		 v_j_o => SYNTHESIZED_WIRE_8,
		 v_k_o => SYNTHESIZED_WIRE_9);


b2v_RS_Mult : rs
GENERIC MAP(FUTagSize => 3,
			nbOfLines => 2,
			opBits => 4,
			tagSize => 4,
			wordSize => 64
			)
PORT MAP(clock => clock,
		 reset => reset,
		 FU_Tag => "011",
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
		 tag => tag_i(11 DOWNTO 8),
		 alu_done=>alu_done11,
		 load_cdb=>load_cdb(2),
		 r0=>r110,
		 r1=>r111,		 
		 
		 v_j_o => SYNTHESIZED_WIRE_20,
		 v_k_o => SYNTHESIZED_WIRE_21);


END bdf_type;