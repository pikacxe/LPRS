
----------------------------------------------------------------------------------
-- Logicko projektovanje racunarskih sistema 1
-- 2011/2012,2021
--
-- Computer system top level
--
-- authors:
-- Ivan Kastelan (ivan.kastelan@rt-rk.com)
-- Milos Subotic (milos.subotic@uns.ac.rs)
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;

entity top is
	port(
		iCLK  : in  std_logic;
		inRST : in  std_logic;
		oLED  : out std_logic_vector(15 downto 0)
	);
end entity;

architecture arch of top is

	signal sINSTR : std_logic_vector(14 downto 0);
	signal sDATA_LD : std_logic_vector(15 downto 0);
	signal sPC : std_logic_vector(15 downto 0);
	signal sDATA_ST : std_logic_vector(15 downto 0);
	signal sADDR : std_logic_vector(15 downto 0);
	signal sMEM_WE : std_logic;

begin

	cpu_top_i : entity work.cpu_top
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iINSTR => sINSTR,
		iDATA => sDATA_LD,
		oPC => sPC,
		oDATA => sDATA_ST,
		oADDR => sADDR,
		oMEM_WE => sMEM_WE,
		oLED => oLED
	);
	
	instr_rom_i : entity work.instr_rom
	port map(
		iA => sPC(4 downto 0),
		oQ => sINSTR
	);
	
	data_ram_i : entity work.data_ram
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iA => sADDR(7 downto 0),
		iD => sDATA_ST,
		iWE => sMEM_WE,
		oQ => sDATA_LD
	);

end architecture;
