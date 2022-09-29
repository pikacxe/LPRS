
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
    oQ <= "000110001001000"  when iA = 0 else
          "000110001001000"  when iA = 1 else
          "000110001001000"  when iA = 2 else
          "000110100100000"  when iA = 3 else
          "000010101001010"  when iA = 4 else
          "010001000001011"  when iA = 5 else
          "000001000100010"  when iA = 6 else
          "100000000000000"  when iA = 7 else
          "000001011000011"  when iA = 8 else
          "000110010010000"  when iA = 9 else
          "010000000000100"  when iA = 10 else
          "000010000000000"  when iA = 11 else
          "100000000000001"  when iA = 12 else
          "110000000011001"  when iA = 13 else
          "010000000001110"  when iA = 14 else
          "000000000000000";
end Behavioral;
------------------------------------------------------------------
