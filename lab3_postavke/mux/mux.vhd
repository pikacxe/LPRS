library ieee;
use ieee.std_logic_1164.all;


entity mux is
	port(
		iX0 : in std_logic;
		iX1 : in std_logic;
		iX2 : in std_logic;
		iX3 : in std_logic;
		iSEL : in std_logic_vector(1 downto 0);
		oY : out std_logic
	);
end entity;


architecture Behavioral of mux is
	
begin

	-- Uslovna dodela
	oY <= iX0 when iSEL = "00" else
			iX1 when iSEL = "01" else
			iX2 when iSEL = "10" else
			iX3;
end architecture;