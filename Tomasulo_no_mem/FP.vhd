--library ieee;
--use ieee.numeric_bit.all;
--USE ieee.std_logic_1164.all;                                
--use IEEE.STD_LOGIC_SIGNED.all;  
--
--entity FP is
--	generic(delay: natural :=5; wordSize: natural := 64); -- number of cycles to execute
--  port (
--    reset : in std_logic;
--	 clock : in std_logic;
--	 execute : in std_logic;
--    A, B : in  STD_LOGIC_VECTOR(wordSize-1 downto 0); -- inputs
--    F    : out STD_LOGIC_VECTOR(wordSize-1 downto 0); -- output
--    S    : in  STD_LOGIC_VECTOR (3 downto 0); -- op selection
--	 ready : out std_logic
--    );
--end entity FP;
--
--architecture fp of FP is
--  signal fpout : STD_LOGIC_VECTOR(wordsize-1 downto 0) := (others=>'0');
--  signal aux : STD_LOGIC_VECTOR(2*wordSize-1 downto 0); -- auxiliar signal for the multiply
----  signal fpout : signed(wordsize-1 downto 0) := (others=>'0');
----  signal aux : signed(2*wordSize-1 downto 0); -- auxiliar signal for the multiply
--  signal executing: std_logic := '0'; 
--  signal timer : integer := 0;
--begin
--process	 (reset, clock, S)
--	begin
--	
--	if reset = '1' then		 
--			executing <= '0';
--			ready <= '0';
--			F <= (others=>'0');
--			
--		elsif clock='1' and clock'event then
--			-- if executing, count timer
--			if executing = '1' then
--				timer <= timer + 1;
--				
--				
--			-- if execute signal received
--			elsif execute = '1' then
--				executing <= '1';
--				ready <= '0';
--						case S is
--							-- TODO : Correct op codes
--							when "0010" => 
--								aux <= A * B;-- MULT
--								fpout <= aux(wordSize-1 downto 0);
--							--when "0001" => fpout <= A / B;-- DIV
--							when others => fpout <= (others=>'0') ;
--						end case;
--					
--				
--			end if;
--			
--			-- if delay reached
--			if timer = delay - 2 then
--				timer <= 0;
--				ready <= '1';
--				executing <= '0';
--				-- Copying temporary signal to output
--				F <= fpout;
--				
--			end if;	
--		end if;
--	end process;
--end architecture fp;

library ieee;
use ieee.numeric_bit.all;
USE ieee.std_logic_1164.all;   
use IEEE.STD_LOGIC_SIGNED.all;                               


entity FP is
  generic(delay: natural :=3; wordSize: natural := 64); -- number of cycles to execute
  port (
    reset : in std_logic;
	 clock : in std_logic;
	 execute : in std_logic;
--	 done : in std_logic;
    A  : in  std_logic_vector(wordSize-1 downto 0); -- inputs
	 B : in  std_logic_vector(wordSize-1 downto 0); -- inputs
    F    : out std_logic_vector(wordSize-1 downto 0); -- output
    S    : in  std_logic_vector (3 downto 0); -- ALUop selection
    --Z    : out STD_LOGIC -- zero flag
--	 timer: buffer std_logic_vector(3 downto 0);
	 ready : out std_logic
    );
end entity FP;

architecture functional of FP is
  signal fpout: std_logic_vector(63 downto 0) := (others=>'0');
  signal aux : STD_LOGIC_VECTOR(2*wordSize-1 downto 0); -- auxiliar signal for the multiply
 
  signal timer : integer := 0;

begin
	
	process	 (reset, clock, S, A, B)
	
   variable executing: std_logic := '0';
	
	begin
	
	case S is
		-- TODO : Correct op codes
		when "0010" => 
			aux <= A * B;-- MULT
			fpout <= aux(wordSize-1 downto 0);
		--when "0001" => fpout <= A / B;-- DIV
		when others => fpout <= (others=>'0') ;
	end case;
	
	if reset = '1' then		 
			ready <= '0';
			timer <= 0;
--			F <= (others=>'0');
			
		elsif clock='1' and clock'event then
			-- if executing, count timer
			if executing = '1' then
				timer <= timer + 1;
			-- if execute signal received
			elsif execute = '1' then
				executing := '1';
				timer <= 0;
				ready <= '0';
			else
				timer <= 0;
				ready <= '0';
			end if;
			
			-- if delay reached
			if timer = delay - 1 then
				timer <= 0;
				ready <= '1';
				executing := '0';
				-- Copying temporary signal to output
				F <= fpout;
				
			end if;
		end if;	

  end process;
end architecture functional;
