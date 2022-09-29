library ieee;
use ieee.std_logic_1164.all;

entity MySecondDigitalSystem_tb is
end MySecondDigitalSystem_tb;

architecture Test_tb of MySecondDigitalSystem_tb is
signal sX0 : std_logic;
signal sX1 : std_logic;
signal sX2 : std_logic;
signal sY0 : std_logic;
signal sY1 : std_logic;
signal sY2 : std_logic;

component MySecondDigitalSystem
	port(
		iX0 : in std_logic;
		iX1 : in std_logic;
		iX2 : in std_logic;
		oY0 : out std_logic;
		oY1 : out std_logic;
		oY2 : out std_logic
	);
end component;

begin
-- instanciranje i mapiranje glavnih portova i signala
uut : MySecondDigitalSystem port map (
	iX0 => sX0,
	iX1 => sX1,
	iX2 => sX2,
	oY0 => sY0,
	oY1 => sY1,
	oY2 => sY2
);

stimulus : process
begin
	sX2 <= '0';
	sX1 <= '0';
	sX0 <= '0';	
	wait for 100 ns;
	sX2 <= '0';
	sX1 <= '0';
	sX0 <= '1';	
	wait for 100 ns;
	sX2 <= '0';
	sX1 <= '1';
	sX0 <= '0';	
	wait for 100 ns;
	sX2 <= '0';
	sX1 <= '1';
	sX0 <= '1';	
	wait for 100 ns;
	sX2 <= '1';
	sX1 <= '0';
	sX0 <= '0';	
	wait for 100 ns;
	sX2 <= '1';
	sX1 <= '0';
	sX0 <= '1';	
	wait for 100 ns;
	sX2 <= '1';
	sX1 <= '1';
	sX0 <= '0';	
	wait for 100 ns;
	sX2 <= '1';
	sX1 <= '1';
	sX0 <= '1';	
	wait;
end process stimulus;
end architecture;