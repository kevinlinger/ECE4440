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
    RD0, RD1: OUT std_logic_vector (15 downto 0);
    done_on_cycle: OUT std_logic_vector(15 downto 0));
END ENTITY RegisterFile;

--
ARCHITECTURE Structure OF RegisterFile IS
  SIGNAL wDecodeOut, rDecodeOut0, rDecodeOut1: std_logic_vector (15 downto 0);

  signal inc0_stop_1: std_logic := '0';
  signal cycle_counter_input, cycle_counter_output : std_logic_vector(15 downto 0) := (others => '0');
  signal cycle_enable: std_logic := '1';
  
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
        PORT MAP (wData, wDecodeOut(i), rDecodeOut0(i), rDecodeOut1(i), clock, RD0, RD1);
  END GENERATE regArr;
  
  cycle_counter : ENTITY work.special_reg_init0(Behavior)
    generic map( size=> 16)
    port map(a => cycle_counter_input, b=> cycle_counter_output, c=> clock, e => cycle_enable);
  
  count_cycles : PROCESS(clock, cycle_counter_input, cycle_counter_output, wData, wAddr, wenable) is
  variable counter_in_as_unsigned: unsigned(15 downto 0) := (others => '0');
  BEGIN

--for fibonacci
    if(wData = "0110111111110001" and wAddr = "0000" and wenable ='1')
--for factorial
--    if(wData = "0000000001111000" and wAddr = "0000" and wenable ='1')

        then
      cycle_enable <= '0';
    else
      counter_in_as_unsigned := unsigned(cycle_counter_output) + 1;
      cycle_counter_input <= std_logic_vector(counter_in_as_unsigned);
    end if;
    
  end process;
  
END ARCHITECTURE Structure;

