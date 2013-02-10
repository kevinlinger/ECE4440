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
  signal IF_jumpEnable : std_logic;
  signal IF_Instruction, IF_PCValue_output, IF_maddr : std_logic_vector(15 downto 0);
  
  signal D_RA0, D_RA1, D_Dest_Reg : std_logic_vector(3 downto 0);
  signal D_Op0, D_Op1, D_Extra : std_logic_vector(15 downto 0);
  signal D_ALU_Control : std_logic_vector(2 downto 0);
  signal D_Op_Type : std_logic_vector(8 downto 0);
  
  signal E_ALU_Out : std_logic_vector(15 downto 0);
  
  signal RF_RD0, RF_RD1 : std_logic_vector(15 downto 0);
  
BEGIN
  
IF_stage : Entity WORK.Instruction_Fetch_Stage(Structural)
  PORT MAP(mem_data => IF_mem_data, readAddress => IF_readAddress, jumpAddress => IF_jumpAddress,
    jumpEnable => IF_jumpEnable, reset =>reset, interrupt => interrupt, clock => clock, memdelay => '0',
    stall => '0', Instruction => IF_Instruction, PCValue_output => IF_PCValue_output, maddr => IF_maddr);

DecodeStage : ENTITY WORK.DecodeStage(Structure)
  PORT MAP( Instruction => IF_Instruction, PCValue => IF_PCValue_output, RD0 => RF_RD0, RD1 => RF_RD1,
    RA0 => D_RA0, RA1 => D_RA1, Dest_Reg => D_Dest_Reg, Op0 => D_Op0, Op1 => D_Op1, Extra => D_Extra,
    ALU_Control => D_ALU_Control, Op_Type => D_Op_Type); 
  
ExecuteStage : ENTITY WORK.ExecuteStage(behavior)
  PORT MAP( ALU0 => D_Op0, ALU1 => D_Op1, Extra => D_Extra, ALU_Ctrl => D_ALU_Control,
    Op_Type => D_Op_Type, ALU_Out => E_ALU_Out, Branch_Inst => D_Dest_Reg, Branch_Ctrl => IF_JumpEnable,
    clock => clock);

END ARCHITECTURE Structure;

