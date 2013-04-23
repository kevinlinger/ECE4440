LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

--
-- VHDL Architecture lab4_lib.MemoryArbitrator.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVINLAPTOP)
--          at - 22:25:35 10/24/2012
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY MemoryArbiterNoCache IS
  port(IRAddress, DAddress, DWData : in std_logic_vector(15 downto 0);
       DREnable, DWEnable, RAMDelay : in std_logic;
       stallFetch, stallMem, writeOut, readOut: out std_logic;
      WData, Address : out std_logic_vector(15 downto 0));
END ENTITY MemoryArbiterNoCache;

--
ARCHITECTURE Structure OF MemoryArbiterNoCache IS
  signal readOrWrite : std_logic;
BEGIN
  
  --Process(RAMDelay)
  --BEGIN
  
 -- arbiterDataReturn <= memoryDataReturn;
  
  readOrWrite <= DREnable or DWEnable;
  stallFetch <= DREnable or DWEnable or RAMDelay;
  stallMem <= readOrWrite and RAMDelay;
 -- mdataOut <= memoryDataReturn;
 WData <= DWData;
  writeOut <= DWEnable;
  readOUt <= not(DWEnable);
  
  addrMux : entity work.TwoOneMux(Behavior)
      generic map (size => 16)
      port map (a0 => IRAddress, a1 => DAddress, c => readOrWrite, z => Address);
        
   
END ARCHITECTURE Structure;


