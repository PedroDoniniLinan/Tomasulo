library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all; -- necessario para converter em integer


entity FIFO is
 generic(wordSize: natural :=32; regNum: natural := 32);
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
end FIFO; 

architecture FIFO of FIFO is 
type registradores is array (0 to regNum-1) of std_logic_vector(wordSize-1 downto 0);	-- Fila de regNum registradores de wordSize bits

signal fila_reg : registradores; -- declarando a variavel fila do tipo registradores

signal point_read : integer; -- aponta para a primeira instruçao da fila (posiçao de leitura)
signal point_write : integer; -- aponta para a primeira posiçao vazia (posiçao de escrita)
signal inst_count : integer; -- guarda o numero de instruçoes na fila

begin	

	process	 (reset, clock) -- caso qualquer entrada sofra alguma alteracao, inicia process
	begin
		if reset = '1' then		 
			for i in 0 to regNum-1 loop
				fila_reg(i) <= (wordSize-1 downto 0 => '0');
			end loop;
			--TESTE
			fila_reg(0) <= "10001011000" & "00010" & "000000" & "00011" & "00001"; -- ADD R2 + R3 = R1
			fila_reg(1) <= "10001011000" & "00011" & "000000" & "00011" & "00000"; -- ADD R3 + R3 = R4
			fila_reg(2) <= "10001011000" & "00001" & "000000" & "00001" & "00001"; -- ADD R1 + R1 = R1 
			fila_reg(3) <= "10001011000" & "00001" & "000000" & "00001" & "00001"; -- ADD R1 + R1 = R1 
			fila_reg(4) <= "10001011000" & "00001" & "000000" & "00001" & "00001"; -- ADD R1 + R1 = R1 
			fila_reg(5) <= "10001011000" & "00001" & "000000" & "00001" & "00001"; -- ADD R1 + R1 = R1 			
			fila_reg(6) <= "11001011000" & "00001" & "000000" & "00010" & "00001"; -- MULT R1 * R2 = R1 
			fila_reg(7) <= "11001011000" & "00001" & "000000" & "00010" & "00001"; -- MULT R1 * R2 = R1 
			fila_reg(8) <= "11001011000" & "00001" & "000000" & "00010" & "00001"; -- MULT R1 * R2 = R1 
			fila_reg(9) <= "11001011000" & "00001" & "000000" & "00010" & "00001"; -- MULT R1 * R2 = R1  						
			
			point_read <= 0;
			point_write <= 10;
			notEmpty <= '1';
			full <= '0';
			inst_count <= 10;
			----- FIM TESTE
			
			--point_read <= 0;
			--point_write <= 0;
			--notEmpty <= '1';
			--full <= '0';
			--inst_count <= 0;
			
		elsif clock='1' and clock'event then	  
		  
			if (wr = '1') then -- se operaçao de escrita
				if (inst_count  = regNum) then -- caso esteja cheio
					full <= '1';
				else
					fila_reg(point_write) <= write_inst; -- escreve a inst no final da fila
					inst_count <= inst_count + 1; -- incrementa inst_count
					if point_write = regNum-1 then -- se apontar para a ultima inst, da a volta
						point_write <= 0;
					 else -- se nao incrementa o ponteiro
						point_write <= point_write + 1;
					 end if;
				end if;
			end if;
			
			
			if (rd = '0') then -- se operaçao de leitura
				if (inst_count  = 0) then -- caso esteja vazio
					notEmpty <= '0';
				else
					read_inst <= fila_reg(point_read); -- le a primeira inst da fila
					inst_count <= inst_count - 1; -- decrementa inst_count
					if point_read = regNum-1 then -- se apontar para a ultima inst, da a volta
						point_read <= 0;
					 else -- se nao incrementa o ponteiro
						point_read <= point_read + 1;
					 end if;
				end if;
			end if;

		end if;
		
		
		
		if (inst_count  = regNum) then -- caso esteja cheio
			full <= '1';
			notEmpty <= '1';
		elsif (inst_count  = 0) then -- caso esteja vazio
			full <= '0';
			notEmpty <= '0';
		else
			full <= '0';
			notEmpty <= '1';
		end if;
	end process ;
end FIFO;