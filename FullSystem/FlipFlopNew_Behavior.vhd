--
-- VHDL Architecture Processor_lib.FlipFlop.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 21:21:04 04/22/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY FlipFlopNew IS
     PORT( 
      clk  : IN     std_logic;
      d    : IN     std_logic;
      en: IN     std_logic;
      rst  : IN     std_logic;
      q    : OUT    std_logic
   );

END ENTITY FlipFlopNew;

--
ARCHITECTURE Behavior OF FlipFlopNew IS
     SIGNAL mw_reg_cval : std_logic;
BEGIN
  
   q <= mw_reg_cval;
   seq_proc: PROCESS (clk, rst)
   BEGIN
      IF (rst = '1') THEN
         mw_reg_cval <= '0';
      ELSIF (clk'EVENT AND clk='1') THEN
         IF (en= '1') THEN
            mw_reg_cval <= d;
         END IF;
      END IF;
   END PROCESS seq_proc;
END ARCHITECTURE Behavior;

