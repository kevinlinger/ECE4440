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

ENTITY InstructionCacheInit2 IS
     PORT( 
      addr : IN     std_logic_vector (2 DOWNTO 0);
      clk  : IN     std_logic;
      din  : IN     std_logic_vector (15 DOWNTO 0);
      we   : IN     std_logic;
      dout : OUT    std_logic_vector (15 DOWNTO 0)
   );
END ENTITY InstructionCacheInit2;

--
ARCHITECTURE Behavior OF InstructionCacheInit2 IS

   TYPE MW_RAM_TYPE IS ARRAY (((2**3) -1) DOWNTO 0) OF std_logic_vector(15 DOWNTO 0);
   --SIGNAL mw_ram_table : MW_RAM_TYPE := (OTHERS => "0000000000000000");

--SIGNAL mw_ram_table : MW_RAM_TYPE := ("0000000000001100", "1110000000000000", "1110010100000101", "1010100010100000", "1011111000100010", "0110100001100000", "1000011100000000", "1000001100000000");
--SIGNAL mw_ram_table : MW_RAM_TYPE := ("0000000000001010", "1010000011000000", "1011111001100010", "1010010010100010", "0111111001000000", "1000101100000000", "1000011000011111", "1000001000011100");
SIGNAL mw_ram_table : MW_RAM_TYPE := ("1110000100000000", "0111111001100000", "1110001100001000", "0110011001000000", "1110000100010000", "1010010101000101", "0111111000000000", "1001001000011110");

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

