library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


library work;

entity automat_tb is
end entity;

architecture arch of automat_tb is

	constant i_clk_period : time := 10ns;

	signal i_clk				: 	 std_logic;
	signal i_rst				:   std_logic;
	signal i_run				:   std_logic;
	signal i_water				:   std_logic;
	signal i_wl_max 			:   std_logic;
	signal i_door_closed		:   std_logic;
	signal i_door_open		:   std_logic;
	signal i_detergent		:   std_logic;
	signal i_hw					:   std_logic_vector(1 downto 0);
	signal i_temp_ok			:   std_logic;
	signal i_wl_min 			:   std_logic;
	signal o_lock				:   std_logic;
	signal o_valve_in 		:   std_logic;
	signal o_heater			:   std_logic;
	signal o_motor_run		:   std_logic_vector(1 downto 0);
	signal o_valve_out		:   std_logic;
	signal o_pump_out			:   std_logic;

begin
	uut: entity work.AutomatVezba
	port map(
		i_clk            	=> i_clk,
		i_rst            	=> i_rst,
		i_run					=> i_run,
		i_water				=> i_water,
		i_wl_max				=> i_wl_max,
		i_door_closed		=> i_door_closed,
		i_door_open			=> i_door_open,
		i_detergent			=> i_detergent,
		i_hw					=> i_hw,
		i_temp_ok			=> i_temp_ok,
		i_wl_min				=> i_wl_min,
		o_lock				=> o_lock,
		o_valve_out			=> o_valve_out,
		o_valve_in			=> o_valve_in,
		o_pump_out			=> o_pump_out,
		o_motor_run			=> o_motor_run,
		o_heater				=> o_heater
	);
	
	clk_p: process
	begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
	end process;
	
	stim_p: process
	begin
	
	-- Test Cases
		i_rst <= '1';
		wait for 3.25 * i_clk_period;
		i_rst <= '0';
		
	-- Pranje haldnom vodom
		i_run <= '1';
		i_water <= '1';
		i_detergent <= '1';
		i_door_closed <= '1';
		wait for 10 * i_clk_period;
		i_wl_max <= '1';
		i_hw <= "00";
		wait for 10 * i_clk_period;
		i_temp_ok <= '1';
		i_wl_min <= '1';
		i_door_open <= '1';
		
	-- Pranje toplom vodom;
		wait for 300 * i_clk_period;
		i_rst <= '1';
		wait for 20 * i_clk_period;
		i_rst <= '0';
		
		i_hw <= "01";
		
	-- Pranje vrucom vodom
		wait for 300 * i_clk_period;
		i_rst <= '1';
		wait for 20 * i_clk_period;
		i_rst <= '0';
		
		i_hw <= "10";
	
	
	wait;
	
	end process;

end architecture;
