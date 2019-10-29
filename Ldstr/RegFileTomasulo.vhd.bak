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
 
 -- TESTE
 r5_out : out std_logic_vector (wordSize-1 downto 0) ; -- sinal do R5 para testes
 
 reg_write : in bit ) ;	  -- controle de escrita/leitura
end RegFileTomasulo; 

architecture RegFileTomasuloArq of RegFileTomasulo is 
type registradores is array (0 to regNum-1) of std_logic_vector(wordSize-1 downto 0);	-- Banco de regNum registradores de wordSize bits

signal lista_reg : registradores; -- declarando a variavel do tipo registradores

signal leitura1 : integer; -- para saber qual o registrador da primeira leitura
signal leitura2 : integer; -- para saber qual o registrador da segunda leitura
signal escrita : integer; -- para saber qual o registrador da escrita	
begin	
	process	 (reset, clock) -- caso qualquer entrada sofra alguma alteracao, inicia process
	begin
		if reset = '1' then		 
			for i in 0 to 31 loop
				lista_reg(i) <= (wordSize-1 downto 0 => '0');
			end loop;
			
			-- TESTE
			lista_reg(2) <= "0000000000000000000000000000000000000000000000000000000000000011";
			lista_reg(2) <= "0000000000000000000000000000000000000000000000000000000000000100";
			-- TESTE FIM
			leitura1 <= 0;
			leitura2 <= 0;
		elsif clock='1' and clock'event then
			case reg_write is
				when '1' =>	 -- operacao de escrita 
					escrita <= TO_INTEGER(signed(write_reg)); -- obtem o registrador que sera gravado
					lista_reg(TO_INTEGER(signed(write_reg))) <= write_data ; -- escreve o dado
				when '0' =>	 -- operacao de leitura
					leitura1 <= TO_INTEGER(unsigned(read_reg_1)); -- obtem o registrador da primeira leitura
					leitura2 <= TO_INTEGER(unsigned(read_reg_2)); -- obtem o registrador da segunda leitura
					read_data_1 <= lista_reg(leitura1);	-- recebe o valor do registrador 1	
					read_data_2 <= lista_reg(leitura2); -- recebe o valor do registrador 2
					-- TESTE
					r5_out <= lista_reg(5); --recebe o valor do r5
			end case ;

		end if;
	end process ;
end RegFileTomasuloArq;