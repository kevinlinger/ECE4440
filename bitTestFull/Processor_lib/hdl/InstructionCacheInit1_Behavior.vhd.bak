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

ENTITY InstructionCacheInit1 IS
     PORT( 
      addr : IN     std_logic_vector (2 DOWNTO 0);
      clk  : IN     std_logic;
      din  : IN     std_logic_vector (15 DOWNTO 0);
      we   : IN     std_logic;
      dout : OUT    std_logic_vector (15 DOWNTO 0)
   );
END ENTITY InstructionCacheInit1;

--
ARCHITECTURE Behavior OF InstructionCacheInit1 IS

   TYPE MW_RAM_TYPE IS ARRAY (((2**3) -1) DOWNTO 0) OF std_logic_vector(15 DOWNTO 0);
   --SIGNAL mw_ram_table : MW_RAM_TYPE := (OTHERS => "0000000000000000");

--SIGNAL mw_ram_table : MW_RAM_TYPE := ("0000000000000011", "1010100010100010", "0111111010000000", "0010110001000000", "1010100010100010", "1000101000000001", "1000010100000000", "0000000000000000");
--SIGNAL mw_ram_table : MW_RAM_TYPE := ("0000000000001010", "1010000011000000", "1011111001100010", "1010010010100010", "0111111001000000", "1000101100000000", "1000011000011111", "1000001000011100");

SIGNAL mw_ram_table : MW_RAM_TYPE := ("1110000111111011", "1010011101100010", "1011111101100010", "1010001101000101", "1010000101000101", "0110010000000000", "1001011000000001", "0000000000000001");

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

