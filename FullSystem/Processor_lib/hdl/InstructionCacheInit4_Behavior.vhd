--
-- VHDL Architecture Processor_lib.InstructionCacheInit1.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 03:57:16 04/12/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY InstructionCacheInit4 IS
     PORT( 
      addr : IN     std_logic_vector (2 DOWNTO 0);
      clk  : IN     std_logic;
      din  : IN     std_logic_vector (15 DOWNTO 0);
      we   : IN     std_logic;
      dout : OUT    std_logic_vector (15 DOWNTO 0)
   );
END ENTITY InstructionCacheInit4;

--
ARCHITECTURE Behavior OF InstructionCacheInit4 IS

   TYPE MW_RAM_TYPE IS ARRAY (((2**3) -1) DOWNTO 0) OF std_logic_vector(15 DOWNTO 0);
   --SIGNAL mw_ram_table : MW_RAM_TYPE := (OTHERS => "0000000000000000");

--SIGNAL mw_ram_table : MW_RAM_TYPE := ("0000000000000000", "0000000000000011", "1010100010100010", "0111111010000000", "0010110001000000", "1010100010100010", "1000101000000001", "1000010100000000");
--SIGNAL mw_ram_table : MW_RAM_TYPE := ("0000000000000000", "1110000000000000", "0010110010000000", "0100110010000000", "1110010100000101", "1010100001100100", "1010000000000010", "1000010000011110");
SIGNAL mw_ram_table : MW_RAM_TYPE := ("0000000000000000", "1110001111110011", "1010000000100000", "0111111001100000", "0110001000000000", "0110000101100000", "1110001100000100", "1001010000000000");

   SIGNAL mw_addr_reg: std_logic_vector(2 DOWNTO 0);

BEGIN
  
    -- mw_ram_table(0) <= "0101010101010101";
    -- mw_ram_table(1) <= "1111000011110000";

   -- ModuleWare code(v1.9) for instance of 'mw_ramsp_6bd1b000'

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

  
END ARCHITECTURE Behavior;

