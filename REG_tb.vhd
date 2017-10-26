library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.FIR_package.all;

entity REG_tb is
end REG_tb;

architecture arq of REG_tb is


component REG is
	port(
		data_in: in std_logic_vector(15 downto 0);
		clk, reset, wr: in std_logic;
		dir: in integer range 0 to 15;
		x_out, c_out: out std_logic_vector(15 downto 0)
		
	);	
end component;

   signal input,x_out, c_out: std_logic_vector(15 downto 0);
	signal reset, clk,wr_reg : std_logic;
	signal dir: integer range 0 to 15;
	constant PERIOD: time := 10 ns;
	
begin
	REG0: REG port map(data_in => input, clk => clk, reset=> reset , dir=> dir, wr=>wr_reg, x_out=> x_out , c_out=> x_out);
	
	process
		type input_record is record 
			input,x_out, c_out: std_logic_vector(15 downto 0);
			reset, clk,wr_reg : std_logic;
			dir: integer range 0 to 15;
		end record;
		type input_list is array (natural range <>) of input_record;
		constant inputs : input_list :=(("0000000000000001", "0000000000000000" , x"F1CA" , '1' , '1' , '0', 0),
						 ("0000000000000001", "0000000000000000" , x"F1CA" , '1' , '0' , '1', 0),
						 ("0000000000000001", "0000000000000001" , x"F1CA" , '1' , '1' , '0', 0),
						 ("0000000000000001", "0000000000000000" , x"F1CA" , '1' , '0' , '0', 1),
						 ("0000000000000001", "0000000000000000" , x"0D1C" , '1' , '1' , '0', 1),
						 ("0000000000000001", "0000000000000000" , x"0D1C" , '1' , '0' , '0', 2),
						 ("0000000000000001", "0000000000000000" , x"118F" , '1' , '1' , '0', 2),
						 ("0000000000000001", "0000000000000000" , x"118F" , '1' , '0' , '0', 3),
						 ("0000000000000001", "0000000000000000" , x"17AC" , '1' , '1' , '0', 3)); 
	begin
		for i in inputs'range loop
			 reset <= inputs(i).reset;
			 clk <= inputs(i).clk;
			 input <= inputs(i).input;
			 dir <= inputs(i).dir;
			 wr_reg <= inputs(i).wr_reg;
			 wait for PERIOD/2;
			 assert x_out = inputs(i).x_out
			    report "Incorrect x_out" severity error;
			 assert c_out = inputs(i).c_out
			    report "Incorrect c_out" severity error;

		end loop;
	      	assert false report "end of test" severity note;
	      	wait;
	end process;
end arq;
