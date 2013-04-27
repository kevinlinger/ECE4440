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
   TYPE MW_RAM_TYPE IS ARRAY (((2**3) -1) DOWNTO 0) OF std_logic_vector(11 DOWNTO 0);
   SIGNAL mw_ram_table : MW_RAM_TYPE := (OTHERS => "000000000000");
   SIGNAL mw_addr_reg: std_logic_vector(2 DOWNTO 0);

BEGIN

   -- ModuleWare code(v1.9) for instance of 'mw_ramsp_24a2ff5e'

   --attribute block_ram : boolean;
   --attribute block_ram of mem : signal is false;
   ram_p_proc: PROCESS (clk, addr)
   BEGIN
      IF (clk'EVENT AND clk='1') THEN
         IF (we = '1') THEN
            mw_ram_table(CONV_INTEGER(unsigned(addr))) <= din;
         END IF;
      END IF;
   mw_addr_reg <= addr;
   END PROCESS ram_p_proc;
   dout <= mw_ram_table(CONV_INTEGER(unsigned(mw_addr_reg)));
END ARCHITECTURE Structure;

