library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity FSM_game is port ( 
	iRST  : in  std_logic;
	iCLK  : in  std_logic;
	iA	   : in  std_logic_vector(1 downto 0);
	iB	   : in  std_logic_vector(1 downto 0);
	oA  	: out std_logic;
	oB  	: out std_logic
	);
end entity;

architecture Behavioral of FSM_game is

	-- Singali
	type states is (DRAW, B_LEAD, B_WIN, A_LEAD, A_WIN);
	signal sSTATE, sNEXT_STATE : states;
	signal sWIN : std_logic_vector(1 downto 0);
	
begin
	process(iRST, iCLK) begin
		if(iRST = '1') then
			sSTATE <= DRAW;
		elsif (iCLK' event and iCLK = '1') then
			sSTATE <= sNEXT_STATE;
		end if;
	end process;
	
	-- funkcija prelaza
	
	process (sSTATE, iA, iB) begin
	 case sSTATE is
		when DRAW =>
			if(iA = "01") then
				sNEXT_STATE <= A_LEAD;
			elsif(iB = "01") then
				sNEXT_STATE <= B_LEAD;
			end if;
		when B_LEAD =>
			if(iB = "01") then
				sNEXT_STATE <= B_WIN;
			elsif (iA = "01") then
				sNEXT_STATE <= DRAW;
			elsif (iA = "10") then
				sNEXT_STATE <= A_LEAD;
			else
				sNEXT_STATE <= sSTATE;
			end if;
		when B_WIN =>
			sNEXT_STATE <= sSTATE;
		when A_LEAD =>
			if(iA = "01") then
			 sNEXT_STATE <= A_WIN;
			elsif(iB = "01") then
				sNEXT_STATE <= DRAW;
			elsif(iB = "10") then
				sNEXT_STATE <= B_LEAD;
			else
				sNEXT_STATE <= sSTATE;
			end if;
		when A_WIN =>
			sNEXT_STATE <= sSTATE;
		when others =>
			sNEXT_STATE <= sSTATE;
		end case;
	end process;


				
	sWIN <= "01" when sSTATE = A_WIN else
			  "10" when sSTATE = B_WIN else "00";
			   
	oA <= '1' when sWIN = "01" else '0';
	oB <= '1' when sWIN = "10" else '0';

end Behavioral;
