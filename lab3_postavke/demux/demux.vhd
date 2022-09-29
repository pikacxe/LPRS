library ieee;
use ieee.std_logic_1164.all;

entity demux is
	port(
		iX : in std_logic;
		iSEL : in std_logic_vector(1 downto 0);
		oY0 : out std_logic;
		oY1 : out std_logic;
		oY2 : out std_logic;
		oY3 : out std_logic
	);
end entity;

architecture Behavioral of demux is
	
begin

end architecture;