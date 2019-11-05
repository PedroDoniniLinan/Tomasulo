library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;                               


entity Tomasulo_tb is
end Tomasulo_tb;

architecture tb of Tomasulo_tb is

	component Tomasulo
	PORT
	(
		opCopeDec : buffer STD_LOGIC_VECTOR(3 DOWNTO 0);
		rjDec : buffer STD_LOGIC_VECTOR(4 DOWNTO 0);
		rkDec : buffer STD_LOGIC_VECTOR(4 DOWNTO 0); 		 
		rs1hot : buffer STD_LOGIC_VECTOR(5 DOWNTO 0);
		regTagAddr : buffer STD_LOGIC_VECTOR(4 DOWNTO 0);
		regTag : buffer STD_LOGIC_VECTOR(3 DOWNTO 0);		

		r010 : 		buffer std_logic_vector(140 downto 0);
		r011 : 		buffer std_logic_vector(140 downto 0);
		r100 : 		buffer std_logic_vector(140 downto 0);
		r101 : 		buffer std_logic_vector(140 downto 0);		
		r110 : 		buffer std_logic_vector(140 downto 0);
		r111 : 		buffer std_logic_vector(140 downto 0);	
	

		A01 : 		buffer std_logic_vector(63 downto 0);
		B01 : 		buffer std_logic_vector(63 downto 0);		 

		A10 : 		buffer std_logic_vector(63 downto 0);
		B10 : 		buffer std_logic_vector(63 downto 0);		

		A11 : 		buffer std_logic_vector(63 downto 0);
		B11 : 		buffer std_logic_vector(63 downto 0);

		cdb_b: buffer STD_LOGIC_VECTOR(67 DOWNTO 0);
		
		t0 : buffer std_logic_vector (3 downto 0);
		t1 : buffer std_logic_vector (3 downto 0);
		t2 : buffer std_logic_vector (3 downto 0);
		t3 : buffer std_logic_vector (3 downto 0);
		t4 : buffer std_logic_vector (3 downto 0);		

		r0 : buffer std_logic_vector (63 downto 0);
		r1 : buffer std_logic_vector (63 downto 0);
	   r2 : buffer std_logic_vector (63 downto 0); 
	   r3 : buffer std_logic_vector (63 downto 0); 
	   r4 : buffer std_logic_vector (63 downto 0); 

		rMem1s : buffer std_logic_vector(146 downto 0);
		rMem2s : buffer std_logic_vector(146 downto 0);
		
		reset :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC
	);
	end component;

	signal reset : std_logic;
	signal clock : std_logic;
	
	signal opCopeDec : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal rjDec : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal rkDec : STD_LOGIC_VECTOR(4 DOWNTO 0); 		 
	signal rs1hot : STD_LOGIC_VECTOR(5 DOWNTO 0);
	signal regTagAddr : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal regTag : STD_LOGIC_VECTOR(3 DOWNTO 0);


	signal r010: std_logic_vector(140 downto 0);	
	signal r011: std_logic_vector(140 downto 0);	
	signal r100: std_logic_vector(140 downto 0);	
	signal r101: std_logic_vector(140 downto 0);		
	signal r110: std_logic_vector(140 downto 0);	
	signal r111: std_logic_vector(140 downto 0);
	signal rMem1s: std_logic_vector(146 downto 0);
	signal rMem2s: std_logic_vector(146 downto 0);	
	signal cdb_b: std_logic_vector(67 downto 0);
	
	signal A01: std_logic_vector(63 downto 0);
	signal B01: std_logic_vector(63 downto 0);
	
	signal A10: std_logic_vector(63 downto 0);
	signal B10: std_logic_vector(63 downto 0);

	signal A11: std_logic_vector(63 downto 0);
	signal B11: std_logic_vector(63 downto 0);		

	signal r0: std_logic_vector(63 downto 0);	
	signal r1: std_logic_vector(63 downto 0);
	signal r2: std_logic_vector(63 downto 0);
	signal r3: std_logic_vector(63 downto 0);
	signal r4: std_logic_vector(63 downto 0);

	signal t0: std_logic_vector(3 downto 0);
	signal t1: std_logic_vector(3 downto 0);
	signal t2: std_logic_vector(3 downto 0);
	signal t3: std_logic_vector(3 downto 0);
	signal t4: std_logic_vector(3 downto 0);
		
	constant clk_per : time := 1us;
	
begin
	
	u1: Tomasulo port map (
		opCopeDec=>opCopeDec,
		rjDec=>rjDec,
		rkDec=>rkDec,
		rs1hot=>rs1hot,
		regTagAddr=>regTagAddr,
		regTag=>regTag,
		
		r010=>r010,
		r011=>r011,
		r100=>r100,
		r101=>r101,
		r110=>r110,
		r111=>r111,
		rMem1s=>rMem1s,
		rMem2s=>rMem2s,
		
		A01=>A01,
		B01=>B01,

		A10=>A10,
		B10=>B10,

		A11=>A11,
		B11=>B11,		

		cdb_b=>cdb_b,
		
		 t0=>t0,
		 t1=>t1,
		 t2=>t2,
		 t3=>t3,
		 t4=>t4,

		 r0=>r0,
		 r1=>r1,
		 r2=>r2,
		 r3=>r3,
		 r4=>r4,
		 
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