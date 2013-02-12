--
-- VHDL Architecture Advanced_Digital_Design_lib.Controler.Behavioral
--
-- Created:
--          by - mew2ub.UNKNOWN (BCFRSJ1)
--          at - 23:37:14 02/ 5/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--

 LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY IF_State_Machine IS
  PORT (  clock, jump, int, reset, mdelay, stall : IN std_logic;
    MuxPrePC_ctrl, MuxPreMAddr_ctrl, MuxPreInst_ctrl : OUT std_logic_vector( 1 downto 0);--Control vector
    MuxPrePCVal_ctrl : OUT std_logic);
  
END ENTITY IF_State_Machine;

  Architecture Behavior of IF_State_Machine IS
    TYPE state IS (run, interrupt, reset_state);
      signal current_state, next_state : state;
  BEGIN
    determine_next_state :  Process(int, reset, mdelay, stall,clock) 
    BEGIN
      
    --Run state
    if(current_state = run) then
      if(int = '1' and reset = '0') then
        next_state <= interrupt; -- interrupt
      end if;
      if(reset = '1') then
        next_state <= reset_state; -- reset
      end if;
    end if;

    -- Interrupt state
    if (current_state = interrupt) then
      if(mdelay = '1' or stall = '1') then
        next_state <= interrupt; -- interrupt
      end if;
      if(reset = '1') then
        next_state <= reset_state; -- reset
      end if;
      if(not (mdelay = '1' or stall = '1') ) then
        next_state <= run; -- run
      end if;
    end if;
    
    -- Reset state
    if(current_state = reset_state) then
      if(mdelay = '1' or reset = '1') then
        next_state <= reset_state; -- reset
      else
        next_state <= run; --run
      end if;
    end if;
     
  END PROCESS determine_next_state;
    
    update_new_state : PROCESS(clock) IS
    BEGIN
    if rising_edge(clock)  then
      current_state <= next_state;
    end if;
  end PROCESS update_new_state;
    
    
    output_control : PROCESS(current_state, jump, stall, mdelay) IS
    BEGIN
     
      if(current_state = run) then
 
       --jump
        if(jump = '1') then
        MuxPrePC_ctrl <= "01"; --JAddr
        MuxPreMaddr_ctrl <= "10"; -- PCregister_value (but I believe this is a don't care)
        MuxPreInst_ctrl <= "00"; -- (make nop when pipelined) run normally in single cycle
        MuxPrePCVal_ctrl <= '1'; -- JAddr       
        end if; 
        
        --run normally
        if(jump = '0' and mdelay = '0' and stall = '0') then       
        MuxPrePC_ctrl <= "11"; --PC + 1
        MuxPreMaddr_ctrl <= "10"; -- PCregister_value (don't care)
        MuxPreInst_ctrl <= "00"; -- Mdata
        MuxPrePCVal_ctrl <= '0'; -- PCregister_value
        end if;
      
        --mdelay
        if(jump = '0' and mdelay = '1') then
        MuxPrePC_ctrl <= "10"; --PC
        MuxPreMaddr_ctrl <= "10"; -- PCregister_value (don't care)
        MuxPreInst_ctrl <= "01"; -- nop
        MuxPrePCVal_ctrl <= '0'; -- PCregister_value 
        end if;
        
         --stall
        if(jump = '0' and stall = '1') then
        MuxPrePC_ctrl <= "10"; --PC
        MuxPreMaddr_ctrl <= "10"; -- PCregister_value (don't care)
        MuxPreInst_ctrl <= "01"; -- nop (don't care)
        MuxPrePCVal_ctrl <= '0'; -- PCregister_value
        end if;      
      end if;
      
      
      --Interrupt
      IF(current_state = interrupt) then
        MuxPrePC_ctrl <= "00"; --Mdata
        MuxPreMaddr_ctrl <= "01"; -- The 'one' value
        MuxPreInst_ctrl <= "10"; -- the special instruction
        MuxPrePCVal_ctrl <= '0'; -- PCregister_value (don't care)           
      end if;
      
      --Reset
      IF(current_state = reset_state) then
        MuxPrePC_ctrl <= "00"; --Mdata
        MuxPreMaddr_ctrl <= "00"; -- The 'zero' value
        MuxPreInst_ctrl <= "01"; -- nop
        MuxPrePCVal_ctrl <= '0'; -- PCregister_value (don't care)           
      end if;

    end process output_control;
    
  END Architecture Behavior;


