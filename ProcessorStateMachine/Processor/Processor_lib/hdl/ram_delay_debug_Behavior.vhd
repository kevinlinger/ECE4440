--
-- VHDL Architecture Processor_lib.ram_delay_debug.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 22:13:52 04/22/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ram_delay_debug IS
    port( 
	  rst   : in	std_logic;                       -- active-high reset
	  hDIn  : in	std_logic_vector (15 DOWNTO 0);  -- data to memory
	  wr    : in	std_logic;                       -- memory write control signal
	  rd    : in	std_logic;                       -- memory read control signal
	  ack   : out	std_logic;                      -- acknowledge signal from memory
	  hAddr : in	std_logic_vector (15 DOWNTO 0);  -- memory address
	  hDOut : out	std_logic_vector (63 DOWNTO 0)  -- data from memory
  );
END ENTITY ram_delay_debug;

--
ARCHITECTURE Behavior OF ram_delay_debug IS
    subtype table_address is integer range 0 to 15;
BEGIN
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
----table(0) := To_stdlogicvector(X"0002");
----table(1) := To_stdlogicvector(X"0000");
----table(2) := To_stdlogicvector(X"9222");
----table(3) := To_stdlogicvector(X"9300");
----table(4) := To_stdlogicvector(X"2120");
----table(5) := To_stdlogicvector(X"9400");
----table(6) := To_stdlog
--

--short factorial
table(0) := To_stdlogicvector(X"0001");
table(1) := To_stdlogicvector(X"921E");
table(2) := To_stdlogicvector(X"2120");
table(3) := To_stdlogicvector(X"9400");
table(4) := To_stdlogicvector(X"9601");
table(5) := To_stdlogicvector(X"7E00");
table(6) := To_stdlogicvector(X"BF42");
table(7) := To_stdlogicvector(X"E304");
table(8) := To_stdlogicvector(X"6400");
table(9) := To_stdlogicvector(X"A545");
table(10) := To_stdlogicvector(X"E104");
table(11) := To_stdlogicvector(X"6160");
table(12) := To_stdlogicvector(X"A145");
table(13) := To_stdlogicvector(X"E110");
table(14) := To_stdlogicvector(X"A562");
table(15) := To_stdlogicvector(X"6200");
table(16) := To_stdlogicvector(X"A345");
table(17) := To_stdlogicvector(X"6640");
table(18) := To_stdlogicvector(X"A745");
table(19) := To_stdlogicvector(X"7E60");
table(20) := To_stdlogicvector(X"BF62");
table(21) := To_stdlogicvector(X"E308");
table(22) := To_stdlogicvector(X"E101");
table(23) := To_stdlogicvector(X"A020");
table(24) := To_stdlogicvector(X"A762");
table(25) := To_stdlogicvector(X"7E60");
table(26) := To_stdlogicvector(X"BF62");
table(27) := To_stdlogicvector(X"E3F3");
table(28) := To_stdlogicvector(X"E1FB");
table(29) := To_stdlogicvector(X"E100");
table(30) := To_stdlogicvector(X"0005");


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
END ARCHITECTURE Behavior;

