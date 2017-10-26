library IEEE;
use IEEE.STD_LOGIC_1164.all; 
entity sieteseg is
port (
		decimal: in std_logic_vector (31 downto 0);
		bcd0,bcd1,bcd2,bcd3,bcd4,bcd5,bcd6,bcd7: out std_logic_vector (6 downto 0)
		);
end sieteseg;

architecture arq of sieteseg is
signal part1,part2,part3,part4,part5,part6,part7,part8: std_logic_vector(3 downto 0);
component bcd27seg is
 port(
		number: in std_logic_vector (3 downto 0);
		bcd: out std_logic_vector (6 downto 0)
		);
end component;

begin
part1 <= decimal(31 downto 28);
part2 <= decimal(27 downto 24);
part3 <= decimal(23 downto 20);
part4 <= decimal(19 downto 16);
part5 <= decimal(15 downto 12);
part6 <= decimal(11 downto 8);
part7 <= decimal(7 downto 4);
part8 <= decimal(3 downto 0);
D0: bcd27seg port map(number => part1, bcd=>bcd7);
D1: bcd27seg port map(number => part2, bcd=>bcd6);
D2: bcd27seg port map(number => part3, bcd=>bcd5);
D3: bcd27seg port map(number => part4, bcd=>bcd4);
D4: bcd27seg port map(number => part5, bcd=>bcd3);
D5: bcd27seg port map(number => part6, bcd=>bcd2);
D6: bcd27seg port map(number => part7, bcd=>bcd1);
D7: bcd27seg port map(number => part8, bcd=>bcd0);
end arq;
