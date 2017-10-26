library IEEE;
use IEEE.STD_LOGIC_1164.all; 
entity bcd27seg is
port (
		number: in std_logic_vector (3 downto 0);
		bcd: out std_logic_vector (6 downto 0)
		);
end bcd27seg;

architecture arq of bcd27seg is
begin
    process(number)
    begin
        case number is
            when "0000" => bcd <= "1000000";
            when "0001" => bcd <= "1111001";
            when "0010" => bcd <= "0100100";
            when "0011" => bcd <= "0110000";
            when "0100" => bcd <= "0011001";
            when "0101" => bcd <= "0010010";
            when "0110" => bcd <= "0000010";
            when "0111" => bcd <= "1111000";
            when "1000" => bcd <= "0000000";
            when "1001" => bcd <= "0011000";
            when "1010" => bcd <= "0001000";
            when "1011" => bcd <= "0000011";
            when "1100" => bcd <= "1000110";
            when "1101" => bcd <= "0100001";
            when "1110" => bcd <= "0000110";
            when "1111" => bcd <= "0001110";
        end case;
    end process;
end arq;