library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- necessario para converter em integer
use ieee.std_logic_misc.all;

entity Decoder is
	generic(
		wordSize: natural :=32;
		regBits: natural := 5;
		rsBits:natural :=1;
		fuBits: natural := 3;
		tagSize:  natural := 4;
		opBits:	natural := 4;
		nb_lines: natural := 6; -- numero de linhas para o busyRs
		ldstrBits:natural := 1;
		n_lines_ldstr: natural := 2; -- number of lines of queue for effective addres calculation
		dt_addressSize:natural := 9  -- size of immediate to sum in address for str and ld instructions		
	);
	port(
--		clock:    		in 	 std_logic; -- clock
		load:				in		 std_logic; -- set by FIFO in case new instruction is available
      instruction:   in 	 std_logic_vector(wordSize-1 downto 0); -- instruction (from FIFO)
		--busyRs:			in		 std_logic_vector((((2**fuBits)-1)*(2**rsBits))-1 downto 0); -- array with busy bit from every line in a RS
		busyRs:			in		 std_logic_vector(nb_lines-1 downto 0); -- array with busy bit from every line in a RS
		
		busy:				out    std_logic; -- indicates (to FIFO) if it is waiting for available line in RS
		busyLDSTR:		in		 std_logic_vector(n_lines_ldstr-1 downto 0); -- array with busy bit from every line in queue for effective address calculation is full
	
	
		rjFiles:			out	 std_logic_vector(regBits-1 downto 0); -- address of operand Rj (to RegFile and MapFile)
		rkFiles:			out	 std_logic_vector(regBits-1 downto 0); -- address of operand Rk (to RegFile and MapFile)
		
		opCode:			out    std_logic_vector(opBits-1 downto 0); -- write operation on RS line (to RS)

--		fuCodeOneHot:	out	 std_logic_vector(2**fuBits-2 downto 0); -- Onehot signal of fucode for loading the instruction into the correct RS (to RS)
		--RSLineOneHot:	out    std_logic_vector(((2**fuBits-1)*2**rsBits)-1 downto 0); -- line into which instruction will be written (onehot) (to RS)
		RSLineOneHot:	out    std_logic_vector(nb_lines-1 downto 0); -- line into which instruction will be written (onehot) (to RS)
		
		--writeLine:		out	 std_logic_vector(rsBits-1 downto 0); -- line into which instruction will be written  
		--fuCode:			out	 std_logic_vector(fuBits-1 downto 0); -- signal to select busy data from RS and select which RS to write into
		
		writeMapRS:			out	 std_logic; -- write into MapFile new entry
		writeMapAddr:		out	 std_logic_vector(regBits-1 downto 0); -- address of new MapFile entry (destination register)
		writeMapData:		out	 std_logic_vector(tagSize-1 downto 0); -- tag of new MapTable entry (to MapFile)
		
		ldstr:			out	 std_logic; -- 1 if load or store
		ldstr_write:		out	std_logic; -- in case it is an str or ld instruction
		dt_address:			out   std_logic_vector(dt_addressSize-1 downto 0) -- immediate for str and ld		
		);
end Decoder;

architecture Decoder of Decoder is 

begin

	process (instruction, busyRS, load)
	variable fuID : std_logic_vector(fuBits-1 downto 0); -- id 0 is used for no mapping
	variable lineId : std_logic_vector(rsBits-1 downto 0);
	
	constant indAdd : integer := 1;
	constant nAdd: integer := 2;
	constant indMult: integer := 3;
	constant nMult: integer := 1;
	constant indMem: integer := 4;
	constant nMem: integer := 1;
	
	variable ind: integer;
	variable n : integer;
		
