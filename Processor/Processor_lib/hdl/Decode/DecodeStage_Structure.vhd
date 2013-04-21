--
-- VHDL Architecture SCRATCH_LIB.DecodeStage.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-ULTRABOOK)
--          at - 23:27:12 02/ 7/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY DecodeStage IS
  port(Instruction, PCValue, RD0, RD1 : in std_logic_vector(15 downto 0);
        downstream_stall, dirty : in std_logic;
    
        bubble_pipeline_preExe, upstream_stall : out std_logic;
       RA0, RA1, Dest_Reg : out std_logic_vector(3 downto 0);
       Op0, Op1, Extra : out std_logic_vector(15 downto 0);
       ALU_Control : out std_logic_vector(2 downto 0);
       Op_Type : out std_logic_vector(8 downto 0));
       
END ENTITY DecodeStage;

--
ARCHITECTURE Structure OF DecodeStage IS
  signal loadOffset : std_logic_vector(15 downto 0) := "0000000000000000";
  signal signExtended : std_logic_vector(15 downto 0);
  signal Op_Type_ROM : std_logic_vector(15 downto 0) := "0000000000000000";
  constant zero16 : std_logic_vector(15 downto 0) := "0000000000000000";
BEGIN
  
  bubble_pipeline_preExe <= dirty;
  upstream_stall <= downstream_stall or dirty;
  
  
  RA0 <= Instruction(8 downto 5);
  RA1 <= Instruction(12 downto 9);
    
  signExtended <= (15 downto 8 => Instruction(7)) & Instruction(7 downto 0);
  Op_Type(8) <= Instruction(8);
  
  InstructionMicroCode : entity work.InstructionUCode(Behavior)
      port map (Instruction => Instruction, Op_Type_ROM => Op_Type_ROM);
  
  destRegMux : entity work.TwoOneMux(Behavior)
      generic map (size => 4)
      port map( a0 => Instruction(12 downto 9), a1 => "1111", c => Op_Type_ROM(15), z => Dest_Reg);
        
  aluControlMux: entity work.TwoOneMux(Behavior)
      generic map (size => 3)
      port map( a0 => Instruction(2 downto 0), a1 => "000", c => Op_Type_ROM(14), z => ALU_Control);


execMuxInput0 : entity work.FourOneMux(Behavior)
      generic map (size => 16)
      port map( a0 => RD1, a1(15 downto 5) => "00000000000", a1(4 downto 0) => Instruction(4 downto 0), a2 => signExtended, a3=> zero16, c => Op_Type_ROM(13 downto 12), z => Op0);

  execMuxInput1 : entity work.FourOneMux(Behavior)
      generic map (size => 16)
      port map (a0 => RD0, a1 => PCValue, a2 => RD1, a3 => zero16, c => Op_Type_ROM(11 downto 10), z => Op1);
            
  
  execMuxExtra : entity work.FourOneMux(Behavior)
      generic map (size => 16)
      port map( a0 => RD1, a1 => signExtended, a2(15 downto 8) => Instruction(7 downto 0), a2(7 downto 0) => RD1(7 downto 0), a3 => zero16, c => Op_Type_ROM(9 downto 8), z => Extra);
  
  Op_Type(7 downto 0) <= Op_Type_ROM(7 downto 0);
  
END ARCHITECTURE Structure;