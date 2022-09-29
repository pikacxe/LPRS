library ieee;
use ieee.std_logic_1164.all;


entity MyFirstDigitalSystem is 
	port(
		iB0: in std_logic;
		iB1: in std_logic;
		iB2: in std_logic;
		iB3: in std_logic;
		oY: out std_logic
		);
end entity;

architecture LPRS1 of MyFirstDigitalSystem is
	signal sS1: std_logic;
	signal sS2: std_logic;
	signal sS3: std_logic;
	signal sS4: std_logic;
begin
	sS1 <= iB1 and (not(iB3));
	sS2 <= iB0 and (not(iB3)) and iB2;
	sS3 <= (not(iB1)) and iB3 and (not(iB2));
	sS4 <= (not(iB1)) and (not(iB3)) and (not(iB2));
	oY <= sS1 or sS2 or sS3 or sS4;
end architecture;