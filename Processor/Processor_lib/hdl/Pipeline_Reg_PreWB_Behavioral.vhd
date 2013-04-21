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
  Port(wEnable: in std_logic;
    rEnable:in std_logic;
    wBackEnable : in std_logic;
    wBackData : in std_logic_vector(15 downto 0);
    wBackAddr : in std_logic_vector(3 downto 0);
       
    out_wEnable: out std_logic;
    out_rEnable: out std_logic;
    out_wBackEnable : out std_logic;
    out_wBackData : out std_logic_vector(15 downto 0);
    out_wBackAddr : out std_logic_vector(3 downto 0);
          
    clock, enable : in std_logic);
  
END ENTITY Pipeline_Reg_PreWB;

--
ARCHITECTURE Behavioral OF Pipeline_Reg_PreWB IS
  
  BEGIN
    

  regy : ENTITY work.Reg(Behavior)
    generic map(size => 24)
    port map(
      a(0) => wEnable, a(1) => rEnable, a(3) => wBackEnable, a(19 downto 4) => wBackData, a(23 downto 20) => wBackAddr,

      b(0) => out_wEnable, b(1) => out_rEnable, b(3) => out_wBackEnable, b(19 downto 4) => out_wBackData, b(23 downto 20) => out_wBackAddr,      
      
      c => clock, e => enable
    );
  
  
  
END ARCHITECTURE Behavioral;

       