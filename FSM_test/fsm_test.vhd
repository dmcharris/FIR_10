library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.FIR_package.all;

entity fsm_test is
port (
		clk, RESET,WRI: in std_logic;
		HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7: out std_logic_vector(6 downto 0);
		READY_SIGN: out std_logic
	);
end fsm_test;

architecture arq of fsm_test is


component FIR_10 is
	port (
		DATA_IN: in std_logic_vector(15 downto 0);
		clk, RESET, WR: in std_logic;
		DATA_OUT: out std_logic_vector(31 downto 0);
		READY_SIGN: out std_logic;
		CLOCK_OUT : out std_logic
	);
	
end component;
component clk_div_mac is
	port(
			 clk_in: in std_logic;
			 rst: in std_logic;
			 clk_out: out std_logic
	);
end component;
component Data_Gen is
		port(
			clk,wr,reset: in std_logic;
			rd: out std_logic;
			data: out std_logic_vector(15 downto 0)
		);
	end component;
	component sieteseg is
		port (
				decimal: in std_logic_vector (31 downto 0);
				bcd0,bcd1,bcd2,bcd3,bcd4,bcd5,bcd6,bcd7: out std_logic_vector (6 downto 0)
				);
end component;
   signal clk_out,clk_mac,rd: std_logic;
	signal X: std_logic_vector(15 downto 0);
	signal Y: std_logic_vector(31 downto 0);
begin
	CLOCK_MAC: clk_div_mac port map(clk_in => clk, rst => RESET, clk_out => clk_mac);
	U0: Data_Gen port map(clk => clk_out, wr => WRI, reset => reset, rd => rd, data => X);
	U1: FIR_10 port map(DATA_IN => X, clk => clk_mac, CLOCK_OUT =>clk_out, RESET => reset, WR => rd, DATA_OUT => Y, READY_SIGN =>ready_sign);
	HEX: sieteseg port map(decimal => Y, bcd0 => HEX0, bcd1 => HEX1,bcd2 => HEX2,bcd3 => HEX3,bcd4 => HEX4,bcd5 => HEX5,bcd6 => HEX6,bcd7 => HEX7);
end arq;
