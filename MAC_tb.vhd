library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MAC_tb is
end MAC_tb;

architecture arq of MAC_tb is


component MAC is
	port 
	(
		X, coeff										: in std_logic_vector(15 downto 0);
		reset,wr_mac, clk_mac					: in std_logic;
		output										: out std_logic_vector (31 downto 0)
	);
	
end component;
    signal input,coeff : std_logic_vector(15 downto 0);
    signal output: std_logic_vector(31 downto 0);
	signal reset, clk,wr_mac : std_logic;
	constant PERIOD: time := 10 ns;
begin
	MAC0: MAC port map(X => input, coeff => coeff, output => output, reset => reset, wr_mac => wr_mac, clk_mac => clk);
	
	process
		type input_record is record 
            input,coeff : std_logic_vector(15 downto 0);
            output: std_logic_vector(31 downto 0);
			reset, clk,wr_mac: std_logic;
		end record;
		type input_list is array (natural range <>) of input_record;
		constant inputs : input_list :=(("0000000000000001", "1111100001011100", "00000000000000000000000000000000",'1','1','1'),
						 ("0000000000000001", "1111100001011100", "00000000000000000000000000000000",'0','0','1'),
						 ("0000000000000001", "1111100001011100", "11111111111111111111100001011100",'0','1','1'),
						 ("0000000000000010", "0001010100010110", "11111111111111111111100001011100",'0','0','1'),
						 ("0000000000000010", "0001010100010110", "00000000000000000010001010001000",'0','1','1'), 
						 ("0000000000000011", "0001000111011111", "00000000000000000010001010001000",'0','0','1')); 
	begin
		for i in inputs'range loop
			 reset <= inputs(i).reset;
			 clk <= inputs(i).clk;
			 input <= inputs(i).input;
			 coeff <= inputs(i).coeff;
			 wr_mac <= inputs(i).wr_mac;
			 wait for PERIOD/2;
			 assert output = inputs(i).output
			    report "Incorrect output" severity error;
	      	end loop;
	      	assert false report "end of test" severity note;
	      	wait;
	end process;
end arq;
