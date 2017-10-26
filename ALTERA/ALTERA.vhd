--Together

library ieee;
use ieee.std_logic_1164.all;
use work.FIR_package.all;

entity ALTERA is
	port (
		clk, RESET,WRI: in std_logic;
		HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7: out std_logic_vector(6 downto 0);
		READY_SIGN: out std_logic
	);
end ALTERA;


architecture arq of ALTERA is

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

signal data: std_logic_vector(15 downto 0);
signal wr: std_logic;
signal clk_data,clk_mac: std_logic;
signal out_decimal: std_logic_vector(31 downto 0);

begin 
	CLOCK_DATA: clk_div_data port map(clk_in => clk_mac, rst => RESET, clk_out => clk_data);
	CLOCK_MAC: clk_div_mac port map(clk_in => clk, rst => RESET, clk_out => clk_mac);
	DataGen: Data_Gen port map(data => data, rd=> wr, reset=> RESET, clk => clk_data, wr => WRI); 
	FIR: FIR_10 port map(DATA_IN => data, clk => clk, RESET => RESET, wr => wr, DATA_OUT => out_decimal, READY_SIGN => READY_SIGN);
	HEX: sieteseg port map(decimal => out_decimal, bcd0 => HEX0, bcd1 => HEX1,bcd2 => HEX2,bcd3 => HEX3,bcd4 => HEX4,bcd5 => HEX5,bcd6 => HEX6,bcd7 => HEX7);

end arq;