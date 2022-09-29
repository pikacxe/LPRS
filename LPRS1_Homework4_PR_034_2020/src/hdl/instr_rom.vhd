
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity instr_rom is
    Port ( iA : in  STD_LOGIC_VECTOR (4 downto 0);
           oQ : out  STD_LOGIC_VECTOR (14 downto 0));
end instr_rom;

-- ubaciti sadrzaj *.txt datoteke generisane pomocu lprsasm ------
architecture Behavioral of instr_rom is
begin
    oQ <= "100000001000000"  when iA = 0 else
          "000110000000000"  when iA = 1 else
          "000110110110000"  when iA = 2 else
          "000010100001110"  when iA = 3 else
          "010010000010001"  when iA = 4 else
          "100000101000000"  when iA = 5 else
          "000001000000001"  when iA = 6 else
          "100000111000000"  when iA = 7 else
          "000001000000001"  when iA = 8 else
          "000011111111101"  when iA = 9 else
          "000001010010111"  when iA = 10 else
          "110000000111000"  when iA = 11 else
          "000010000000001"  when iA = 12 else
          "000010000000001"  when iA = 13 else
          "000110110110000"  when iA = 14 else
          "000110000000000"  when iA = 15 else
          "010000000000011"  when iA = 16 else
          "010000000010001"  when iA = 17 else
          "000000000000000";
end Behavioral;
------------------------------------------------------------------
