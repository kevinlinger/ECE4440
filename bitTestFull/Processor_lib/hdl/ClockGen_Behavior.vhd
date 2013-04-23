--
-- VHDL Architecture Processor_lib.ClockGen.Behavior
--
-- Adapted from VHDL Tutorials from TKT-1426
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ClockGen IS
   GENERIC( 
      PERIOD    : TIME := 100 ns
   );
   PORT( 
      Clock    : OUT    std_logic;
      Reset  : OUT  std_logic 
   );
END ENTITY ClockGen;

--
ARCHITECTURE Behavior OF ClockGen IS

  signal TBClk : std_logic := '0';
  signal TBReset : std_logic := '1';

BEGIN

  Process(TBClk)
    begin
      TBClk  <= not TBClk after PERIOD/2;
  end Process;

  
  TBReset <= '1', 
  '0' after PERIOD;

   Clock <= TBClk;
   Reset <= TBReset;
END ARCHITECTURE Behavior;
