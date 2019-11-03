library ieee;
use ieee.std_logic_1164.all;

entity FIFO_tb is
 generic(wordSize: natural :=32; regNum: natural := 32);
end FIFO_tb;

architecture tb of FIFO_tb is

	component FIFO
	 port (
	 reset : in std_logic;
	 clock : in std_logic;

	 wr : in  std_logic; -- controle de escrita
	 write_inst : in  std_logic_vector(wordSize-1 downto 0); -- sinal de entrada de escrita da instrucao
	 
	 rd : in  std_logic; -- controle de leitura (dispatch)
	 read_inst : out std_logic_vector(wordSize-1 downto 0); -- sinal de saida da leitura da instrucao
	 
	 notEmpty : out std_logic; -- fila esta vazia, nao consegue ler
	 full  : out std_logic -- fila esta cheia, nao consegue escrever
	) ;	  
	end component;

	 signal wr : std_logic; -- controle de escrita
	 signal write_inst : std_logic_vector(wordSize-1 downto 0); -- sinal de entrada de escrita da instrucao
	 
	 signal rd : std_logic; -- controle de leitura (dispatch)
	 signal read_inst : std_logic_vector(wordSize-1 downto 0); -- sinal de saida da leitura da instrucao
	 
	 signal notEmpty : std_logic; -- fila esta vazia, nao consegue ler
	 signal full  : std_logic -- fila esta cheia, nao consegue escrever
	
	signal reset : std_logic;
	signal clock : std_logic;
		
	constant clk_per : time := 1us;
	
begin
	
	u1: FIFO port map (
		reset=>reset,
		clock=>clock,
		wr=>wr,
		write_inst=>write_inst,
		rd=>rd,
		read_inst=>read_inst,
		notEmpty=>notEmpty,
		full=>full
	);
	
	tom_process: process
	begin
				
		
		-- init
		
		reset <= '0';
		clock <= '0';
		wr <= '0';
		write_inst <= (others => '0');
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