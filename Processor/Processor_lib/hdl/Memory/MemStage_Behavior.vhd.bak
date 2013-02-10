--
-- VHDL Architecture Memory_lib.MemStage.Behavior
--
-- Created:
--          by - Shef.UNKNOWN (SHEF-HP)
--          at - 22:38:34 02/ 7/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY MemStage IS
  PORT (addr:IN std_logic_vector (3 DOWNTO 0);
    --wData:IN std_logic_vector (15 DOWNTO 0);
    opType:IN std_logic_vector (8 DOWNTO 0);
    aluData:IN std_logic_vector (15 DOWNTO 0);
    rData: IN std_logic_vector (15 DOWNTO 0);
    destAddr : OUT std_logic_vector(3 downto 0);
    wEnable:OUT std_logic;
    rEnable:OUT std_logic;
    wBackEnable : out std_logic;
    wBackData : out std_logic_vector(15 downto 0);
    wBackAddr : out std_logic_vector(3 downto 0));
END ENTITY MemStage;


ARCHITECTURE Behavior OF MemStage IS
  SIGNAL control:std_logic;
BEGIN
  
  rEnable <= opType(1);
  wEnable <= opType(2);
  wBackEnable <= opType(1) or opType(4) or opType(5) or opType(6) or opType(3);
  destAddr <= wBackAddr;
  control <= opType(1);
  
  mux:ENTITY work.Mux2to1(Behavior)
	GENERIC MAP (size=>16)
    PORT MAP (aluData, rData, control, wBackData);
END ARCHITECTURE Behavior;