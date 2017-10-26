library ieee;
use ieee.std_logic_1164.all;
use work.FIR_package.all;

entity fsm_test is
	port (
		clk, RESET,WRI: in std_logic;
		HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7: out std_logic_vector(6 downto 0);
		READY_SIGN: out std_logic
	);
end fsm_test;


architecture arq of fsm_test is

component Data_Gen is
	port(
		clk,wr,reset: in std_logic;
		rd: out std_logic;
		data: out std_logic_vector(15 downto 0)
	);
end component;

component FIR_10 is
	port (
		DATA_IN: in std_logic_vector(15 downto 0);
		clk, RESET, WR: in std_logic;
		DATA_OUT: out std_logic_vector(31 downto 0);
		READY_SIGN: out std_logic
	);
end component;

component sieteseg is
port (
		decimal: in std_logic_vector (31 downto 0);
		bcd0,bcd1,bcd2,bcd3,bcd4,bcd5,bcd6,bcd7: out std_logic_vector (6 downto 0)
		);
end component;

component clk_div_mac is
	port(
			 clk_in: in std_logic;
			 rst: in std_logic;
			 clk_out: out std_logic
	);
end component;

component clk_div_data is
	port(
			 clk_in: in std_logic;
			 rst: in std_logic;
			 clk_out: out std_logic
	);
end component;
	component REG is
		port(
			data_in: in std_logic_vector(15 downto 0);
			clk, reset, wr: in std_logic;
			dir: in integer range 0 to 15;
			x_out, c_out: out std_logic_vector(15 downto 0)
		);
	end component;	

	component MAC is
		port 
		(
			X, coeff										: in std_logic_vector(15 downto 0);
			reset,wr_mac, clk_mac					: in std_logic;
			output										: out std_logic_vector (31 downto 0)
		);
		
	end component;	

signal data,mac_in,mac_coeffs: std_logic_vector(15 downto 0);
signal wr,wr_reg,wr_mac,reset_mac: std_logic;
signal clk_data,clk_mac: std_logic;
signal out_decimal: std_logic_vector(31 downto 0);
signal dir: integer range 0 to 15 :=0;

begin 
	wr_mac <= '1';
	CLOCK_DATA: clk_div_data port map(clk_in => clk_mac, rst => RESET, clk_out => clk_data);
	CLOCK_MAC: clk_div_mac port map(clk_in => clk, rst => RESET, clk_out => clk_mac);
	DataGen: Data_Gen port map(data => data, rd=> wr, reset=> RESET, clk => clk_data, wr => WRI); 
	REG0: REG port map(data_in => data, clk => clk_mac, reset => RESET, wr => wr, dir => dir, x_out => mac_in, c_out => mac_coeffs);
	MAC_PROCESS: MAC port map(x => mac_in, coeff => mac_coeffs, reset => reset_mac, wr_mac => wr_mac, clk_mac => clk_mac, output => out_decimal);
	HEX: sieteseg port map(decimal => out_decimal, bcd0 => HEX0, bcd1 => HEX1,bcd2 => HEX2,bcd3 => HEX3,bcd4 => HEX4,bcd5 => HEX5,bcd6 => HEX6,bcd7 => HEX7);
	process(clk_mac,dir,reset_mac)
	begin
		if(clk_mac'event and clk_mac='1') then
			
			if(dir>10) then
				reset_mac <= '1';
				READY_SIGN <= '1';
				dir <=0;
				wr_reg <=  '0';
			elsif(dir=0) then
				wr_reg<='1';
				reset_mac <= '0';
				READY_SIGN <= '0';
			else	
				reset_mac <= '0';
				READY_SIGN <= '0';
				wr_reg <=  '0';
			end if;
			dir<=dir+1;
		end if;
	end process;

end arq;