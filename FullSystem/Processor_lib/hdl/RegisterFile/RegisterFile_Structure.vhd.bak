--
-- VHDL Architecture Processor_lib.RegisterFile.Structure
--
-- Created:
--          by - Shef.UNKNOWN (SHEF-HP)
--          at - 18:13:41 02/10/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY RegisterFile IS
  PORT (wAddr: IN std_logic_vector (3 downto 0);
    wData: IN std_logic_vector (15 downto 0);
    wEnable: IN std_logic;
    rAddr0, rAddr1: IN std_logic_vector (3 downto 0);
    clock: IN std_logic;
    Debug_Register_Dump : OUT std_logic_vector( 255 downto 0);
    RD0, RD1: OUT std_logic_vector (15 downto 0));
END ENTITY RegisterFile;

--
ARCHITECTURE Structure OF RegisterFile IS
  SIGNAL wDecodeOut, rDecodeOut0, rDecodeOut1: std_logic_vector (15 downto 0);
BEGIN
  wDecoder: ENTITY work.Decoder(Behavior)
    PORT MAP (wAddr, wDecodeOut, wEnable);
  rDecoder0: ENTITY work.Decoder(Behavior)
    PORT MAP (rAddr0, rDecodeOut0, '1');
  rDecoder1: ENTITY work.Decoder(Behavior)
    PORT MAP (rAddr1, rDecodeOut1, '1');
  regArr: for i IN 0 to 15 GENERATE
    BEGIN
      regBlock: ENTITY work.RegisterFileRegister (Behavior)
        PORT MAP (wData, wDecodeOut(i), rDecodeOut0(i), rDecodeOut1(i), clock, RD0, RD1,
         Debug_Register_Dump( ((i * 16) + 15) downto (i *16) ));
  END GENERATE regArr;
END ARCHITECTURE Structure;

