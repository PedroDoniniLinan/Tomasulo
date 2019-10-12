library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- necessario para converter em integer

entity cdb is
	generic(
		wordSize: natural :=4;
		tagSize:  natural :=3; -- tamanho da tag inteira 
		FUTagSize:natural :=2; -- numero de linhas da RS
		nbOfLines:natural :=2  -- tamanho do pedaço da tag que indica a qual FU pertence
	);
	port(
		clock:    		in 	 std_logic; --! entrada de clock
		
		load_add:		in		 std_logic;
		add_alu:			in		 std_logic_vector(tagSize+wordSize-1 downto 0);
		
		load_mult:		in		 std_logic;
		mult_alu:		in		 std_logic_vector(tagSize+wordSize-1 downto 0);
		
		busy:				out	 std_logic;
		
		cdb_o:			out	 std_logic_vector(tagSize+wordSize-1 downto 0)
	);
end cdb;

architecture cdb of cdb is 

signal cdb_busy: std_logic := '0';

begin

	process (clock) -- caso qualquer entrada sofra alguma alteracao, inicia process	
	begin
	if clock='0' and clock'event then
		if cdb_busy = '0' then
			if load_add = '1' then
				cdb_o <= add_alu;
				cdb_busy <= '1';
			elsif load_mult = '1' then
				cdb_o <= mult_alu;
				cdb_busy <= '1';
			end if;
		elsif cdb_busy ='1'then
			cdb_busy <= '0';
		end if;
	end if;

	busy <= cdb_busy;	
	end process;
end cdb;