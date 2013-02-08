--
-- VHDL Architecture Advanced_Digital_Design_lib.x_bit_Register.Behavioral
--
-- Created:
--          by - mew2ub.UNKNOWN (BCFRSJ1)
--          at - 00:39:27 02/ 5/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Reg IS
  GENERIC(size : POSITIVE :=8);
  PORT ( A : in STD_LOGIC_VECTOR( size -1 downto 0);
    B : OUT STD_LOGIC_VECTOR(size -1 downto 0);
    c, e : IN std_logic);
  END ENTITY Reg;
  
  ARCHITECTURE Behavior of Reg IS
    BEGIN
      PROCESS(c)
      BEGIN
        IF (rising_edge(c) AND e='1') THEN
          b <= a;
        END IF;
      END PROCESS;
    END ARCHITECTURE Behavior;