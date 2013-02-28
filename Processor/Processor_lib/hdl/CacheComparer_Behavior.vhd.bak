--
-- VHDL Architecture Processor_lib.CacheComparer.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 18:25:20 02/27/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY CacheComparer IS
    Generic(size : POSITIVE := 11);
    Port(InA, InB : in std_logic_vector(size-1 downto 0);
         match : out std_logic);
END ENTITY CacheComparer;

--
ARCHITECTURE Behavior OF CacheComparer IS
BEGIN
  Process(InA, InB)
  Begin
  if(InA = InB) then
    match <= '1';
  else
    match <= '0';
  end if;
  end process;
END ARCHITECTURE Behavior;

