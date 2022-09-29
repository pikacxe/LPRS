library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity zadatak is
	port(
		iA : in std_logic_vector(7 downto 0);
		iB : in std_logic_vector(2 downto 0);
		iSEL : in std_logic_vector(1 downto 0);
		oY : out std_logic_vector(3 downto 0);
		oZERO : out std_logic
	);
end entity;

architecture Behavioral of zadatak is
	-- Prioritetni koder
	signal sCOD : std_logic_vector(2 downto 0);
	
	-- Dekoder
	signal sDEC : std_logic_vector(7 downto 0);
	
	-- Sabirac
	signal sADD_A : std_logic_vector(3 downto 0);
	signal sADD_B : std_logic_vector(3 downto 0);
	signal sADD   : std_logic_vector(3 downto 0);
	
	--Komplementer
	signal sCOMP  : std_logic_vector(3 downto 0);
	
	--Aritmeticko pomeranje
	signal  sSHIFT : std_logic_vector(3 downto 0);
	
	--Multiplekser
	signal sMUX : std_logic_vector(3 downto 0);
	
	
begin
	sCOD <= "111" when iA(7) = '1' else
			  "110" when iA(6) = '1' else
			  "101" when iA(5) = '1' else
			  "100" when iA(4) = '1' else
			  "011" when iA(3) = '1' else
			  "010" when iA(2) = '1' else
			  "001" when iA(1) = '1' else
			  "000" when iA(0) = '1' else
			  "000";
			  
	sDEC <= "00000001" when iB = "000" else
			  "00000010" when iB = "001" else
			  "00000100" when iB = "010" else
			  "00001000" when iB = "011" else
			  "00010000" when iB = "100" else
			  "00100000" when iB = "101" else
			  "01000000" when iB = "110" else
			  "10000000" when iB = "111" else
			  "10000000";
			  
			  
	sADD_A <= sCOD(2) & sCOD;
	sADD_B <= iB(2) & iB;
	
	sADD <= sADD_A + sADD_B;

	sCOMP <= not(sADD) + 1;
	
	sSHIFT <= sADD(3) & sADD(3) & sADD(3 downto 2);
	
	sMUX <= sCOMP when iSEL = "00" else
			  sSHIFT when iSEL = "01" else
			  sDEC(7 downto 4) when iSEL = "10" else
			  sDEC(3 downto 0);
			  
	oZERO <= '1' when sMUX = 0 else
				'0';
				
	oY <= sMUX;

end architecture;