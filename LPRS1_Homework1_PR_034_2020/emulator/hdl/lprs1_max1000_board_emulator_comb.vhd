
library ieee;
use ieee.std_logic_1164.all;

library work;

entity lprs1_max1000_board_emulator_comb is
	port(
		-- Outputs.
		o_led                      :  in std_logic_vector(7 downto 0);
		o_sem_r                    :  in std_logic;
		o_sem_y                    :  in std_logic;
		o_sem_g                    :  in std_logic;
		
		-- To UUT intputs.
		m_sw                       : out std_logic_vector(7 downto 0);
		m_pb_up                    : out std_logic;
		m_pb_center                : out std_logic;
		m_pb_down                  : out std_logic;
		m_pb_left                  : out std_logic;
		m_pb_right                 : out std_logic;
		m_pb_rst                   : out std_logic;
		
		-- Inputs from TB stim process.
		i_sw                       :  in std_logic_vector(7 downto 0);
		i_pb_up                    :  in std_logic;
		i_pb_center                :  in std_logic;
		i_pb_down                  :  in std_logic;
		i_pb_left                  :  in std_logic;
		i_pb_right                 :  in std_logic;
		i_pb_rst                   :  in std_logic
	);
end entity;


architecture lprs1_max1000_board_emulator_comb_arch
	of lprs1_max1000_board_emulator_comb is
	
	constant CLK_PERIOD : time := 83.333 ns; -- 12MHz
	
	signal clk          : std_logic := '0';
begin

	emu: entity work.lprs1_max1000_board_emulator
	port map(
		i_clk                    => clk,

		o_led                    => o_led,
		o_sem_r                  => o_sem_r,
		o_sem_y                  => o_sem_y,
		o_sem_g                  => o_sem_g,
		o_n_col_0_or_7segm_a     => '0',
		o_n_col_1_or_7segm_b     => '0',
		o_n_col_2_or_7segm_c     => '0',
		o_n_col_3_or_7segm_d     => '0',
		o_n_col_4_or_7segm_e     => '0',
		o_n_col_5_or_7segm_f     => '0',
		o_n_col_6_or_7segm_g     => '0',
		o_n_col_7_or_7segm_dp    => '0',
		o_mux_row_or_digit       => "000",
		o_mux_sel_color_or_7segm => "11",

		m_sw                     => m_sw,
		m_pb_up                  => m_pb_up,
		m_pb_center              => m_pb_center,
		m_pb_down                => m_pb_down,
		m_pb_left                => m_pb_left,
		m_pb_right               => m_pb_right,
		m_pb_rst                 => m_pb_rst,
		mn_rst                   => open,
		
		i_sw                     => i_sw,
		i_pb_up                  => i_pb_up,
		i_pb_center              => i_pb_center,
		i_pb_down                => i_pb_down,
		i_pb_left                => i_pb_left,
		i_pb_right               => i_pb_right,
		i_pb_rst                 => i_pb_rst,
		in_rst                   => '1'
	);
	
	clk_gen_i: process
	begin
		wait for CLK_PERIOD/2;
		clk <= not clk;
	end process;
	
end architecture;
