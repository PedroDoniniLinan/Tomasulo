library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- necessario para converter em integer

entity LdstrQueue is
	generic(
		wordSize: natural :=32;
		tagSize:  natural :=3; -- tamanho da tag inteira 
		FUTagSize:natural :=2; -- tamanho do pedaço da tag que indica a qual FU pertence
		nbOfLines:natural :=2; -- numero de linhas da RS 
		opBits: natural	:=1;  -- 0 is str and 1 is ld
		dt_addressSize:natural := 9  -- size of immediate to sum in address for str and ld instructions
	);
	port(
		clock:    		in 	 std_logic; --! entrada de clock
		reset:	 		in 	 std_logic; --! clear assíncrono
		load:			   in 	 std_logic;	-- set by decoder ldstr_write signal 
		 
		
		-- conteudo da instrucao a ser armazenada (from decoder)
		alu_op_i:   	in		 std_logic_vector(opBits-1 downto 0); 		-- 0 is str and 1 is ld from opCode of decoder
		v_n_in:  		 	in		 std_logic_vector(wordSize-1 downto 0);	-- Coming from regFile Rj
		v_t_in:  		 	in		 std_logic_vector(wordSize-1 downto 0);	-- Coming from regFile Rk
		q_n:  		 	in		 std_logic_vector(tagSize-1 downto 0);		-- Coming from MapFile Qj
		q_t:  		 	in		 std_logic_vector(tagSize-1 downto 0);    -- Coming from MapfFile Qk
		
		done:				in		 std_logic; -- set if previous effective address computation is done
		
		-- entrada vinda do cdb para pegar operandos sendo esperados (from cdb)
		cdb:				in		 std_logic_vector(wordSize+tagSize-1 downto 0);
	
		dt_address_in:		in		 std_logic_vector(dt_addressSize-1 downto 0); -- immediate for str and ld
		
		busy_adder_in: in	std_logic;
		
		-- sinal de busy de todas linhas da rs (to decoder)
		busy:				out	 std_logic_vector(nbOfLines-1 downto 0);
		
		-- output for effective address calculation
		alu_op_o:   	out	 std_logic_vector(opBits-1 downto 0); -- output for mem buffer
		v_n_out:  		 	out	 std_logic_vector(wordSize-1 downto 0);
		v_t_out:				out	 std_logic_vector(wordSize-1 downto 0);
      dt_address_out:  	out	 std_logic_vector(wordSize-1 downto 0);
		start:			out 	 std_logic; -- signal to start effective address computation
		
		-- tag da instrucao que esta sendo alimentada para a ALU e que vai para o cdb (to cdb)
		tag:  		 	out	 std_logic_vector(tagSize-1 downto 0); -- goes to mem buffer
		
		read_instr_0: 	out	std_logic_vector(dt_addressSize+2*wordSize+2*tagSize+opBits downto 0);
		read_instr_1: 	out	std_logic_vector(dt_addressSize+2*wordSize+2*tagSize+opBits downto 0)
	);
end LdstrQueue;

architecture LdstrQueue of LdstrQueue is 

type rs_lines is array (0 to nbOfLines-1) of std_logic_vector(dt_addressSize+2*wordSize+2*tagSize+opBits downto 0);
signal list_rs : rs_lines; 

constant zeros : std_logic_vector(2*tagSize-1 downto 0) := (others => '0'); -- usado para uma comparacao
signal point_read : integer := 0; -- aponta para a primeira instruçao da fila (posiçao de leitura)
signal point_write : integer := 0; -- aponta para a primeira posiçao vazia (posiçao de escrita)