--	variable tempFuID : std_logic_vector(2**fuBits-2 downto 0); -- 0 is used for no mapping
	variable tempRSID : std_logic_vector(((2**fuBits-1)*2**rsBits)-1 downto 0); -- 0 is used for no mapping

	variable rj : std_logic_vector(regBits-1 downto 0);
	variable rk : std_logic_vector(regBits-1 downto 0);
	variable rd : std_logic_vector(regBits-1 downto 0);
	variable rsBusy : std_logic := '0';
	variable rsBusyAdd: std_logic;
	variable rsBusyMult: std_logic;
	variable rsBusyLdstr: std_logic;
	variable str: std_logic; -- in case it is an str instruction
	variable ld: std_logic; -- in case it is an ld instruction
	variable dt_address_temp : std_logic_vector(dt_addressSize-1 downto 0);	
	begin
		
		rsBusyAdd := and_reduce(busyRs((indAdd+nAdd-1)*2**rsBits-1 downto (indAdd-1)*2**rsBits));
		rsBusyMult := and_reduce(busyRs((indMult+nMult-1)*2**rsBits-1 downto (indMult-1)*2**rsBits));
		rsBusyLdstr := and_reduce(busyLDSTR); -- assuming only one queue for effective address calculation		
	
		--if clock='1' and clock'event then					
		-- decode instruction
		if load = '1' then
		-- decode operation
		case instruction(31 downto 21) is 
			when "10001011000" => -- ADD
				opCode <= "0000"; -- Operation 00 is ADD in fixed-point FU
				
				rsBusy := rsBusyAdd;
				ind := indAdd;
				n := nAdd;
				
				rj := instruction(9 downto 5); -- Rn in Green Card
				rk := instruction (20 downto 16); -- Rm in GreenCode
				rd := instruction(4 downto 0); -- Rd in Green Card
			when "11001011000" => -- Mult
				opCode <= "0010"; 
				
				rsBusy := rsBusyMult;
				ind := indMult;
				n := nMult;
				
				rj := instruction(9 downto 5); -- Rn in Green Card
				rk := instruction (20 downto 16); -- Rm in GreenCode
				rd := instruction(4 downto 0); -- Rd in Green Card
				
			when "11111000000" => -- STR operation
				opCode <= "0000"; -- store
				rsBusy := rsBusyLdstr;
				ind := indMem;
				n := nMem;
				str := '1';
				ld := '0';
				
				rj := instruction(9 downto 5); -- Rn in Green Card
				rk := instruction (4 downto 0); -- Rt in Green Card
				rd := (others => '0');
				dt_address_temp := instruction(20 downto 12); -- DT_address in Green Card
			when "11111000010" => -- LD operation
				opCode <= "1111"; -- load
				rsBusy := rsBusyLdstr;
				ind := indMem;
				n := nMem;
				str := '0';
				ld := '1';
				
				rj := instruction(9 downto 5); -- Rn in Green Card
				rk := (others => '0'); -- supposig it is the zero register
				dt_address_temp := instruction (20 downto 12); -- DT_address in Green Card
				rd := instruction(4 downto 0); -- Rt in Green Card				
			when others => -- random values
				opCode <= "0000";
				
				
				rsBusy := '0';
				n := 0;
				
				str := '0';
				ld := '0';
				
				rj := (others => '0'); 
				rk := (others => '0'); 
				rd := (others => '0'); 
		end case;


		-- Get value of operands in RegFile
		rjFiles <= rj;
		rkFiles <= rk;
		writeMapAddr <= rd;
		dt_address <= dt_address_temp;		



		-- Verify if there is any RS available
		if rsBusy = '1' or n = 0 then
			--busy <= '1'; 
			writeMapRS <= '0';
			--writeAddr <= (others => '0');
			writeMapData <= (others => '0');
			--writeLine <= (others => '0');
			RSLineOneHot <= (others => '0');
			ldstr_write <= '0';
			ldstr <= '0';			
		else
					if str = '1' then
--					   fuCodeOneHot <= (others => '0');
						RSLineOneHot <= (others => '0');
						writeMapRS <= '0';
						Loop_1: for i in 0 to 2**ldstrBits-1 loop						
							if busyLDSTR(i) = '0' then
								lineId := std_logic_vector(to_unsigned(i,ldstrBits)); -- RS counting begins with 1 (0 means no mapping)
								exit Loop_1;
							end if;
						end loop;
						ldstr_write <= '1';
						ldstr <= '0';
						fuId := std_logic_vector(to_unsigned(ind,fuBits));  -- assuming memory as id 0 always
						-- Tag of new MapFile entry
						writeMapData <= fuID & lineId;

					else
						if ld = '1' then
--							fuCodeOneHot <= (others => '0');
							RSLineOneHot <= (others => '0');
							writeMapRS <= '1';
							Loop_2: for i in 0 to 2**ldstrBits-1 loop						
								if busyLDSTR(i) = '0' then
									lineId := std_logic_vector(to_unsigned(i,ldstrBits)); -- RS counting begins with 1 (0 means no mapping)
									exit Loop_2;
								end if;
							end loop;
							ldstr_write <= '1';
							fuId := std_logic_vector(to_unsigned(ind,fuBits));  -- assuming memory as id 0 always
							-- Tag of new MapFile entry
							writeMapData <= fuID & lineId;
							ldstr <= '1';
						else	
					
							ldstr_write <= '0';
							ldstr <= '0';
							
							--busy<= '0';
							writeMapRS <= '1';
							--writeAddr <= rd;
							-- loop over lines in the RS 
							Loop_3: for i in 0 to 2**rsBits-1 loop
								Loop_4: for j in 0 to nAdd-1 loop
									if j >= n then
										exit Loop_4;
									end if;
									if busyRS((j+ind-1)*2**rsBits+i) = '0' then
										lineId := std_logic_vector(to_unsigned(i,rsBits)); -- RS counting begins with 1 (0 means no mapping)
										fuId := std_logic_vector(to_unsigned(j+ind,fuBits)); 
										--writeLine <= lineId;
										--fuCode <= fuID;
										exit Loop_3;
									end if;
								end loop;
							end loop;
							
									-- One-hot RSLine
							tempRSID := (others => '0');
							ind := to_integer(unsigned(fuID&lineID))-2**rsBits; 
							tempRSID(ind) := '1';
							RSLineOneHot <= tempRSID;

							
						end if;
					end if;	
		
		-- Tag of new MapFile entry
		writeMapData <= fuID & lineId;		
		
		end if;


		end if;

		busy <= rsBusy;
						
		--end if;
		
		
			
	end process;
		
end Decoder;