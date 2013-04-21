library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

ENTITY ExecuteStage IS
  PORT (
    ALU0, ALU1, Extra : IN std_logic_vector (15 DOWNTO 0);
    ALU_Ctrl : IN std_logic_vector(2 DOWNTO 0);
    Op_Type : IN std_logic_vector(8 DOWNTO 0);    
    IF_memDelay : IN std_logic;
    
    Branch_Inst : IN std_logic_vector(3 DOWNTO 0);
    Downstream_stall : IN std_logic;
    
    Branch_Ctrl : OUT std_logic;
	  upstream_stall : OUT std_logic;
	  ALU_Out : OUT std_logic_vector(15 DOWNTO 0);
	  bubble_pipeline_preMem : OUT std_logic;
	
    clock : IN std_logic);
END ENTITY ExecuteStage;

ARCHITECTURE behavior OF ExecuteStage IS
  SIGNAL conzIn, conzOut : std_logic_vector (3 DOWNTO 0);
  --CONSTANT enable : std_logic := '1';
  signal cc_enable : std_logic;
  signal cc_enable_checked_for_nops : std_logic;
  signal temp_branch_ctrl : std_logic;
BEGIN
    
    --Execute causes a stall if it is outputing a taken branch and sees an IF_memDelay 
    
     branch_ctrl <= temp_branch_ctrl;
    
    Decide_if_stalled :PROCESS(Downstream_stall, IF_memDelay, temp_branch_ctrl) IS
    BEGIN
      if(Downstream_stall = '1') then
       cc_enable <= '0';
       upstream_stall <= '1';
       bubble_pipeline_preMem <= '0';
        elsif( IF_memDelay = '1' and temp_branch_ctrl = '1') then
         cc_enable <= '0';
         upstream_stall <= '1';
         bubble_pipeline_preMem <= '1';
        else
        cc_enable <= '1';
          upstream_stall <= '0';
          bubble_pipeline_preMem <='0';
        end if;
    end process decide_if_stalled;
    
    
    check_cc_enable_for_nops : PROCESS(cc_enable, Op_Type) is
    BEGIN
    if(Op_Type(0) = '1') then
     cc_enable_checked_for_nops <= '0';
   else
    cc_enable_checked_for_nops <= cc_enable;
   END IF;
  END PROCESS;
        
    ccReg : ENTITY work.reg(behavior)
      GENERIC MAP (size => 4)
      PORT MAP(conzIn, conzOut, clock, cc_enable_checked_for_nops);
  
    PROCESS (ALU0, ALU1, ALU_Ctrl, Op_Type, Branch_Inst, clock)
      VARIABLE branchInstrNor, andC, andO, andN, andZ, jump : std_logic;
      VARIABLE tempResult : std_logic_vector (15 DOWNTO 0);
      VARIABLE testCarry : unsigned (16 DOWNTO 0) := (others => '0');
      VARIABLE testCarryLeft : unsigned (16 DOWNTO 0) := (others => '0');
      VARIABLE testCarryRight : unsigned (16 DOWNTO 0) := (others => '0');
      CONSTANT zero16 : std_logic_vector(15 DOWNTO 0) := (others => '0');
	  CONSTANT zero : std_logic := '0';
    BEGIN
		
		IF(Op_Type(0) = '1') THEN --nop
			ALU_Out <= zero16;
			temp_branch_ctrl <= zero;
			
		ELSIF(Op_Type(1) = '1') THEN --load
			ALU_Out <= unsigned(ALU0) + unsigned(ALU1);
			temp_branch_ctrl <= zero;
			
		ELSIF(Op_Type(2) = '1') THEN --store
			ALU_Out <= unsigned(ALU0) + unsigned(ALU1);
			temp_branch_ctrl <= zero;
			
		ELSIF(Op_Type(3) = '1') THEN --mov
			ALU_Out <= ALU1;
			temp_branch_ctrl <= zero;
			
		ELSIF(Op_Type(4) = '1') THEN --li
			ALU_Out <= Extra;
			temp_branch_ctrl <= zero;
			
		ELSIF(Op_Type(5) = '1') THEN --arith
			IF(ALU_Ctrl = "000") THEN --add
				tempResult := signed(ALU0) + signed(ALU1);

				ALU_Out <= tempResult(15 DOWNTO 0);

				IF(tempResult(15 DOWNTO 0) = zero16) THEN
					conzIn(0) <= '1';
				ELSE
					conzIn(0) <= '0';
				END IF;

				conzIn(1) <= tempResult(15);
				
				IF( (ALU0(15) = ALU1(15)) and (tempResult(15) /= ALU1(15)) ) THEN
					conzIn(2) <= '1';          
				ELSE
					conzIn(2) <= '0';
				END IF;
				
				testCarryLeft(15 DOWNTO 0) := unsigned(ALU0);
				testCarryRight(15 DOWNTO 0) := unsigned(ALU1);
				testCarry := testCarryLeft + testCarryRight;
				IF(testCarry(16) = '1') THEN
					conzIn(3) <= '1';
				ELSE
					conzIn(3) <= '0';
				END IF;
			
			ELSIF(ALU_Ctrl = "001") THEN --adc
				tempResult := signed(ALU0) + signed(ALU1) + conzOut(3);

				ALU_Out <= tempResult(15 DOWNTO 0);

				IF(tempResult(15 DOWNTO 0) = zero16) THEN
					conzIn(0) <= '1';
				ELSE
					conzIn(0) <= '0';
				END IF;

				conzIn(1) <= tempResult(15);
				
				IF( (ALU0(15) = ALU1(15)) and (tempResult(15) /= ALU1(15)) ) THEN
					conzIn(2) <= '1';          
				ELSE
					conzIn(2) <= '0';
				END IF;
				
				testCarryLeft(15 DOWNTO 0) := unsigned(ALU0);
				testCarryRight(15 DOWNTO 0) := unsigned(ALU1);
				testCarry := testCarryLeft + testCarryRight + conzOut(3);
				IF(testCarry(16) = '1') THEN
					conzIn(3) <= '1';
				ELSE
					conzIn(3) <= '0';
				END IF;
			
			ELSIF(ALU_Ctrl = "010") THEN --sub
				tempResult := signed(ALU0) - signed(ALU1);

				ALU_Out <= tempResult(15 DOWNTO 0);

				IF(tempResult(15 DOWNTO 0) = zero16) THEN
					conzIn(0) <= '1';
				ELSE
					conzIn(0) <= '0';
				END IF;

				conzIn(1) <= tempResult(15);
				
				IF( (ALU0(15) = ALU1(15)) and (tempResult(15) /= ALU1(15)) ) THEN
					conzIn(2) <= '1';          
				ELSE
					conzIn(2) <= '0';
				END IF;
				
				testCarryLeft(15 DOWNTO 0) := unsigned(ALU0);
				testCarryRight(15 DOWNTO 0) := unsigned(ALU1);
				testCarry := testCarryLeft - testCarryRight;
				IF(testCarry(16) = '1') THEN
					conzIn(3) <= '1';
				ELSE
					conzIn(3) <= '0';
				END IF;
			
			ELSIF(ALU_Ctrl = "011") THEN --sbc
				tempResult := signed(ALU0) - signed(ALU1) + conzOut(3) - 1;

				ALU_Out <= tempResult(15 DOWNTO 0);

				IF(tempResult(15 DOWNTO 0) = zero16) THEN
					conzIn(0) <= '1';
				ELSE
					conzIn(0) <= '0';
				END IF;

				conzIn(1) <= tempResult(15);
				
				IF( (ALU0(15) = ALU1(15)) and (tempResult(15) /= ALU1(15)) ) THEN
					conzIn(2) <= '1';          
				ELSE
					conzIn(2) <= '0';
				END IF;
				
				testCarryLeft(15 DOWNTO 0) := unsigned(ALU0);
				testCarryRight(15 DOWNTO 0) := unsigned(ALU1);
				testCarry := testCarryLeft - testCarryRight + conzOut(3) - 1;
				IF(testCarry(16) = '1') THEN
					conzIn(3) <= '1';
				ELSE
					conzIn(3) <= '0';
				END IF;
			
			ELSIF(ALU_Ctrl = "100") THEN --and
				ALU_Out <= ALU0 AND ALU1;
			
			ELSIF(ALU_Ctrl = "101") THEN --or
				ALU_Out <= ALU0 OR ALU1;
			
			ELSIF(ALU_Ctrl = "110") THEN --xor
				ALU_Out <= ALU0 XOR ALU1;
			
			ELSIF(ALU_Ctrl = "111") THEN --not
				ALU_Out <= NOT ALU1; 
			
			END IF;
			
			temp_branch_ctrl <= zero;
			
		ELSIF(Op_Type(6) = '1') THEN --shift
			IF (ALU_Ctrl = "000") THEN --sl
				tempResult(15 DOWNTO 1) := ALU1(14 DOWNTO 0);
				tempResult(0) := '0';
				ALU_Out <= tempResult(15 DOWNTO 0);
			
			ELSIF (ALU_Ctrl = "001") THEN --srl
				tempResult(14 DOWNTO 0) := ALU1(15 DOWNTO 1);
				tempResult(15) := '0';
				ALU_Out <= tempResult(15 DOWNTO 0);
			
			ELSIF (ALU_Ctrl = "010") THEN --sra
				tempResult(15) := ALU1(15);
				tempResult(14 DOWNTO 0) := ALU1(15 DOWNTO 1);
				ALU_Out <= tempResult(15 DOWNTO 0);
			
			ELSIF (ALU_Ctrl = "110") THEN --rra
				conzIn(3) <= ALU1(0);
				tempResult(14 DOWNTO 0) := ALU1(15 DOWNTO 1);
				tempResult(15) := ALU1(15);
				ALU_Out <= tempResult(15 DOWNTO 0);
			
			ELSIF (ALU_Ctrl = "101") THEN --rr
				tempResult(15) := conzOut(3);
				tempResult(14 DOWNTO 0) := ALU1(15 DOWNTO 1);
				conzIn(3) <= ALU1(0);
				ALU_Out <= tempResult(15 DOWNTO 0);
			
			ELSIF (ALU_Ctrl = "100") THEN --rl
				tempResult(15 DOWNTO 1) := ALU1(14 DOWNTO 0);
				tempResult(0) := conzOut(3);
				conzIn(3) <= ALU1(15);
				ALU_Out <= tempResult(15 DOWNTO 0);
			
			END IF;
			
			temp_branch_ctrl <= zero;
			
		ELSIF(Op_Type(7) = '1') THEN --branch
			branchInstrNor := NOT(Branch_Inst(3) OR Branch_Inst(2) OR Branch_Inst(1) OR Branch_Inst(0));
			andC := Branch_Inst(3) AND conzOut(3);
			andO := Branch_Inst(2) AND conzOut(2);
			andN := Branch_Inst(1) AND conzOut(1);
			andZ := Branch_Inst(0) AND conzOut(0);
			
			jump := branchInstrNor OR andC OR andO OR andN OR andZ OR (NOT(Op_Type(8)));
			
			ALU_Out <= signed(ALU0)+ signed(ALU1);
			temp_branch_ctrl <= jump;		
			
		END IF;
    END PROCESS;
END ARCHITECTURE;

