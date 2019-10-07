library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- necessario para converter em integer
use ieee.std_logic_misc.all;

entity Decoder is
	generic(
		wordSize: natural :=32;
		regBits: natural := 5;
		rsBits:natural :=2;
		fuBits: natural := 2;
		tagSize:  natural := 4;
		opBits:	natural := 2		
	);
	port(
		clock:    		in 	 std_logic; -- clock
		load:				in		 std_logic; -- set by FIFO in case new instruction is available
      instruction:   in 	 std_logic_vector(wordSize-1 downto 0); -- instruction fro FIFO
		busyRs:			in		 std_logic_vector(2**rsBits-1 downto 0); -- array with busy bit from every line in a RS
		
		busy:				out    std_logic; -- indicates to FIFO if it is waiting for available line in RS
		rjMapFile:		out	 std_logic_vector(regBits-1 downto 0); -- address of operand Rj in MapFile
		rkMapFile:		out	 std_logic_vector(regBits-1 downto 0); -- address of operand Rk in MapFile
		rjRegFile:		out	 std_logic_vector(regBits-1 downto 0); -- address of operand RJ in RegFile
		rkRegFile:		out	 std_logic_vector(regBits-1 downto 0); -- address of operand Rk in RegFile
		
		opCode:			out    std_logic_vector(opBits-1 downto 0); -- write operation on RS line
		fuCode:			out	 std_logic_vector(fuBits-1 downto 0); -- signal to select busy data from RS and select which RS to write into
		fuCodeOneHot:	out	 std_logic_vector(2**fuBits-1 downto 0); -- Onehot signal of fucode for loading the instruction into the correct RS
		writeLine:		out	 std_logic_vector(rsBits-1 downto 0); -- line into which instruction will be written  
		RSLineOneHot:	out    std_logic_vector(2**rsBits-1 downto 0); -- line into which instruction will be written (onehot) 
		writeRS:			out	 std_logic; -- write into MapFile new entry
		writeAddr:		out	 std_logic_vector(regBits-1 downto 0); -- address of new MapFile entry (destination register)
		writeData:		out	 std_logic_vector(tagSize-1 downto 0) -- tag of new MapTable entry
		);
end Decoder;

architecture Decoder of Decoder is 

--type rs_lines is array (0 to nbOfLines-1) of std_logic_vector(2*wordSize+2*tagSize+4 downto 0);
--signal list_rs : rs_lines; 

begin

	process (clock)
	variable fuID : std_logic_vector(fuBits-1 downto 0);
	variable lineId : std_logic_vector(rsBits-1 downto 0);
	
	variable tempFuID : std_logic_vector(2**fuBits-1 downto 0);
	variable tempRSID : std_logic_vector(2**rsBits-1 downto 0);
	variable ind: integer;
	variable rj : std_logic_vector(regBits-1 downto 0);
	variable rk : std_logic_vector(regBits-1 downto 0);
	variable rd : std_logic_vector(regBits-1 downto 0);
	variable rsBusy : std_logic;
	begin
		if clock='1' and clock'event then				
			-- decode instruction
			if load = '1' then
				-- decode operation
				case instruction(31 downto 21) is 
					when "10001011000" => -- ADD
						opCode <= "00"; -- Operation 00 is ADD in fixed-point FU
						fuID := "00"; -- ID of fixed-point FU is 0 (supposing only one fixed-point FU)
						rj := instruction(9 downto 5); -- Rn in Green Card
						rk := instruction (20 downto 16); -- Rm in GreenCode
						rd := instruction(4 downto 0); -- Rd in Green Card
					when others => -- random values
						opCode <= "11";
						fuID := "00"; 
						rj := (others => '0'); 
						rk := (others => '0'); 
						rd := (others => '0'); 
				end case;
				
				-- One-hot FuCode
				tempFuID := (others => '0');
				ind := to_integer(unsigned(fuID));
				tempFuID(ind) := '1';
				fuCodeOneHot <= tempFuID;
				
				-- Get value of operands in RegFile
				rjRegFile <= rj;
				rkRegFile <= rk;
				
				-- Get address of RS in MapFile
				rjMapFile <= rj;
				rkMapFile <= rk;
				
				-- Verify if there is any RS available
				-- Use mux from busy signal from every RS in the architecture
				fuCode <= fuID;
				rsBusy := and_reduce(busyRs); -- and over all bits in busyRs
				
				if rsBusy = '1' then
					busy <= '1'; 
					writeRS <= '0';
					writeAddr <= (others => '0');
					writeData <= (others => '0');
					writeLine <= (others => '0');
				else
					busy<= '0';
					writeRS <= '1';
					writeAddr <= rd;
					-- loop over lines in the RS 
					for i in 0 to rsBits**2-1 loop
						if busyRS(i) = '0' then
							lineId := std_logic_vector(to_unsigned(i+1,writeLine'length)); -- RS counting begins with 1 (0 means no mapping)
							writeLine <= lineId;
						end if;
					end loop;
					
				end if;
				
				-- Tag of new MapFile entry
				writeData <= fuID & lineId;
				
				-- One-hot RSLine
				tempRSID := (others => '0');
				ind := to_integer(unsigned(lineId)) - 1; -- bit zero in onehot refers to line address 1 in RS
				tempRSID(ind) := '1';
				RSLineOneHot <= tempRSID;
				
			end if;		
						
		end if;
			
	end process;
		
end Decoder;
