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
  RA0 <= Instruction(8 downto 5);
  RA1 <= Instruction(12 downto 9);
    
  signExtended <= (15 downto 8 => Instruction(7)) & Instruction(7 downto 0);
  Op_Type(8) <= Instruction(8);
  
  InstructionMicroCode : entity InstructrionUCode(Behavior)
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

ENTITY InstructionUCode IS
  port(Instruction : in std_logic_vector(15 downto 0);
       Op_Type_ROM : out std_logic_vector(15 downto 0));
END ENTITY InstructionUCode;

--
ARCHITECTURE Behavior OF InstructionUCode IS
BEGIN
  Process(Instruction)
  variable opcode : std_logic_vector(2 downto 0);
  begin
    opcode := instr(15 downto 13);
    
    if(opcode = "000") then 
      if(Instruction(0) = '1') then
        Op_Type_ROM <= "1111010000100000";
      else 
        Op_Type_ROM <= "0000000000000001";
    end if;
  
  elsif(opcode = "001") then --load
    Op_Type_ROM <= "0001000000000010";
    
  elsif(opcode = "010") then -- store
    Op_Type_ROM <= "0001000000000100";
    
elsif(opcode = "011") then --move
    Op_Type_ROM <= "0011000000001000";

elsif(opcode = "100") then 
  if(Instruction(8) = '0') then --lil
    Op_Type_ROM <= "0000000100010000";
  else --lih
    Op_Type_ROM <= "0000001000010000";
  end if;
  
elsif(opcode = "101") then --arithmetic 
    Op_Type_ROM <= "0000000000100000";
    
elsif(opcode = "110") then --Shift 
    Op_Type_ROM <= "0000000001000000";

elsif(opcode = "101") then --Branch 
  if(Instruction(8) = '0') then --unconditionaljump
    Op_Type_ROM <= "0011100010000000";
else
    Op_Type_ROM <= "0011010010000000";
  end if;
  end if;
  end process;
END ARCHITECTURE Behavior;
