library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;                               


entity Tomasulo_tb is
end Tomasulo_tb;

architecture tb of Tomasulo_tb is

	component Tomasulo
	PORT
	(
		rd_fifo: buffer std_logic;
		inst_fifo: buffer std_logic_vector(31 downto 0);
		fifo_has : buffer std_logic;

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
		F01 : 		buffer std_logic_vector(63 downto 0);		 

		A10 : 		buffer std_logic_vector(63 downto 0);
		B10 : 		buffer std_logic_vector(63 downto 0);
		F10 : 		buffer std_logic_vector(63 downto 0);		

		A11 : 		buffer std_logic_vector(63 downto 0);
		B11 : 		buffer std_logic_vector(63 downto 0);
		F11 : 		buffer std_logic_vector(63 downto 0);	

		cdb_b: buffer STD_LOGIC_VECTOR(67 DOWNTO 0);
		
--		ex01 : buffer std_logic;		
--		ex01 : buffer std_logic;
--		ex11 : buffer std_logic;
--		alu_done1 : buffer std_logic;
--		alu_done2 : buffer std_logic;
--		alu_done3 : buffer std_logic;
		load_cdbs : buffer std_logic_vector(3 downto 0);
		
--		write_regs: buffer std_logic_vector(4 downto 0);
--		reg_writes : buffer std_logic;		
		
		t0 : buffer std_logic_vector (3 downto 0);
		t1 : buffer std_logic_vector (3 downto 0);
		t2 : buffer std_logic_vector (3 downto 0);
		t3 : buffer std_logic_vector (3 downto 0);
		t4 : buffer std_logic_vector (3 downto 0);		
		t5 : buffer std_logic_vector (3 downto 0);

		r0 : buffer std_logic_vector (63 downto 0);
		r1 : buffer std_logic_vector (63 downto 0);
	   r2 : buffer std_logic_vector (63 downto 0); 
	   r3 : buffer std_logic_vector (63 downto 0); 
	   r4 : buffer std_logic_vector (63 downto 0); 
	   r5 : buffer std_logic_vector (63 downto 0);

		rMem1s : buffer std_logic_vector(146 downto 0);
		rMem2s : buffer std_logic_vector(146 downto 0);
		result_adders : buffer std_logic_vector (63 downto 0);
		ldstr_writes : buffer std_logic;
		start_ldstrs : buffer std_logic;
		point_reads : buffer integer; 
	   point_writes : buffer integer;
		busy_adders : buffer std_logic;
		counter_outs : buffer integer;
		mem_results : buffer std_logic_vector (63 downto 0);
		busy_mems : buffer std_logic;
		addr_outs : buffer integer; 
		counter_mems : buffer integer;
		done_cdbss : buffer integer;
		
		reset :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC
	);
	end component;

	signal rd_fifo: std_logic;
	signal inst_fifo: std_logic_vector(31 downto 0);
	signal fifo_has : std_logic;	
	
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
	
	signal A01: std_logic_vector(63 downto 0);
	signal B01: std_logic_vector(63 downto 0);
	signal F01: std_logic_vector(63 downto 0);
	
	signal A10: std_logic_vector(63 downto 0);
	signal B10: std_logic_vector(63 downto 0);
	signal F10: std_logic_vector(63 downto 0);	

	signal A11: std_logic_vector(63 downto 0);
	signal B11: std_logic_vector(63 downto 0);
	signal F11: std_logic_vector(63 downto 0);		

	signal cdb_b: std_logic_vector(67 downto 0);

----	signal ex01: std_logic;	
----	signal ex01: std_logic;	
--	signal ex11: std_logic;	
----	signal alu_done1: std_logic;
----	signal alu_done2: std_logic;
--	signal alu_done3: std_logic;
	signal load_cdbs: std_logic_vector(3 downto 0);	

--	signal write_regs: std_logic_vector(4 downto 0);	
--	signal reg_writes : std_logic;	

	signal t0: std_logic_vector(3 downto 0);
	signal t1: std_logic_vector(3 downto 0);
	signal t2: std_logic_vector(3 downto 0);
	signal t3: std_logic_vector(3 downto 0);
	signal t4: std_logic_vector(3 downto 0);
	signal t5: std_logic_vector(3 downto 0);

	signal r0: std_logic_vector(63 downto 0);	
	signal r1: std_logic_vector(63 downto 0);
	signal r2: std_logic_vector(63 downto 0);
	signal r3: std_logic_vector(63 downto 0);
	signal r4: std_logic_vector(63 downto 0);
	signal r5: std_logic_vector(63 downto 0);
	
	signal rMem1s: std_logic_vector(146 downto 0);
	signal rMem2s: std_logic_vector(146 downto 0);
	signal result_adders: std_logic_vector(63 downto 0);
	signal ldstr_writes : std_logic;
	signal start_ldstrs : std_logic;
	signal point_read : integer; 
	signal point_write : integer;
	signal busy_adder:std_logic;	
	signal counter_out:integer;
	signal mem_result : std_logic_vector (63 downto 0);
	signal busy_mem : std_logic;
	signal addr_out : integer; 
	signal counter_mem : integer;
	signal done_cdbss : integer;
	
	signal reset : std_logic;
	signal clock : std_logic;
		
	constant clk_per : time := 1us;
	
begin
	
	u1: Tomasulo port map (
		rd_fifo=>rd_fifo,
		inst_fifo=>inst_fifo,
		fifo_has=>fifo_has,
		
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
		A01=>A01,
		B01=>B01,
		F01=>F01,
--		
		A10=>A10,
		B10=>B10,
		F10=>F10,

		A11=>A11,
		B11=>B11,
		F11=>F11,		

		cdb_b=>cdb_b,
		
		load_cdbs => load_cdbs,
		 t0=>t0,
		 t1=>t1,
		 t2=>t2,
		 t3=>t3,
		 t4=>t4,
		 t5=>t5,

		 r0=>r0,
		 r1=>r1,
		 r2=>r2,
		 r3=>r3,
		 r4=>r4,
		 r5=>r5,

		rMem1s => rMem1s,
		rMem2s => rMem2s,
		result_adders => result_adders,
		ldstr_writes => ldstr_writes,
		start_ldstrs => start_ldstrs,
		point_reads => point_read,
		point_writes => point_write,
		busy_adders => busy_adder,
		counter_outs => counter_out,
		mem_results => mem_result,
		busy_mems => busy_mem,
		addr_outs => addr_out,
		counter_mems	=> counter_mem,
		done_cdbss => done_cdbss,
		
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
		
		
	end process;
	
	
end tb;