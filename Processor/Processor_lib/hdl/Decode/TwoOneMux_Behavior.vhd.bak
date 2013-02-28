--
-- VHDL Architecture lab4_lib.TwoOneMux.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVINLAPTOP)
--          at - 23:32:01 09/27/2012
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY TwoOneMux IS
  Generic(size : POSITIVE := 16);
  port(a0, a1: in std_logic_vector(size-1 downto 0);
       c : in std_logic;
       z : out std_logic_vector(size-1 downto 0));
END ENTITY TwoOneMux;

--
ARCHITECTURE Behavior OF TwoOneMux IS
BEGIN
  process(a0, a1, c)
  begin
    if(c = '0') then
      z <= a0;
  else
    z <= a1;
    end if;
    end process;
END ARCHITECTURE Behavior;

