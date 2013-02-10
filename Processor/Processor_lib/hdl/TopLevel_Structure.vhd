--
-- VHDL Architecture Processor_lib.TopLevel.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-ULTRABOOK)
--          at - 13:06:17 02/ 8/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY TopLevel IS
  PORT(clock, reset, interrupt : IN std_logic);
END ENTITY TopLevel;



--
ARCHITECTURE Structure OF TopLevel IS
  
  signal IF_mem_data, IF_readAddress, IF_jumpAddress : std_logic_vector(15 downto 0);
  signal IF_jumpEnable, IF_memdelay : std_logic;
  signal IF_Instruction, IF_PCValue_output, IF_maddr : std_logic_vector(15 downto 0);
  
BEGIN
  
IF_stage : Entity WORK.Instruction_Fetch_Stage(Structural)
  PORT MAP(mem_data => IF_mem_data, readAddress => IF_readAddress, jumpAddress => IF_jumpAddress,
    jumpEnable => IF_jumpEnable, reset =>reset, interrupt => interrupt, clock => clock, memdelay => IF_memdelay,
    stall => '0', Instruction => IF_Instruction, PCValue_output => IF_PCValue_output, maddr => IF_maddr);

  
  
END ARCHITECTURE Structure;

