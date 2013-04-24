--
-- VHDL Architecture lab4_lib.RegisterReservationUnit.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVINLAPTOP)
--          at - 14:13:54 10/31/2012
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY RegisterReservationUnit IS
  port(clock, reset,WB_enabled : in std_logic; --R0En, R1En, WenDecode, WenWriteBack, clock : in std_logic;
       Rselect0, Rselect1, WselectDecode, WselectWriteBack : in std_logic_vector(15 downto 0);
       decode_opType : in std_logic_vector(8 downto 0);
       dirty : out std_logic);
END ENTITY RegisterReservationUnit;

--
ARCHITECTURE Structure OF RegisterReservationUnit IS
  signal writeDecodeAddrEn, writeBackAddrEn, flipFlopEnable, reserveOut, dirtyVector, dirtyR0, dirtyR1 : std_logic_vector(15 downto 0);
  signal temp_dirty : std_logic;
  signal tempWselectDecode : std_logic_vector(15 downto 0);
BEGIN

 suppress_false_d_Wselect : process(WselectDecode, decode_opType) is
   begin
     if(decode_opType(0) = '1' or decode_opType(2) = '1' or decode_opType(7) = '1' ) then
       tempWselectDecode <= (others => '0');
     else
       tempWselectDecode <= WselectDecode;
     end if;
   end process;



--elsif(WB_enabled = '1') then
--     

  --writeDecodeAddrEn <= WenDecode and WselectDecode; 
  --writeBackAddrEn <= WenWriteBack and WselectWriteBack;
  set_enables : process(reset, tempWselectDecode, WselectWriteBack, WB_enabled) is
  BEGIN
  if(reset = '1')
  then
   flipFlopEnable <= (others => '1');
      else
       flipFlopEnable <= tempWselectDecode or WselectWriteBack; 
  end if;
  END PROCESS;
  
  --generate 16 Flip Flops
   flipFlops: 
   for reserveNumber in 0 to 15 generate
      reserve : entity work.reg(Behavior)
        generic map (size => 1)
        port map(a => tempWselectDecode(reserveNumber downto reserveNumber) , b => reserveOut(reserveNumber downto reserveNumber), e => flipFlopEnable(reserveNumber), c => clock);
   end generate flipFlops;
   
   dirtyR0 <= reserveOut and Rselect0;
   dirtyR1 <= reserveOut and Rselect1;
   dirtyVector <= dirtyR0 or dirtyR1;
   
   temp_dirty <= dirtyVector(15) or dirtyVector(14) or dirtyVector(13) or dirtyVector(12) or dirtyVector(11) or dirtyVector(10) or dirtyVector(9) or dirtyVector(8)
    or dirtyVector(7) or dirtyVector(6) or dirtyVector(5) or dirtyVector(4) or dirtyVector(3) or dirtyVector(2) or dirtyVector(1) or dirtyVector(0);
    
   
   suppress_false_dirties : process(decode_opType, temp_dirty) is
   begin
     --if(decode_opType(0) = '1' or decode_opType(2) = '1' or decode_opType(7) = '1' ) then
     if(decode_opType(0) = '1' or decode_opType(7) = '1' ) then
       dirty <= '0';
     else
       dirty <= temp_dirty;
     end if;
   end process;
   
END ARCHITECTURE Structure;

