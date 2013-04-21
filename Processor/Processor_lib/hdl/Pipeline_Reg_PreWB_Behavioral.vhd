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

ENTITY Pipeline_Reg_PreWB IS
  Port(
    
    M_WBackEnable : in std_logic;
    wBackData : in std_logic_vector(15 downto 0);
    wBackAddr : in std_logic_vector(3 downto 0);
       
    
   
    out_M_WBackEnable : out std_logic;
    out_wBackData : out std_logic_vector(15 downto 0);
    out_wBackAddr : out std_logic_vector(3 downto 0);
          
    clock, enable, bubble : in std_logic);
  
END ENTITY Pipeline_Reg_PreWB;

--
ARCHITECTURE Behavioral OF Pipeline_Reg_PreWB IS
  
  signal temp_M_WBackEnable : std_logic;
  BEGIN
    
    determine_bubble : process (M_WBackEnable, bubble, clock, enable) is
    BEGIN
      if(bubble = '1' and enable = '1') then
        temp_M_WBackEnable <= '0'; --nop
      else
        temp_M_WBackEnable <= M_WBackEnable;
      end if;
    end process determine_bubble; 
    

  regy : ENTITY work.Reg(Behavior)
    generic map(size => 21)
    port map(
      a(0) => temp_M_WBackEnable, a(16 downto 1) => wBackData, a(20 downto 17) => wBackAddr,

      b(0) => out_M_WBackEnable, b(16 downto 1) => out_wBackData, b(20 downto 17) => out_wBackAddr,      
      
      c => clock, e => enable
    );
  
  
  
END ARCHITECTURE Behavioral;

       