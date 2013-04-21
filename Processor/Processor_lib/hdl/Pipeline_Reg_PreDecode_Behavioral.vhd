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

ENTITY Pipeline_Reg_PreDecode IS
  Port( Instruction, PCValue : in std_logic_vector(15 downto 0);
       
       out_Instruction, out_PCValue : out std_logic_vector(15 downto 0);
       
       clock, enable, bubble : in std_logic);
  
END ENTITY Pipeline_Reg_PreDecode;

--
ARCHITECTURE Behavioral OF Pipeline_Reg_PreDecode IS
  
  signal Temp_Instruction : std_logic_vector(15 downto 0);
  BEGIN
    
    determine_bubble : process (Instruction, bubble, clock) is
    BEGIN
      if(bubble = '1') then
        Temp_Instruction <= (others => '0');
      else
        Temp_Instruction <= Instruction;
      end if;
    end process determine_bubble; 

  regy : ENTITY work.Reg(Behavior)
    generic map(size => 32)
    port map(
      a(15 downto 0) => Temp_Instruction, a(31 downto 16) => PCValue,
      b(15 downto 0) => out_Instruction, b(31 downto 16) => out_PCValue,
      c => clock, e => enable
    );
  
  
  
END ARCHITECTURE Behavioral;

       