
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

library work;

entity lprs1_homework1_tb is
end entity;

architecture arch of lprs1_homework1_tb is
	
	signal o_res : std_logic_vector(3 downto 0);
	signal o_cmp : std_logic_vector(1 downto 0);
	signal o_enc : std_logic_vector(1 downto 0);
		
	signal m_x   : std_logic_vector(3 downto 0) := (others => 'U');
	signal m_y   : std_logic_vector(3 downto 0) := (others => 'U');
	signal m_z   : std_logic_vector(1 downto 0) := (others => 'U');
	signal m_sel : std_logic_vector(1 downto 0) := (others => 'U');
	
	signal i_x   : std_logic_vector(3 downto 0) := (others => 'U');
	signal i_y   : std_logic_vector(3 downto 0) := (others => 'U');
	signal i_z   : std_logic_vector(1 downto 0) := (others => 'U');
	signal i_sel : std_logic_vector(1 downto 0) := (others => 'U');
	
begin
	
	uut: entity work.lprs1_homework1
	port map(
		i_x   => m_x,
		i_y   => m_y,
		i_z   => m_z,
		i_sel => m_sel,
		o_res => o_res,
		o_cmp => o_cmp,
		o_enc => o_enc
	);
	
	emu: entity work.lprs1_max1000_board_emulator_comb
	port map(
		o_led(3 downto 0) => o_res,
		o_led(5 downto 4) => o_cmp,
		o_led(7 downto 6) => o_enc,
		o_sem_r           => '0',
		o_sem_y           => '0',
		o_sem_g           => '0',

		m_sw(3 downto 0)  => m_x,
		m_sw(7 downto 4)  => m_y,
		m_pb_up           => m_z(1),
		m_pb_center       => open,
		m_pb_down         => m_z(0),
		m_pb_left         => m_sel(1),
		m_pb_right        => m_sel(0),
		m_pb_rst          => open,
		
		i_sw(3 downto 0)  => i_x,
		i_sw(7 downto 4)  => i_y,
		i_pb_up           => i_z(1),
		i_pb_center       => 'U',
		i_pb_down         => i_z(0),
		i_pb_left         => i_sel(1),
		i_pb_right        => i_sel(0),
		i_pb_rst          => 'U'
	);
	
	stim_i: process
	begin
		-- Test cases:
		----------
		i_sel <= conv_std_logic_vector(1, i_sel'length);
		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 1 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 2 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 3 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 4 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 5 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 6 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 7 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 8 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 9 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 10 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 11 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 12 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 13 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 14 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 15 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 16 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 17 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 18 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 19 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 20 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 21 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 22 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 23 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 24 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 25 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 26 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 27 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 28 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 29 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 30 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 31 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 32 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 33 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 34 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 35 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 36 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 37 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 38 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 39 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 40 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 41 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 42 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 43 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 44 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 45 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 46 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 47 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 48 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 49 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 50 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 51 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 52 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 53 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 54 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 55 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 56 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 57 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 58 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 59 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 60 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 61 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 62 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 63 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 64 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 65 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 66 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 67 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 68 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 69 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 70 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 71 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 72 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 73 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 74 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 75 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 76 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 77 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 78 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 79 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 80 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 81 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 82 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 83 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 84 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 85 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 86 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 87 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 88 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 89 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 90 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 91 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 92 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 93 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 94 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 95 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 96 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 97 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 98 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 99 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 100 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 101 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 102 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 103 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 104 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 105 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 106 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 107 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 108 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 109 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 110 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 111 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 112 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 113 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 114 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 115 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 116 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 117 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 118 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 119 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 120 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 121 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 122 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 123 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 124 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 125 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 126 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 127 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 128 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 129 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 130 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 131 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 132 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 133 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 134 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 135 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 136 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 137 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 138 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 139 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 140 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 141 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 142 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 143 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 144 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 145 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 146 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 147 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 148 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 149 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 150 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 151 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 152 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 153 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 154 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 155 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 156 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 157 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 158 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 159 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 160 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 161 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 162 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 163 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 164 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 165 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 166 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 167 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 168 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 169 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 170 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 171 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 172 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 173 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 174 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 175 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 176 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 177 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 178 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 179 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 180 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 181 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 182 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 183 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 184 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 185 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 186 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 187 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 188 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 189 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 190 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 191 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 192 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 193 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 194 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 195 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 196 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 197 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 198 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 199 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 200 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 201 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 202 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 203 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 204 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 205 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 206 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 207 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 208 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 209 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 210 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 211 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 212 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 213 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 214 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 215 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 216 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 217 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 218 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 219 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 220 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 221 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 222 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 223 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 224 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 225 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 226 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 227 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 228 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 229 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 230 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 231 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 232 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 233 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 234 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 235 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 236 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 237 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 238 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 239 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 240 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 241 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(1, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 242 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(2, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 243 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(3, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 244 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(4, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 245 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(5, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 246 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(6, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 247 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(7, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 248 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(8, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 249 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(9, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 250 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(10, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 251 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(11, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 252 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(12, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 253 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(13, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 254 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(14, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 255 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(15, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 256 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		----------
		i_sel <= conv_std_logic_vector(0, i_sel'length);
		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 257 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 258 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 259 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 260 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 261 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 262 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 263 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(1, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 264 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 265 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 266 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 267 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(2, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 268 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 269 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 270 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 271 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(3, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 272 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 273 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 274 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 275 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(4, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 276 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 277 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 278 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 279 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(5, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 280 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 281 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 282 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 283 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(6, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 284 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 285 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 286 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 287 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(7, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 288 ns
		assert o_res = 1 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 289 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 290 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 291 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(8, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 292 ns
		assert o_res = 0 severity error;
		assert o_cmp(0) = '1' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 293 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 294 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 295 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(9, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 296 ns
		assert o_res = 15 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 297 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 298 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 299 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(10, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 300 ns
		assert o_res = 14 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 301 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 302 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 303 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(11, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 304 ns
		assert o_res = 13 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 305 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 306 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 307 ns
		assert o_res = 8 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 3 severity error;

		i_x <= conv_std_logic_vector(12, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 308 ns
		assert o_res = 12 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 309 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 310 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 311 ns
		assert o_res = 7 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(13, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 312 ns
		assert o_res = 11 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 313 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 314 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 315 ns
		assert o_res = 6 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(14, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 316 ns
		assert o_res = 10 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 317 ns
		assert o_res = 2 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 1 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(1, i_z'length);
		wait for 1 ns;
		-- 318 ns
		assert o_res = 3 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(2, i_z'length);
		wait for 1 ns;
		-- 319 ns
		assert o_res = 5 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 0 severity error;

		i_x <= conv_std_logic_vector(15, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(3, i_z'length);
		wait for 1 ns;
		-- 320 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		----------
		i_sel <= conv_std_logic_vector(2, i_sel'length);
		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 321 ns
		assert o_res = 4 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '1' severity error;
		assert o_enc = 2 severity error;

		----------
		i_sel <= conv_std_logic_vector(3, i_sel'length);
		i_x <= conv_std_logic_vector(0, i_x'length);
		i_y <= conv_std_logic_vector(0, i_y'length);
		i_z <= conv_std_logic_vector(0, i_z'length);
		wait for 1 ns;
		-- 322 ns
		assert o_res = 9 severity error;
		assert o_cmp(0) = '0' severity error;
		assert o_cmp(1) = '0' severity error;
		assert o_enc = 0 severity error;

		
		wait;
	end process;
	
	
end architecture;
