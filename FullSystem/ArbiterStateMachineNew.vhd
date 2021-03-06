LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY Processor_lib;
USE Processor_lib.All;

ENTITY ArbiterStateMachineNew IS
	PORT(
		RAMAck : IN std_logic;	
		IRAddress : IN std_logic_vector (15 DOWNTO 0);
		IREnable : IN std_logic;	
		DWEnable, DREnable : IN std_logic;
		DAddress : IN std_logic_vector (15 DOWNTO 0);
		DWData : IN std_logic_vector (15 DOWNTO 0);	
		REnable, WEnable : OUT std_logic;
		Address : OUT std_logic_vector (26 DOWNTO 0);
		WData : OUT std_logic_vector (63 DOWNTO 0);	
		IHandshake : OUT std_logic;	
		DHandshake : OUT std_logic;
		byteEnable : out std_logic_vector(7 downto 0);
		ackReset, ackEnable : out std_logic;
		clock : IN std_logic;
		CurrentState, NextState : OUT std_logic_vector (2 DOWNTO 0)
	);
END ENTITY ArbiterStateMachineNew;

ARCHITECTURE Behavior OF ArbiterStateMachineNew IS
	TYPE state IS (state_idle, state_dr, state_dw, state_ir, state_iack, state_dack);
	SIGNAL current_state, next_state : state := state_idle;
	
	BEGIN
  
  Address(26 downto 17) <= "0000000000";
  Address(2 downto 0) <= "000";
  
		update_new_state : PROCESS (clock)
		BEGIN
			IF rising_edge(clock) THEN
				current_state <= next_state;
			END IF;
		END PROCESS;
		
		determine_next_state : PROCESS (current_state, IREnable, DREnable, DWEnable, RAMAck)
		BEGIN
			IF (current_state = state_idle) THEN
				IF (IREnable = '1' AND DREnable = '0' AND DWEnable = '0') THEN
					next_state <= state_ir;
				ELSIF (DREnable = '1') THEN
					next_state <= state_dr;
				ELSIF (DWEnable = '1') THEN
					next_state <= state_dw;
				ELSE
					next_state <= state_idle;
				END IF;
			ELSIF (current_state = state_dr) THEN
				IF (RAMAck = '1') THEN
					next_state <= state_dack;
				ELSIF (RAMAck = '0') THEN
					next_state <= state_dr;
				ELSE
				  next_state <= state_idle;
				END IF;
			ELSIF (current_state = state_dw) THEN
				IF (RAMAck = '1') THEN
					next_state <= state_dack;
--				ELSIF(RAMDelay = '0' and IREnable = '0') THEN
--					next_state <= state_idle;
--				ELSIF(RAMDelay = '0' and IREnable = '1') THEN
--				  next_state <= state_ir;
        ELSIF(RAMAck = '0') then
          next_state <= state_dw;
        ELSE
          next_state <= state_idle;
				END IF;
			ELSIF (current_state = state_ir) THEN
				IF (RAMAck = '1') THEN
					next_state <= state_iack;
				ELSIF(RAMAck = '0') THEN
					next_state <= state_ir;
				ELSE
				  next_state <= state_idle;
				END IF;
			ELSIF (current_state = state_iack) then
			   next_state <= state_idle;
			ELSIF (current_state = state_dack) then
			   next_state <= state_idle;
			ELSE
			  next_state <= state_idle;
			END IF;
		END PROCESS;
		
		update_outputs: PROCESS (current_state, IREnable, DREnable, DWEnable, RAMAck)
		BEGIN
			IF (current_state = state_idle) THEN
				REnable <= '0';
				WEnable <= '0';
				DHandshake <= '0';
				IHandshake <= '0';
				byteEnable <= "00000000";
				ackReset <= '1';
				ackEnable <= '0';
				
			ELSIF (current_state = state_dr) THEN
				Address(16 downto 3) <= DAddress(15 downto 2);
				REnable <= '1';
				WEnable <= '0';
				IHandshake <= '0';
        DHandshake <= '0';       
				byteEnable <= "11111111";
        ackReset <= '0';
				ackEnable <= '1';
				
			ELSIF (current_state = state_dw) THEN
				Address(16 downto 3) <= DAddress(15 downto 2);
				REnable <= '0';
				WEnable <= '1';	
				IHandshake <= '0';
				DHandshake <= '0';
        ackReset <= '0';
      		ackEnable <= '1';
      					
				IF(Daddress(1 downto 0) = "00") then
				  WData(63 downto 16) <= "000000000000000000000000000000000000000000000000";
				  WData(15 downto 0) <= DWData;
			    ByteEnable <= "00000011";
			    
			  ELSIF(Daddress(1 downto 0) = "01") then
				  WData(63 downto 32) <= "00000000000000000000000000000000";
				  WData(31 downto 16) <= DWData;
				  WData(15 downto 0) <= "0000000000000000";
			    ByteEnable <= "00001100";
			    
			  ELSIF(Daddress(1 downto 0) = "10") then
				  WData(31 downto 0) <= "00000000000000000000000000000000";
				  WData(47 downto 32) <= DWData;
				  WData(63 downto 48) <= "0000000000000000";
			    ByteEnable <= "00110000";
			    
			  	ELSIF(Daddress(1 downto 0) = "11") then
				  WData(63 downto 48) <= DWData;
		      WData(47 downto 0) <= "000000000000000000000000000000000000000000000000";
			    ByteEnable <= "11000000";
			    
			  ELSE
			    WData(63 downto 16) <= "000000000000000000000000000000000000000000000000";
				  WData(15 downto 0) <= DWData;
			    ByteEnable <= "00000011";
			    
			   END IF;
			    
			ELSIF (current_state = state_ir) THEN
				Address(16 downto 3) <= IRAddress(15 downto 2);
				REnable <= '1';
				WEnable <= '0';
				DHandshake <= '0';
				IHandshake <= '0';			
				byteEnable <= "11111111";
        ackReset <= '0';
        ackEnable <= '1';
        		
			ELSIF (current_state = state_iack) then
			  Address(16 downto 3) <= IRAddress(15 downto 2);
				REnable <= '1';
				WEnable <= '0';
				DHandshake <= '0';
				IHandshake <= '1';
    				byteEnable <= "11111111";
    				ackReset <= '0';
    				ackEnable <= '0';


    ELSIF (current_state = state_dack) then
    				Address(16 downto 3) <= DAddress(15 downto 2);
				WEnable <= '0';
				IHandshake <= '0';
        DHandshake <= '1';
    				byteEnable <= "11111111";
        ackReset <= '0';
        ackEnable <= '0';
                
   ELSE  
    				REnable <= '0';
				WEnable <= '0';
				DHandshake <= '0';
				IHandshake <= '0';
        byteEnable <= "00000000";
        ackReset <= '0';
        ackEnable <= '0';
        				
	 END IF;

		END PROCESS;
		
					WITH current_state SELECT
				CurrentState <= "001" WHEN state_idle,
								        "010" WHEN state_dr,
								        "011" WHEN state_dw,
								        "100" WHEN state_ir,
								        "101" WHEN state_iack,
								        "110" WHEN state_dack,
								        "111" WHEN OTHERS;
								
			WITH next_state SELECT
				NextState <= "001" WHEN state_idle,
								        "010" WHEN state_dr,
								        "011" WHEN state_dw,
								        "100" WHEN state_ir,
								        "101" WHEN state_iack,
								        "110" WHEN state_dack,
								        "111" WHEN OTHERS;
END ARCHITECTURE Behavior;