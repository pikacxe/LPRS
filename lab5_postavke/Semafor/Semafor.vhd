library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Semafor is
    port ( 	iCLK    : in  std_logic;
				iRST    : in  std_logic;
				iOK     : in  std_logic;
				iHAZ    : in  std_logic;
				oRED    : out std_logic;
				oYELLOW : out std_logic;
				oGREEN  : out std_logic);
end Semafor;

architecture Behavioral of Semafor is
	type tSTATE is (IDLE, RED, RED_YELLOW, GREEN, YELLOW, HAZARD);
	signal sSTATE, sNEXT_STATE : tSTATE;
	signal sCNT : std_logic_vector(2 downto 0);
	signal sTC : std_logic;
	signal sYELLOW : std_logic;

begin

	-- brojac do 4
	process (iCLK, iRST) begin
		if( iRST = '1') then
			sCNT <= "000";
		elsif (iCLK' event and iCLK = '1') then
			sCNT <= sCNT + '1';
			if(sCNT = "100") then
				sTC <= '1';
				sCNT <= "000";
			else
				sTC <= '0';
			end if;
		end if;
	end process;
	

	process (iRST, iCLK) begin
		if (iRST = '1') then
			sSTATE <= IDLE;
		elsif ( iCLK' event and iCLK = '1') then
			if(sTC = '1') then
			sSTATE <= sNEXT_STATE;
			end if;
		end if;
	end process;
	
	process(sSTATE, iOK, iHAZ) begin
		case sSTATE is
			when IDLE =>
				if(iOK = '1') then
					sNEXT_STATE <= RED;
				else
					sNEXT_STATE <= IDLE;
				end if;
			when RED =>
				if(iHAZ = '1') then
					sNEXT_STATE <= HAZARD;
				else
					sNEXT_STATE <= RED_YELLOW;
				end if;
			when RED_YELLOW =>
				if(iHAZ = '1') then
					sNEXT_STATE <= HAZARD;
				else
					sNEXT_STATE <= GREEN;
				end if;
			when GREEN =>
				if(iHAZ = '1') then
					sNEXT_STATE <= HAZARD;
				else
					sNEXT_STATE <= YELLOW;
				end if;
			when YELLOW =>
				if(iHAZ = '1') then
					sNEXT_STATE <= HAZARD;
				else
					sNEXT_STATE <= RED;
				end if;
			when HAZARD =>
				if(iOK = '1') then
					sNEXT_STATE <= RED;
				else
					sNEXT_STATE <= HAZARD;
				end if;
			when others =>
				sNEXT_STATE <= IDLE;
			end case;
	end process;
	
	process(sSTATE) begin
		case sSTATE is
			when YELLOW => sYELLOW <= '1';
			when RED_YELLOW => sYELLOW <= '1';
			when HAZARD =>
				if(sTC ='1') then
					sYELLOW <= '1';
				else
					sYELLOW <= '0';
				end if;
			when others =>
				sYELLOW <= '0';
		end case;
	end process;
 
	oRED <= '1' when sSTATE = RED or sSTATE = RED_YELLOW else '0';
	oYELLOW <= sYELLOW;
	oGREEN <= '1' when sSTATE = GREEN  else '0';
	
	
end Behavioral;