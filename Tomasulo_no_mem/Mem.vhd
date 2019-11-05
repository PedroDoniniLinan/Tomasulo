library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use std.textio.all;

entity Mem is
  generic (
    addressSize : natural := 16; -- for not having overflow
    wordSize    : natural := 64;
	 n_cycles: natural := 7
  );
  port (
    clock: in  std_logic;
	 reset: in std_logic;
	 start_mem : in std_logic; -- input from AdderMem
	 wr: in std_logic; -- input from LdstrQueue alu_op_o
    addr   : in  std_logic_vector(wordSize-1 downto 0); -- input from AdderMem
    data_i : in  std_logic_vector(wordSize-1 downto 0); -- input from LdstrQueue r_t
    data_o : out std_logic_vector(wordSize-1 downto 0); -- data to cdb
	 busy_mem : out std_logic;
	 addr_out : out integer; 
	 counter_mem : out integer;
	 load_cdb : out std_logic;
	 done : out std_logic -- output to ldstrQueue
  );
end Mem;

architecture Mem of Mem is
  constant depth : natural := 2**addressSize;
  type mem_type is array (0 to depth-1) of std_logic_vector(wordSize-1 downto 0);
  signal mem : mem_type;
  signal counter : integer;
  signal busy : std_logic;
begin
	process(clock, reset, start_mem)
	variable data_temp : std_logic_vector(wordSize-1 downto 0);
		begin
			if reset = '1' then		 
					counter <= 0;
					done <= '1';
					data_o <= (others => '0');
					
					
					mem(507) <= x"0000000000000001";
					
					
					busy <= '0';
					load_cdb <= '0';
			elsif clock='1' and clock'event then		
				if busy = '1' then
					counter <= counter + 1;					
				end if;
				
				if counter = n_cycles then
					data_temp := mem(to_integer(unsigned(addr(addressSize-1 downto 0))));
					data_o <= data_temp;
					busy <= '0';
					done <= '1';
					counter <= 0;
					load_cdb <= '1';
				else
					load_cdb <= '0';
				end if;
					
				if (wr='0') then
				  mem(to_integer(unsigned(addr(addressSize-1 downto 0)))) <= data_i;
				end if;

			end if;
			
			if start_mem = '1' then
				busy <= '1';
				done <= '0';
				data_o <= (others => '0');				
			end if;

		end process;
		counter_mem <= counter;
		addr_out <= to_integer(unsigned(addr(addressSize-1 downto 0)));
		busy_mem <= busy;
end Mem;