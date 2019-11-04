library ieee;
use ieee.numeric_bit.all;
USE ieee.std_logic_1164.all;   
use IEEE.STD_LOGIC_SIGNED.all;   

entity alu_tb is
  generic(delay: natural :=2; wordSize: natural := 64); -- number of cycles to execute
end entity alu_tb;

architecture tb of alu_tb is

	component alu
	  port (
		 reset : in std_logic;
		 clock : in std_logic;
		 execute : in std_logic;
--		 done : in std_logic;
--		 A  : in  signed(wordSize-1 downto 0); -- inputs
--		 B : in  signed(wordSize-1 downto 0); -- inputs
--		 F    : out signed(wordSize-1 downto 0); -- output		 
		 A  : in  std_logic_vector(wordSize-1 downto 0); -- inputs
		 B : in  std_logic_vector(wordSize-1 downto 0); -- inputs
		 F    : out std_logic_vector(wordSize-1 downto 0); -- output
		 S    : in  std_logic_vector (3 downto 0); -- ALUop selection
		 --Z    : out STD_LOGIC -- zero flag
--		timer: buffer std_logic_vector(3 downto 0);		 
		 ready : out std_logic
		 );
	end component;

	signal reset : std_logic;
	signal clock : std_logic;
--	signal done : std_logic;	
	signal execute : std_logic;
--	signal A  : signed(wordSize-1 downto 0); -- inputs
--	signal B : signed(wordSize-1 downto 0); -- inputs
--	signal F    : signed(wordSize-1 downto 0); -- output	
	signal A  : std_logic_vector(wordSize-1 downto 0); -- inputs
	signal B : std_logic_vector(wordSize-1 downto 0); -- inputs
	signal F    : std_logic_vector(wordSize-1 downto 0); -- output
	signal S    : std_logic_vector (3 downto 0); -- ALUop selection
	--Z    : out STD_LOGIC -- zero flag
--	signal timer    : std_logic_vector (3 downto 0); -- ALUop selection	
	signal ready : std_logic;
		
	constant clk_per : time := 1us;
	
begin
	
	u1: alu port map (
		reset=>reset,
		clock=>clock,
		execute=>execute,
--		done=>done,
		A=>A,
		B=>B,
		S=>S,
		F=>F,
--		timer=>timer,
		ready=>ready
	);
	
	tom_process: process
	begin
				
		
		-- init
		
		reset <= '0';
		clock <= '0';
		wait for clk_per/8;
		reset <= '1';
		execute <= '1';
		A <= x"0000000000000000";
		B <= x"0000000000000000";
		S <= "0000";
		wait for clk_per/8;
		reset <= '0';
		wait for clk_per/4;

		execute <= '1';
		A <= x"0000000000000007";
		B <= x"0000000000000001";
		S <= "0000";
		
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
		
		A <= x"0000000000000003";
		B <= x"0000000000000002";
		S <= "0000";			
		
		clock <= '1';
		wait for clk_per/2;
--		done <= '0';		
		clock <= '0';
		wait for clk_per/2;
		
--		done <= '1';
--		execute <= '0';	
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
--		done <= '0';	
		
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