library ieee;
use ieee.std_logic_1164.all;

entity MyFirstDigitalSystem_tb is
end MyFirstDigitalSystem_tb;

architecture Test_tb of MyFirstDigitalSystem_tb is
	signal sA : std_logic;
	signal sB : std_logic;
	signal sY : std_logic;

	component MyFirstDigitalSystem
	port(
	 iA : in std_logic;
	 iB : in std_logic;
	 oY : out std_logic
	 );
	end component;

	begin
	-- instanciranje i mapiranje glavnih portova i signala
	 uut : MyFirstDigitalSystem port map (
	 iA => sA,
	 iB => sB,
	 oY => sY
	 );

	stimulus : process
	begin
	 sA <= '0';
	 sB <= '0';
	wait for 100 ns;
	 sA <= '0';
	 sB <= '1';
	wait for 100 ns;
	 sA <= '1';
	 sB <= '0';
	wait for 100 ns;
	 sA <= '1';
	 sB <= '1';
	wait;
	end process stimulus;
end architecture; 