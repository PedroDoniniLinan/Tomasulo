library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- necessario para converter em integer

entity cdb is
	generic(
		wordSize: natural :=32;
		tagSize:  natural :=3; -- size of the whole tag 
		FUTagSize:natural :=2; -- part of the tag that indicates the FU
		nFU: natural := 3;	  -- number of FU
		nbOfLines:natural :=2  -- number of lines of each RS
	);
	port(
		clock:    		in 	 std_logic; 
		
		load:				in		 std_logic_vector(nFU-1 downto 0); -- load from all FU when they want to write on the cdb
		alu:				in		 std_logic_vector(nFU*(tagSize+wordSize)-1 downto 0); -- data+tag from all FU connected to the cdb
		
		busy:				out	 std_logic; -- cdb busy bit
		
		cdb_o:			out	 std_logic_vector(tagSize+wordSize-1 downto 0) -- data+tag on the cdb
	);
end cdb;

architecture cdb of cdb is 

signal cdb_busy: std_logic := '0';


begin

	process (clock) -- caso qualquer entrada sofra alguma alteracao, inicia process	
	
	variable start: integer := 0;
	variable ind: integer := 0;
	
	begin
	if clock='0' and clock'event then
		if cdb_busy = '0' then
			for i in 0 to nFU-1 loop
				ind := start + i;
				if ind >= nFU then
					ind := ind - nFU;
					start := -1;
				end if;
				if load(ind) = '1' then
					cdb_o <= alu((ind+1)*(wordSize+tagSize)-1 downto ind*(wordSize+tagSize));
					cdb_busy <= '1';
					start := ind + 1;
					exit;
				end if;
			end loop;
		elsif cdb_busy ='1'then
			cdb_busy <= '0';
		end if;
	end if;

	busy <= cdb_busy;	
	end process;
end cdb;