library ieee;
use ieee.std_logic_1164.all;

entity cdb_tb is
	generic(
		wordSize: natural :=4;
		tagSize:  natural :=3; -- tamanho da tag inteira 
		FUTagSize:natural :=2; -- numero de linhas da RS
		nbOfLines:natural :=2  -- tamanho do pedaço da tag que indica a qual FU pertence
	);
end cdb_tb;

architecture tb of cdb_tb is

	component cdb
	port(
		clock:    		in 	 std_logic; --! entrada de clock
		
		load_add:		in		 std_logic;
		add_alu:			in		 std_logic_vector(tagSize+wordSize-1 downto 0);
		
		load_mult:		in		 std_logic;
		mult_alu:		in		 std_logic_vector(tagSize+wordSize-1 downto 0);
		
		busy:				buffer	 std_logic;
		
		cdb_o:			out	 std_logic_vector(tagSize+wordSize-1 downto 0)
	);
	end component;

	signal clock:    	std_logic := '0'; --! entrada de clock
	
	signal load_add: 	std_logic;	
	signal add_alu: 	std_logic_vector(tagSize+wordSize-1 downto 0);
	
	signal load_mult:	std_logic;	
	signal mult_alu:	std_logic_vector(tagSize+wordSize-1 downto 0);
	
	signal busy:		std_logic;
	
	signal cdb_o: 		std_logic_vector(tagSize+wordSize-1 downto 0);
	
	constant clk_per : time := 1us;
	
begin
	
	u1: cdb port map(
		clock=>clock,
		load_add=>load_add,
		add_alu=>add_alu,
		load_mult=>load_mult,
		mult_alu=>mult_alu,
		busy=>busy,
		cdb_o=>cdb_o
	);
	
	rs_process: process
	begin
		
		clock <= '0';
		wait for clk_per/2;
		clock <= '1';
		wait for clk_per/2;

		clock <= '0';
		wait for clk_per/2;
		
		load_add <= '1';
		add_alu <= (others => '1');
		
		clock <= '1';
		wait for clk_per/2;

		clock <= '0';
		wait for clk_per/2;
		clock <= '1';
		wait for clk_per/2;
		
		clock <= '0';
		wait for clk_per/2;
		
		load_mult <= '1';
		mult_alu <= (others => '0');
		
		clock <= '1';
		wait for clk_per/2;		
		
	end process;
	
	
end tb;