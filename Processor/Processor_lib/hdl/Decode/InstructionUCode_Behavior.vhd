--
-- VHDL Architecture SCRATCH_LIB.InstructionUCode.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-ULTRABOOK)
--          at - 00:05:44 02/ 8/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

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
    opcode := Instruction(15 downto 13);
    
    if(opcode = "000") then 
      if(Instruction(0) = '1') then
        Op_Type_ROM <= "1101000000010000";
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

elsif(opcode = "111") then --Branch 
  if(Instruction(8) = '0') then --unconditionaljump
    Op_Type_ROM <= "0011100010000000";
else
    Op_Type_ROM <= "0011010010000000";
  end if;
  end if;
  end process;
END ARCHITECTURE Behavior;

