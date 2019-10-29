library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;                        

entity AdderMem is
  	generic(
		wordSize: natural :=32;
		n_cycles: natural := 4
	);
  port (
	 clock:    		in 	 std_logic; --! entrada de clock
	 reset:	 		in 	 std_logic; --! clear assíncrono
    r_n: in  std_logic_vector(wordSize-1 downto 0); 
	 data_address: in std_logic_vector(wordSize-1 downto 0);
	 start: in std_logic; -- input from ldstrQueue
    s    : out  std_logic_vector(15 downto 0); -- TEST!!!!!
	 start_mem : out std_logic; -- output to bufferMem
	 busy_out : out std_logic
    );
end entity AdderMem;

architecture AdderMem of AdderMem is
signal counter : integer;
signal busy : std_logic;

begin

	process (reset, clock) -- caso qualquer entrada sofra alguma alteracao, inicia process
	variable s_temp : std_logic_vector(wordSize-1 downto 0);
	begin
		
			if reset = '1' then		 
				counter <= 0;
				start_mem <= '0';
				s <= (others => '0');
				busy <= '0';
				
			elsif clock='1' and clock'event then
				s_temp := std_logic_vector(unsigned(r_n) + unsigned(data_address));
				s <= s_temp(15 downto 0);
				if start = '1' then
					busy <= '1';
					start_mem <= '0';					
				end if;
				
				if busy = '1' then
					counter <= counter + 1;					
				end if;
				
				if counter = n_cycles then
					busy <= '0';
					start_mem <= '1';
					counter <= 0;
				end if;
				
				busy_out <= busy;
			end if;
		end process;
end AdderMem;
