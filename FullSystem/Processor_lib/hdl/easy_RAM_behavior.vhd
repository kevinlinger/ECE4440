--
-- VHDL Simple RAM
-- Mircea Stan
--
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY easy_RAM_simu IS
  port( 
	  rst   : in	std_logic;                       -- active-high reset
	  hDIn  : in	std_logic_vector (15 DOWNTO 0);  -- data to memory
	  wr    : in	std_logic;                       -- memory write control signal
	  hAddr : in	std_logic_vector (15 DOWNTO 0);  -- memory address
	  hDOut : out	std_logic_vector (15 DOWNTO 0)   -- data from memory
  );
END ENTITY easy_RAM_simu;

--
ARCHITECTURE behavior OF easy_RAM_simu IS
  subtype table_address is integer range 0 to 15;
begin
  process(hAddr,hDIn,wr,rst)
	  type counter_array is array (0 to 65535) of std_logic_vector(15 downto 0);
	  variable table : counter_array;
	  variable table_index: integer;
  begin
	  if (rst = '1') then
	    
--Fibonacci Benchmark
table(0) := To_stdlogicvector(X"0002");
table(1) := To_stdlogicvector(X"0000");
table(2) := To_stdlogicvector(X"8401");
table(3) := To_stdlogicvector(X"8500");
table(4) := To_stdlogicvector(X"8237");
table(5) := To_stdlogicvector(X"8300");
table(6) := To_stdlogicvector(X"4420");
table(7) := To_stdlogicvector(X"8239");
table(8) := To_stdlogicvector(X"8300");
table(9) := To_stdlogicvector(X"4420");
table(10) := To_stdlogicvector(X"A442");
table(11) := To_stdlogicvector(X"823A");
table(12) := To_stdlogicvector(X"8300");
table(13) := To_stdlogicvector(X"4420");
table(14) := To_stdlogicvector(X"8238");
table(15) := To_stdlogicvector(X"8300");
table(16) := To_stdlogicvector(X"4420");
table(17) := To_stdlogicvector(X"8216");
table(18) := To_stdlogicvector(X"8300");
table(19) := To_stdlogicvector(X"843B");
table(20) := To_stdlogicvector(X"8500");
table(21) := To_stdlogicvector(X"4240");
table(22) := To_stdlogicvector(X"E113");
table(23) := To_stdlogicvector(X"8438");
table(24) := To_stdlogicvector(X"8500");
table(25) := To_stdlogicvector(X"2640");
table(26) := To_stdlogicvector(X"8237");
table(27) := To_stdlogicvector(X"8300");
table(28) := To_stdlogicvector(X"4620");
table(29) := To_stdlogicvector(X"8839");
table(30) := To_stdlogicvector(X"8900");
table(31) := To_stdlogicvector(X"2280");
table(32) := To_stdlogicvector(X"4240");
table(33) := To_stdlogicvector(X"A260");
table(34) := To_stdlogicvector(X"4280");
table(35) := To_stdlogicvector(X"863A");
table(36) := To_stdlogicvector(X"8700");
table(37) := To_stdlogicvector(X"2260");
table(38) := To_stdlogicvector(X"8401");
table(39) := To_stdlogicvector(X"8500");
table(40) := To_stdlogicvector(X"A240");
table(41) := To_stdlogicvector(X"4260");
table(42) := To_stdlogicvector(X"823B");
table(43) := To_stdlogicvector(X"8300");
table(44) := To_stdlogicvector(X"2420");
table(45) := To_stdlogicvector(X"823A");
table(46) := To_stdlogicvector(X"8300");
table(47) := To_stdlogicvector(X"2620");
table(48) := To_stdlogicvector(X"7E60");
table(49) := To_stdlogicvector(X"BE42");
table(50) := To_stdlogicvector(X"E5E4");
table(51) := To_stdlogicvector(X"8239");
table(52) := To_stdlogicvector(X"8300");
table(53) := To_stdlogicvector(X"2020");
table(54) := To_stdlogicvector(X"E1FF");
table(55) := To_stdlogicvector(X"0000");
table(56) := To_stdlogicvector(X"0000");
table(57) := To_stdlogicvector(X"0000");
table(58) := To_stdlogicvector(X"0000");
table(59) := To_stdlogicvector(X"0000");



