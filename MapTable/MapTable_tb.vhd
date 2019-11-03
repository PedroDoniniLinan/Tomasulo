library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all; -- necessario para converter em integer


entity MapTable_tb is
 generic(
		tagSize: natural :=3; 
		regNum: natural := 32; 
		regNumBits: natural := 5
		);
end MapTable_tb;



architecture tb of MapTable_tb is 
	component MapTable
	 port (
	 reset : in std_logic;
	 clock : in std_logic;
	 
	 read_tag_1 : in std_logic_vector (regNumBits-1 downto 0);	-- sinal do endereco de leitura 1
	 read_tag_2 : in std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de leitura 2
	 
	 tag_write : in bit; -- controle de escrita
	 
	 write_tag : in std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de escrita 
	 write_tag_data : in std_logic_vector (tagSize-1 downto 0) ; -- sinal de escrita da tag
	 
	 cdb_tag : in std_logic_vector (tagSize-1 downto 0);

	 tag_1  : out std_logic_vector (tagSize-1 downto 0); -- sinal de saida do tag da leitura 1
	 tag_2  : out std_logic_vector (tagSize-1 downto 0);   -- sinal de saida do tag da leitura 2
	 
	 write_reg : buffer std_logic_vector (regNumBits-1 downto 0)
	 
	 ) ;	
	end component;
	
	 signal reset : std_logic;
	 signal clock : std_logic;
	 
	 signal read_tag_1 : std_logic_vector (regNumBits-1 downto 0);	-- sinal do endereco de leitura 1
	 signal read_tag_2 : std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de leitura 2
	 
	 signal tag_write : bit; -- controle de escrita
	 
	 signal write_tag : std_logic_vector (regNumBits-1 downto 0) ; -- sinal do endereco de escrita 
	 signal write_tag_data : std_logic_vector (tagSize-1 downto 0) ; -- sinal de escrita da tag
	 
	 signal cdb_tag : std_logic_vector (tagSize-1 downto 0);
	 	 
	 signal tag_1  : std_logic_vector (tagSize-1 downto 0); -- sinal de saida do tag da leitura 1
	 signal tag_2  : std_logic_vector (tagSize-1 downto 0);   -- sinal de saida do tag da leitura 2
	 
	 --reg_write : out std_logic;
	 signal write_reg : std_logic_vector (regNumBits-1 downto 0);
	
	constant clk_per : time := 1us;
begin
	u1: MapTable port map(
		reset=>reset,
		clock=>clock,
		read_tag_1=>read_tag_1,
		read_tag_2=>read_tag_2,
		tag_write=>tag_write,
		write_tag=>write_tag,
		write_tag_data=>write_tag_data,
		cdb_tag=>cdb_tag,
		write_reg=>write_reg,
		tag_1=>tag_1,
		tag_2=>tag_2

	);
	
	a_process: process
	begin

		-- init
		
		reset <= '0';
		clock <= '0';
		wait for clk_per/8;
		reset <= '1';
		wait for clk_per/8;
		cdb_tag <= "000";
		read_tag_1 <= "00000";
		read_tag_2 <= "00000";
		tag_write <= '0';
		write_tag <= "00000";
		write_tag_data <= "000";
		reset <= '0';
		wait for clk_per/4;

		-- escreve 110 em r0
		
		tag_write <= '1';
		write_tag <= "00000";
		write_tag_data <= "110";
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;
		
		-- escreve 010 em r1
		-- le2 r1		
		
		read_tag_2 <= "00001";
		
		write_tag <= "00001";
		write_tag_data <= "010";
		
		clock <= '1';
		wait for clk_per/2;		
		clock <= '0';
		wait for clk_per/2;
		
		-- escreve 011 em r2
		-- le2 r2	
		
		write_tag <= "00010";
		write_tag_data <= "011";
		read_tag_2 <= "00010";
		
		clock <= '1';
		wait for clk_per/2;
		cdb_tag <= "010"; -- cdb 010 (tag de r1)
		clock <= '0';
		wait for clk_per/2;

		-- le2 r1
		-- escreve 111 em r3
		
		read_tag_2 <= "00001";
		write_tag <= "00011";
		write_tag_data <= "111";
		
		clock <= '1';
		wait for clk_per/2;
		clock <= '0';
		wait for clk_per/2;		

		-- le2 r2
		
		read_tag_2 <= "00010";
		
		clock <= '1';
		wait for clk_per/2;
		cdb_tag <= "011"; -- cdb 011 (tag de r2)		
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
