
library ieee;
use ieee.std_logic_1164.all;

use std.textio.all;
use ieee.std_logic_textio.all;

library work;

entity lprs1_max1000_board_emulator is
	port(
		-- System signals.
		i_clk                      :  in std_logic; -- 12MHz clock.
		
		-- Outputs.
		o_led                      :  in std_logic_vector(7 downto 0);
		o_sem_r                    :  in std_logic;
		o_sem_y                    :  in std_logic;
		o_sem_g                    :  in std_logic;
		o_n_col_0_or_7segm_a       :  in std_logic;
		o_n_col_1_or_7segm_b       :  in std_logic;
		o_n_col_2_or_7segm_c       :  in std_logic;
		o_n_col_3_or_7segm_d       :  in std_logic;
		o_n_col_4_or_7segm_e       :  in std_logic;
		o_n_col_5_or_7segm_f       :  in std_logic;
		o_n_col_6_or_7segm_g       :  in std_logic;
		o_n_col_7_or_7segm_dp      :  in std_logic;
		o_mux_row_or_digit         :  in std_logic_vector(2 downto 0);
		o_mux_sel_color_or_7segm   :  in std_logic_vector(1 downto 0);
		
		-- To UUT intputs.
		m_sw                       : out std_logic_vector(7 downto 0);
		m_pb_up                    : out std_logic;
		m_pb_center                : out std_logic;
		m_pb_down                  : out std_logic;
		m_pb_left                  : out std_logic;
		m_pb_right                 : out std_logic;
		m_pb_rst                   : out std_logic;
		mn_rst                     : out std_logic; -- Active low reset.
		
		-- Inputs from TB stim process.
		i_sw                       :  in std_logic_vector(7 downto 0);
		i_pb_up                    :  in std_logic;
		i_pb_center                :  in std_logic;
		i_pb_down                  :  in std_logic;
		i_pb_left                  :  in std_logic;
		i_pb_right                 :  in std_logic;
		i_pb_rst                   :  in std_logic;
		in_rst                     :  in std_logic -- Active low reset.
	);
end entity;


architecture lprs1_max1000_board_emulator_arch
	of lprs1_max1000_board_emulator is
		
	signal emu_ins : std_logic_vector(14 downto 0) := (others => '0');
	
	constant sufix : string := "__lprs1_max1000_board_emulator.txt";
	
	
	signal outs     : std_logic_vector(23 downto 0);
	signal m_ins    : std_logic_vector(14 downto 0);
	signal tb_ins   : std_logic_vector(14 downto 0);
	
	signal outs_d1  : std_logic_vector(23 downto 0);
begin
	outs <=
		o_sem_g &
		o_sem_y &
		o_sem_r &
		o_mux_sel_color_or_7segm &
		o_mux_row_or_digit &
		o_n_col_7_or_7segm_dp &
		o_n_col_6_or_7segm_g &
		o_n_col_5_or_7segm_f &
		o_n_col_4_or_7segm_e &
		o_n_col_3_or_7segm_d &
		o_n_col_2_or_7segm_c &
		o_n_col_1_or_7segm_b &
		o_n_col_0_or_7segm_a &
		o_led;

	-- Masked: tb ins have priority over emulator ins.
	m_sw <= m_ins(7 downto 0);
	m_pb_up <= m_ins(8);
	m_pb_center <= m_ins(9);
	m_pb_down <= m_ins(10);
	m_pb_left <= m_ins(11);
	m_pb_right <= m_ins(12);
	m_pb_rst <= m_ins(13);
	mn_rst <= m_ins(14);

	-- Inactive when in_rst is 1, others are U.
	tb_ins <= in_rst &
		i_pb_rst  & i_pb_right  & i_pb_left &
		i_pb_down & i_pb_center & i_pb_up &
		i_sw;
	
	
	process(i_clk)
	begin
		if falling_edge(i_clk) then
			outs_d1 <= outs;
		end if;
	end process;
	
	process(i_clk)
		file f : text;
		variable fstatus : file_open_status;
		variable row : line;
	begin
		if falling_edge(i_clk) then
			if outs /= outs_d1 then -- Change occured.
				file_open(
					fstatus,
					f,
					"outs" & sufix,
					WRITE_MODE
				);
				--TODO fstatus
				-- MSB is first.
				write(row, outs, RIGHT, outs'length);
				writeline(f, row);
				file_close(f);
			end if;
		end if;
	end process;
	
	
	process
		file f : text;
		variable fstatus : file_open_status;
		variable row : line;
		variable v : std_logic_vector(14 downto 0);
		--variable good_v : boolean;
		variable stay_in_loop : boolean;
	begin
		--TODO Count num of errors.
		-- Loop if file exists, but is not completely read.
		stay_in_loop := true;
		for i in 0 to 10 loop
			file_open(
				fstatus,
				f,
				"emu_ins" & sufix,
				READ_MODE
			);
			if fstatus /= OPEN_OK then
				--report "ERROR: No file!";
				stay_in_loop := false;
			else
				if endfile(f) then
					-- Often come here.
					--report "ERROR: Incomplete file 2!";
				else
					readline(f, row);
					if row'length /= 15 then
						--report "ERROR: Incomplete file!";
					else
						read(row, v);
						--read(row, v, good_v);
						emu_ins <= v;
						stay_in_loop := false;
					end if;
				end if;
			end if;
			file_close(f);
			if not stay_in_loop then
				exit;
			end if;
		end loop;
		
		wait for 1 us;
	end process;
	
	masking: for i in 0 to 13 generate
		m_ins(i) <= emu_ins(i) when tb_ins(i) = 'U' else tb_ins(i);
	end generate;
	m_ins(14) <= emu_ins(14) when tb_ins(14) = '1' else tb_ins(14);
	
end architecture;
