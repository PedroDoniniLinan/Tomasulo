library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;                               


entity Tomasulo_tb is
end Tomasulo_tb;

architecture tb of Tomasulo_tb is

	component Tomasulo
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

--		A11 : 		buffer std_logic_vector(63 downto 0);
--		B11 : 		buffer std_logic_vector(63 downto 0);
--		F11 : 		buffer std_logic_vector(63 downto 0);	

		cdb_b: buffer STD_LOGIC_VECTOR(66 DOWNTO 0);
		
		alu_done1 : buffer std_logic;
		alu_done2 : buffer std_logic;
		load_cdbs : buffer std_logic_vector(2 downto 0);		
		
		reset :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC
	);
	end component;

	signal rd_fifo: std_logic;
	signal inst_fifo: std_logic_vector(31 downto 0);
	signal fifo_has : std_logic;	
	
	signal opCopeDec : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal rjDec : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal rkDec : STD_LOGIC_VECTOR(4 DOWNTO 0); 		 
	signal rs1hot : STD_LOGIC_VECTOR(5 DOWNTO 0);
	signal regTagAddr : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal regTag : STD_LOGIC_VECTOR(2 DOWNTO 0);


	signal r010: std_logic_vector(138 downto 0);	
	signal r011: std_logic_vector(138 downto 0);	
	signal r100: std_logic_vector(138 downto 0);	
	signal r101: std_logic_vector(138 downto 0);		
	signal r110: std_logic_vector(138 downto 0);	
	signal r111: std_logic_vector(138 downto 0);	
	
	signal A01: std_logic_vector(63 downto 0);
	signal B01: std_logic_vector(63 downto 0);
	signal F01: std_logic_vector(63 downto 0);
	
	signal A10: std_logic_vector(63 downto 0);
	signal B10: std_logic_vector(63 downto 0);
	signal F10: std_logic_vector(63 downto 0);	

--	signal A11: std_logic_vector(63 downto 0);
--	signal B11: std_logic_vector(63 downto 0);
--	signal F11: std_logic_vector(63 downto 0);		

	signal cdb_b: std_logic_vector(66 downto 0);

	signal alu_done1: std_logic;
	signal alu_done2: std_logic;
	signal load_cdbs: std_logic_vector(2 downto 0);	
	
	signal reset : std_logic;
	signal clock : std_logic;
		
	constant clk_per : time := 1us;
	
begin
	
	u1: Tomasulo port map (
		rd_fifo=>rd_fifo,
		inst_fifo=>inst_fifo,
		fifo_has=>fifo_has,
		
		opCopeDec=>opCopeDec,
		rjDec=>rjDec,
		rkDec=>rkDec,
		rs1hot=>rs1hot,
		regTagAddr=>regTagAddr,
		regTag=>regTag,
		
		r010=>r010,
		r011=>r011,
		r100=>r100,
		r101=>r101,
		r110=>r110,
		r111=>r111,
		A01=>A01,
		B01=>B01,
		F01=>F01,
--		
		A10=>A10,
		B10=>B10,
		F10=>F10,

--		A11=>A11,
--		B11=>B11,
--		F11=>F11,		

		cdb_b=>cdb_b,
		
		alu_done1=>alu_done1,
		alu_done2=>alu_done2,
		load_cdbs=>load_cdbs,

		reset=>reset,
		clock=>clock
		
	);
	
	tom_process: process
	begin
				
		
		-- init
		
		reset <= '0';
		clock <= '0';
		wait for clk_per/8;
		reset <= '1';
		wait for clk_per/8;
		reset <= '0';
		wait for clk_per/4;

		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;	
	
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;	

		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;		
		
		
	end process;
	
	
end tb;