library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.FIR_package.all;

entity FSM_tb is
end FSM_tb;

architecture arq of FSM_tb is


component FSM is
	port 
	(
		reset, clk, wr								: in std_logic;
		wr_reg,ready_signal						: out std_logic;
		dir											: out integer range 0 to 15
	);
	
end component;

	signal reset, clk, wr:std_logic;
	signal wr_reg,ready_signal: std_logic;
	signal dir: integer range 0 to 15;
	constant PERIOD: time := 10 ns;
	
begin
	FSM_p: FSM port map(reset => reset, clk => clk, dir=> dir, wr=>wr, wr_reg=> wr_reg , ready_signal=> ready_signal);
	
	process
		type input_record is record 
			reset, clk, wr:std_logic;
			wr_reg,ready_signal: std_logic;
			dir: integer range 0 to 15;
		end record;
		type input_list is array (natural range <>) of input_record;
		constant inputs : input_list :=(('1', '1' , '1', '0' , '0' , 0),
						 ('0', '0' , '1', '0' , '0' , 0),
						 ('0', '1' , '1', '1' , '0' , 0),
						 ('0', '0' , '1', '1' , '0' , 0),
						 ('0', '1' , '1', '0' , '0' , 1),
						 ('0', '0' , '1', '0' , '0' , 1),
						 ('0', '1' , '1', '0' , '0' , 2)); 
	begin
		for i in inputs'range loop
			 reset <= inputs(i).reset;
			 clk <= inputs(i).clk;
			 wr <= inputs(i).wr;
			 ready_signal <=inputs(i).ready_signal;
			 wait for PERIOD/2;
			 assert wr_reg = inputs(i).wr_reg
			    report "Incorrect wr_reg" severity error;
			 assert dir = inputs(i).dir
			    report "Incorrect dir" severity error;

		end loop;
	      	assert false report "end of test" severity note;
	      	wait;
	end process;
end arq;