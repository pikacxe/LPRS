library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity Brojac is port ( 
	iRST  : in  std_logic;
	iCLK  : in  std_logic;
	iEN   : in  std_logic;
	oCNT  : out std_logic_vector(7 downto 0)
	);
end entity;

architecture Behavioral of Brojac is
	
	signal sCNT : std_logic_vector(7 downto 0);
	
begin
	
	process (iCLK, iRST) begin
		if (iRST = '1') then
			sCNT <= "00000000";
		elsif (iCLK' event and iCLK = '1') then
			if (iEN = '1') then
				sCNT <= sCNT + 1;
			end if;
		end if;
	end process;
	
	oCNT <= sCNT;
	
end Behavioral;
