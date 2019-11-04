library ieee;
use ieee.std_logic_1164.all;

entity rs_tb is
	generic(
		wordSize: natural :=32;
		tagSize:  natural :=3; -- tamanho da tag inteira 
		FUTagSize:natural :=2; -- tamanho do pedaço da tag que indica a qual FU pertence
		nbOfLines:natural :=2; -- numero de linhas da RS 
		opBits: natural	:=4
	);
end rs_tb;

architecture tb of rs_tb is

	component rs
	port(
		clock:    		in 	 std_logic; --! entrada de clock
		reset:	 		in 	 std_logic; --! clear assíncrono
		load:      		in 	 std_logic_vector(nbOfLines-1 downto 0); -- carrega valor em linha da rs (from decoder)
--		loadFU:			in 	 std_logic;	-- indica se a FU dessa RS pode receber a instrução (from decoder)

		-- indica numero da FU a qual rs esta ligada (ex.: FUTagSize = 2 => FU_Tag = 01, 10 ou 11)
		-- Add1 = 01; Add2 = 10; Mult = 11; neither = 00
		-- a ideia é ter isso como entrada na arquitetura estrutural do vhdl do tomasulo completo
		-- hard coded
		FU_tag:  		in	    std_logic_vector(FUTagSize-1 downto 0); -- tag da FU 
		 
		
		-- conteudo da instrucao a ser armazenada (from decoder)
		alu_op_i:   	in		 std_logic_vector(opBits-1 downto 0); 		-- Operacao da ALU (decoder)
		v_j_i:  		 	in		 std_logic_vector(wordSize-1 downto 0);	-- Valores (regfile)
		v_k_i:  		 	in		 std_logic_vector(wordSize-1 downto 0);
		q_j_i:  		 	in		 std_logic_vector(tagSize-1 downto 0);		-- Tags de operandos sendo esperados (map file)
		q_k_i:  		 	in		 std_logic_vector(tagSize-1 downto 0);
		
		
		alu_done: in std_logic;
		
		-- entrada vinda do cdb para pegar operandos sendo esperados (from cdb)
		cdb:				in		 std_logic_vector(wordSize+tagSize-1 downto 0); 
		
		
		
		-- sinal de busy de todas linhas da rs (to decoder)
		busy:				out	 std_logic_vector(nbOfLines-1 downto 0);
		
		
		
		-- saidas para a ALU (to alu)
		alu_op_o:   	out	 std_logic_vector(opBits-1 downto 0); 
		v_j_o:  		 	out	 std_logic_vector(wordSize-1 downto 0);
		v_k_o:  		 	out	 std_logic_vector(wordSize-1 downto 0);
		
		-- tag da instrucao que esta sendo alimentada para a ALU e que vai para o cdb (to cdb)
		tag:  		 	out	 std_logic_vector(tagSize-1 downto 0);
		
		load_cdb:				out std_logic;
		
		-- inicia execução na alu (to alu)
		ready:			out	 std_logic;
		
		-- buffer para o testbench (retirar depois)
		r0 : 		buffer std_logic_vector(2*wordSize+2*tagSize+opBits downto 0);
		r1 : 		buffer std_logic_vector(2*wordSize+2*tagSize+opBits downto 0)
	);
	end component;

	signal clock:    	std_logic := '0'; --! entrada de clock
	signal reset:	 	std_logic := '0'; --! clear assíncrono
	signal load:      std_logic_vector(nbOfLines-1 downto 0) := (others => '0'); 
--	signal loadFU:		std_logic := '0';	 	
	signal FU_tag:  	std_logic_vector(FUTagSize-1 downto 0);
	
	signal alu_op_i:  std_logic_vector(3 downto 0) := (others => '0'); 
	signal v_j_i:  	std_logic_vector(wordSize-1 downto 0) := (others => '0');
	signal v_k_i:     std_logic_vector(wordSize-1 downto 0) := (others => '0');
	signal q_j_i:  	std_logic_vector(tagSize-1 downto 0) := (others => '0');
	signal q_k_i:  	std_logic_vector(tagSize-1 downto 0) := (others => '0');
	
	signal cdb:			std_logic_vector(wordSize+tagSize-1 downto 0) := (others => '0');
		
	signal r0 :  std_logic_vector(2*wordSize+2*tagSize+opBits downto 0);
	signal r1 :  std_logic_vector(2*wordSize+2*tagSize+opBits downto 0);
		
	signal busy:		std_logic_vector(nbOfLines-1 downto 0);
	signal load_cdb:		std_logic;
	signal alu_done:		std_logic;
	signal ready:		std_logic;
	
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
--		loadFU=>loadFU,
		
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
		ready=> ready,
		alu_done=>alu_done,
		load_cdb=>load_cdb,
		
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
		
		load <= "01";
--		loadFU <= '1';
		alu_op_i <= x"B";
		v_j_i <= x"00000000";
		v_k_i <= x"99999999";
		q_j_i <= "001";
		q_k_i <= "000";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		-- emissao da 2a instrucao
		
		alu_op_i <= x"C";
		v_j_i <= x"00000000";
		v_k_i <= x"AAAAAAAA";
		q_j_i <= "001";
		q_k_i <= "000";
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		load <= "10";
		alu_done <= '1';
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		-- emissao da 3a instrucao (n é carregada imediatamente - rs cheia)
				
		alu_op_i <= x"D";
		v_j_i <= x"00000000";
		v_k_i <= x"22222222";
		q_j_i <= "001";
		q_k_i <= "000";
		alu_done <= '0';
		
		clock <= '1';
		wait for clk_per/2;		
		
		-- valor esperado pelas duas linhas aparece no cdb
		
		cdb(wordSize+tagSize-1 downto wordSize) <= "001";
		cdb(wordSize-1 downto 0) <= x"FFFFFFFF";
		
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
		cdb(wordSize-1 downto 0) <= x"FFFFFFFF";	

		clock <= '0';
		wait for clk_per/2;

		load <= "01";	
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;		

		-- valor esperado pela nova instrucao aparece no cdb
		
		cdb(wordSize+tagSize-1 downto wordSize) <= "001";
		cdb(wordSize-1 downto 0) <= x"FFFFFFFF";
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		alu_done <= '1';
		
		clock <= '1';
		wait for clk_per/2;
		
		-- execucao da 2a instrucao termina e valor é colocado no cdb
		
		cdb(wordSize+tagSize-1 downto wordSize) <= "111";
		cdb(wordSize-1 downto 0) <= x"FFFFFFFF";	
		
		clock <= '0';
		wait for clk_per/2;

		alu_done <= '0';		
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		
				clock <= '1';
		wait for clk_per/2;
		clock <= '0';
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