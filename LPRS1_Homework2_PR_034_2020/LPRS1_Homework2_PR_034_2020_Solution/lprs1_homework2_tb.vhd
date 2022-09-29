
library ieee;
use ieee.std_logic_1164.all;

library work;

entity lprs1_homework2_tb is
end entity;

architecture arch of lprs1_homework2_tb is
	
	constant i_clk_period : time := 10 ns; -- 100 MHz
	
	signal i_clk    : std_logic;
	signal i_rst    : std_logic;
	signal i_run    : std_logic;
	signal i_pause  : std_logic;
	
	signal o_digit0 : std_logic_vector(3 downto 0);
	signal o_digit1 : std_logic_vector(3 downto 0);
	signal o_digit2 : std_logic_vector(3 downto 0);
	signal o_digit3 : std_logic_vector(3 downto 0);
	
begin
	
	uut: entity work.lprs1_homework2
	port map(
		i_clk    => i_clk,
		i_rst    => i_rst,
		i_run    => i_run,
		i_pause  => i_pause,
		o_digit0 => o_digit0,
		o_digit1 => o_digit1,
		o_digit2 => o_digit2,
		o_digit3 => o_digit3
	);
	
	clk_p: process
	begin
		i_clk <= '1';
		wait for i_clk_period/2;
		i_clk <= '0';
		wait for i_clk_period/2;
	end process;
	
	stim_p: process
	begin
		-- Test cases:
		i_run <= '0';
		i_pause <= '0';
		
		-- 1.
		i_rst <= '1';
		wait for 1us - i_clk_period;
		i_rst <= '0';
		
		-- 2.
		i_run <= '1';
		wait for i_clk_period;
		i_run <= '0';
		
		--3.
		wait for 298*i_clk_period; 
		
		--4.
		i_pause <= '1';
		wait for i_clk_period;
		i_pause <= '0';
		
		i_run <= '1';
		wait for i_clk_period; 
		i_run <= '0';
		wait for 2 * i_clk_period; 
		--5.
		i_run <= '1';
		
		--6.
		wait for 99*i_clk_period;
		i_rst <= '1';
		wait for 99*i_clk_period;
		
		i_rst <= '0';
		
		--7. 
		wait for  2302 * i_clk_period;
		
		i_rst <= '1';
		wait for i_clk_period;
		i_rst <= '0';
		
		--8. 
		wait for 1502 * i_clk_period;
		
		i_rst <= '1';
		wait for i_clk_period;
		i_rst <= '0';
		

	
		wait;
	end process;
	
	
end architecture;
