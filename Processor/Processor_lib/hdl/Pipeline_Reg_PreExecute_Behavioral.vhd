--
-- VHDL Architecture Processor_lib.Pipeline_Reg_PreDecode.Behavioral
--
-- Created:
--          by - mew2ub.UNKNOWN (BCFRSJ1)
--          at - 22:43:29 04/20/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Pipeline_Reg_PreExecute IS
  Port( ALU0, ALU1, Extra : IN std_logic_vector (15 DOWNTO 0);
    ALU_Ctrl : IN std_logic_vector(2 DOWNTO 0);
    Op_Type : IN std_logic_vector(8 DOWNTO 0);    
    Branch_Inst : IN std_logic_vector(3 DOWNTO 0);
       
    out_ALU0, out_ALU1, Extra : out std_logic_vector (15 DOWNTO 0);
    out_ALU_Ctrl : out std_logic_vector(2 DOWNTO 0);
    out_Op_Type : out std_logic_vector(8 DOWNTO 0);    
    out_Branch_Inst : out std_logic_vector(3 DOWNTO 0);
          
    clock, enable, bubble : in std_logic);
  
END ENTITY Pipeline_Reg_PreExecute;

--
ARCHITECTURE Behavioral OF Pipeline_Reg_PreExecute IS
  
  signal Temp_Op_Type : std_logic_vector(8 downto 0);
  BEGIN
    
    determine_bubble : process (Instruction, bubble, clock) is
    BEGIN
      if(bubble = '1') then
        Temp_Op_Type <= "000000001"; --nop
      else
        Temp_Op_Type <= Op_Type;
      end if;
    end process determine_bubble; 

  regy : ENTITY work.Reg(Behavior)
    generic map(size => 64)
    port map(
      a(15 downto 0) => ALU0, a(31 downto 16) => ALU1, a(47 downto 32) => Extra, a(50 downto 48) => ALU_Ctrl,
      a(59 downto 51) => Temp_Op_Type, a(63 downto 60) => Branch_Inst,
      
      b(15 downto 0) => out_ALU0, b(31 downto 16) => out_ALU1, b(47 downto 32) => out_Extra, b(50 downto 48) => out_ALU_Ctrl,
      b(59 downto 51) => out_Op_Type, b(63 downto 60) => out_Branch_Inst,
      
      c => clock, e => enable
    );
  
  
  
END ARCHITECTURE Behavioral;

       