
----------------------------------------------------------------------------------
-- Logicko projektovanje racunarskih sistema 1
-- 2011/2012,2020,2021
--
-- Control unit
--
-- authors:
-- Ivan Kastelan (ivan.kastelan@rt-rk.com)
-- Milos Subotic (milos.subotic@uns.ac.rs)
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
	port(
		iCLK      : in  std_logic;
		inRST     : in  std_logic;
		iINSTR    : in  std_logic_vector(14 downto 0);
		iSIGN     : in  std_logic;
		iZERO     : in  std_logic;
		iCARRY    : in  std_logic;
		oREG_WE   : out std_logic_vector(7 downto 0);
		oPC_IN    : out std_logic_vector(15 downto 0);
		oPC_LOAD  : out std_logic;
		oMUXA_SEL : out std_logic_vector(3 downto 0);
		oMUXB_SEL : out std_logic_vector(3 downto 0);
		oALU_SEL  : out std_logic_vector(3 downto 0);
		oMEM_WE   : out std_logic
	);
end entity control_unit;

architecture arch of control_unit is

	signal sY : std_logic_vector(2 downto 0);
	signal sX : std_logic_vector(2 downto 0);
	signal sZ : std_logic_vector(2 downto 0);
	signal sA : std_logic_vector(8 downto 0);
	signal sI : std_logic_vector(5 downto 0);
	signal sO : std_logic_vector(3 downto 0);
	signal sT : std_logic_vector(1 downto 0);
	
	signal sZ_DEC : std_logic_vector(7 downto 0);
	
begin

	sY <= iINSTR(2 downto 0);
	sX <= iINSTR(5 downto 3);
	sZ <= iINSTR(8 downto 6);
	sA <= iINSTR(8 downto 0);
	sI <= iINSTR(14 downto 9);
	sO <= sI(3 downto 0);
	sT <= sI(5 downto 4);
	
	-- Selecting source operands for ALU.
	-- Load instruction source iDATA.
	oMUXA_SEL <= "1000" when sT = "10" else '0' & sX;
	oMUXB_SEL <= '0' & sY;
	
	oALU_SEL <= sO;
	
	sZ_DEC <=
		"00000001" when sZ = "000" else
		"00000010" when sZ = "001" else
		"00000100" when sZ = "010" else
		"00001000" when sZ = "011" else
		"00010000" when sZ = "100" else
		"00100000" when sZ = "101" else
		"01000000" when sZ = "110" else
		"10000000";
	-- Result is written in registers on ALU or Load instructions.
	oREG_WE <= sZ_DEC when sT = "00" or sT = "10" else "00000000";
	
	-- Store instruction WE.
	oMEM_WE <= '1' when sT = "11" else '0';
	
	-- Load sA to PC i.e. jump to address.
	oPC_IN <= "0000000" & sA;
	oPC_LOAD <=
		'1' when
			sT = "01" and                         -- Jump instructions.
			(
				(sO = "0000") or                  -- jmp
				(sO = "0001" and iZERO  = '1') or -- jmpz
				(sO = "0010" and iSIGN  = '1') or -- jmps
				(sO = "0011" and iCARRY = '1') or -- jmpc
				(sO = "0101" and iZERO  = '0') or -- jmpnz
				(sO = "0110" and iSIGN  = '0') or -- jmpns
				(sO = "0111" and iCARRY = '0')    -- jmpnc
			)
		else '0';

end architecture;
