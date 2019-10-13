library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all; -- necessario para converter em integer


entity MapTable is
 generic(
		tagSize: natural :=3; 
		regNum: natural := 32; 
		regNumBits: natural := 5
		);
 port (
 reset : in std_logic;
 clock : in std_logic;
 
 read_tag_1 : in std_logic_vector (regNumBits-1 downto 0);	-- sinal do endereco de leitura 1
 read_tag_2 : in std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de leitura 2
 
 tag_write : in bit -- controle de escrita
 
 write_tag : in std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de escrita 
 write_tag_data : in std_logic_vector (tagSize-1 downto 0) ; -- sinal de escrita da tag
 
 tag_1  : out std_logic_vector (tagSize-1 downto 0) ; -- sinal de saida do tag da leitura 1
 tag_2  : out std_logic_vector (tagSize-1 downto 0) ; -- sinal de saida do tag da leitura 2
 
 ) ;	  
 
end MapTable; 

architecture MapTable of MapTable is 

type tags is array (0 to regNum-1) of std_logic_vector(tagSize-1 downto 0); -- Banco de regNum tags de tagSize bits
signal lista_tag : tags; -- declarando a variavel do tipo tags

signal leitura1 : integer; -- para saber qual o registrador da primeira leitura
signal leitura2 : integer; -- para saber qual o registrador da segunda leitura
signal escrita : integer; -- para saber qual o registrador da escrita	

begin	
	process	 (reset, clock) -- caso qualquer entrada sofra alguma alteracao, inicia process
	begin
		if reset = '1' then		 
			for i in 0 to 31 loop
				lista_tag(i) <= (tagSize-1 downto 0 => '0');
			end loop;
			leitura1 <= 0;
			leitura2 <= 0;
			escrita <= 0;
			
		elsif clock='1' and clock'event then
		
			case tag_write is
				when '1' =>	 -- operacao de escrita 
					escrita <= TO_INTEGER(signed(write_tag)); -- obtem o registrador que sera gravado
					lista_tag(escrita) <= write_tag_data ; -- escreve a tag
				when '0' =>	 -- operacao de leitura
					leitura1 <= TO_INTEGER(unsigned(read_tag_1)); -- obtem o registrador da primeira leitura
					leitura2 <= TO_INTEGER(unsigned(read_tag_2)); -- obtem o registrador da segunda leitura
					tag_1 <= lista_tag(leitura1); -- recebe o valor da tag do registrador 1
					tag_2 <= lista_tag(leitura2); -- recebe o valor da tag do registrador 2
			end case ;

		end if;
	end process ;
end MapTable;