library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity slozeni_sistem_2 is
	port(
		iA : in std_logic_vector(3 downto 0);
		iB : in std_logic_vector(3 downto 0);
		iSEL : in std_logic_vector(1 downto 0);
		oC : out std_logic_vector(3 downto 0)
	);
end entity;


architecture Behavioral of slozeni_sistem_2 is
	
	signal sB : std_logic_vector(3 downto 0);
	signal sC : std_logic_vector(3 downto 0);
		
begin

	sB <= (not(iB(2 downto 0)) + 1) when iB < 0 else
			iB;
			
	sC <= iA when iSEL = "00" else
			iB when iSEL = "01" else
			(iA + sB) when iSEL = "10" else
			(sB + 1)  when iSEL = "11" else
			(sB + 1);


end architecture;