library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all; -- necessario para converter em integer


entity RegFileTomasulo is
 generic(wordSize: natural :=32; regNum: natural := 5; regNumBits: natural := 5);
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
 
 reg_write : in std_logic ) ;	  -- controle de escrita/leitura
end RegFileTomasulo; 

architecture RegFileTomasuloArq of RegFileTomasulo is 
type registradores is array (0 to regNum-1) of std_logic_vector(wordSize-1 downto 0);	-- Banco de regNum registradores de wordSize bits

signal lista_reg : registradores; -- declarando a variavel do tipo registradores

signal leitura1 : integer := 0; -- para saber qual o registrador da primeira leitura
signal leitura2 : integer := 0; -- para saber qual o registrador da segunda leitura
signal escrita : integer; -- para saber qual o registrador da escrita	
begin	
	process	 (reset, clock, read_reg_1, read_reg_2) -- caso qualquer entrada sofra alguma alteracao, inicia process
	variable read_reg_temp_1: std_logic_vector(regNumBits-1 downto 0);
	variable read_reg_temp_2: std_logic_vector(regNumBits-1 downto 0);
	begin
		if reset = '1' then		 
			for i in 0 to 31 loop
				lista_reg(i) <= (wordSize-1 downto 0 => '0');
			end loop;
			
			-- TESTE
			lista_reg(3) <= "00000000000000000000000000000011";
			lista_reg(4) <= "00000000000000000000000000000100";
			-- TESTE FIM
			leitura1 <= 0;
			leitura2 <= 0;
		elsif clock='1' and clock'event then
			case reg_write is
				when '1' =>	 -- operacao de escrita 
					escrita <= TO_INTEGER(signed(write_reg)); -- obtem o registrador que sera gravado
					lista_reg(TO_INTEGER(signed(write_reg))) <= write_data ; -- escreve o dado
				when others =>	 -- operacao de leitura
			end case ;

		end if;
		
		read_reg_temp_1 := read_reg_1;
		if read_reg_temp_1(0) = '0' or read_reg_temp_1(0) = '1' then
			leitura1 <= TO_INTEGER(unsigned(read_reg_1)); -- obtem o registrador da primeira leitura
		else
			leitura1 <= 0;
		end if;
		
		read_reg_temp_2 := read_reg_2;
		if read_reg_temp_2(0) = '0' or read_reg_temp_2(0) = '1' then
			leitura2 <= TO_INTEGER(unsigned(read_reg_2)); -- obtem o registrador da primeira leitura
		else
			leitura2 <= 0;
		end if;

		read_data_1 <= lista_reg(leitura1);	-- recebe o valor do registrador 1	
		read_data_2 <= lista_reg(leitura2); -- recebe o valor do registrador 2
		-- TESTE
		r5_out <= lista_reg(3); --recebe o valor do r5
	end process ;

end RegFileTomasuloArq;