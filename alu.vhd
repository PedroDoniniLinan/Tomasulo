library ieee;
use ieee.numeric_bit.all;
USE ieee.std_logic_1164.all;                                


entity alu is
  generic(delay: natural :=5; wordSize: natural := 64); -- number of cycles to execute
  port (
    reset : in std_logic;
	 clock : in std_logic;
	 execute : in std_logic;
    A, B : in  signed(wordSize-1 downto 0); -- inputs
    F    : out signed(wordSize-1 downto 0); -- output
    S    : in  STD_LOGIC_VECTOR (3 downto 0); -- ALUop selection
    --Z    : out STD_LOGIC -- zero flag
	 ready : out std_logic
    );
end entity alu;

architecture functional of alu is
  signal aluout, altb: signed(63 downto 0) := (others=>'0');
  signal executing: std_logic := '0'; 
  signal timer : integer := 0;
begin
	process	 (reset, clock, S)
	begin
	
	if reset = '1' then		 
			executing <= '0';
			ready <= '0';
			F <= (others=>'0');
			
		elsif clock='1' and clock'event then
			-- if executing, count timer
			if executing = '1' then
				timer <= timer + 1;
				
				
			-- if execute signal received
			elsif execute = '1' then
				executing <= '1';
				ready <= '0';
						case S is
							when "0000" => aluout <= A and B;-- AND
							when "0001" => aluout <= A or  B;-- OR
							when "0010" => aluout <= A +   B;-- ADD
							when "0110" => aluout <= A -   B;-- SUB
							when "0111" => aluout <= B;		-- PASS B
							when "1100" => aluout <= A nor B;-- NOR
							when others => aluout <= (others=>'0') ;
						end case;
					
				
			end if;
			
			-- if delay reached
			if timer = delay then
				timer <= 0;
				ready <= '1';
				executing <= '0';
				-- Copying temporary signal to output
				F <= aluout;
				
			end if;
		end if;
		

  end process;
end architecture functional;
