--
-- VHDL Architecture Processor_lib.TopLevel.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-ULTRABOOK)
--          at - 13:06:17 02/ 8/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY TopLevel IS
  --PORT(clock, reset, interrupt : IN std_logic);
  PORT(interrupt : in std_logic);
END ENTITY TopLevel;



--
ARCHITECTURE Structure OF TopLevel IS
  
  signal IF_mem_data, IF_readAddress : std_logic_vector(15 downto 0);
  signal IF_jumpEnable : std_logic;
  signal IF_Instruction, IF_PCValue_output, IF_maddr : std_logic_vector(15 downto 0);
  
  signal D_RA0, D_RA1, D_Dest_Reg : std_logic_vector(3 downto 0);
  signal D_Op0, D_Op1, D_Extra : std_logic_vector(15 downto 0);
  signal D_ALU_Control : std_logic_vector(2 downto 0);
  signal D_Op_Type : std_logic_vector(8 downto 0);
  
  signal E_ALU_Out : std_logic_vector(15 downto 0);
  
  signal RF_RD0, RF_RD1 : std_logic_vector(15 downto 0);
  
  signal M_rData : std_logic_vector(15 downto 0);
  signal M_wEnable, M_rEnable, M_WBackEnable : std_logic;
  signal M_wBackData: std_logic_vector (15 downto 0);
  signal M_wBackAddr : std_logic_vector(3 downto 0);
  
  signal IHandshake, IREnable : std_logic;
  signal DHandshake, DREnable, DWEnable : std_logic;
  
  signal RAMREnable, RAMWEnable : std_logic;
  
  signal clock, reset : std_logic;
  
BEGIN

ClockGenerator : entity work.ClockGen(behavior)
  PORT MAP( Clock => clock, Reset => reset);

MemStage : ENTITY WORK.MemStage(behavior)
  PORT MAP( addr => D_Dest_Reg, opType => D_Op_Type, aluData => E_ALU_Out, rData => M_rData,
    wEnable => M_wEnable, rEnable => M_rEnable, wBackEnable => M_WBackEnable,
    wBackData => M_wBackData, wBackAddr => M_wBackAddr);
    

RegisterFile : ENTITY WORK.RegisterFile(structure)
  PORT MAP( wAddr => M_wBackAddr, wData => M_wBackData, wEnable => M_WBackEnable,
    rAddr0 => D_RA0, rAddr1 => D_RA1, clock =>clock, RD0 => RF_RD0, RD1 => RF_RD1);


Instruction_Mem : ENTITY WORK.easy_RAM_simu(behavior)
  PORT MAP( rst => reset, hDIn => (others => '0'), wr => '0', hAddr => IF_maddr,
    hDOut => IF_mem_data);


Data_Mem : ENTITY WORK.easy_RAM_simu(behavior)
  PORT MAP( rst => reset, hDIn => D_Extra, wr => M_wEnable, hAddr => E_ALU_Out, hDOut => M_rData);  
  
IF_stage : Entity WORK.Instruction_Fetch_Stage(Structural)
  PORT MAP(mem_data => IF_mem_data, readAddress => IF_readAddress, jumpAddress => E_ALU_Out,
    jumpEnable => IF_jumpEnable, reset => reset, interrupt => '0', clock => clock, memdelay => '0',
    stall => '0', Instruction => IF_Instruction, PCValue_output => IF_PCValue_output, maddr => IF_maddr);

DecodeStage : ENTITY WORK.DecodeStage(Structure)
  PORT MAP( Instruction => IF_Instruction, PCValue => IF_PCValue_output, RD0 => RF_RD0, RD1 => RF_RD1,
    RA0 => D_RA0, RA1 => D_RA1, Dest_Reg => D_Dest_Reg, Op0 => D_Op0, Op1 => D_Op1, Extra => D_Extra,
    ALU_Control => D_ALU_Control, Op_Type => D_Op_Type); 
  
ExecuteStage : ENTITY WORK.ExecuteStage(behavior)
  PORT MAP( ALU0 => D_Op0, ALU1 => D_Op1, Extra => D_Extra, ALU_Ctrl => D_ALU_Control,
    Op_Type => D_Op_Type, ALU_Out => E_ALU_Out, Branch_Inst => D_Dest_Reg, Branch_Ctrl => IF_JumpEnable,
    clock => clock);
    
ICache : ENTITY work.Cache(structure)
 PORT MAP(
 AddrIn
 DataIn : in std_logic_vector(15 downto 0);
 Read, 
 Write, 
 Handshake, 
 clk, 
 reset : in std_logic;
 RAMData : in std_logic_vector(63 downto 0);
 AddrOut, 
 WriteDataOut, 
 DataReturn : out std_logic_vector(15 downto 0);
 WriteOut, 
 ReadOut, 
 stall : out std_logic);
    
DCache : ENTITY work.Cache(structure)
  PORT MAP();
    
MemoryArbiter : ENTITY work.ArbiterStateMachine(behavior)
  PORT MAP(RAMDelay : IN std_logic;
		
		IRAddress : IN std_logic_vector (15 DOWNTO 0);
		IREnable => IREnable;
		
		DWEnable => DWEnable;
		DREnable => DREnable;
		DAddress : IN std_logic_vector (15 DOWNTO 0);
		DWData : IN std_logic_vector (15 DOWNTO 0);
		
		REnable => RAMREnable;
		WEnable => RAMWEnable;
		Address : OUT std_logic_vector (15 DOWNTO 0);
		WData : OUT std_logic_vector (15 DOWNTO 0);
		
		IHandshake => IHandshake;
		
		DHandshake => DHandshake;
		
		clock => clock);

END ARCHITECTURE Structure;

