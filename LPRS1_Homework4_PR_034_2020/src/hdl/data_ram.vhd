
-------------------------------------------------------
-- Logicko projektovanje racunarskih sistema 1
-- 2011/2012
-- Lab 5
--
-- Data RAM
--
-- author: Ivan Kastelan (ivan.kastelan@rt-rk.com)
-------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_ram is
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC;
           iA : in  STD_LOGIC_VECTOR (7 downto 0);
           iD : in  STD_LOGIC_VECTOR (15 downto 0);
           iWE : in  STD_LOGIC;
           oQ : out  STD_LOGIC_VECTOR (15 downto 0));
end data_ram;

architecture Behavioral of data_ram is

    type tMEM is array(0 to 255) of std_logic_vector(15 downto 0);
    signal rMEM : tMEM;
	 signal sMEM : tMEM := (others => x"0000");

begin

    process (iCLK, inRST) begin
        if (inRST = '0') then
            for i in 0 to 31 loop
                rMEM(i) <= sMEM(i); 
            end loop;
        elsif (iCLK'event and iCLK = '1') then
            if (iWE = '1') then
                rMEM(to_integer(unsigned(iA))) <= iD;
            end if;
        end if;
    end process;
-- ubaciti sadrzaj *.dat datoteke generisane pomocu lprsasm ------
sMEM(0) <= x"000a";
sMEM(1) <= x"0015";
sMEM(2) <= x"0014";
sMEM(3) <= x"001a";
sMEM(4) <= x"0004";
sMEM(5) <= x"0004";
sMEM(6) <= x"0000";
sMEM(7) <= x"001a";
sMEM(8) <= x"0016";
sMEM(9) <= x"0005";
sMEM(10) <= x"0006";
sMEM(11) <= x"0014";
sMEM(12) <= x"000c";
sMEM(13) <= x"0012";
sMEM(14) <= x"0020";
sMEM(15) <= x"001c";
sMEM(16) <= x"001f";
sMEM(17) <= x"0019";
sMEM(18) <= x"0001";
sMEM(19) <= x"0013";
sMEM(20) <= x"001d";
------------------------------------------------------------------
    
    oQ <= rMEM(to_integer(unsigned(iA)));

end Behavioral;
