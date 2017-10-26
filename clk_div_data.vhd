library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_div_data is
	port(
          clk_in: in std_logic;
          rst: in std_logic;
          clk_out: out std_logic
	);
end clk_div_data;

architecture arq of clk_div_data is
--	constant max_count : natural := 100000000;
	constant max_count : natural := 10;
begin
	process(clk_in,rst)
		variable count : natural range 0 to max_count;
   begin
		if (rst = '1') then
            count := 0;
            clk_out    <= '1';
      elsif (clk_in = '1' and clk_in'event) then
  			if (count < (max_count/2)-1) then
				clk_out <= '1';
            count := count + 1;
         elsif (count < max_count-1) then
             clk_out <= '0';
             count := count + 1;
         else
				count := 0;
            clk_out <= '1';
         end if;
      end if;
  end process;
 end arq; 