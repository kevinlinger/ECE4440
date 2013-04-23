--
-- VHDL Architecture lab3_lib.VarRegister.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVINLAPTOP)
--          at - 19:31:41 09/20/2012
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY VarRegister IS
  Generic(size : POSITIVE := 8);
  port(a : IN std_logic_vector(size-1 downto 0);
       b : out std_logic_vector(size-1 downto 0) := (others => '0');
       clk, en : in std_logic);
END ENTITY VarRegister;

--
ARCHITECTURE Behavior OF VarRegister IS
BEGIN
  process(clk)
  begin
    if(rising_edge(clk) AND (en='1')) then
      b <= a;
    end if;
  end process;
END ARCHITECTURE Behavior;

