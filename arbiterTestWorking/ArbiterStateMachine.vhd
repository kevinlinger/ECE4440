LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ArbiterStateMachine IS
	PORT(
		RAMAcknowledge : IN std_logic;
		
		IRAddress : IN std_logic_vector (15 DOWNTO 0);
		IREnable : IN std_logic;
		
		DWEnable, DREnable : IN std_logic;
		DAddress : IN std_logic_vector (15 DOWNTO 0);
		DWData : IN std_logic_vector (15 DOWNTO 0);
		
		REnable, WEnable : OUT std_logic;
		Address : OUT std_logic_vector (26 DOWNTO 0);
		WData : OUT std_logic_vector (63 DOWNTO 0);
		ByteEnable : OUT std_logic_vector(7 DOWNTO 0);
		
		IHandshake : OUT std_logic;
		
		DHandshake : OUT std_logic;

		CurrentState, NextState : OUT std_logic_vector (1 DOWNTO 0);
		
		clock : IN std_logic
	);
END ENTITY ArbiterStateMachine;

ARCHITECTURE Behavior OF ArbiterStateMachine IS
	TYPE state IS (state_idle, state_dr, state_dw, state_ir);
	SIGNAL current_state, next_state : state := state_idle;
	CONSTANT WData0Extend : std_logic_vector(47 DOWNTO 0) := (others => '0');
	CONSTANT Address0Extend : std_logic_vector(10 DOWNTO 0) := (others => '0');
	CONSTANT AddressDoubleWordAlign : std_logic_vector(2 DOWNTO 0) := "000";
	BEGIN
	
		update_new_state : PROCESS (clock)
		BEGIN
			IF rising_edge(clock) THEN
				current_state <= next_state;
			END IF;
		END PROCESS;
		
		determine_next_state : PROCESS (current_state, IREnable, DREnable, DWEnable, RAMAcknowledge)
		BEGIN
			IF (current_state = state_idle) THEN
				IF (IREnable = '1' AND DREnable /= '1' AND DWEnable /= '1') THEN
					next_state <= state_ir;
				ELSIF (DREnable = '1') THEN
					next_state <= state_dr;
				ELSIF (DWEnable = '1') THEN
					next_state <= state_dw;
				ELSE
					next_state <= state_idle;
				END IF;
			ELSIF (current_state = state_dr) THEN
				IF (RAMAcknowledge = '0') THEN
					next_state <= state_dr;
				ELSIF (RAMAcknowledge = '1') THEN
					next_state <= state_idle;
				ELSE
					next_state <= state_dr;
				END IF;
			ELSIF (current_state = state_dw) THEN
				IF (RAMAcknowledge = '0') THEN
					next_state <= state_dw;
				ELSIF(RAMAcknowledge = '1' and IREnable = '0') THEN
					next_state <= state_idle;
				ELSIF(RAMAcknowledge = '1' and IREnable = '1') THEN
				  next_state <= state_ir;
				ELSE
					next_state <= state_dw;
				END IF;
			ELSIF (current_state = state_ir) THEN
				IF (RAMAcknowledge = '0') THEN
					if(next_state <= state_idle) then
						next_state <= state_idle;
					else
						next_state <= state_ir;
					end if;
				ELSIF(RAMAcknowledge = '1') THEN
					next_state <= state_idle;
				ELSE
					next_state <= state_ir;
				END IF;
				
			ELSE
				next_state <= state_idle;
			END IF;
		END PROCESS;
		
		update_outputs: PROCESS (current_state, IREnable, DREnable, DWEnable, RAMAcknowledge, IRAddress, DAddress)
		BEGIN
			IF (current_state = state_idle) THEN
				REnable <= '0';
				WEnable <= '0';
				DHandshake <= '0';
				IHandshake <= '0';
				ByteEnable <= "00000000";
				Address <= (others => '0');
				WData <= (others => '0');
			ELSIF (current_state = state_dr) THEN
				--Address <= Address0Extend & DAddress;
				Address <= Address0Extend & DAddress (15 DOWNTO 3) & AddressDoubleWordAlign;
				REnable <= '1';
				WEnable <= '0';
				ByteEnable <= "11111111";
				
				IHandshake <= '0';
				IF(RAMAcknowledge = '0') THEN
					DHandshake <= '0';
				ELSIF (RAMAcknowledge = '1') THEN
					DHandshake <= '1';
					--REnable <= '0';
				ELSE
					DHandshake <= '0';
				END IF;
			ELSIF (current_state = state_dw) THEN
				--Address <= Address0Extend & DAddress;
				Address <= Address0Extend & DAddress (15 DOWNTO 3) & AddressDoubleWordAlign;
				WData <= WData0Extend & DWData;
				REnable <= '0';
				WEnable <= '1';
				ByteEnable <= "11111111";
				
				IHandshake <= '0';
				IF(RAMAcknowledge = '0') THEN
					DHandshake <= '0';
				ELSIF (RAMAcknowledge = '1' and IREnable = '0') THEN
					DHandshake <= '1';
					--WEnable <= '0';
				ELSE 
					DHandshake <= '0';
				END IF;
			ELSIF (current_state = state_ir) THEN
				--Address <= Address0Extend & IRAddress;
				Address <= Address0Extend & IRAddress (15 DOWNTO 3) & AddressDoubleWordAlign;
				REnable <= '1';
				WEnable <= '0';
				ByteEnable <= "11111111";
				
				--DHandshake <= '0';
				IF(RAMAcknowledge = '0') THEN
					IHandshake <= '0';
				ELSIF (RAMAcknowledge = '1') THEN
				--	REnable <= '0';
					IF(DWEnable = '1') THEN
						DHandshake <= '1';
					ELSE
					END IF;
					IHandshake <= '1';
				ELSE
					IHandshake <= '0';
				END IF;
			ELSE
				REnable <= '0';
				WEnable <= '0';				
			END IF;
		END PROCESS;
		
			WITH current_state SELECT
				CurrentState <= "00" WHEN state_idle,
								        "01" WHEN state_dr,
								        "10" WHEN state_dw,
								        "11" WHEN state_ir,
								        "XX" WHEN OTHERS;
								
			WITH next_state SELECT
				NextState <= "00" WHEN state_idle,
				             "01" WHEN state_dr,
  					           "10" WHEN state_dw,
					           "11" WHEN state_ir,
					           "XX" WHEN OTHERS;
	
END ARCHITECTURE behavior;