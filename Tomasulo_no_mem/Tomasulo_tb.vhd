library ieee;
use ieee.std_logic_1164.all;

entity Tomasulo_tb is
end Tomasulo_tb;

architecture tb of Tomasulo_tb is

	component Tomasulo
	PORT
	(
		rd_fifo: buffer std_logic;
		inst_fifo: buffer std_logic_vector(31 downto 0);	
		reset :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC
	);
	end component;

	signal rd_fifo: std_logic;
	signal inst_fifo: std_logic_vector(31 downto 0);	
	
	signal reset : std_logic;
	signal clock : std_logic;
		
	constant clk_per : time := 1us;
	
begin
	
	u1: Tomasulo port map (
		reset=>reset,
		clock=>clock
	);
	
	tom_process: process
	begin
				
		
		-- init
		
		reset <= '0';
		clock <= '0';
		wait for clk_per/8;
		reset <= '1';
		wait for clk_per/8;
		reset <= '0';
		wait for clk_per/4;

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
		
		
	end process;
	
	
end tb;