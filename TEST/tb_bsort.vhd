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
library RAM_LIB;
use RAM_LIB.all;

entity tb_bsort is
end tb_bsort;

architecture stimulus of tb_bsort is

-- COMPONENTS --
	component bsort
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			RAMD		: out	std_logic_vector(7 downto 0);
			RAMWE		: out	std_logic;
			RAMQ		: in	std_logic_vector(7 downto 0);
			RAMA		: out	std_logic_vector(7 downto 0);
			ORDER		: in	std_logic;
			TOP		: in	std_logic_vector(7 downto 0);
			START		: in	std_logic;
			STOP		: out	std_logic
		);
	end component;
	component dp256x8 
	port
	(
		address_a	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		address_b	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock_a		: IN STD_LOGIC  := '1';
		clock_b		: IN STD_LOGIC 	:= '1';
		data_a		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data_b		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren_a		: IN STD_LOGIC  := '0';
		wren_b		: IN STD_LOGIC  := '0';
		q_a			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		q_b			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	end component;

--
-- SIGNALS --
	signal MCLK		: std_logic;
	signal nRST		: std_logic;
	signal RAMD		: std_logic_vector(7 downto 0);
	signal RAMWE		: std_logic;
	signal RAMQ		: std_logic_vector(7 downto 0);
	signal RAMA		: std_logic_vector(7 downto 0);
	signal ORDER		: std_logic;
	signal TOP		: std_logic_vector(7 downto 0);
	signal START		: std_logic;
	signal STOP		: std_logic;
	
	
	signal LOGIC_0	: std_logic;
	signal BYTE_0	: std_logic_vector(7 downto 0);

--
	signal RUNNING	: std_logic := '1';

begin

	LOGIC_0 <= '0';
	BYTE_0 <= (others=>'0');
	ORDER <= '1';
	TOP <= x"FF";
	

-- PORT MAP --
	I_bsort_0 : bsort
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			RAMD		=> RAMD,
			RAMWE		=> RAMWE,
			RAMQ		=> RAMQ,
			RAMA		=> RAMA,
			ORDER		=> ORDER,
			TOP		=> TOP,
			START		=> START,
			STOP		=> STOP
		);

	I_ram : dp256x8
		port map (
			address_a	=> RAMA,
			address_b	=> BYTE_0,
			clock_a		=> MCLK,
			clock_b		=> MCLK,
			data_a		=> RAMD,
			data_b		=> BYTE_0,
			wren_a		=> RAMWE,
			wren_b		=> LOGIC_0,
			q_a			=> RAMQ,
			q_b			=> open
		);
--
	CLOCK: process
	begin
		while (RUNNING = '1') loop
			MCLK <= '1';
			wait for 10 ns;
			MCLK <= '0';
			wait for 10 ns;
		end loop;
		wait;
	end process CLOCK;

	GO: process
	begin
		START <= '0';
		nRST <= '0';
		wait for 1001 ns;
		nRST <= '1';
		wait for 100 ns;
		START <= '1';
		wait for 20 ns;
		START <= '0';
		wait until STOP='1';
		RUNNING <= '0';
		wait;
	end process GO;

end stimulus;
