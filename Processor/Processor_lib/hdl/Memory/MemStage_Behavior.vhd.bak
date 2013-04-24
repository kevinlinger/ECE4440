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
    Dcache_stall, IF_memDelay: IN std_logic;
    
    mem_stall_toUpstream, bubble_preWB_pipeline : OUT std_logic;
    wEnable:OUT std_logic;
    rEnable:OUT std_logic;
    wBackEnable : out std_logic;
    wBackData : out std_logic_vector(15 downto 0);
    wBackAddr : out std_logic_vector(3 downto 0));
END ENTITY MemStage;

--
--Read => M_rEnable and (not IF_memDelay),
-- Write => M_wEnable and (not IF_memDelay),

ARCHITECTURE Behavior OF MemStage IS
  SIGNAL control:std_logic;
BEGIN
  
  determine_stalls : PROCESS(IF_memDelay, DCache_stall, opType) is
  begin
    if(DCache_stall = '1') then
      mem_stall_toUpstream <= '1';
      bubble_preWB_pipeline <= '1';
    elsif( IF_memDelay = '1' and (opType(1) = '1' or opType(2) = '1' )) then
      mem_stall_toUpstream <= '1';
      bubble_preWB_pipeline <= '1';
    else
      mem_stall_toUpstream <= '0';
      bubble_preWB_pipeline <= '0';
    end if;
  end process;
  
  
--  mem_stall_toUpstream <= DCache_stall;
--  bubble_preWB_pipeline <= DCache_stall;
  
  rEnable <= opType(1);
  wEnable <= opType(2);
  wBackEnable <= (opType(1) or opType(4) or opType(5) or opType(6) or opType(3)) and (not Dcache_stall);
  control <= opType(1);
  wBackAddr <= addr;
  
  mux:ENTITY work.Mux_2_to_1(Behavior)
  	GENERIC MAP (width=>16)
    PORT MAP (aluData, rData, control, wBackData);
END ARCHITECTURE Behavior;