--Kevin's Benchmark
--table(0) := To_stdlogicvector(X"0002");
--table(1) := To_stdlogicvector(X"0000");
----table(2) := To_stdlogicvector(X"0000");
--
--table(2) := To_stdlogicvector(X"E101");
--table(3) := To_stdlogicvector(X"E13E");
--table(4) := To_stdlogicvector(X"8000");
--table(5) := To_stdlogicvector(X"8180");
--table(6) := To_stdlogicvector(X"6200");
--table(7) := To_stdlogicvector(X"A200");
--table(8) := To_stdlogicvector(X"E901");
--table(9) := To_stdlogicvector(X"E138");
--table(10) := To_stdlogicvector(X"6200");
--table(11) := To_stdlogicvector(X"A202");
--table(12) := To_stdlogicvector(X"E301");
--table(13) := To_stdlogicvector(X"E134");
--table(14) := To_stdlogicvector(X"84FF");
--table(15) := To_stdlogicvector(X"8601");
--table(16) := To_stdlogicvector(X"A640");
--table(17) := To_stdlogicvector(X"F101");
--table(18) := To_stdlogicvector(X"E12F");
--table(19) := To_stdlogicvector(X"8800");
--table(20) := To_stdlogicvector(X"8AFF");
--table(21) := To_stdlogicvector(X"A8A0");
--table(22) := To_stdlogicvector(X"E501");
--table(23) := To_stdlogicvector(X"E12A");
--table(24) := To_stdlogicvector(X"84FF");
--table(25) := To_stdlogicvector(X"8601");
--table(26) := To_stdlogicvector(X"8802");
--table(27) := To_stdlogicvector(X"8A00");
--table(28) := To_stdlogicvector(X"A460");
--table(29) := To_stdlogicvector(X"AA61");
--table(30) := To_stdlogicvector(X"AA82");
--table(31) := To_stdlogicvector(X"E301");
--table(32) := To_stdlogicvector(X"E121");
--table(33) := To_stdlogicvector(X"8000");
--table(34) := To_stdlogicvector(X"8201");
--table(35) := To_stdlogicvector(X"A200");
--table(36) := To_stdlogicvector(X"A203");
--table(37) := To_stdlogicvector(X"E301");
--table(38) := To_stdlogicvector(X"E11B");
--table(39) := To_stdlogicvector(X"800A");
--table(40) := To_stdlogicvector(X"8214");
--table(41) := To_stdlogicvector(X"9207");
--table(42) := To_stdlogicvector(X"B322");
--table(43) := To_stdlogicvector(X"D000");
--table(44) := To_stdlogicvector(X"E301");
--table(45) := To_stdlogicvector(X"E114");
--table(46) := To_stdlogicvector(X"A302");
--table(47) := To_stdlogicvector(X"E301");
--table(48) := To_stdlogicvector(X"E111");
--table(49) := To_stdlogicvector(X"80FF");
--table(50) := To_stdlogicvector(X"82FF");
--table(51) := To_stdlogicvector(X"837F");
--table(52) := To_stdlogicvector(X"CE01");
--table(53) := To_stdlogicvector(X"AE22");
--table(54) := To_stdlogicvector(X"E301");
--table(55) := To_stdlogicvector(X"E10A");
--table(56) := To_stdlogicvector(X"80FF");
--table(57) := To_stdlogicvector(X"81EF");
--table(58) := To_stdlogicvector(X"82FF");
--table(59) := To_stdlogicvector(X"83F7");
--table(60) := To_stdlogicvector(X"CC02");
--table(61) := To_stdlogicvector(X"AC22");
--table(62) := To_stdlogicvector(X"E301");
--table(63) := To_stdlogicvector(X"E102");
--table(64) := To_stdlogicvector(X"9AFF");
--table(65) := To_stdlogicvector(X"E1FF");
--table(66) := To_stdlogicvector(X"9CFF");
--table(67) := To_stdlogicvector(X"E1FF");


