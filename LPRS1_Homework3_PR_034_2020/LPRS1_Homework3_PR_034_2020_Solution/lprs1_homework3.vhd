
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- Libraries.

entity lprs1_homework3 is
	port(
		i_clk            :  in std_logic;
		i_rst            :  in std_logic;
		i_base           :  in std_logic_vector(1 downto 0);
		i_sequence       :  in std_logic_vector(63 downto 0);
		i_load_sequence  :  in std_logic;
		i_base_src_sel   :  in std_logic;
		i_cnt_subseq_sel :  in std_logic_vector(1 downto 0);
		o_cnt_subseq     : out std_logic_vector(3 downto 0)
	);
end entity;


architecture arch of lprs1_homework3 is
	-- Constants.
	constant A : std_logic_vector(1 downto 0) := "00";
	constant C : std_logic_vector(1 downto 0) := "01";
	constant G : std_logic_vector(1 downto 0) := "10";
	constant T : std_logic_vector(1 downto 0) := "11";
	
	-- Signals.
	type tSTATE is (IDLE, A0S012, A1S2, A2S2, G0S01, T0S0, C0S1);
	signal s_state, s_next_state: tSTATE;
	signal s_base : std_logic_vector(1 downto 0);
	signal s_sh_base : std_logic_vector(1 downto 0);
	signal s_en_subseq0 : std_logic;
	signal s_en_subseq1 : std_logic;
	signal s_en_subseq2 : std_logic;
	signal s_cnt_subseq0 : std_logic_vector(3 downto 0);
	signal s_cnt_subseq1 : std_logic_vector(3 downto 0);
	signal s_cnt_subseq2 : std_logic_vector(3 downto 0);
	signal s_sh_reg : std_logic_vector(63 downto 0);
	signal s_mux_izl : std_logic_vector(3 downto 0);
	
	
begin
	-- Body.
	
	-- Automat sa konacnim brojem stanja
	
	-- Promena stanja sa sinhronim resetom
	process( i_clk, i_rst) begin
		if(i_clk' event and i_clk = '0') then
			if( i_rst = '1') then
				s_state <= IDLE;
			else
				s_state <= s_next_state;
			end if;
		end if;
	end process;
	
	-- Logika sledeceg stanja
	process(s_base, s_state) begin
		case s_state is
			when IDLE => 
				if(s_base = A) then
					s_next_state <= A0S012;
				else
					s_next_state <= IDLE;
				end if;
			when A0S012 =>
				if(s_base = A) then
					s_next_state <= A1S2;
				elsif (s_base = G) then
					s_next_state <= G0S01;
				else 
					s_next_state <= IDLE;
				end if;
			when A1S2 =>
				if(s_base = A) then
					s_next_state <= A2S2;
				elsif (s_base = G) then
					s_next_state <= G0S01;
				else 
					s_next_state <= IDLE;
				end if;
			when A2S2 =>
				if(s_base = A) then
					s_next_state <= A0S012;
				elsif (s_base = G) then
					s_next_state <= G0S01;
				else 
					s_next_state <= IDLE;
				end if;
			when G0S01 =>
				if(s_base = A) then
					s_next_state <= A0S012;
				elsif(s_base = C) then
					s_next_state <= C0S1;
				elsif(s_base = T) then
					s_next_state <= T0S0;
				else
					s_next_state <= IDLE;
				end if;
			when C0S1 =>
				if(s_base = A) then
					s_next_state <= A0S012;
				else
					s_next_state <= IDLE;
				end if;
			when T0S0 =>
				if(s_base = A) then
					s_next_state <= A0S012;
				else
					s_next_state <= IDLE;
				end if;		
			when others =>
				s_next_state <= IDLE;
			end case;
	end process;
			
	s_en_subseq0 <= '1' when s_state = T0S0 else '0';
	s_en_subseq1 <= '1' when s_state = C0S1 else '0';
	s_en_subseq2 <= '1' when s_state = A2S2 else '0';
	
	--brojac 0. podsekvence
	process( i_clk, i_rst) begin
		if( i_rst = '1') then
			s_cnt_subseq0 <= "0000";
		elsif(i_clk' event and i_clk = '0') then
			if(s_en_subseq0 = '1') then
				s_cnt_subseq0 <= s_cnt_subseq0 + '1';
				if(s_cnt_subseq0 = "0011") then
					s_cnt_subseq0 <= "0000";
				end if;
			end if;
		end if;
	end process;
	
	--brojac 1. podsekvence
	process(i_clk, i_rst) begin
		if(i_clk' event and i_clk = '0') then
			if(i_rst = '1') then
				s_cnt_subseq1 <= "0000";
			elsif(s_en_subseq1 = '1') then
				s_cnt_subseq1 <= s_cnt_subseq1 + '1';
				if(s_cnt_subseq1 = "0111") then
					s_cnt_subseq1 <= "0000";
				end if;
			end if;	
		end if;
	end process;
	
	--brojac 2. podsekvence
	process(i_clk, i_rst) begin
		if(i_clk' event and i_clk = '0') then
			if(i_rst = '1') then
				s_cnt_subseq2 <= "0000";
			elsif(s_en_subseq2 = '1') then
				s_cnt_subseq2 <= s_cnt_subseq2 + '1';
				if(s_cnt_subseq2 = "0101") then
					s_cnt_subseq2 <= "0000";
				end if;
			end if;	
		end if;
	end process;	
	
	--izlazni multiplekser
	process(i_cnt_subseq_sel) begin
		if(i_cnt_subseq_sel = "00") then
			s_mux_izl <= s_cnt_subseq0;
		elsif(i_cnt_subseq_sel = "01") then
			s_mux_izl <= s_cnt_subseq1;
		elsif(i_cnt_subseq_sel = "10") then
			s_mux_izl <= s_cnt_subseq2;
		else
			s_mux_izl <= s_cnt_subseq0;
		end if;
	end process;
	
	--ulazni multiplekser
	process(i_base_src_sel, i_base, s_sh_base) begin
		if(i_base_src_sel = '0') then
			s_base <= i_base;
		elsif(i_base_src_sel = '1') then
			s_base <= s_sh_base;
		else
			s_base <= i_base;
		end if;
	end process;
	
	-- pomeracki registar;
	process(i_clk, i_rst, i_load_sequence) begin
		if(i_clk' event and i_clk = '0') then
			if(i_rst = '1') then
				s_sh_reg <= "0000000000000000000000000000000000000000000000000000000000000000";
			elsif(i_load_sequence = '1') then
				s_sh_reg <= i_sequence;
			else
				s_sh_reg <= s_sh_reg(62 downto 0) & '0';
			end if;
		end if;
	end process;
	
	s_sh_base <= s_sh_reg(63) & s_sh_reg(62);
	o_cnt_subseq <= s_mux_izl;
	
end architecture;
