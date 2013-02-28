--
-- VHDL Architecture Processor_lib.TagLUT.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 17:54:27 02/27/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Processor_lib;
USE Processor_lib.All;

ENTITY TagLUT IS
  Port(clk, we : in std_logic;
     din : in std_logic_vector(11 downto 0);
     addr : in std_logic_vector(2 downto 0);
     dout : out std_logic_vector(11 downto 0));
END ENTITY TagLUT;

--
ARCHITECTURE Structure OF TagLUT IS
   COMPONENT mw_ramsp_24a2ff5e
      PORT (
         addr : IN     std_logic_vector(2 DOWNTO 0);
         clk  : IN     std_logic;
         din  : IN     std_logic_vector(11 DOWNTO 0);
         we   : IN     std_logic;
         dout : OUT    std_logic_vector(11 DOWNTO 0)
      );
   END COMPONENT mw_ramsp_24a2ff5e;
   FOR ALL : mw_ramsp_24a2ff5e USE ENTITY Processor_lib.mw_ramsp_24a2ff5e;
BEGIN
   --  hds mw_cpt_inst uid 0 v1.9 **Double click THIS LINE to edit**
   instanceName0 : mw_ramsp_24a2ff5e
      PORT MAP (
         addr => addr,
         clk  => clk,
         din  => din,
         we   => we,
         dout => dout
      );
END ARCHITECTURE Structure;

