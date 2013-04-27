--
-- VHDL Architecture lab3_lib.FlipFlop.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVINLAPTOP)
--          at - 12:31:57 09/21/2012
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY FlipFlop IS
    port(a : IN std_logic;
       b : out std_logic := '0';
       clk, en : in std_logic);
END ENTITY FlipFlop;

--
ARCHITECTURE Behavior OF FlipFlop IS
BEGIN
    process(clk)
  begin
    if(rising_edge(clk) AND (en='1')) then
      b <= a;
    end if;
  end process;
END ARCHITECTURE Behavior;

