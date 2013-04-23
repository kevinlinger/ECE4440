--
-- VHDL Architecture my_project_lib.ram_delay.behavior
--
--
-- Created:
--          by - dm5jc.UNKNOWN (LENOVO)
--          at - 08:09:23 03/ 1/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;


ENTITY ram_delay IS
  port( 
	  rst   : in	std_logic;                       -- active-high reset
	  hDIn  : in	std_logic_vector (15 DOWNTO 0);  -- data to memory
	  wr    : in	std_logic;                       -- memory write control signal
	  rd    : in	std_logic;                       -- memory read control signal
	  ack   : out	std_logic;                      -- acknowledge signal from memory
	  hAddr : in	std_logic_vector (15 DOWNTO 0);  -- memory address
	  hDOut : out	std_logic_vector (63 DOWNTO 0)  -- data from memory
  );
END ENTITY ram_delay;

--
ARCHITECTURE behavior OF ram_delay IS
  subtype table_address is integer range 0 to 15;
begin
  process(hAddr,hDIn,wr,rd,rst)
	  type counter_array is array (0 to 65535) of std_logic_vector(15 downto 0);
	  variable table : counter_array;
	  variable table_index: integer;
    variable seed1, seed2: positive;               -- Seed values for random generator
    variable rand: real;                           -- Random real-number value in range 0 to 1.0
    variable delay: time;                           -- delay in main memory
  begin

    ack <= '0';
    UNIFORM(seed1, seed2, rand);
    delay := (rand*0.0000001)*10 sec;              -- random delay between 0 and 1000 ns
	  if (rst = '1') then
--	  table := (others => (others => '0'));


--Factorial with branches intending PC
table(0) := To_stdlogicvector(X"0002");
table(1) := To_stdlogicvector(X"0000");
table(2) := To_stdlogicvector(X"9222");
table(3) := To_stdlogicvector(X"9300");
table(4) := To_stdlogicvector(X"2120");
table(5) := To_stdlogicvector(X"9400");
table(6) := To_stdlogicvector(X"9500");
table(7) := To_stdlogicvector(X"9601");
table(8) := To_stdlogicvector(X"9700");
table(9) := To_stdlogicvector(X"7E00");
table(10) := To_stdlogicvector(X"BF42");
table(11) := To_stdlogicvector(X"E304");
table(12) := To_stdlogicvector(X"6400");
table(13) := To_stdlogicvector(X"A545");
table(14) := To_stdlogicvector(X"E104");
table(15) := To_stdlogicvector(X"6160");
table(16) := To_stdlogicvector(X"A145");
table(17) := To_stdlogicvector(X"E110");
table(18) := To_stdlogicvector(X"A562");
table(19) := To_stdlogicvector(X"6200");
table(20) := To_stdlogicvector(X"A345");
table(21) := To_stdlogicvector(X"6640");
table(22) := To_stdlogicvector(X"A745");
table(23) := To_stdlogicvector(X"7E60");
table(24) := To_stdlogicvector(X"BF62");
table(25) := To_stdlogicvector(X"E308");
table(26) := To_stdlogicvector(X"E101");
table(27) := To_stdlogicvector(X"A020");
table(28) := To_stdlogicvector(X"A762");
table(29) := To_stdlogicvector(X"7E60");
table(30) := To_stdlogicvector(X"BF62");
table(31) := To_stdlogicvector(X"E3F3");
table(32) := To_stdlogicvector(X"E1FB");
table(33) := To_stdlogicvector(X"E100");
table(34) := To_stdlogicvector(X"0005");

----Factorial with branches intending for PC +1
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

