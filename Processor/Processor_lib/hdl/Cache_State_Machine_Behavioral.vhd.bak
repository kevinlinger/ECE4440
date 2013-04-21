--
-- VHDL Architecture Advanced_Digital_Design_lib.Cache_State_Machine.Behavioral
--
-- Created:
--          by - mew2ub.UNKNOWN (BCFRSJ1)
--          at - 20:39:46 02/27/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Cache_State_Machine IS
  PORT( read_from_proc, write_from_proc, hit : IN  std_logic;
    arbiter_handshake : IN std_logic;
    AddrIn : IN std_logic_vector(15 downto 0);
    SRAM_control, Tag_LUT_control : OUT std_logic;
    stall : OUT std_logic;
    pre_address_mux_ctrl : out std_logic; --IMPORTANT!!! I assume InAddress is line '0' and * is line '1'.
    read_to_arbiter, write_to_arbiter : out std_logic;
    clock, reset : IN std_logic);
    
    
    
    --SRAM_CONTROL
    --functions as a write enable to be set to 1 on load misses once we have the data ready
    
    --Tag_LUT_control
    --functions as write enable to be set to 1 on the arcs back to ready state
    
    
END ENTITY Cache_State_Machine;

--
ARCHITECTURE Behavioral OF Cache_State_Machine IS
  TYPE state IS (ready, store, load_miss, reset_state);
    signal current_state, next_state : state;
    
  BEGIN
    determine_next_state : Process( clock, reset, read_from_proc, write_from_proc, hit, arbiter_handshake, AddrIn) IS
      BEGIN
            
      --READY
      if( current_state = ready)
      then
        
        if(reset = '1')
        then
            next_state <= reset_state;
        else
          if(read_from_proc='1')
          then
              if(hit ='1')
              then
                next_state <= ready;
              else
                next_state <= load_miss;
              end if;
          else
            if(write_from_proc = '1')
            then 
                next_state <= store;
            else
            next_state <= ready;   
            end if;       
          end if;
        end if;
      end if;
        
      
      
      --STORE
      if(current_state = store)
      then
        
        
        if(reset = '1')
        then
          next_state <= reset_state;
        else
          if(arbiter_handshake = '0')
          then
            next_state <= store;
          else
            next_state <= ready;
          end if;      
        end if;      
      end if;
      
      
      --LOAD_MISS
      if(current_state = load_miss)
      then
         
         if(reset = '1')
         then
           next_state <= reset_state;
         else
           if(arbiter_handshake = '0')
           then
             next_state <= load_miss;
           else
             next_state <= ready;
           end if;
         end if;        
      end if;
      
      --RESET
      if(current_state = reset_state)
      then
        
        if(reset = '1')
        then
          next_state <= reset_state;
        else
          next_state <= ready;
        end if;
      end if;  

      
      END PROCESS determine_next_state;
  
  
    determine_output : Process(clock, reset, read_from_proc, write_from_proc, hit, arbiter_handshake, AddrIn) IS
      BEGIN
        --Note that the conditions for this process are copied from determine_next_state 
        --TODO
        
        --READY
      if( current_state = ready)
      then
        
        if(reset = '1')
        then
            --next_state <= reset_state;
            SRAM_control <= '0';
            Tag_LUT_control <= '0';
            stall <= '0';
            pre_address_mux_ctrl <= '0';
            read_to_arbiter <= '0';
            write_to_arbiter <= '0';
        else
          if(read_from_proc='1')
          then
              if(hit ='1')
              then
                --next_state <= ready;
                SRAM_control <= '0';
                Tag_LUT_control <= '0';
                stall <= '0';
                pre_address_mux_ctrl <= '0';
                read_to_arbiter <= '0';
                write_to_arbiter <= '0';
              else
                --next_state <= load_miss;
                SRAM_control <= '0';
                Tag_LUT_control <= '0';
                stall <= '1';
                pre_address_mux_ctrl <= '1';
                read_to_arbiter <= '1';
                write_to_arbiter <= '0';
              end if;
          elsif(write_from_proc = '1')
            then 
                --next_state <= store;
                SRAM_control <= '0';
                Tag_LUT_control <= '0';
                stall <= '1';
                pre_address_mux_ctrl <= '0';
                read_to_arbiter <= '0';
                write_to_arbiter <= '1';
 
                  else
                        SRAM_control <= '0';
                Tag_LUT_control <= '0';
                stall <= '0';
                pre_address_mux_ctrl <= '0';
                read_to_arbiter <= '0';
                write_to_arbiter <= '0';               
          end if;
        end if;
        

      end if;
      
        
        --STORE
      if(current_state = store)
      then
        if(reset = '1')
        then
          --next_state <= reset_state;
          SRAM_control <= '0';
          Tag_LUT_control <= '0';
          stall <= '0';
          pre_address_mux_ctrl <= '0';
          read_to_arbiter <= '0';
          write_to_arbiter <= '0';
        else
          if(arbiter_handshake = '0')
          then
            --next_state <= store;
            SRAM_control <= '0';
            Tag_LUT_control <= '0';
            stall <= '1';
            pre_address_mux_ctrl <= '0';
            read_to_arbiter <= '0';
            write_to_arbiter <= '1';
          else
            --next_state <= ready;
            SRAM_control <= '0';
            Tag_LUT_control <= '0';
            stall <= '0';
            pre_address_mux_ctrl <= '0';
            read_to_arbiter <= '0';
            write_to_arbiter <= '0';
          end if;      
        end if;      
      end if;  
 
 
      --LOAD_MISS
      if(current_state = load_miss)
      then
         
         if(reset = '1')
         then
           --next_state <= reset_state;
           SRAM_control <= '0';
           Tag_LUT_control <= '0';
           stall <= '0';
           pre_address_mux_ctrl <= '0';
           read_to_arbiter <= '0';
           write_to_arbiter <= '0';
         else
           if(arbiter_handshake = '0')
           then
             --next_state <= load_miss;
             SRAM_control <= '0';
             Tag_LUT_control <= '0';
             stall <= '1';
             pre_address_mux_ctrl <= '1';
             read_to_arbiter <= '1';
             write_to_arbiter <= '0';
           else
             --next_state <= ready;
             SRAM_control <= '1';
             Tag_LUT_control <= '1';
             stall <= '1';
             pre_address_mux_ctrl <= '0';
             read_to_arbiter <= '0';
             write_to_arbiter <= '0';
           end if;
         end if;        
      end if;

      --RESET
      if(current_state = reset_state)
      then
        
        if(reset = '1')
        then
          --next_state <= reset_state;
          SRAM_control <= '0';
          Tag_LUT_control <= '0';
          stall <= '0';
          pre_address_mux_ctrl <= '0';
          read_to_arbiter <= '0';
          write_to_arbiter <= '0';
        else
          --next_state <= ready;
          SRAM_control <= '0';
          Tag_LUT_control <= '0';
          stall <= '0';
          pre_address_mux_ctrl <= '0';
          read_to_arbiter <= '0';
          write_to_arbiter <= '0';
        end if;
      end if;  
 
      END PROCESS determine_output;
  
    update_new_state : PROCESS(clock) IS
      BEGIN
        IF rising_edge(clock) THEN
         current_state <= next_state;
        END IF;
      END PROCESS update_new_state;
    
    
END ARCHITECTURE Behavioral;

