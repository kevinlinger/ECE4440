--
-- VHDL Architecture lab4_lib.FourOneMux.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVINLAPTOP)
--          at - 23:37:31 09/27/2012
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY FourOneMux IS
  Generic(size: POSITIVE := 16);
  port(a0, a1, a2, a3 : in std_logic_vector(size-1 downto 0);
        c : in std_logic_vector( 1 downto 0);
        z : out std_logic_vector(size-1 downto 0));
END ENTITY FourOneMux;

--
ARCHITECTURE Behavior OF FourOneMux IS
BEGIN
  process(a0, a1, a2, a3, c)
  begin
    if(c = "00") then
      z <= a0;
    elsif(c = "01") then
      z <=a1;
    elsif(c = "10") then
      z <= a2;
    else
      z <= a3;
    end if;
  end process;
END ARCHITECTURE Behavior;

