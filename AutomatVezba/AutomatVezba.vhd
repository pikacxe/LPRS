library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity AutomatVezba is
	port (

	i_clk				: in std_logic;
	i_rst				: in std_logic;
	i_run				: in std_logic;
	i_water			: in std_logic;
	i_wl_max 		: in std_logic;
	i_door_closed	: in std_logic;
	i_door_open		: in std_logic;
	i_detergent		: in std_logic;
	i_hw				: in std_logic_vector(1 downto 0);
	i_temp_ok		: in std_logic;
	i_wl_min			: in std_logic;
	o_lock			: out std_logic;
	o_valve_in		: out std_logic;
	o_heater			: out std_logic;
	o_motor_run		: out std_logic_vector(1 downto 0);
	o_valve_out		: out std_logic;
	o_pump_out		: out std_logic
);
end entity;


architecture arch of AutomatVezba is
 -- Signals
	type states is (S_IDLE, S_WATER_IN, S_COLD_W, S_WARM_W, S_HOT_W, S_WASHING, S_WATER_OUT, S_CENTRIFUGA, S_WAIT);
	signal s_state, s_next_state: states;
	signal s_w_timer_elapsed : std_logic;
	signal s_c_timer_elapsed : std_logic;
	signal s_cnt_w : std_logic_vector(5 downto 0) := "110010";
	signal s_cnt_c : std_logic_vector(4 downto 0) := "10100";
	signal s_w_init : std_logic;
	signal s_c_init : std_logic;
	signal s_clr_w_c : std_logic;
	signal s_out : std_logic_vector(9 downto 0);
	

begin
	-- Automat
	process(i_rst, i_clk) begin
		if (i_rst = '1') then
			s_state <= S_IDLE;
		elsif (i_clk' event and i_clk = '1') then
			s_state <= s_next_state;
		end if;
	end process;
		
	process (s_state, i_run, i_water, i_detergent, i_door_closed, i_wl_max, i_wl_min, i_hw, i_temp_ok, s_w_timer_elapsed, s_c_timer_elapsed) begin
		case (s_state) is
			when S_IDLE => 
				if (i_run = '1' and i_water = '1' and i_detergent = '1' and i_door_closed = '1') then
					s_next_state <= S_WATER_IN;
				else
					s_next_state <= s_state;
				end if;
			when S_WATER_IN =>
				if (i_wl_max = '1' ) then
					if (i_hw = "00" ) then
						s_next_state <= S_COLD_W;
					elsif (i_hw = "01") then
						s_next_state <= S_WARM_W;
					elsif (i_hw = "11") then
						s_next_state <= S_HOT_W;
					else 
						s_next_state <= s_state;
					end if;
				else 
					s_next_state <= s_state;
				end if;
			when S_COLD_W =>
				if (i_temp_ok = '1') then
					s_next_state <= S_WASHING;
				else 
					s_next_state <= s_state;
				end if;
			when S_WARM_W =>
				if (i_temp_ok = '1') then
					s_next_state <= S_WASHING;
				else 
					s_next_state <= s_state;
				end if;
			when S_HOT_W =>
				if (i_temp_ok = '1') then
					s_next_state <= S_WASHING;
				else 
					s_next_state <= s_state;
				end if;
			when S_WASHING =>
				if (s_w_timer_elapsed = '1') then
					s_next_state <= S_WATER_OUT;
				else
					s_next_state <= s_state;
				end if;
			when S_WATER_OUT =>
				if (i_wl_min = '1') then
					s_next_state <= S_CENTRIFUGA;
				else
					s_next_state <= s_state;
				end if;
			when S_CENTRIFUGA =>
				if (s_c_timer_elapsed = '1') then
					s_next_state <= S_WAIT;
				else
					s_next_state <= s_state;
				end if;
			when S_WAIT =>
				if (i_door_open = '1') then
					s_next_state <= S_IDLE;
				else
					s_next_state <= s_state;
				end if;
			when others =>
				s_next_state <= s_state;
			end case;
	end process; 
				
-- Water Couter
	process (i_clk, i_rst) begin
		if (i_rst = '1' or s_clr_w_c = '1') then
			s_cnt_w <= "110010";
		elsif (i_clk' event and i_clk = '1') then
			if (s_w_init = '1') then
				s_cnt_w <= s_cnt_w - 1;
				if (s_cnt_w = 1) then
					s_cnt_w <= "110010";
					s_w_timer_elapsed <= '1';
				end if;
			end if;
		end if;
	end process;
	
-- Centrifuga timer
	process (i_clk, i_rst) begin
		if (i_rst = '1' or s_clr_w_c = '1') then
			s_cnt_c <= "10100";
		elsif (i_clk' event and i_clk = '1') then
			if (s_c_init = '1') then
				s_cnt_c <= s_cnt_c - 1;
				if (s_cnt_c = 0) then
					s_cnt_c <= "10100";
					s_c_timer_elapsed <= '1';
				end if;
			end if;
		end if;
	end process;

-- Izlazi automata
	s_out <= "0000000001" when s_state = S_IDLE 			else
				"1100000000" when s_state = S_WATER_IN 	else
				"1000000000" when s_state = S_COLD_W 		else
				"1010000000" when s_state = S_WARM_W 		else
				"1010000000" when s_state = S_HOT_W 		else
				"1000100100" when s_state = S_WASHING 		else
				"1000011000" when s_state = S_WATER_OUT	else
				"1001011010" when s_state = S_CENTRIFUGA	else
				"0000000000";
				
	o_lock <= s_out(9);
	o_valve_in <= s_out(8);
	o_heater <= s_out(7);
	o_motor_run <= s_out(6 downto 5);
	o_valve_out <= s_out(4);
	o_pump_out <= s_out(3);
	s_w_init <= s_out(2);
	s_c_init <= s_out(1);
	s_clr_w_c <= s_out(0);

end architecture;