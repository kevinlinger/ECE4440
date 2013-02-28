--
-- VHDL Architecture Processor_lib.CacheMemory.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 22:26:22 02/27/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Processor_lib;
USE Processor_lib.All;

ENTITY CacheMemory IS
    Port(clk, we : in std_logic;
     din : in std_logic_vector(15 downto 0);
     addr : in std_logic_vector(2 downto 0);
     dout : out std_logic_vector(15 downto 0));
END ENTITY CacheMemory;

--
ARCHITECTURE Structure OF CacheMemory IS
   COMPONENT mw_ramsp_6bd1b000
      PORT (
         addr : IN     std_logic_vector(2 DOWNTO 0);
         clk  : IN     std_logic;
         din  : IN     std_logic_vector(15 DOWNTO 0);
         we   : IN     std_logic;
         dout : OUT    std_logic_vector(15 DOWNTO 0)
      );
   END COMPONENT mw_ramsp_6bd1b000;
   FOR ALL : mw_ramsp_6bd1b000 USE ENTITY Processor_lib.mw_ramsp_6bd1b000;
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

