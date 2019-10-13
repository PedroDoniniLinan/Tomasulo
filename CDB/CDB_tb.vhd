library ieee;
use ieee.std_logic_1164.all;

entity cdb_tb is
	generic(
		wordSize: natural :=32;
		tagSize:  natural :=3; -- tamanho da tag inteira 
		FUTagSize:natural :=2; -- numero de linhas da RS
		nFU: natural := 3;
		nbOfLines:natural :=2  -- tamanho do pedaço da tag que indica a qual FU pertence
	);
end cdb_tb;

architecture tb of cdb_tb is

	component cdb
	port(
		clock:    		in 	 std_logic; --! entrada de clock
		
		load:				in		 std_logic_vector(nFU-1 downto 0);
		alu:				in		 std_logic_vector(nFU*(tagSize+wordSize)-1 downto 0);
		
		busy:				out	 std_logic;
		
		cdb_o:			out	 std_logic_vector(tagSize+wordSize-1 downto 0)
	);
	end component;

	signal clock:    	std_logic := '0'; --! entrada de clock
	
	signal load: 		std_logic_vector(nFU-1 downto 0) := (others => '0');	
	signal alu: 		std_logic_vector(nFU*(tagSize+wordSize)-1 downto 0) := (others => '0');
	
	signal busy:		std_logic := '0';
	
	signal cdb_o: 		std_logic_vector(tagSize+wordSize-1 downto 0);
	
	constant clk_per : time := 1us;
	
begin
	
	u1: cdb port map(
		clock=>clock,
		load=>load,
		alu=>alu,
		busy=>busy,
		cdb_o=>cdb_o
	);
	
	cdb_process: process
	begin
		
		alu <= "110" & x"00000FFF" & "100" & x"000000FF" & "010" & x"0000000F";
		
		clock <= '0';
		wait for clk_per/2;
		clock <= '1';
		wait for clk_per/2;

		clock <= '0';
		wait for clk_per/2;
		
		load <= "001";
		
		clock <= '1';
		wait for clk_per/2;

		clock <= '0';
		wait for clk_per/2;
		clock <= '1';
		wait for clk_per/2;
		
		clock <= '0';
		wait for clk_per/2;
		
		load <= "011";
		
		clock <= '1';
		wait for clk_per/2;
		
		clock <= '0';
		wait for clk_per/2;
		clock <= '1';
		wait for clk_per/2;
		
		clock <= '0';
		wait for clk_per/2;
		
		load <= "111";
		
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
		
	end process;
	
	
end tb;