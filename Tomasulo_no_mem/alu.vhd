library ieee;
--use ieee.numeric_bit.all;
USE ieee.std_logic_1164.all;   
use IEEE.STD_LOGIC_SIGNED.all;                               


entity alu is
  generic(delay: natural :=2; wordSize: natural := 64); -- number of cycles to execute
  port (
    reset : in std_logic;
	 clock : in std_logic;
	 execute : in std_logic;
	 done : in std_logic;
    A  : in  std_logic_vector(wordSize-1 downto 0); -- inputs
	 B : in  std_logic_vector(wordSize-1 downto 0); -- inputs
    F    : out std_logic_vector(wordSize-1 downto 0); -- output
    S    : in  std_logic_vector (3 downto 0); -- ALUop selection
    --Z    : out STD_LOGIC -- zero flag
	 timer: buffer std_logic_vector(3 downto 0);
	 ready : out std_logic
    );
end entity alu;

architecture functional of alu is
  signal aluout: std_logic_vector(63 downto 0) := (others=>'0');
--  signal executing: std_logic := '0'; 
--  signal timer : integer := 0;

begin
	
	process	 (reset, clock, S, A, B)
	begin
	
	if reset = '1' then		 
			ready <= '0';
			timer <= (others => '0');
			F <= (others=>'0');
			
	elsif clock='1' and clock'event then		
		
		if execute = '1' then
			timer <= timer + 1;
			
			case S is
				when "0000" => aluout <= A + B;-- AND
				when "0001" => aluout <= A -  B;-- OR
				when "0010" => aluout <= A and B;-- ADD	
				when "0110" => aluout <= A or  B;-- SUB
				when "0111" => aluout <= B;		-- PASS B
				when "1100" => aluout <= A nor B;-- NOR
				when others => aluout <= (others=>'0') ;
			end case;	
			
			
			if timer = "0010" then
				timer <= (others => '0');
				ready <= '1';
				F <= aluout;
			end if;
			
		end if;
		
		if done = '1' then
			ready <= '0';
			timer <= (others => '0');			
			if execute = '1' then
				timer <= timer + 1;
			end if;
		end if;		
		
	end if;		

  end process;
end architecture functional;