--table(0) := To_stdlogicvector(X"0002");
--table(1) := To_stdlogicvector(X"0000");
--table(2) := To_stdlogicvector(X"8401");
--table(3) := To_stdlogicvector(X"8500");
--table(4) := To_stdlogicvector(X"8237");
--table(5) := To_stdlogicvector(X"8300");
--table(6) := To_stdlogicvector(X"4420");
--table(7) := To_stdlogicvector(X"8239");
--table(8) := To_stdlogicvector(X"8300");
--table(9) := To_stdlogicvector(X"4420");
--table(10) := To_stdlogicvector(X"A442");
--table(11) := To_stdlogicvector(X"823A");
--table(12) := To_stdlogicvector(X"8300");
--table(13) := To_stdlogicvector(X"4420");
--table(14) := To_stdlogicvector(X"8238");
--table(15) := To_stdlogicvector(X"8300");
--table(16) := To_stdlogicvector(X"4420");
--table(17) := To_stdlogicvector(X"8216");
--table(18) := To_stdlogicvector(X"8300");
--table(19) := To_stdlogicvector(X"843B");
--table(20) := To_stdlogicvector(X"8500");
--table(21) := To_stdlogicvector(X"4240");
--table(22) := To_stdlogicvector(X"E114");
--table(23) := To_stdlogicvector(X"8438");
--table(24) := To_stdlogicvector(X"8500");
--table(25) := To_stdlogicvector(X"2640");
--table(26) := To_stdlogicvector(X"8237");
--table(27) := To_stdlogicvector(X"8300");
--table(28) := To_stdlogicvector(X"4620");
--table(29) := To_stdlogicvector(X"8839");
--table(30) := To_stdlogicvector(X"8900");
--table(31) := To_stdlogicvector(X"2280");
--table(32) := To_stdlogicvector(X"4240");
--table(33) := To_stdlogicvector(X"A260");
--table(34) := To_stdlogicvector(X"4280");
--table(35) := To_stdlogicvector(X"863A");
--table(36) := To_stdlogicvector(X"8700");
--table(37) := To_stdlogicvector(X"2260");
--table(38) := To_stdlogicvector(X"8401");
--table(39) := To_stdlogicvector(X"8500");
--table(40) := To_stdlogicvector(X"A240");
--table(41) := To_stdlogicvector(X"4260");
--table(42) := To_stdlogicvector(X"823B");
--table(43) := To_stdlogicvector(X"8300");
--table(44) := To_stdlogicvector(X"2420");
--table(45) := To_stdlogicvector(X"823A");
--table(46) := To_stdlogicvector(X"8300");
--table(47) := To_stdlogicvector(X"2620");
--table(48) := To_stdlogicvector(X"7E60");
--table(49) := To_stdlogicvector(X"BE42");
--table(50) := To_stdlogicvector(X"E5E5");
--table(51) := To_stdlogicvector(X"8239");
--table(52) := To_stdlogicvector(X"8300");
--table(53) := To_stdlogicvector(X"2020");
--table(54) := To_stdlogicvector(X"E100");
--table(55) := To_stdlogicvector(X"0000");
--table(56) := To_stdlogicvector(X"0000");
--table(57) := To_stdlogicvector(X"0000");
--table(58) := To_stdlogicvector(X"0000");
--table(59) := To_stdlogicvector(X"0000");


