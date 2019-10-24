library ieee;
use ieee.numeric_bit.all;
USE ieee.std_logic_1164.all;                                


entity FP is
  port (
    A, B : in  signed(63 downto 0); -- inputs
    F    : out signed(63 downto 0); -- output
    S    : in  STD_LOGIC_VECTOR (3 downto 0) -- op selection
    );
end entity FP;

architecture fp of FP is
  signal fpout : signed(63 downto 0) := (others=>'0');
begin
-- TODO : Correct op codes
  with S select fpout <=
    A(31 downto 0) * B(31 downto 0) when "0000", -- multiply
    A / B when "0001", -- divide

    (others=>'0') when others;
  -- Copying temporary signal to output
  F <= fpout;
end architecture fp;
