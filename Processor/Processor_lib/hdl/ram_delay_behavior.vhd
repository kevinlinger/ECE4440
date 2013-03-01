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
	  ack    : out	std_logic;                       -- acknowledge signal from memory
	  hAddr : in	std_logic_vector (15 DOWNTO 0);  -- memory address
	  hDOut : out	std_logic_vector (63 DOWNTO 0)   -- data from memory
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
		  table := (others => (others => '0'));
      --table(0) := To_stdlogicvector(X"97FF");   ---here you insert your program
--      table(1) := To_stdlogicvector(X"9A00");
--      table(2) := To_stdlogicvector(X"9900");
--      table(3) := To_stdlogicvector(X"87FF");
--      table(4) := To_stdlogicvector(X"8A01");
--      table(5) := To_stdlogicvector(X"8900");
--      table(6) := To_stdlogicvector(X"3877");
--      table(7) := To_stdlogicvector(X"7789");
--      table(8) := To_stdlogicvector(X"188A");
--      table(9) := To_stdlogicvector(X"3788");
--      table(10) := To_stdlogicvector(X"9600");

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



          elsif (wr = '1' and rd = '0') then
        table_index :=  CONV_INTEGER(hAddr(15 downto 0));
            table(table_index) := hDIn;
            hDOut <= table(table_index) after delay;
          elsif (rd = '1' and wr = '0') then
	       table_index :=  CONV_INTEGER(hAddr(15 downto 0));--	       
            hDOut(63 downto 48) <= table(table_index) after delay;
            hDOut(47 downto 32) <= table(table_index+1) after delay;
            hDOut(31 downto 16) <= table(table_index+2) after delay;
            hDOut(15 downto 0) <= table(table_index+3) after delay;
            ack <= '1';
	  end if;
  end process;
END ARCHITECTURE behavior;


