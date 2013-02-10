--
-- VHDL Architecture Processor_lib.RegisterFileRegister.Behavior
--
-- Created:
--          by - Shef.UNKNOWN (SHEF-HP)
--          at - 17:56:37 02/10/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY RegisterFileRegister IS
  PORT (wData:IN std_logic_vector(15 downto 0);
    wEnable:IN std_logic;
    rEnable0,rEnable1: IN std_logic;
    clock: IN std_logic;
    out0, out1: OUT std_logic_vector(15 downto 0));
END ENTITY RegisterFileRegister;

--
ARCHITECTURE Behavior OF RegisterFileRegister IS
  SIGNAL regout: std_logic_vector(15 downto 0);
BEGIN
  reggy: ENTITY work.Reg(Behavior)
    GENERIC MAP (size=> 16)
    PORT MAP (wData, regout, wEnable, clock);
  ts0: ENTITY work.TriState(Behavior)
    PORT MAP (regout, rEnable0, out0); 
  ts1: ENTITY work.TriState(Behavior)
    PORT MAP (regout, rEnable1, out1); 
END ARCHITECTURE Behavior;