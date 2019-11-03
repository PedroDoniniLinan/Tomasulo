library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all; -- necessario para converter em integer


entity RegFileTomasulo is
 generic(wordSize: natural :=64; regNum: natural := 32; regNumBits: natural := 5);
 port (
 reset : in std_logic;
 clock : in std_logic;
 
 read_reg_1 : in std_logic_vector (regNumBits-1 downto 0);	-- sinal do endereco de leitura 1
 read_reg_2 : in std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de leitura 2
 
 read_data_1 : out std_logic_vector (wordSize-1 downto 0) ; -- sinal de saida da leitura 1
 read_data_2 : out std_logic_vector (wordSize-1 downto 0) ; -- sinal de saida da leitura 2
 
 write_reg : in std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de escrita
 write_data : in std_logic_vector (wordSize-1 downto 0) ; -- registra o que deve ser escrito
 
 reg_write : in std_logic 
 ) ;	  -- controle de escrita/leitura
end RegFileTomasulo; 

architecture RegFileTomasuloArq of RegFileTomasulo is 
type registradores is array (0 to regNum-1) of std_logic_vector(wordSize-1 downto 0);	-- Banco de regNum registradores de wordSize bits

signal lista_reg : registradores; -- declarando a variavel do tipo registradores

begin	
	process	 (reset, clock,  read_reg_1, read_reg_2, lista_reg) -- caso qualquer entrada sofra alguma alteracao, inicia process
	begin
		if reset = '1' then		 
			for i in 0 to 31 loop
				lista_reg(i) <= (wordSize-1 downto 0 => '0');
			end loop;

		elsif clock='1' and clock'event then
		
			if reg_write ='1' then	 -- operacao de escrita 
					lista_reg(TO_INTEGER(signed(write_reg))) <= write_data ; -- escreve
			end if ;		

		end if;

		read_data_1 <= lista_reg(TO_INTEGER(unsigned(read_reg_1)));	-- recebe o valor do registrador 1	
		read_data_2 <= lista_reg(TO_INTEGER(unsigned(read_reg_2))); -- recebe o valor do registrador 2
		
	end process ;
end RegFileTomasuloArq;