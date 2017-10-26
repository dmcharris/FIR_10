library ieee;
use ieee.std_logic_1164.all;
use work.FIR_package.all;

entity REG is
	port(
		data_in: in std_logic_vector(15 downto 0);
		clk, reset, wr: in std_logic;
		dir: in integer range 0 to 15;
		x_out, c_out: out std_logic_vector(15 downto 0)
		
	);
end REG;

architecture arq of REG is
	signal mem: Taps_array;
	constant coeffs: Coeffs_array := (x"F1CA",x"0D1C",x"118F",x"17AC",x"1CA7",x"1E8B",
												 x"1CA7",x"17AC",x"118F",x"0D1C",x"F1CA");
begin
	
	process (clk, reset, wr, dir, data_in)
	begin
		if (reset = '1') then
			for i in 0 to 10 loop
				mem(i) <= x"0000";
			end loop;
		elsif (clk = '1' and clk'event) then
			if (wr = '1') then
				for i in 10 downto 1 loop
					mem(i) <= mem(i-1);
				end loop;
				mem(0) <= data_in;
			else
				for i in 10 downto 0 loop
					mem(i) <= mem(i);
				end loop;

			end if;
			x_out <= mem(integer(dir));
			c_out <= coeffs(integer(dir));
		end if;
	end process;
	

end arq;