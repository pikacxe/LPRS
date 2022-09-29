library ieee;
use ieee.std_logic_1164.all;

entity slozeni_sistem_2_tb is
end entity;

architecture Behavioral of slozeni_sistem_2_tb is
	
	signal sA : std_logic_vector(3 downto 0);
	signal sB : std_logic_vector(3 downto 0);
	signal sSEL : std_logic_vector(1 downto 0);
	signal sC : std_logic_vector(3 downto 0);

	component slozeni_sistem_2 is
		port(
			iA : in std_logic_vector(3 downto 0);
			iB : in std_logic_vector(3 downto 0);
			iSEL : in std_logic_vector(1 downto 0);
			oC : out std_logic_vector(3 downto 0)
		);
	end component;

begin

	uut : slozeni_sistem_2 port map(
		iA => sA,
		iB => sB,
		iSEL => sSEL,
		oC => sC
	);
	
	stimulus: process
	begin
		sA <= "1010";
		sB <= "0101";
		
		iSEL <= "00";
		wait for 100ns;
		
		iSEL <= "01";
		wait for 100ns;
		
		iSEL <= "10";
		wait for 100ns;
		
		iSEL <= "11";
		wait for 100ns;
		
		
	end process stimulus;

end architecture;