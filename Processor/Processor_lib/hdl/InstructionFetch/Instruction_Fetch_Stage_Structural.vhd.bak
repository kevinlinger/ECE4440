--
-- VHDL Architecture Advanced_Digital_Design_lib.Instruction_Fetch_Stage.Structural
--
-- Created:
--          by - mew2ub.UNKNOWN (BCFRSJ1)
--          at - 20:38:06 02/ 4/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Instruction_Fetch_Stage IS
  Port( mem_data : IN std_logic_vector(15 downto 0);
    readAddress : OUT std_logic_vector(15 downto 0);
    jumpAddress : IN  std_logic_vector(15 downto 0);
    jumpEnable, reset, interrupt, clock, memdelay, D_cache_stall, downstream_stall : IN std_logic;
    Instruction, PCValue_output : OUT std_logic_vector(15 downto 0);
    maddr : OUT std_logic_vector(15 downto 0);
    bubble_pipeline_preDec : OUT std_logic);
    
END ENTITY Instruction_Fetch_Stage;

--
ARCHITECTURE Structural OF Instruction_Fetch_Stage IS

  signal PC_val : std_logic_vector(15 downto 0); --THIS IS AN INTERNAL SIGNAL, PCValue_output is the output of this stage
  signal MuxpreMaddr_ctrl, muxPrePC_ctrl, MuxPreInst_ctrl : std_logic_vector(1 downto 0);
  signal MuxPrePCValOut_ctrl : std_logic_vector(0 downto 0);
  
  signal PC_plus_one : std_logic_vector(15 downto 0);
  signal PC_in : std_logic_vector(15 downto 0);
  
  signal stall : std_logic;

BEGIN
  
  stall <= D_cache_stall or downstream_stall;
  bubble_pipeline_preDec <= memdelay;
  
  mux_pre_maddr : ENTITY work.Mux_4_to_1(Behavior)
  GENERIC MAP( width => 16)
  PORT MAP(line_0 => (others => '0'), line_1 => "0000000000000001", line_2 => PC_val, line_3 => (others => 'Z'),
        control => MuxpreMaddr_ctrl,  out_line => maddr);
 
  mux_pre_pc : ENTITY work.Mux_4_to_1(Behavior)
  GENERIC MAP( width => 16)
  PORT MAP(line_0 => mem_data, line_1 => jumpAddress, line_2 => PC_val, line_3 => PC_plus_one, out_line => PC_in,
  control => muxPrePC_ctrl);

  mux_pre_inst : ENTITY work.Mux_4_to_1(Behavior)
  GENERIC MAP( width => 16)
  PORT MAP(line_0 => mem_data, line_1 => (others => '0'), line_2 =>  (0 => '1', others => '0'),
    line_3 => (others => 'Z') , out_line => Instruction, control =>muxPreInst_ctrl);
    --note that the special instruction here is 0000....01
  
  mux_pre_PCval_output : ENTITY WORK.Mux_2_to_1(Behavior)
  GENERIC MAP( width => 16)
  --PORT MAP(line_0 => PC_val, line_1 => jumpAddress, control => MuxPrePCvalOut_ctrl(0), out_line => PCValue_output);
  PORT MAP(line_0 => PC_val, line_1 => jumpAddress, control => MuxPrePCvalOut_ctrl(0), out_line => PCValue_output);
  
  
  PC : ENTITY work.Reg(Behavior)
  GENERIC MAP(size => 16)
  PORT MAP(  A => PC_in, B => PC_val, c => clock, e => '1');
  
  
  SM : ENTITY work.IF_State_Machine(Behavior)
  PORT MAP( clock => clock, jump => jumpEnable, int => interrupt, reset => reset, mdelay => memdelay,
    stall => stall, MuxPrePC_ctrl => muxPrePC_ctrl, MuxpreMaddr_ctrl => MuxpreMaddr_ctrl,
    MuxPreInst_ctrl => muxPreInst_ctrl, MuxPrePCVal_ctrl => muxprePCvalOut_ctrl(0));
    
  incrementer : Process(PC_val) is
      VARIABLE temp_unsigned : unsigned(15 downto 0);
      BEGIN
        temp_unsigned := unsigned(PC_val);
        temp_unsigned := temp_unsigned + 1;
        PC_plus_one <= conv_std_logic_vector( temp_unsigned, 16);
        
    end Process;    
END ARCHITECTURE Structural;

