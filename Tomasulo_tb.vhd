library ieee;
use ieee.std_logic_1164.all;

entity Tomasulo_tb is
	generic(
		wordSize: natural :=32;
		tagSize:  natural :=3; -- tamanho da tag inteira 
		FUTagSize:natural :=2; -- tamanho do pedaço da tag que indica a qual FU pertence
		nbOfLines:natural :=2; -- numero de linhas da RS 
		opBits: natural	:=4
	);
end Tomasulo_tb;

architecture tb of Tomasulo_tb is

	component Tomasulo
	PORT
	(
		reset :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC;
		TAG_RS_Add1 :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		TAG_RS_Add2 :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		TAG_RS_Mult :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
	end component;

	signal reset : std_logic;
	signal clock : std_logic;
	signal TAG_RS_Add1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal TAG_RS_Add2 : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal TAG_RS_Mult : STD_LOGIC_VECTOR(1 DOWNTO 0);
		
	constant clk_per : time := 1us;
	
begin
	
	u1: Tomasulo port map (
		reset=>reset,
		clock=>clock,
		TAG_RS_Add1=>TAG_RS_Add1,
		TAG_RS_Add2=>TAG_RS_Add2,
		TAG_RS_Mult=>TAG_RS_Mult
	);
	
	tom_process: process
	begin
				
		
		
		clock <= '0';
		wait for clk_per/8;
		reset <= '0';
		wait for clk_per/8;
		wait for clk_per/4;

		
		
		
	end process;
	
	
end tb;