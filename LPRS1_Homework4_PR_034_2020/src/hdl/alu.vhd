
----------------------------------------------------------------------------------
-- Logicko projektovanje racunarskih sistema 1
-- 2011/2012,2021
--
-- Arithmetic-Logic Unit
--
-- authors:
-- Ivan Kastelan (ivan.kastelan@rt-rk.com)
-- Milos Subotic (milos.subotic@uns.ac.rs)
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
	port (
		iA     : in  std_logic_vector(15 downto 0);
		iB     : in  std_logic_vector(15 downto 0);
		iSEL   : in  std_logic_vector(3 downto 0);
		oC     : out std_logic_vector(15 downto 0);
		oSIGN  : out std_logic;
		oCARRY : out std_logic;
		oZERO  : out std_logic
	);
end entity alu;

architecture arch of alu is

	signal sA : std_logic_vector(16 downto 0);
	signal sB : std_logic_vector(16 downto 0);
	signal sC : std_logic_vector(16 downto 0);

begin
	-- Sign extensions.
	sA <= '0' & iA;
	sB <= '0' & iB;

	-- Mux with arithmetic-logical operations.
	sC <=
		sA                                when iSEL = "0000" else
		sA + sB                           when iSEL = "0001" else
		sA - sB                           when iSEL = "0010" else
		sA and sB                         when iSEL = "0011" else
		sA or sB                          when iSEL = "0100" else
		not(sA)                           when iSEL = "0101" else
		sA + 1                            when iSEL = "0110" else
		sA - 1                            when iSEL = "0111" else
		'0' & sA(14 downto 0) & '0'       when iSEL = "1000" else
		"00" & sA(15 downto 1)            when iSEL = "1001" else
		sA(16) & sA(14 downto 0) & '0'    when iSEL = "1010" else
		sA(16) & sA(15) & sA(15 downto 1) when iSEL = "1011" else
		(others => '0');
	
	-- Flags.
	oC <= sC(15 downto 0);
	oZERO <= '1' when sC(15 downto 0) = "0000000000000000" else '0';
	oCARRY <= sC(16);
	oSIGN <= sC(15);

end architecture;
