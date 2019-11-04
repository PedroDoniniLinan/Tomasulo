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
		clock:    		in 	 std_logic; 
		
		load:				in		 std_logic_vector(nFU-1 downto 0); -- load from all FU when they want to write on the cdb
		--alu:				in		 std_logic_vector(nFU*(tagSize+wordSize)-1 downto 0); -- data+tag from all FU connected to the cdb
		
		data_i:				in		 std_logic_vector(nFU*(wordSize)-1 downto 0); -- data from all FU connected to the cdb
		tag_i:				in		 std_logic_vector(nFU*(tagSize)-1 downto 0); -- tag from all FU connected to the cdb
		
		busy:				out	 std_logic; -- cdb busy bit
		
		cdb_o:			out	std_logic_vector(tagSize+wordSize-1 downto 0)
	);
	end component;

	signal clock:    	std_logic := '0'; --! entrada de clock
	
	signal load: 		std_logic_vector(nFU-1 downto 0) := (others => '0');	
	signal data_i:		std_logic_vector(nFU*(wordSize)-1 downto 0); -- data from all FU connected to the cdb
	signal tag_i:		std_logic_vector(nFU*(tagSize)-1 downto 0); 
	
	signal busy:		std_logic := '0';
	
	signal cdb_o: 		std_logic_vector(tagSize+wordSize-1 downto 0);
	
	constant clk_per : time := 1us;
	
begin
	
	u1: cdb port map(
		clock=>clock,
		load=>load,
		tag_i=>tag_i,
		data_i=>data_i,
		busy=>busy,
		cdb_o=>cdb_o
	);
	
	cdb_process: process
	begin
		
		tag_i <= "110" & "100" & "010";
		data_i <= x"00000FFF"  & x"000000FF"  & x"0000000F";
		
		clock <= '0';
		wait for clk_per/2;
		clock <= '1';
		wait for clk_per/2;

		clock <= '0';
		wait for clk_per/2;
		
--		load <= "001";
		
		clock <= '1';
		wait for clk_per/2;

		clock <= '0';
		wait for clk_per/2;
		clock <= '1';
		wait for clk_per/2;
		
		clock <= '0';
		wait for clk_per/2;
		
--		load <= "011";
		
		clock <= '1';
		wait for clk_per/2;
		
		clock <= '0';
		wait for clk_per/2;
		
		load <= "001";
		
		clock <= '1';
		wait for clk_per/2;
		
		clock <= '0';
		wait for clk_per/2;
		
--		load <= "111";
		
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
		
		load <= "010";
		
		clock <= '1';
		wait for clk_per/2;	
		
		clock <= '0';
		wait for clk_per/2;
		clock <= '1';
		wait for clk_per/2;	
		
		load <= "000";
		
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