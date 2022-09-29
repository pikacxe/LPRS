
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity instr_rom is
    Port ( iA : in  STD_LOGIC_VECTOR (7 downto 0);
           oQ : out  STD_LOGIC_VECTOR (14 downto 0));
end instr_rom;

-- ubaciti sadrzaj *.txt datoteke generisane pomocu lprsasm ------
architecture Behavioral of instr_rom is
begin
    oQ <= "100000101000101"  when iA = 0 else
          "000110011011000"  when iA = 1 else
          "000110011011000"  when iA = 2 else
          "100000010000011"  when iA = 3 else
          "000110011011000"  when iA = 4 else
          "000110001001000"  when iA = 5 else
          "000110110110000"  when iA = 6 else
          "000010111010110"  when iA = 7 else
          "010010000001111"  when iA = 8 else
          "001000001001000"  when iA = 9 else
          "100000100000011"  when iA = 10 else
          "000001000100000"  when iA = 11 else
          "000110011011000"  when iA = 12 else
          "000111010010000"  when iA = 13 else
          "010000000000111"  when iA = 14 else
          "000001000000001"  when iA = 15 else
          "001001000000000"  when iA = 16 else
          "001001000000000"  when iA = 17 else
          "110000000000101"  when iA = 18 else
          "000010110110110"  when iA = 19 else
          "000110110110000"  when iA = 20 else
          "100000111000110"  when iA = 21 else
          "110000000110111"  when iA = 22 else
          "010000000010111"  when iA = 23 else
          "000000000000000";
end Behavioral;
------------------------------------------------------------------