--table(0) := To_stdlogicvector(X"0002");
--table(1) := To_stdlogicvector(X"0000");
--table(2) := To_stdlogicvector(X"8003");
--table(3) := To_stdlogicvector(X"9E31");
--table(4) := To_stdlogicvector(X"9F00");
--table(5) := To_stdlogicvector(X"41E0");
--table(6) := To_stdlogicvector(X"A002");
--table(7) := To_stdlogicvector(X"21E0");
--table(8) := To_stdlogicvector(X"8204");
--table(9) := To_stdlogicvector(X"9C34");
--table(10) := To_stdlogicvector(X"9D00");
--table(11) := To_stdlogicvector(X"0000");
--table(12) := To_stdlogicvector(X"0000");
--table(13) := To_stdlogicvector(X"43C0");
--table(14) := To_stdlogicvector(X"A222");
--table(15) := To_stdlogicvector(X"23C0");
--table(16) := To_stdlogicvector(X"0000");
--table(17) := To_stdlogicvector(X"0000");
--table(18) := To_stdlogicvector(X"8407");
--table(19) := To_stdlogicvector(X"9C34");
--table(20) := To_stdlogicvector(X"9D00");
--table(21) := To_stdlogicvector(X"0000");
--table(22) := To_stdlogicvector(X"45C0");
--table(23) := To_stdlogicvector(X"A442");
--table(24) := To_stdlogicvector(X"25C0");
--table(25) := To_stdlogicvector(X"0000");
--table(26) := To_stdlogicvector(X"8608");
--table(27) := To_stdlogicvector(X"9C34");
--table(28) := To_stdlogicvector(X"9D00");
--table(29) := To_stdlogicvector(X"0000");
--table(30) := To_stdlogicvector(X"0000");
--table(31) := To_stdlogicvector(X"47C0");
--table(32) := To_stdlogicvector(X"A662");
--table(33) := To_stdlogicvector(X"27C0");
--table(34) := To_stdlogicvector(X"8809");
--table(35) := To_stdlogicvector(X"9C34");
--table(36) := To_stdlogicvector(X"9D00");
--table(37) := To_stdlogicvector(X"0000");
--table(38) := To_stdlogicvector(X"0000");
--table(39) := To_stdlogicvector(X"0000");
--table(40) := To_stdlogicvector(X"49C0");
--table(41) := To_stdlogicvector(X"A882");
--table(42) := To_stdlogicvector(X"29C0");
--
----table(22) := To_stdlogicvector(X"0000");
----table(23) := To_stdlogicvector(X"0000");
----table(24) := To_stdlogicvector(X"0000");
----table(25) := To_stdlogicvector(X"0000");
----table(26) := To_stdlogicvector(X"0000");
----table(27) := To_stdlogicvector(X"0000");
----table(28) := To_stdlogicvector(X"0000");
----table(29) := To_stdlogicvector(X"0000");
----table(30) := To_stdlogicvector(X"0000");
----table(31) := To_stdlogicvector(X"0000");
----table(32) := To_stdlogicvector(X"0000");
----table(33) := To_stdlogicvector(X"0000");
----table(34) := To_stdlogicvector(X"0000");
----table(35) := To_stdlogicvector(X"0000");
----table(36) := To_stdlogicvector(X"0000");
----table(37) := To_stdlogicvector(X"0000");
----table(38) := To_stdlogicvector(X"0000");
----table(39) := To_stdlogicvector(X"0000");
----table(40) := To_stdlogicvector(X"0000");
----table(41) := To_stdlogicvector(X"0000");
----table(42) := To_stdlogicvector(X"0000");
--
--table(43) := To_stdlogicvector(X"0000");
--table(44) := To_stdlogicvector(X"8C00");
--table(45) := To_stdlogicvector(X"9A36");
--table(46) := To_stdlogicvector(X"9B00");
--table(47) := To_stdlogicvector(X"2DA0");
--table(48) := To_stdlogicvector(X"E100");
--table(49) := To_stdlogicvector(X"0005");
--table(50) := To_stdlogicvector(X"00FF");
--table(51) := To_stdlogicvector(X"0023");
--table(52) := To_stdlogicvector(X"0011");
--table(53) := To_stdlogicvector(X"00EE");
--table(54) := To_stdlogicvector(X"F0F7");
--table(55) := To_stdlogicvector(X"00BB");
--table(56) := To_stdlogicvector(X"00FF");
--table(57) := To_stdlogicvector(X"0023");
--table(58) := To_stdlogicvector(X"0011");
--table(59) := To_stdlogicvector(X"00EE");
--table(60) := To_stdlogicvector(X"F0F7");
--table(61) := To_stdlogicvector(X"00BB");
--table(62) := To_stdlogicvector(X"F0F7");
--table(63) := To_stdlogicvector(X"00BB");





          elsif (wr = '1' and rd = '0') then
        table_index :=  CONV_INTEGER(hAddr(15 downto 0));
            table(table_index) := hDIn;
			hDOut(63 downto 48) <= table(table_index) after delay;
            hDOut(47 downto 32) <= table(table_index+1) after delay;
            hDOut(31 downto 16) <= table(table_index+2) after delay;
            hDOut(15 downto 0)  <= table(table_index+3) after delay;
            ack <= '0', '1' after delay;
          elsif (rd = '1' and wr = '0') then
	       table_index :=  CONV_INTEGER(hAddr(15 downto 0));--
			hDOut(63 downto 48) <= table(table_index) after delay;
            hDOut(47 downto 32) <= table(table_index+1) after delay;
            hDOut(31 downto 16) <= table(table_index+2) after delay;
            hDOut(15 downto 0) <= table(table_index+3) after delay;
            ack <= '0', '1' after delay;
	  end if;
  end process;
END ARCHITECTURE behavior;