----Memory Benchmark
--table(0) := To_stdlogicvector(X"821F");
--table(1) := To_stdlogicvector(X"8300");
--table(2) := To_stdlogicvector(X"8422");
--table(3) := To_stdlogicvector(X"8500");
--table(4) := To_stdlogicvector(X"6620");
--table(5) := To_stdlogicvector(X"8000");
--table(6) := To_stdlogicvector(X"8A01");
--table(7) := To_stdlogicvector(X"2860");
--table(8) := To_stdlogicvector(X"A8A0");
--table(9) := To_stdlogicvector(X"4860");
--table(10) := To_stdlogicvector(X"7E60");
--table(11) := To_stdlogicvector(X"BE42");
--table(12) := To_stdlogicvector(X"E302");
--table(13) := To_stdlogicvector(X"A6A0");
--table(14) := To_stdlogicvector(X"E1F8");
--table(15) := To_stdlogicvector(X"2860");
--table(16) := To_stdlogicvector(X"A8A2");
--table(17) := To_stdlogicvector(X"4860");
--table(18) := To_stdlogicvector(X"7E60");
--table(19) := To_stdlogicvector(X"BE22");
--table(20) := To_stdlogicvector(X"E302");
--table(21) := To_stdlogicvector(X"A6A2");
--table(22) := To_stdlogicvector(X"E1F8");
--table(23) := To_stdlogicvector(X"2860");
--table(24) := To_stdlogicvector(X"A080");
--table(25) := To_stdlogicvector(X"7E60");
--table(26) := To_stdlogicvector(X"BE42");
--table(27) := To_stdlogicvector(X"E302");
--table(28) := To_stdlogicvector(X"A6A0");
--table(29) := To_stdlogicvector(X"E1F9");
--table(30) := To_stdlogicvector(X"E1FF");
--table(31) := To_stdlogicvector(X"0003");
--table(32) := To_stdlogicvector(X"000A");
--table(33) := To_stdlogicvector(X"000C");
--table(34) := To_stdlogicvector(X"0012");
--

--Factorial Benchmark
--table(0) := To_stdlogicvector(X"0002");
--table(1) := To_stdlogicvector(X"0000");
--table(2) := To_stdlogicvector(X"9222");
--table(3) := To_stdlogicvector(X"9300");
--table(4) := To_stdlogicvector(X"2120");
--table(5) := To_stdlogicvector(X"9400");
--table(6) := To_stdlogicvector(X"9500");
--table(7) := To_stdlogicvector(X"9601");
--table(8) := To_stdlogicvector(X"9700");
--table(9) := To_stdlogicvector(X"7E00");
--table(10) := To_stdlogicvector(X"BF42");
--table(11) := To_stdlogicvector(X"E303");
--table(12) := To_stdlogicvector(X"6400");
--table(13) := To_stdlogicvector(X"A545");
--table(14) := To_stdlogicvector(X"E103");
--table(15) := To_stdlogicvector(X"6160");
--table(16) := To_stdlogicvector(X"A145");
--table(17) := To_stdlogicvector(X"E10F");
--table(18) := To_stdlogicvector(X"A562");
--table(19) := To_stdlogicvector(X"6200");
--table(20) := To_stdlogicvector(X"A345");
--table(21) := To_stdlogicvector(X"6640");
--table(22) := To_stdlogicvector(X"A745");
--table(23) := To_stdlogicvector(X"7E60");
--table(24) := To_stdlogicvector(X"BF62");
--table(25) := To_stdlogicvector(X"E307");
--table(26) := To_stdlogicvector(X"E100");
--table(27) := To_stdlogicvector(X"A020");
--table(28) := To_stdlogicvector(X"A762");
--table(29) := To_stdlogicvector(X"7E60");
--table(30) := To_stdlogicvector(X"BF62");
--table(31) := To_stdlogicvector(X"E3F2");
--table(32) := To_stdlogicvector(X"E1FA");
--table(33) := To_stdlogicvector(X"E1FF");
--table(34) := To_stdlogicvector(X"0005");


          elsif (wr = '1') then
	      table_index :=  CONV_INTEGER(hAddr(15 downto 0));
            table(table_index) := hDIn;
            hDOut <= table(table_index);
          else
	      table_index :=  CONV_INTEGER(hAddr(15 downto 0));
            hDOut <= table(table_index);
	  end if;
  end process;
END ARCHITECTURE behavior;

