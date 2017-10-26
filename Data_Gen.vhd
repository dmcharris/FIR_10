library ieee;
use ieee.std_logic_1164.all;

entity Data_Gen is
	port(
		clk,wr,reset: in std_logic;
		rd: out std_logic;
		data: out std_logic_vector(15 downto 0)
	);
end Data_Gen;

architecture arq of Data_Gen is
	type mem is array (natural range 0 to 15) of std_logic_vector(15 downto 0);
	constant rom: mem :=	(x"0001",x"0002",x"0003",x"0004",
								 x"0005",x"0006",x"0007",x"0008",
								 x"0009",x"000A",x"000B",x"000C",
								 x"000D",x"000E",x"000F",x"0010");
	signal counter: natural range 0 to 15;
begin
	data <= rom(counter);
	process(clk,reset)
	begin
		if (reset = '1') then
			counter <= 15;
			rd <= '0';
		elsif (clk'event and clk = '1') then
			if (wr = '1') then
				rd <= '1';
				if (counter = 15) then
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
			else
				rd <= '0';
			end if;
		end if;
	end process;
end arq;
