--
-- VHDL Architecture Processor_lib.CacheMemory.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-ULTRABOOK)
--          at - 15:52:40 02/26/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Processor_lib;
USE Processor_lib.All;

ENTITY CacheMemory IS
-- Declarations

END CacheMemory ;

--
ARCHITECTURE Structure OF CacheMemory IS
   SIGNAL addr : std_logic_vector(2 DOWNTO 0);
   SIGNAL clk  : std_logic;
   SIGNAL din  : std_logic_vector(15 DOWNTO 0);
   SIGNAL we   : std_logic;
   SIGNAL dout : std_logic_vector(15 DOWNTO 0);
   COMPONENT mw_ramsp_6bd1b000
      PORT (
         addr : IN     std_logic_vector(2 DOWNTO 0);
         clk  : IN     std_logic;
         din  : IN     std_logic_vector(15 DOWNTO 0);
         dout : OUT    std_logic_vector(15 DOWNTO 0);
         we   : IN     std_logic
      );
   END COMPONENT mw_ramsp_6bd1b000;
   FOR ALL : mw_ramsp_6bd1b000 USE ENTITY mw_ramsp_6bd1b000;
BEGIN
   --  hds mw_cpt_inst uid 0 v1.9 **Double click THIS LINE to edit**
   instanceName0 : mw_ramsp_6bd1b000
      PORT MAP (
         addr => addr,
         clk  => clk,
         din  => din,
         we   => we,
         dout => dout
      );
END ARCHITECTURE Structure;
