library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- necessario para converter em integer

entity rs is
	generic(
		wordSize: natural :=4;
		tagSize:  natural :=3; -- tamanho da tag inteira 
		FUTagSize:natural :=2; -- numero de linhas da RS
		nbOfLines:natural :=2  -- tamanho do pedaço da tag que indica a qual FU pertence
	);
	port(
		clock:    		in 	 std_logic; --! entrada de clock
		reset:	 		in 	 std_logic; --! clear assíncrono
		load:      		in 	 std_logic; -- carrega valor em rs livre

		-- indica numero da FU a qual rs esta ligada
		-- a ideia é ter isso como entrada na arquitetura estrutural do tomasulo completo
		FU_tag:  		in	    std_logic_vector(FUTagSize-1 downto 0); 
		
		
		-- conteudo da instrucao a ser armazenada
		alu_op_i:   	in		 std_logic_vector(3 downto 0); 				-- Operacao da ALU
		v_j_i:  		 	in		 std_logic_vector(wordSize-1 downto 0);	-- Valores
		v_k_i:  		 	in		 std_logic_vector(wordSize-1 downto 0);
		q_j_i:  		 	in		 std_logic_vector(tagSize-1 downto 0);		-- Tags de operandos sendo esperados
		q_k_i:  		 	in		 std_logic_vector(tagSize-1 downto 0);
		
		-- entrada vinda do cdb para pegar operandos sendo esperados 
		cdb:				in		 std_logic_vector(wordSize+tagSize-1 downto 0); 
		
		-- buffer para o testbench (retirar depois)
		r0 : 		buffer std_logic_vector(2*wordSize+2*tagSize+4 downto 0);
		r1 : 		buffer std_logic_vector(2*wordSize+2*tagSize+4 downto 0);
		
		-- sinal de busy de todas linhas da rs 
		busy:				out	 std_logic;
		
		-- saidas para a ALU
		alu_op_o:   	out	 std_logic_vector(3 downto 0); 
		v_j_o:  		 	out	 std_logic_vector(wordSize-1 downto 0);
		v_k_o:  		 	out	 std_logic_vector(wordSize-1 downto 0);
		
		-- tag da instrucao que esta sendo alimentada para a ALU e que vai para o cdb
		tag:  		 	out	 std_logic_vector(tagSize-1 downto 0)
	);
end rs;

architecture rs of rs is 

type rs_lines is array (0 to nbOfLines-1) of std_logic_vector(2*wordSize+2*tagSize+4 downto 0);
signal list_rs : rs_lines; 

constant zeros : std_logic_vector(2*tagSize-1 downto 0) := (others => '0'); -- usado para uma comparacao

begin

	process (reset, clock, list_rs) -- caso qualquer entrada sofra alguma alteracao, inicia process
	variable temp : std_logic;
	begin
	
		-- para testbench
		r0 <= list_rs(0);
		r1 <= list_rs(1);
	
		if reset = '1' then		 
			
			for i in 0 to nbOfLines-1 loop
				list_rs(i)(2*wordSize+2*tagSize+4 downto 2*tagSize) <= (others =>'0');
				list_rs(i)(2*tagSize-1 downto 0) <= (others => '1');
			end loop;
			
			busy <= '0';
			alu_op_o <= (others => '0');
			v_j_o <= (others => '0');
			v_k_o <= (others => '0');
			tag <= (others => '0');
			
		elsif clock='1' and clock'event then
			
			-- apaga instrucao executada que se encontra no cdb ja
			if cdb(wordSize+tagSize-1 downto wordSize+tagSize-FUTagSize) = FU_Tag then
				list_rs(to_integer(unsigned(cdb(wordSize+tagSize-FUTagSize-1 downto wordSize)))) <= (others => '0');
			end if;
			
			-- carrega instrucao emitida em rs livre
			if load = '1' then
				for i in 0 to nbOfLines-1 loop
					if list_rs(i)(2*wordSize+2*tagSize+4) = '0' then
						list_rs(i) <= "1" & alu_op_i & v_j_i & v_k_i & q_j_i & q_k_i;
						exit;
					end if;
				end loop;
			end if;
			
			-- checa se alguma reservation station esta esperando o valor atual no cdb
			for i in 0 to nbOfLines-1 loop
				if list_rs(i)(2*tagSize-1 downto tagSize) = cdb(wordSize+tagSize-1 downto wordSize) then
					list_rs(i)(2*wordSize+2*tagSize-1 downto wordSize+2*tagSize) <= cdb(wordSize-1 downto 0);
					list_rs(i)(2*tagSize-1 downto tagSize) <= (others => '0');
				end if;
				if list_rs(i)(tagSize-1 downto 0) = cdb(wordSize+tagSize-1 downto wordSize) then
					list_rs(i)(2*wordSize+2*tagSize-1 downto wordSize+2*tagSize) <= cdb(wordSize-1 downto 0);
					list_rs(i)(tagSize-1 downto 0) <= (others => '0');
				end if;
			
			end loop;
		
		end if;
		
		-- coloca em execucao instrucao com operandos prontos
		for i in 0 to nbOfLines-1 loop
			if (list_rs(i)(2*tagSize-1 downto 0) = zeros) 
			and (list_rs(i)(2*wordSize+2*tagSize+4) = '1') 
			then
				alu_op_o <= list_rs(i)(2*wordSize+2*tagSize+3 downto 2*wordSize+2*tagSize);
				v_j_o <= list_rs(i)(2*wordSize+2*tagSize-1 downto wordSize+2*tagSize);	
				v_k_o <= list_rs(i)(wordSize+2*tagSize-1 downto 2*tagSize);
				tag <= FU_Tag & std_logic_vector(TO_SIGNED(i, tagSize-FUtagSize));
				exit;
			end if;
		end loop;
		
		
		
		-- checa se existe uma linha livre na reservation station
		-- atualiza sinal de busy da rs
		temp := '1';
		for i in 0 to nbOfLines-1 loop
			temp := temp and list_rs(i)(2*wordSize+2*tagSize+4);
			
		end loop;
		busy <= temp;
		
	end process;

end rs;