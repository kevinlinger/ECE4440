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

ENTITY Pipeline_Reg_PreMem IS
  Port( addr:IN std_logic_vector (3 DOWNTO 0);
    opType:IN std_logic_vector (8 DOWNTO 0);
    aluData:IN std_logic_vector (15 DOWNTO 0);
    
       
    out_addr: OUT std_logic_vector (3 DOWNTO 0);
    out_opType: OUT std_logic_vector (8 DOWNTO 0);
    out_aluData: OUT std_logic_vector (15 DOWNTO 0);
    
          
    clock, enable, bubble : in std_logic);
  
END ENTITY Pipeline_Reg_PreMem;

--
ARCHITECTURE Behavioral OF Pipeline_Reg_PreMem IS
  
  signal Temp_Op_Type : std_logic_vector(8 downto 0);
  BEGIN
    
    determine_bubble : process (opType, bubble, clock, enable) is
    BEGIN
      if(enable = '1' and bubble = '1') then
        Temp_Op_Type <= "000000001"; --nop
      else
        Temp_Op_Type <= opType;
      end if;
    end process determine_bubble; 

  regy : ENTITY work.Reg(Behavior)
    generic map(size => 29)
    port map(
      a(3 downto 0) => addr, a(12 downto 4) => Temp_Op_Type, a(28 downto 13) => aluData,
      
      b(3 downto 0) => out_addr, b(12 downto 4) => out_opType, b(28 downto 13) => out_aluData,     
      
      c => clock, e => enable
    );
  
  
  
END ARCHITECTURE Behavioral;

       