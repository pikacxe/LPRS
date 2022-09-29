library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Libraries.

entity lprs1_homework2 is
	port(
		i_clk    :  in std_logic;
		i_rst    :  in std_logic;
		i_run    :  in std_logic;
		i_pause  :  in std_logic;
		o_digit0 : out std_logic_vector(3 downto 0);
		o_digit1 : out std_logic_vector(3 downto 0);
		o_digit2 : out std_logic_vector(3 downto 0);
		o_digit3 : out std_logic_vector(3 downto 0)
	);
end entity;


architecture arch of lprs1_homework2 is
	-- Signals.
	-- Signali dozovle brojanja
	signal s_en_1us : std_logic;
	signal s_en0 : std_logic;
	signal s_en1 : std_logic;
	
	-- Signali kraja brojanja
	signal s_tc_1us : std_logic;
	signal s_tc0 : std_logic;
	
	-- Signali brojanja
	signal s_cnt_1us : std_logic_vector(6 downto 0);
	signal s_cnt0 : std_logic_vector(3 downto 0);
	signal s_cnt1 : std_logic_vector(3 downto 0);
		
	-- 100 * 10ns = 1us	
	
begin
	-- Body.
	
	-- Dozvola brojanja
	process (i_clk, i_run, i_rst, i_pause) begin
			if(i_rst = '1') then
				s_en_1us <= '0';
			elsif(i_clk' event and i_clk = '1') then	
				if(i_run  = '1') then
					s_en_1us <= '1';
				elsif(i_pause = '1') then
					s_en_1us <= '0';
				end if;
			end if;
	end process;
	
	-- Brojac 1 us
	process (i_clk,i_rst) begin
			if(i_rst = '1') then
				s_cnt_1us <= "0000000";
				s_tc_1us <= '0';
			elsif(i_clk' event and i_clk = '1') then
				if(s_en_1us = '1') then
					--broji
					s_tc_1us <= '0';
					s_cnt_1us <= s_cnt_1us + 1;
					if(s_cnt_1us >= "1100011") then -- Moduo 100
						s_cnt_1us <= "0000000";
						s_tc_1us <= '1';
					end if;					
				end if;		
			end if;
	end process;
	
	
	-- Kontrola brojanja
	--s_tc_1us <= '1' when s_cnt_1us = "0000000" else '0';
	
	-- And kolo
	s_en0 <= s_tc_1us and s_en_1us;
	
	-- Brojac nulte cifre
	process (i_rst,i_clk) begin		
			if(i_rst = '1') then
				s_cnt0 <= "0000";
				s_tc0 <= '0';
			elsif(i_clk' event and i_clk = '1') then
				if(s_en0 = '1') then
					-- broji	
					s_tc0 <= '0';
					s_cnt0 <= s_cnt0 + 1;
					if(s_cnt0 = "1001") then -- Moduo 10
						s_cnt0 <= "0000";
						s_tc0 <= '1';
					end if;					
				end if;
			end if;
	end process;
	
	-- Kontrola brojanja
	--s_tc0 <= '1' when s_cnt0 = "0000" else '0';
	
	
	--- And kolo
	s_en1 <= s_tc0 and s_en0;

	o_digit0 <= s_cnt0;
	
	-- Brojac prve cifre
	process (i_rst,i_clk) begin
		if(i_rst = '1') then
			s_cnt1 <= "0000";
		elsif (i_clk' event and i_clk = '1') then
			if(s_en1 = '1') then
				-- broji
				s_cnt1 <= s_cnt1 + 1;				
				if(s_cnt1 = "0100") then -- Moduo 4
					s_cnt1 <= "0000";
				end if;
			end if;	
		end if;
	end process;	
	

	o_digit1 <= s_cnt1;
	
	
	o_digit2 <= "0010";
	o_digit3 <= "1110";
	
end architecture;
