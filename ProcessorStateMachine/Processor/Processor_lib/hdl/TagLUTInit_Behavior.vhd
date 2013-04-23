-- VHDL Entity Processor_lib.mw_ramsp_24a2ff5e.MW
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 17:58:01 02/27/2013
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY TagLUTInit IS
   PORT( 
      addr : IN     std_logic_vector (2 DOWNTO 0);
      clk  : IN     std_logic;
      din  : IN     std_logic_vector (11 DOWNTO 0);
      we   : IN     std_logic;
      dout : OUT    std_logic_vector (11 DOWNTO 0)
   );

-- Declarations

END TagLUTInit ;

ARCHITECTURE Behavior OF TagLUTInit IS
   TYPE MW_RAM_TYPE IS ARRAY (((2**3) -1) DOWNTO 0) OF std_logic_vector(11 DOWNTO 0);
   SIGNAL mw_ram_table : MW_RAM_TYPE := (OTHERS => "100000000000");
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

END Behavior;
