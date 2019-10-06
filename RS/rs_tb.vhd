library ieee;
use ieee.std_logic_1164.all;

entity rs_tb is
	generic(
		wordSize: natural :=4;
		tagSize:  natural :=3; 
		FUTagSize:natural :=2; 
		nbOfLines:natural :=2  
	);
end rs_tb;

architecture tb of rs_tb is

	component rs
	port(
		clock:    		in 	 std_logic; --! entrada de clock
		reset:	 		in 	 std_logic; --! clear assíncrono
		load:      		in 	 std_logic;	-- carrega valor

		FU_tag:  		in	    std_logic_vector(FUTagSize-1 downto 0);
		
		alu_op_i:   	in		 std_logic_vector(3 downto 0); 
		v_j_i:  		 	in		 std_logic_vector(wordSize-1 downto 0);
		v_k_i:  		 	in		 std_logic_vector(wordSize-1 downto 0);
		q_j_i:  		 	in		 std_logic_vector(tagSize-1 downto 0);
		q_k_i:  		 	in		 std_logic_vector(tagSize-1 downto 0);
		
		cdb:				in		 std_logic_vector(wordSize+tagSize-1 downto 0);
		
		r0 : 		buffer std_logic_vector(2*wordSize+2*tagSize+4 downto 0);
		r1 : 		buffer std_logic_vector(2*wordSize+2*tagSize+4 downto 0);
		
		busy:				out	 std_logic;
		
		alu_op_o:   	out	 std_logic_vector(3 downto 0); 
		v_j_o:  		 	out	 std_logic_vector(wordSize-1 downto 0);
		v_k_o:  		 	out	 std_logic_vector(wordSize-1 downto 0);
		
		tag:  		 	buffer	 std_logic_vector(tagSize-1 downto 0)
	);
	end component;

	signal clock:    	std_logic := '0'; --! entrada de clock
	signal reset:	 	std_logic := '0'; --! clear assíncrono
	signal load:      std_logic := '0'; 
	signal FU_tag:  	std_logic_vector(FUTagSize-1 downto 0);
	
	signal alu_op_i:  std_logic_vector(3 downto 0) := (others => '0'); 
	signal v_j_i:  	std_logic_vector(wordSize-1 downto 0) := (others => '0');
	signal v_k_i:     std_logic_vector(wordSize-1 downto 0) := (others => '0');
	signal q_j_i:  	std_logic_vector(tagSize-1 downto 0) := (others => '0');
	signal q_k_i:  	std_logic_vector(tagSize-1 downto 0) := (others => '0');
	
	signal cdb:			std_logic_vector(wordSize+tagSize-1 downto 0) := (others => '0');
		
	signal r0 :  std_logic_vector(2*wordSize+2*tagSize+4 downto 0);
	signal r1 :  std_logic_vector(2*wordSize+2*tagSize+4 downto 0);
		
	signal busy:		std_logic;
	
	signal alu_op_o:	std_logic_vector(3 downto 0);
	signal v_j_o:  	std_logic_vector(wordSize-1 downto 0);
	signal v_k_o:  	std_logic_vector(wordSize-1 downto 0);
	
	signal tag:  		std_logic_vector(tagSize-1 downto 0);
	
	constant clk_per : time := 1us;
	
begin
	
	u1: rs port map(
		clock=>clock ,
		reset=>reset ,
		load=>load ,
		
		FU_Tag=>FU_Tag,
		
		alu_op_i=>alu_op_i ,
		v_j_i=>v_j_i ,
		v_k_i=>v_k_i ,
		q_j_i=>q_j_i ,
		q_k_i=>q_k_i,
		
		cdb=>cdb,
		
		r0=>r0,
		r1=>r1,
		
		busy=>busy,
		
		alu_op_o=>alu_op_o ,
		v_j_o=>v_j_o ,
		v_k_o=>v_k_o,
		tag=>tag
	);
	
	rs_process: process
	begin
				
		FU_Tag <= "11";
		
		reset <= '1';
		
		clock <= '0';
		wait for clk_per/8;
		reset <= '0';
		wait for clk_per/8;
		wait for clk_per/4;

		-- emissao da 1a instrucao
		
		load <= '1';
		alu_op_i <= x"B";
		v_j_i <= x"0";
		v_k_i <= x"9";
		q_j_i <= "001";
		q_k_i <= "000";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		-- emissao da 2a instrucao
		
		alu_op_i <= x"C";
		v_j_i <= x"0";
		v_k_i <= x"A";
		q_j_i <= "001";
		q_k_i <= "000";
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		-- emissao da 3a instrucao (n é carregada imediatamente - rs cheia)
				
		alu_op_i <= x"D";
		v_j_i <= x"0";
		v_k_i <= x"2";
		q_j_i <= "001";
		q_k_i <= "000";
		
		clock <= '1';
		wait for clk_per/2;		
		
		-- valor esperado pelas duas linhas aparece no cdb
		
		cdb(wordSize+tagSize-1 downto wordSize) <= "001";
		cdb(wordSize-1 downto 0) <= x"F";
		
		clock <= '0';
		wait for clk_per/2;
		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		clock <= '1';
		wait for clk_per/2;

		-- execucao da 1a instrucao termina e valor é colocado no cdb
		
		cdb(wordSize+tagSize-1 downto wordSize) <= "110";
		cdb(wordSize-1 downto 0) <= x"F";		

		clock <= '0';
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