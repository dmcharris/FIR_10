--FIR Code

library ieee;
use ieee.std_logic_1164.all;
use work.FIR_package.all;

entity FIR_10 is
	port (
		DATA_IN: in std_logic_vector(15 downto 0);
		clk, RESET, WR: in std_logic;
		DATA_OUT: out std_logic_vector(31 downto 0);
		READY_SIGN: out std_logic;
		CLOCK_OUT : out std_logic
	);
end FIR_10;


architecture arq of FIR_10 is

	--signal clock_out: std_logic;
	signal mac_in: std_logic_vector(15 downto 0);
	signal mac_coeffs: std_logic_vector(15 downto 0);
	signal wr_reg: std_logic;
	signal reset_mac: std_logic;
	signal dir: integer;
	signal mac_out: std_logic_vector(31 downto 0);
	
	component clk_div is
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
	
	component FSM is
		port 
		(
			reset, clk, wr								: in std_logic;
			wr_reg,ready_signal						: out std_logic;
			dir											: out integer range 0 to 15;
			mac_out										: in std_logic_Vector(31 downto 0);
			data_out										: out std_logic_Vector(31 downto 0)			
		);
		
	end component;
	
begin

	CLK_D: Clk_div port map(clk_in => clk, rst => RESET, clk_out => CLOCK_OUT);

	REG0: REG port map(data_in => DATA_IN, clk => clk, reset => RESET, wr => wr_reg, dir => dir, x_out => mac_in, c_out => mac_coeffs);
	
	MAC_PROCESS: MAC port map(x => mac_in, coeff => mac_coeffs, reset => RESET, wr_mac => WR, clk_mac => clk, output => mac_out);

	FSM_PROCESS: FSM port map(reset => RESET, clk => clk, wr => WR, ready_signal => READY_SIGN, dir=> dir, wr_reg=> wr_reg, mac_out => mac_out, data_out => DATA_OUT); 
	
end arq;