--------------------------------------------------------------------------------
--! @file alu.vhd
--! @brief 64-bit ALU
--! @author Bruno Albertini (balbertini@usp.br)
--! @date 20180807
--------------------------------------------------------------------------------

library ieee;
use ieee.numeric_bit.all;
USE ieee.std_logic_1164.all;                                


-- @brief ALU is signed and uses 2-complement
entity alu is
  port (
    A, B : in  signed(63 downto 0); -- inputs
    F    : out signed(63 downto 0); -- output
    S    : in  STD_LOGIC_VECTOR (3 downto 0); -- ALUop selection
    Z    : out STD_LOGIC -- zero flag
    );
end entity alu;

-- @brief Fully functional architecture
architecture functional of alu is
  signal aluout, altb: signed(63 downto 0) := (others=>'0');
begin
  with S select aluout <=
    A and B when "0000", -- AND
    A or  B when "0001", -- OR
    A +   B when "0010", -- ADD
    A -   B when "0110", -- SUB
    B   		when "0111", -- PASS B
    A nor B when "1100", -- NOR
    (others=>'0') when others;
  -- Generating A<B?1:0
  --altb(63 downto 1) <= (others=>'0');
  --altb(0) <= '1' when (A<B) else '0';
  -- Generating zero flag
  Z <= '1' when (aluout=0) else '0';
  -- Copying temporary signal to output
  F <= aluout;
end architecture functional;
