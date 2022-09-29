
----------------------------------------------------------------------------------
-- Logicko projektovanje racunarskih sistema 1
-- 2011/2012
-- Lab 5
--
-- Multiplexer 9:1
--
-- author: Ivan Kastelan (ivan.kastelan@rt-rk.com)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( iD0 : in  STD_LOGIC_VECTOR (15 downto 0);
           iD1 : in  STD_LOGIC_VECTOR (15 downto 0);
           iD2 : in  STD_LOGIC_VECTOR (15 downto 0);
           iD3 : in  STD_LOGIC_VECTOR (15 downto 0);
           iD4 : in  STD_LOGIC_VECTOR (15 downto 0);
           iD5 : in  STD_LOGIC_VECTOR (15 downto 0);
           iD6 : in  STD_LOGIC_VECTOR (15 downto 0);
           iD7 : in  STD_LOGIC_VECTOR (15 downto 0);
           iD8 : in  STD_LOGIC_VECTOR (15 downto 0);
           iSEL : in  STD_LOGIC_VECTOR (3 downto 0);
           oQ : out  STD_LOGIC_VECTOR (15 downto 0));
end mux;

architecture Behavioral of mux is

begin

    oQ <= iD0 when iSEL = "0000" else
          iD1 when iSEL = "0001" else
          iD2 when iSEL = "0010" else
          iD3 when iSEL = "0011" else
          iD4 when iSEL = "0100" else
          iD5 when iSEL = "0101" else
          iD6 when iSEL = "0110" else
          iD7 when iSEL = "0111" else
          iD8 when iSEL = "1000" else
          (others => '0');

end Behavioral;
