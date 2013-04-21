--
-- VHDL Architecture Processor_lib.Full_Reservation_Station.Hybrid
--
-- Created:
--          by - mew2ub.UNKNOWN (BCFRSJ1)
--          at - 15:09:43 04/21/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Full_Reservation_Station IS
  PORT(clock, reset, decode_stalled, wb_enabled : in std_logic; --R0En, R1En, WenDecode, WenWriteBack, clock : in std_logic;
      decode_opType : in std_logic_vector(8 downto 0);
       Rselect0addr, Rselect1addr, Wselectaddr, WselectWriteBackaddr : in std_logic_vector(3 downto 0);
       dirty : out std_logic
       );
END ENTITY Full_Reservation_Station;

--
ARCHITECTURE Hybrid OF Full_Reservation_Station IS

  signal Rselect0, Rselect1, WselectDecode, WselectWriteBack : std_logic_vector(15 downto 0);
BEGIN
    
  Decode_Rselect0 : Process(Rselect0addr) is
  BEGIN
    
    CASE Rselect0addr is
      
      when "0000" =>  Rselect0 <= "0000000000000001";
      when "0001" =>  Rselect0 <= "0000000000000010";
      when "0010" =>  Rselect0 <= "0000000000000100";
      when "0011" =>  Rselect0 <= "0000000000001000";
      when "0100" =>  Rselect0 <= "0000000000010000";
      when "0101" =>  Rselect0 <= "0000000000100000";
      when "0110" =>  Rselect0 <= "0000000001000000";
      when "0111" =>  Rselect0 <= "0000000010000000";
      when "1000" =>  Rselect0 <= "0000000100000000";
      when "1001" =>  Rselect0 <= "0000001000000000";
      when "1010" =>  Rselect0 <= "0000010000000000";
      when "1011" =>  Rselect0 <= "0000100000000000";
      when "1100" =>  Rselect0 <= "0001000000000000";
      when "1101" =>  Rselect0 <= "0010000000000000";
      when "1110" =>  Rselect0 <= "0100000000000000";
      when others =>  Rselect0 <= "1000000000000000";  
      
      
    end case;
  end PROCESS;
    
    Decode_Rselect1 : Process(Rselect1addr) is
  BEGIN
    
    CASE Rselect1addr is
      
      when "0000" =>  Rselect1 <= "0000000000000001";
      when "0001" =>  Rselect1 <= "0000000000000010";
      when "0010" =>  Rselect1 <= "0000000000000100";
      when "0011" =>  Rselect1 <= "0000000000001000";
      when "0100" =>  Rselect1 <= "0000000000010000";
      when "0101" =>  Rselect1 <= "0000000000100000";
      when "0110" =>  Rselect1 <= "0000000001000000";
      when "0111" =>  Rselect1 <= "0000000010000000";
      when "1000" =>  Rselect1 <= "0000000100000000";
      when "1001" =>  Rselect1 <= "0000001000000000";
      when "1010" =>  Rselect1 <= "0000010000000000";
      when "1011" =>  Rselect1 <= "0000100000000000";
      when "1100" =>  Rselect1 <= "0001000000000000";
      when "1101" =>  Rselect1 <= "0010000000000000";
      when "1110" =>  Rselect1 <= "0100000000000000";
      when others =>  Rselect1 <= "1000000000000000";  
      
      
    end case;    
  END PROCESS;
  
  Decode_Wselectaddr : Process(Wselectaddr, decode_stalled, reset) is
  BEGIN
    
    if( decode_stalled = '1' or reset = '1') then
      WselectDecode <= "0000000000000000";
    else
      
      CASE Wselectaddr is
        
        when "0000" =>  WselectDecode <= "0000000000000001";
        when "0001" =>  WselectDecode <= "0000000000000010";
        when "0010" =>  WselectDecode <= "0000000000000100";
        when "0011" =>  WselectDecode <= "0000000000001000";
        when "0100" =>  WselectDecode <= "0000000000010000";
        when "0101" =>  WselectDecode <= "0000000000100000";
        when "0110" =>  WselectDecode <= "0000000001000000";
        when "0111" =>  WselectDecode <= "0000000010000000";
        when "1000" =>  WselectDecode <= "0000000100000000";
        when "1001" =>  WselectDecode <= "0000001000000000";
        when "1010" =>  WselectDecode <= "0000010000000000";
        when "1011" =>  WselectDecode <= "0000100000000000";
        when "1100" =>  WselectDecode <= "0001000000000000";
        when "1101" =>  WselectDecode <= "0010000000000000";
        when "1110" =>  WselectDecode <= "0100000000000000";
        when others =>  WselectDecode <= "1000000000000000";  
        
        
      end case;
    end if;
  end PROCESS;
  
  
  Decode_WselectWriteBackaddr : Process(WselectWriteBackaddr) is
  BEGIN
    
    CASE WselectWriteBackaddr is
      
      when "0000" =>  WselectWriteBack <= "0000000000000001";
      when "0001" =>  WselectWriteBack <= "0000000000000010";
      when "0010" =>  WselectWriteBack <= "0000000000000100";
      when "0011" =>  WselectWriteBack <= "0000000000001000";
      when "0100" =>  WselectWriteBack <= "0000000000010000";
      when "0101" =>  WselectWriteBack <= "0000000000100000";
      when "0110" =>  WselectWriteBack <= "0000000001000000";
      when "0111" =>  WselectWriteBack <= "0000000010000000";
      when "1000" =>  WselectWriteBack <= "0000000100000000";
      when "1001" =>  WselectWriteBack <= "0000001000000000";
      when "1010" =>  WselectWriteBack <= "0000010000000000";
      when "1011" =>  WselectWriteBack <= "0000100000000000";
      when "1100" =>  WselectWriteBack <= "0001000000000000";
      when "1101" =>  WselectWriteBack <= "0010000000000000";
      when "1110" =>  WselectWriteBack <= "0100000000000000";
      when others =>  WselectWriteBack <= "1000000000000000";  
      
      
    end case;    
  END PROCESS;
      
      
      --signal Rselect0, Rselect1, WselectDecode, WselectWriteBack : std_logic_vector(15 downto 0);
  ReservationUnit : ENTITY WORK.RegisterReservationUnit(Structure)
  PORT MAP(
    clock => clock, wb_enabled => wb_enabled, reset => reset, dirty => dirty, Rselect0 => Rselect0,
    Rselect1 => Rselect1, WselectDecode => WselectDecode, WselectWriteBack => WselectWriteBack,
    decode_opType => decode_opType
  );
 
END ARCHITECTURE Hybrid;

