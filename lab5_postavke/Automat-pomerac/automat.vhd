library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity automat is
    Port ( 	iCLK    	: in  std_logic;
				iRST    	: in  std_logic;
				iSTOP   	: in  std_logic;
				iRL	   : in  std_logic;
				iRR		: in  std_logic;
				iSRA		: in 	std_logic;
				oDATA		: out std_logic_vector(7 downto 0));
end automat;

architecture Behavioral of automat is

	type tSTATE is (IDLE, ROT_LEFT, ROT_RIGHT, SHIFT_RIGHT_ARITH);
	signal sSTATE, sNEXT_STATE : tSTATE;
	signal sDATA : std_logic_vector(7 downto 0);
	signal sNEXT_DATA : std_logic_vector(7 downto 0);

begin

	process(iCLK, iRST) begin
		if(iRST = '1') then
			sSTATE <= IDLE;
		elsif (iCLK'	event and iCLK = '1') then
			sSTATE <= sNEXT_STATE;
		end if;	
	end process;
	
	process(iSTOP, iRL, iRR, iSRA, sSTATE) begin
		case sSTATE is
			when IDLE =>
				if(iRL = '1') then
					sNEXT_STATE <= ROT_LEFT;
				elsif (iRR = '1') then
					sNEXT_STATE <= ROT_RIGHT;
				elsif (iSRA = '1') then
					sNEXT_STATE <= SHIFT_RIGHT_ARITH;
				else
					sNEXT_STATE <= IDLE;
				end if;
			when ROT_LEFT =>
				if(iSTOP = '1') then
					sNEXT_STATE <= IDLE;
				else
					sNEXT_STATE <= ROT_LEFT;
				end if;
			when ROT_RIGHT =>
				if(iSTOP = '1') then
					sNEXT_STATE <= IDLE;
				else
					sNEXT_STATE <= ROT_RIGHT;
				end if;
			when SHIFT_RIGHT_ARITH =>
				if(iSTOP = '1') then
					sNEXT_STATE <= IDLE;
				else
					sNEXT_STATE <= SHIFT_RIGHT_ARITH;
				end if;
			when others =>
				sNEXT_STATE <= IDLE;
		end case;
	end process;
	
	
	process(iCLK, iRST) begin
		if( iRST = '1') then
			sDATA <= "00000000";
		elsif( iCLK' event and iCLK = '1') then
			sDATA <= sNEXT_DATA;
		end if;
	end process;
	
	process(sSTATE, sDATA) begin
		case sSTATE is
			when IDLE => sNEXT_DATA <= "00110011";
			when ROT_LEFT => sNEXT_DATA <= sDATA(6 downto 0) & sDATA(7);
			when ROT_RIGHT => sNEXT_DATA <= sDATA(0) & sDATA(7 downto 1);
			when SHIFT_RIGHT_ARITH => sNEXT_DATA <= sDATA(7) & sDATA(7 downto 1);
			when others => sNEXT_DATA <= "00000000";
		end case;
	end process;
	
	oDATA <= sDATA;
	
end architecture;