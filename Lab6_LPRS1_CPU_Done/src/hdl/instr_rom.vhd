
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
          "100000010000000"  when iA = 2 else
          "000110000000000"  when iA = 3 else
          "000000011000000"  when iA = 4 else
          "000001101000001"  when iA = 5 else
          "000010111101011"  when iA = 6 else
          "010010000010000"  when iA = 7 else
          "100000110000011"  when iA = 8 else
          "000010111110011"  when iA = 9 else
          "010010000001101"  when iA = 10 else
          "000110011011000"  when iA = 11 else
          "010000000000110"  when iA = 12 else
          "110000000110010"  when iA = 13 else
          "000110010010000"  when iA = 14 else
          "010000000001011"  when iA = 15 else
          "010000000010000"  when iA = 16 else
          "000000000000000";
end Behavioral;
------------------------------------------------------------------
