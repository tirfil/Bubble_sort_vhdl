--###############################
--# Project Name : 
--# File         : 
--# Author       : 
--# Description  : 
--# Modification History
--#
--###############################

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bsort is
	port(
		MCLK		: in	std_logic;
		nRST		: in	std_logic;
		RAMD		: out	std_logic_vector(7 downto 0);
		RAMWE		: out	std_logic;
		RAMQ		: in	std_logic_vector(7 downto 0);
		RAMA		: out	std_logic_vector(7 downto 0);
		ORDER		: in	std_logic;
		TOP			: in	std_logic_vector(7 downto 0);
		START		: in	std_logic;
		STOP		: out 	std_logic
	);
end bsort;

architecture rtl of bsort is
type state_t is (S_IDLE,S_R0, S_R1, S_R2, S_W0, S_W1, S_END);
signal state    : state_t;
signal cmp_i 	: std_logic;
signal cmp 		: std_logic;
signal det 		: std_logic;
signal nextaddr : std_logic_vector(7 downto 0);
signal q1		: std_logic_vector(7 downto 0);
signal a1		: std_logic_vector(7 downto 0);
signal a2		: std_logic_vector(7 downto 0);
signal a3		: std_logic_vector(7 downto 0);
signal rama_i   : std_logic_vector(7 downto 0);
signal last		: std_logic;
begin
	
	RAMA <= rama_i;
	
	last <= '1' when (TOP = rama_i) else '0';

	nextaddr <= (others=>'0') when (last = '1') else std_logic_vector(unsigned(rama_i) + 1);
	
	cmp_i <= '1' when (RAMQ < q1) else '0';
	cmp <= cmp_i xor ORDER;
	
	PSHIFT: process(MCLK, nRST)
	begin
		if (nRST = '0') then
			q1 <= (others=>'0');
			a1 <= (others=>'0');
			a2 <= (others=>'0');
			a3 <= (others=>'0');
			RAMD <= (others=>'0');
		elsif (MCLK'event and MCLK = '1') then
			q1 <= RAMQ;
			RAMD <= q1;
			a1 <= rama_i;
			a2 <= a1;
			a3 <= a2;
		end if;
	end process PSHIFT;
	
	POTO: process(MCLK, nRST)
	begin
		if (nRST = '0') then
			--RAMD <= (others=>'0');
			rama_i <= (others=>'1');
			RAMWE <= '0';
			--addr <= (others=>'0');
			det <= '0';
			state <= S_IDLE;
			STOP <= '0';
		elsif (MCLK'event and MCLK = '1') then
			if (state = S_IDLE) then
				rama_i <= (others=>'0');
				RAMWE <= '0';
				det <= '0';
				STOP <= '0';
				if (START = '1') then
					state <= S_R0;
				end if;
			elsif (state = S_R0) then
				RAMWE <= '0';
				if (last='1') then
					state <= S_END;
				else 
					rama_i <= nextaddr;
					state <= S_R1;
				end if;
			elsif (state = S_R1) then
				RAMWE <= '0';
				if (last='1') then
					state <= S_R2;
				else 
					rama_i <= nextaddr;
					state <= S_R2;
				end if;	
			elsif (state = S_R2) then
				if (cmp = '1') then
					state <= S_W0;
					rama_i <= a1;
					RAMWE <= '1';
					det <= '1';
				else
					RAMWE <= '0';
					if (last = '1') then
						state <= S_END;
					else
						rama_i <= nextaddr;
						state <= S_R2;
					end if;
				end if;
			elsif (state = S_W0) then	
				rama_i <= a3;
				RAMWE <= '1';
				state <= S_W1;
			elsif (state = S_W1) then
				rama_i <= a1;
				state <= S_R0;
				RAMWE <= '0';
			elsif (state = S_END) then
				if (det='0') then
					STOP <= '1';
					state <= S_IDLE;
				else
					det <= '0';
					rama_i <= (others=>'0');
					RAMWE <= '0';
					state <= S_R0;
				end if;
			else
				state <= S_IDLE;
			end if;
		end if;
	end process POTO;
end rtl;

