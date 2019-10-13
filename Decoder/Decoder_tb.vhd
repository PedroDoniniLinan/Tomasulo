library ieee;
use ieee.std_logic_1164.all;

entity decoder_tb is
	generic(
		wordSize: natural :=32;
		regBits: natural := 5;
		rsBits:natural :=1;
		fuBits: natural := 2;
		tagSize:  natural := 3;
		opBits:	natural := 4	
	);
end decoder_tb;

architecture tb of decoder_tb is

	component decoder
	port(
		clock:    		in 	 std_logic; -- clock
		load:				in		 std_logic; -- set by FIFO in case new instruction is available
      instruction:   in 	 std_logic_vector(wordSize-1 downto 0); -- instruction fro FIFO
		busyRs:			in		 std_logic_vector(((2**fuBits-1)*2**rsBits)-1 downto 0); -- array with busy bit from every line in a RS
		
		busy:				out    std_logic; -- indicates to FIFO if it is waiting for available line in RS
		rjFiles:			out	 std_logic_vector(regBits-1 downto 0); -- address of operand Rj in MapFile
		rkFiles:			out	 std_logic_vector(regBits-1 downto 0); -- address of operand Rk in MapFile
		
		opCode:			out    std_logic_vector(opBits-1 downto 0); -- write operation on RS line
		fuCode:			out	 std_logic_vector(fuBits-1 downto 0); -- signal to select busy data from RS and select which RS to write into
		fuCodeOneHot:	out	 std_logic_vector(2**fuBits-2 downto 0); -- Onehot signal of fucode for loading the instruction into the correct RS
		writeLine:		out	 std_logic_vector(rsBits-1 downto 0); -- line into which instruction will be written  
		RSLineOneHot:	out    std_logic_vector(((2**fuBits-1)*2**rsBits)-1 downto 0); -- line into which instruction will be written (onehot) 
		writeRS:			out	 std_logic; -- write into MapFile new entry
		writeAddr:		out	 std_logic_vector(regBits-1 downto 0); -- address of new MapFile entry (destination register)
		writeData:		out	 std_logic_vector(tagSize-1 downto 0) -- tag of new MapTable entry
	);
	end component;

	signal clock:    		std_logic := '0'; --! entrada de clock
	signal load:			std_logic; -- set by FIFO in case new instruction is available
	signal instruction:  std_logic_vector(wordSize-1 downto 0); -- instruction fro FIFO
	signal busyRs:			std_logic_vector(((2**fuBits-1)*2**rsBits)-1 downto 0); -- array with busy bit from every line in a RS
	
	signal busy:			std_logic; -- indicates to FIFO if it is waiting for available line in RS
	signal rjFiles:		std_logic_vector(regBits-1 downto 0); -- address of operand Rj in MapFile
	signal rkFiles:		std_logic_vector(regBits-1 downto 0); -- address of operand Rk in MapFile
	
	signal opCode:			std_logic_vector(opBits-1 downto 0); -- write operation on RS line
	signal fuCode:			std_logic_vector(fuBits-1 downto 0); -- signal to select busy data from RS and select which RS to write into
	signal fuCodeOneHot:	std_logic_vector(2**fuBits-2 downto 0); -- Onehot signal of fucode for loading the instruction into the correct RS
	signal writeLine:		std_logic_vector(rsBits-1 downto 0); -- line into which instruction will be written  
	signal RSLineOneHot:	std_logic_vector(((2**fuBits-1)*2**rsBits)-1 downto 0); -- line into which instruction will be written (onehot) 
	signal writeRS:		std_logic; -- write into MapFile new entry
	signal writeAddr:		std_logic_vector(regBits-1 downto 0); -- address of new MapFile entry (destination register)
	signal writeData:		std_logic_vector(tagSize-1 downto 0); -- tag of new MapTable entry
	
	constant clk_per : time := 1us;
	
begin
	
	u1: decoder port map(
		clock=>clock ,
		load=> load,
		instruction=>instruction,
		busyRS=>busyRS,
		
		busy=>busy,
		rjFiles=>rjFiles,
		rkFiles=>rkFiles,
		
		opCode=>opCode,
		fuCode=>fuCode,
		fuCodeOneHot=>fuCodeOneHot,
		writeLine=>writeLine,
		RSLineOneHot=>RSLineOneHot,
		writeRS=>writeRS,
		writeAddr=>writeAddr,
		writeData=>writeData
	);
	
	decoder_process: process
	begin

		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		load <= '1';
		instruction <= "10001011000" & "0" & x"FFFFF";
		busyRS <= "000000";

		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		busyRS <= "000001";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		busyRS <= "000101";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		busyRS <= "000111";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		
		busyRS <= "001111";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		busyRS <= "001101";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;		
		
		instruction <= "11001011000" & "0" & x"FFFFF";
		busyRS <= "001111";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		busyRS <= "011111";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		busyRS <= "111111";
		
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