begin

	process (reset, clock) -- caso qualquer entrada sofra alguma alteracao, inicia process
	variable temp : std_logic_vector(nbOfLines-1 downto 0);
	variable dt_address_temp : std_logic_vector(dt_addressSize-1 downto 0);
	variable next_read : integer;
	variable i : natural;
	begin
	
		if reset = '1' then		 
			
			for i in 0 to nbOfLines-1 loop
				list_rs(i)(dt_addressSize+2*wordSize+2*tagSize+opBits downto 2*tagSize) <= (others =>'0');
				list_rs(i)(2*tagSize-1 downto 0) <= (others => '1');
			end loop;
			alu_op_o <= (others => '0');
			busy <= (others => '0');
			v_n_out  <= (others => '0');
			v_t_out  <= (others => '0');
			dt_address_out <= (others => '0');
			tag <= (others => '0');
			point_read <= nbOfLines-1; -- corner case when queue is empty
			point_write <= 0; -- lines counting begins with 1
			read_instr_0 <= list_rs(0);
			read_instr_1 <= list_rs(1);
		elsif clock='1' and clock'event then
			
			-- load signal from decoder
			if load = '1' then

				if point_write = nbOfLines then
					point_write <= 0;
				end if;
				
				dt_address_temp := dt_address_in;
				
				if list_rs(point_write)(dt_addressSize+2*wordSize+2*tagSize+opBits) = '0' then
					list_rs(point_write) <= "1"  & dt_address_temp & alu_op_i & v_n_in & v_t_in & q_n & q_t; -- to not mess up with other things					
				end if;
				
				point_write <= point_write + 1;
			end if;
			
			-- check for result on cdb --
--			for i in 0 to nbOfLines-1 loop
--				if list_rs(i)(2*tagSize-1 downto tagSize) = cdb(wordSize+tagSize-1 downto wordSize) then
--					list_rs(i)(2*wordSize+2*tagSize-1 downto wordSize+2*tagSize) <= cdb(wordSize-1 downto 0);
--					list_rs(i)(2*tagSize-1 downto tagSize) <= (others => '0');
--				end if;
--				if list_rs(i)(tagSize-1 downto 0) = cdb(wordSize+tagSize-1 downto wordSize) then
--					list_rs(i)(2*wordSize+2*tagSize-1 downto wordSize+2*tagSize) <= cdb(wordSize-1 downto 0);
--					list_rs(i)(tagSize-1 downto 0) <= (others => '0');
--				end if;
--			
--			end loop;
			
			-- verify if there is a next instruction
			next_read := point_read;
			if next_read = nbOfLines-1 then
				next_read := 0;
			end if;
			
			-- if computation is done and next instruction ready, delete old one and execute next
			if done = '1' and busy_adder_in = '0' and (list_rs(next_read)(dt_addressSize + 2*wordSize+2*tagSize+opBits) = '1')  and
			(list_rs(next_read)(2*tagSize-1 downto 0) = zeros) then 
			
				list_rs(point_read)(dt_addressSize+2*wordSize+2*tagSize+opBits) <= '0';
				point_read <= next_read	;
				i := point_read;
				alu_op_o <= list_rs(i)(2*wordSize+2*tagSize+opBits-1 downto 2*wordSize+2*tagSize); 
				v_n_out <= list_rs(i)(2*wordSize+2*tagSize-1 downto wordSize+2*tagSize);
			   v_t_out <= list_rs(i)(wordSize+2*tagSize-1 downto 2*tagSize);	
				dt_address_out <= (wordSize-1 downto dt_addressSize => '0') & list_rs(i)(dt_addressSize + 2*wordSize+2*tagSize+opBits-1 downto 2*wordSize+2*tagSize+opBits);
				tag <= std_logic_vector(TO_SIGNED(i+1, tagSize)); -- fu tag of mem is zero
				start <= '1';
			else 
			   start <= '0';
			end if;

		end if;
		
		-- checa se existe uma linha livre na reservation station
		-- atualiza sinal de busy da rs
		for i in 0 to nbOfLines-1 loop
			temp(i) := list_rs(i)(dt_addressSize+2*wordSize+2*tagSize+opBits);			
		end loop;
		busy <= temp;
		
		read_instr_0 <= list_rs(0);
		read_instr_1 <= list_rs(1);
		
	end process;

end LdstrQueue;