--MAC code

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MAC is
	port 
	(
		X, coeff										: in std_logic_vector(15 downto 0);
		reset,wr_mac, clk_mac					: in std_logic;
		output										: out std_logic_vector (31 downto 0)
	);
	
end MAC;

architecture arq of MAC is
	signal out_internal : signed(31 downto 0);
begin
	output <= std_logic_vector(out_internal);
	process (reset, x, coeff, wr_mac, clk_mac)
	begin
	if (reset='0') then
		if (clk_mac'event AND clk_mac='1') then
			if (wr_mac='1') then
				out_internal <= out_internal + (signed(x)*signed(coeff));
			end if;
		end if;
	else
		out_internal <= (others => '0');
	end if;
	end process;
	
end arq;
