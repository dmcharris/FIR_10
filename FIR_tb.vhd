library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.FIR_package.all;

entity FIR_tb is
end FIR_tb;

architecture arq of FIR_tb is


component FIR_10 is
	port (
		DATA_IN: in std_logic_vector(15 downto 0);
		clk, RESET, WR: in std_logic;
		DATA_OUT: out std_logic_vector(31 downto 0);
		READY_SIGN: out std_logic;
		CLOCK_OUT : out std_logic
	);
	
end component;
component Data_Gen is
		port(
			clk,wr,reset: in std_logic;
			rd: out std_logic;
			data: out std_logic_vector(15 downto 0)
		);
	end component;
   signal clk_out,clk,wr,reset,rd, ready_sign: std_logic;
	signal X: std_logic_vector(15 downto 0);
	signal Y: std_logic_vector(31 downto 0);
begin
	U0: Data_Gen port map(clk => clk_out, wr => wr, reset => reset, rd => rd, data => X);
	U1: FIR_10 port map(DATA_IN => X, clk => clk, CLOCK_OUT =>clk_out, RESET => reset, WR => rd, DATA_OUT => Y, READY_SIGN =>ready_sign);
	process
	begin
		clk <= '1';
		reset <= '1';
		wr <= '1';
		wait for 50 ns;
		clk <= '0';
		reset <= '0';
		wait for 50 ns;
		for i in 1 to 200 loop
			clk <= not(clk);
			wait for 50 ns;
		end loop;
		assert false report "end of test" severity note;
		wait;
	end process;
end arq;
