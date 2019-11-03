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
 
 tag_write : in std_logic; -- controle de escrita
 
 write_tag : in std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de escrita 
 write_tag_data : in std_logic_vector (tagSize-1 downto 0) ; -- sinal de escrita da tag
 
 cdb_tag : in std_logic_vector (tagSize-1 downto 0);
 
 tag_1  : out std_logic_vector (tagSize-1 downto 0); -- sinal de saida do tag da leitura 1
 tag_2  : out std_logic_vector (tagSize-1 downto 0);   -- sinal de saida do tag da leitura 2
 
 write_reg : buffer std_logic_vector (regNumBits-1 downto 0)
 
 ) ;	  
 
end MapTable; 

architecture MapTable of MapTable is 

type tags is array (0 to regNum-1) of std_logic_vector(tagSize-1 downto 0); -- Banco de regNum tags de tagSize bits
signal lista_tag : tags; -- declarando a variavel do tipo tags

begin	
	process	 (reset, clock, read_tag_1, read_tag_2, lista_tag, write_tag, cdb_tag) -- caso qualquer entrada sofra alguma alteracao, inicia process
	
	begin		
		
		if reset = '1' then		 
			for i in 0 to 31 loop
				lista_tag(i) <= (tagSize-1 downto 0 => '0');
			end loop;
			
		elsif clock='1' and clock'event then
		
			lista_tag(TO_INTEGER(signed(write_reg))) <= (others => '0');
		
			if tag_write ='1' then	 -- operacao de escrita 
					lista_tag(TO_INTEGER(signed(write_tag))) <= write_tag_data ; -- escreve a tag
			end if ;		

		end if;
		
		for i in 0 to 31 loop
			if lista_tag(i) = cdb_tag then
				write_reg <= std_logic_vector(TO_SIGNED(i, regNumBits));
				exit;
			end if;				
		end loop;

		tag_1 <= lista_tag(TO_INTEGER(unsigned(read_tag_1))); -- recebe o valor da tag do registrador 1
		tag_2 <= lista_tag(TO_INTEGER(unsigned(read_tag_2))); -- recebe o valor da tag do registrador 2

	end process ;
	
end MapTable;