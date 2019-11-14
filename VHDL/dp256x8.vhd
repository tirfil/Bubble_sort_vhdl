--###############################
--# Project Name : 
--# File         : 
--# Project      : VHDL RAM model
--# Engineer     : 
--# Modification History
--###############################
-- VHDL model for altera

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


ENTITY dp256x8 IS
	PORT
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
END dp256x8;

architecture rtl of dp256x8 is
	type memory is array(0 to 255) of std_logic_vector(7 downto 0);
	shared variable mem : memory := 
	(
		
0=>x"01",
1=>x"33",
2=>x"6e",
3=>x"d1",
4=>x"8e",
5=>x"28",
6=>x"70",
7=>x"02",
8=>x"e3",
9=>x"1a",
10=>x"c2",
11=>x"2d",
12=>x"b3",
13=>x"22",
14=>x"ea",
15=>x"5f",
16=>x"64",
17=>x"e8",
18=>x"76",
19=>x"29",
20=>x"55",
21=>x"7b",
22=>x"00",
23=>x"89",
24=>x"2b",
25=>x"81",
26=>x"e1",
27=>x"86",
28=>x"65",
29=>x"99",
30=>x"1b",
31=>x"13",
32=>x"80",
33=>x"a1",
34=>x"ce",
35=>x"39",
36=>x"f2",
37=>x"56",
38=>x"27",
39=>x"2f",
40=>x"16",
41=>x"6f",
42=>x"f0",
43=>x"09",
44=>x"b8",
45=>x"5d",
46=>x"fd",
47=>x"4f",
48=>x"03",
49=>x"4c",
50=>x"e5",
51=>x"87",
52=>x"18",
53=>x"e9",
54=>x"f6",
55=>x"c5",
56=>x"bb",
57=>x"72",
58=>x"3b",
59=>x"a0",
60=>x"60",
61=>x"3c",
62=>x"8c",
63=>x"54",
64=>x"d3",
65=>x"9e",
66=>x"47",
67=>x"4a",
68=>x"ae",
69=>x"46",
70=>x"32",
71=>x"8b",
72=>x"e0",
73=>x"40",
74=>x"f3",
75=>x"67",
76=>x"24",
77=>x"b2",
78=>x"52",
79=>x"34",
80=>x"bf",
81=>x"82",
82=>x"19",
83=>x"ec",
84=>x"a6",
85=>x"ca",
86=>x"59",
87=>x"cd",
88=>x"7f",
89=>x"cb",
90=>x"aa",
91=>x"f7",
92=>x"44",
93=>x"37",
94=>x"e6",
95=>x"62",
96=>x"a7",
97=>x"83",
98=>x"c4",
99=>x"92",
100=>x"3d",
101=>x"8d",
102=>x"da",
103=>x"de",
104=>x"25",
105=>x"0a",
106=>x"a4",
107=>x"f9",
108=>x"c3",
109=>x"84",
110=>x"8f",
111=>x"73",
112=>x"9f",
113=>x"4d",
114=>x"e7",
115=>x"0b",
116=>x"b6",
117=>x"8a",
118=>x"51",
119=>x"5a",
120=>x"d2",
121=>x"41",
122=>x"d0",
123=>x"ff",
124=>x"38",
125=>x"ef",
126=>x"fc",
127=>x"6b",
128=>x"9b",
129=>x"50",
130=>x"c0",
131=>x"06",
132=>x"31",
133=>x"21",
134=>x"ee",
135=>x"bd",
136=>x"17",
137=>x"23",
138=>x"a3",
139=>x"15",
140=>x"7a",
141=>x"1c",
142=>x"5c",
143=>x"74",
144=>x"cc",
145=>x"d8",
146=>x"d9",
147=>x"12",
148=>x"2e",
149=>x"35",
150=>x"07",
151=>x"45",
152=>x"0e",
153=>x"85",
154=>x"cf",
155=>x"db",
156=>x"77",
157=>x"c9",
158=>x"af",
159=>x"6a",
160=>x"b1",
161=>x"5e",
162=>x"88",
163=>x"3a",
164=>x"96",
165=>x"9d",
166=>x"be",
167=>x"3e",
168=>x"a9",
169=>x"b0",
170=>x"0d",
171=>x"9a",
172=>x"63",
173=>x"ac",
174=>x"95",
175=>x"df",
176=>x"48",
177=>x"79",
178=>x"1f",
179=>x"2a",
180=>x"c7",
181=>x"7c",
182=>x"71",
183=>x"b5",
184=>x"d7",
185=>x"c8",
186=>x"36",
187=>x"1e",
188=>x"e4",
189=>x"ab",
190=>x"7e",
191=>x"d5",
192=>x"14",
193=>x"58",
194=>x"42",
195=>x"1d",
196=>x"3f",
197=>x"bc",
198=>x"b4",
199=>x"f4",
200=>x"f8",
201=>x"c6",
202=>x"91",
203=>x"a8",
204=>x"75",
205=>x"68",
206=>x"e2",
207=>x"eb",
208=>x"66",
209=>x"9c",
210=>x"78",
211=>x"dd",
212=>x"fe",
213=>x"a2",
214=>x"f1",
215=>x"ba",
216=>x"57",
217=>x"4e",
218=>x"fa",
219=>x"61",
220=>x"4b",
221=>x"b7",
222=>x"49",
223=>x"0c",
224=>x"dc",
225=>x"d6",
226=>x"5b",
227=>x"97",
228=>x"7d",
229=>x"a5",
230=>x"f5",
231=>x"05",
232=>x"fb",
233=>x"43",
234=>x"53",
235=>x"26",
236=>x"93",
237=>x"20",
238=>x"90",
239=>x"c1",
240=>x"2c",
241=>x"d4",
242=>x"6d",
243=>x"0f",
244=>x"b9",
245=>x"69",
246=>x"6c",
247=>x"11",
248=>x"94",
249=>x"ad",
250=>x"08",
251=>x"04",
252=>x"30",
253=>x"10",
254=>x"98",
255=>x"ed",


		others=>x"00"
	);
begin
	RAM_A : process(clock_a)
	begin
		if (clock_a'event and clock_a='1') then
				if (wren_a = '1') then
					mem(to_integer(unsigned(address_a))) := data_a;
					q_a <= data_a;  -- ????
				else
					q_a <= mem(to_integer(unsigned(address_a)));
				end if;
		end if;
	end process RAM_A;
	
	RAM_B : process(clock_b)
	begin
		if (clock_b'event and clock_b='1') then
				if (wren_b = '1') then
					mem(to_integer(unsigned(address_b))) := data_b;
					q_b <= data_b;  -- ????
				else
					q_b <= mem(to_integer(unsigned(address_b)));
				end if;
		end if;
	end process RAM_B;
end rtl;
