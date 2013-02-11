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
		  table := (others => (others => '0'));
table(0) := To_stdlogicvector(X"97FF");   ---here you insert your program
table(1) := To_stdlogicvector(X"9A00");
table(2) := To_stdlogicvector(X"9900");
table(3) := To_stdlogicvector(X"87FF");
table(4) := To_stdlogicvector(X"8A01");
table(5) := To_stdlogicvector(X"8900");
table(6) := To_stdlogicvector(X"3877");
table(7) := To_stdlogicvector(X"7789");
table(8) := To_stdlogicvector(X"188A");
table(9) := To_stdlogicvector(X"3788");
table(10) := To_stdlogicvector(X"9600");
table(11) := To_stdlogicvector(X"8603");
table(12) := To_stdlogicvector(X"1886");
table(13) := To_stdlogicvector(X"3099");
table(14) := To_stdlogicvector(X"31AA");
table(15) := To_stdlogicvector(X"9200");
table(16) := To_stdlogicvector(X"8205");
table(17) := To_stdlogicvector(X"3399");
table(18) := To_stdlogicvector(X"A021");
table(19) := To_stdlogicvector(X"B802");
table(20) := To_stdlogicvector(X"B601");
table(21) := To_stdlogicvector(X"033A");
table(22) := To_stdlogicvector(X"A093");
table(23) := To_stdlogicvector(X"B705");
table(24) := To_stdlogicvector(X"B915");
table(25) := To_stdlogicvector(X"32AA");
table(26) := To_stdlogicvector(X"0312");
table(27) := To_stdlogicvector(X"3133");
table(28) := To_stdlogicvector(X"B9F2");
table(29) := To_stdlogicvector(X"32AA");
table(30) := To_stdlogicvector(X"3399");
table(31) := To_stdlogicvector(X"A012");
table(32) := To_stdlogicvector(X"B802");
table(33) := To_stdlogicvector(X"B601");
table(34) := To_stdlogicvector(X"033A");
table(35) := To_stdlogicvector(X"A093");
table(36) := To_stdlogicvector(X"B705");
table(37) := To_stdlogicvector(X"B9F3");
table(38) := To_stdlogicvector(X"33AA");
table(39) := To_stdlogicvector(X"0423");
table(40) := To_stdlogicvector(X"3244");
table(41) := To_stdlogicvector(X"B9F4");
table(42) := To_stdlogicvector(X"0302");
table(43) := To_stdlogicvector(X"3033");
table(44) := To_stdlogicvector(X"B9F9");
table(45) := To_stdlogicvector(X"B9EB");
table(46) := To_stdlogicvector(X"3B00");
table(47) := To_stdlogicvector(X"3877");
table(48) := To_stdlogicvector(X"088A");
table(49) := To_stdlogicvector(X"7786");
table(50) := To_stdlogicvector(X"B909");
table(51) := To_stdlogicvector(X"088A");
table(52) := To_stdlogicvector(X"3877");
table(53) := To_stdlogicvector(X"088A");
table(54) := To_stdlogicvector(X"7786");
table(55) := To_stdlogicvector(X"B904");
table(56) := To_stdlogicvector(X"088A");
table(57) := To_stdlogicvector(X"9600");
table(58) := To_stdlogicvector(X"8603");
table(59) := To_stdlogicvector(X"0886");
table(60) := To_stdlogicvector(X"30BB");
table(61) := To_stdlogicvector(X"B9FF");

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

