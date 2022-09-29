
----------------------------------------------------------------------------------
-- Logicko projektovanje racunarskih sistema 1
-- 2011/2012,2021
--
-- CPU top level
--
-- authors:
-- Ivan Kastelan (ivan.kastelan@rt-rk.com)
-- Milos Subotic (milos.subotic@uns.ac.rs)
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;

entity cpu_top is
	port(
		iCLK    : in  std_logic;
		inRST   : in  std_logic;
		iINSTR  : in  std_logic_vector(14 downto 0);
		iDATA   : in  std_logic_vector(15 downto 0);
		oPC     : out std_logic_vector(15 downto 0);
		oDATA   : out std_logic_vector(15 downto 0);
		oADDR   : out std_logic_vector(15 downto 0);
		oMEM_WE : out std_logic;
		oLED    : out std_logic_vector(15 downto 0)
	);
end entity cpu_top;

architecture arch of cpu_top is

	signal sREG_WE : std_logic_vector(7 downto 0);
	signal sR0, sR1, sR2, sR3, sR4, sR5, sR6, sR7 : std_logic_vector(15 downto 0);
	signal sMUXA, sMUXB : std_logic_vector(15 downto 0);
	signal sMUXA_SEL, sMUXB_SEL : std_logic_vector(3 downto 0);
	signal sALU_SEL : std_logic_vector(3 downto 0);
	signal sC : std_logic_vector(15 downto 0);
	signal sPC : std_logic_vector(15 downto 0);
	signal sPC_IN : std_logic_vector(15 downto 0);
	signal sPC_LOAD : std_logic;
	signal sMEM_WE : std_logic;
	signal sSIGN_COMB, sSIGN : std_logic;
	signal sZERO_COMB, sZERO : std_logic;
	signal sCARRY_COMB, sCARRY : std_logic;

begin

	alu_i : entity work.alu
	port map(
		iA => sMUXA,
		iB => sMUXB,
		iSEL => sALU_SEL,
		oC => sC,
		oSIGN => sSIGN_COMB,
		oCARRY => sCARRY_COMB,
		oZERO => sZERO_COMB
	);
	
	process(iCLK, inRST)
	begin
		if inRST = '0' then
			sSIGN <= '0';
			sCARRY <= '0';
			sZERO <= '0';
		elsif rising_edge(iCLK) then
			sSIGN <= sSIGN_COMB;
			sCARRY <= sCARRY_COMB;
			sZERO <= sZERO_COMB;
		end if;
	end process;
	
	pc_i : entity work.cnt
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iD => sPC_IN,
		iLOAD => sPC_LOAD,
		oQ => sPC
	);
	
	cu_i : entity work.control_unit
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iINSTR => iINSTR,
		oREG_WE => sREG_WE,
		oPC_IN => sPC_IN,
		oPC_LOAD => sPC_LOAD,
		oMUXA_SEL => sMUXA_SEL,
		oMUXB_SEL => sMUXB_SEL,
		oALU_SEL => sALU_SEL,
		oMEM_WE => sMEM_WE,
		iSIGN => sSIGN,
		iCARRY => sCARRY,
		iZERO => sZERO
	);
	
	muxa_i : entity work.mux
	port map(
		iD0 => sR0,
		iD1 => sR1,
		iD2 => sR2,
		iD3 => sR3,
		iD4 => sR4,
		iD5 => sR5,
		iD6 => sR6,
		iD7 => sR7,
		iD8 => iDATA,
		iSEL => sMUXA_SEL,
		oQ => sMUXA
	);
	
	mubx_i : entity work.mux
	port map(
		iD0 => sR0,
		iD1 => sR1,
		iD2 => sR2,
		iD3 => sR3,
		iD4 => sR4,
		iD5 => sR5,
		iD6 => sR6,
		iD7 => sR7,
		iD8 => iDATA,
		iSEL => sMUXB_SEL,
		oQ => sMUXB
	);
	
	r0_i : entity work.reg
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iD => sC,
		iWE => sREG_WE(0),
		oQ => sR0
	);
	
	r1_i : entity work.reg
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iD => sC,
		iWE => sREG_WE(1),
		oQ => sR1
	);
	
	r2_i : entity work.reg
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iD => sC,
		iWE => sREG_WE(2),
		oQ => sR2
	);
	
	r3_i : entity work.reg
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iD => sC,
		iWE => sREG_WE(3),
		oQ => sR3
	);
	
	r4_i : entity work.reg
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iD => sC,
		iWE => sREG_WE(4),
		oQ => sR4
	);
	
	r5_i : entity work.reg
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iD => sC,
		iWE => sREG_WE(5),
		oQ => sR5
	);
	
	r6_i : entity work.reg
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iD => sC,
		iWE => sREG_WE(6),
		oQ => sR6
	);
	
	r7_i : entity work.reg
	port map(
		iCLK => iCLK,
		inRST => inRST,
		iD => sC,
		iWE => sREG_WE(7),
		oQ => sR7
	);
	
	oPC <= sPC;
	oDATA <= sC;
	oADDR <= sMUXB;
	oMEM_WE <= sMEM_WE;
	
	oLED <= sC;

end architecture;
