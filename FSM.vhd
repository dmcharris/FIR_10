--FSM code

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM is
	port 
	(
		reset, clk, wr								: in std_logic;
		wr_reg,ready_signal						: out std_logic;
		dir											: out integer range 0 to 15;
		mac_out										: in std_logic_Vector(31 downto 0);
		data_out										: out std_logic_Vector(31 downto 0)
	);
	
end FSM;

architecture arq of FSM is
	type states is (A,B,C,D,E,F,G,H,I,J,K,L,M,N);
	signal state, nxt_state: states;
begin
	process(clk,reset)
	begin
		if (clk'event and clk='1') then
			if (reset='1') then
				state <= A;
			else
				state <= nxt_state;			
			end if;
		end if;
	end process;

	process(state,mac_out)
	begin
		case state is
			when A => 
						 wr_reg <= '0';
						 dir <= 0;
						 ready_signal <= '0';	
			when B => 
						 wr_reg <= '1';
						 dir <= 0;
						 ready_signal <= '0';
			when C => 
						 wr_reg <= '0';
						 dir <= 0;
						 ready_signal <= '0';
			when D => 	
						 wr_reg <= '0';
						 dir <= 1;
						 ready_signal <= '0';
			when E => 
						 wr_reg <= '0';
						 dir <= 2;
						 ready_signal <= '0';
			when F => 
						 wr_reg <= '0';
						 dir <= 3;
						 ready_signal <= '0';
			when G => 
						 wr_reg <= '0';
						 dir <= 4;
						 ready_signal <= '0';
			when H => 
						 wr_reg <= '0';
						 dir <= 5;
						 ready_signal <= '0';
			when I => 
						 wr_reg <= '0';
						 dir <= 6;
						 ready_signal <= '0';
			when J => 
						 wr_reg <= '0';
						 dir <= 7;
						 ready_signal <= '0';
			when K => 
						 wr_reg <= '0';
						 dir <= 8;
						 ready_signal <= '0';
			when L => 
						 wr_reg <= '0';
						 dir <= 9;
						 ready_signal <= '0';
			when M => 
						 wr_reg <= '0';
						 --dir <= 0;
						 dir <= 10;
						 --ready_signal <= '1';
						 ready_signal <= '0';
						 --data_out <= mac_out;
			when N => 
						 wr_reg <= '0';
						 dir <= 0;
						 --ready_signal <= '0';
						 ready_signal <= '1';
						 data_out <= mac_out;
			end case;
	end process;

	process(state,wr,reset)
	begin
		if (reset='1') then
			nxt_state <= A;
		else
			case state is
				when A =>	
					if(wr = '1') then
						nxt_state <= B;
					else
						nxt_state <= state;
					end if;
				when B =>
					if(wr = '1') then
						nxt_state <= C;
					else
						nxt_state <= state;
					end if;
				when C =>
					if(wr = '1') then
						nxt_state <= D;
					else
						nxt_state <= state;
					end if;
				when D =>
					if(wr = '1') then
						nxt_state <= E;
					else
						nxt_state <= state;
					end if;
				when E =>
					if(wr = '1') then
						nxt_state <= F;
					else
						nxt_state <= state;
					end if;
				when F =>
					if(wr = '1') then
						nxt_state <= G;
					else
						nxt_state <= state;
					end if;					
				when G =>
					if(wr = '1') then
						nxt_state <= H;
					else
						nxt_state <= state;
					end if;
				when H =>
					if(wr = '1') then
						nxt_state <= I;
					else
						nxt_state <= state;
					end if;
				when I =>
					if(wr = '1') then
						nxt_state <= J;
					else
						nxt_state <= state;
					end if;
				when J =>
					if(wr = '1') then
						nxt_state <= K;
					else
						nxt_state <= state;
					end if;
				when K =>
					if(wr = '1') then
						nxt_state <= L;
					else
						nxt_state <= state;
					end if;
				when L =>
					if(wr = '1') then
						nxt_state <= M;
					else
						nxt_state <= state;
					end if;
				when M =>
					if(wr = '1') then
						nxt_state <= N;
					else
						nxt_state <= state;
					end if;
				when N =>
					if(wr = '1') then
						nxt_state <= A;
					else
						nxt_state <= state;
					end if;				
				when others =>
						nxt_state <= A;
				end case;
			end if;
	end process;
	
end arq;
