library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Slozeni is port (
		iCLK   : in  std_logic;
      iRST   : in  std_logic;
      iEN    : in  std_logic;
		oCNT   : out std_logic_vector (7 downto 0);
      oSHREG : out  std_logic_vector (7 downto 0)
		);
end entity;

architecture Behavioral of Slozeni is
	
	-- signali brojaca
	signal sCNT : std_logic_vector (7 downto 0);
	
	--signali pomeraca
	signal sSHREG : std_logic_vector(7 downto 0);
	
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
	

	
	process (iCLK, iRST) begin
		if (iRST = '1') then
				sSHREG <= "00000000";
		elsif (iCLK' event and iCLK = '1') then
			if (sCNT = "00001000" or sCNT = "10000000") then
				sSHREG <= sCNT;
			elsif(sCNT > "10000000") then
				sSHREG <= sSHREG(7) & sSHREG(7 downto 1);
			elsif(sCNT < "10000000") then
				sSHREG <= sSHREG(6 downto 0) & sSHREG(0);
			end if;
		end if;
	end process;	
	oSHREG <= sSHREG;
	oCNT <= sCNT;

	
end architecture;
