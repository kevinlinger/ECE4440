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
  signal IF_jumpEnable, IF_memDelay : std_logic;
  signal IF_Instruction, IF_PCValue_output, IF_maddr : std_logic_vector(15 downto 0);
  
  signal pipeline_IF_Instruction, pipeline_IF_PCValue_output : std_logic_vector(15 downto 0);
  
  signal D_RA0, D_RA1, D_Dest_Reg : std_logic_vector(3 downto 0);
  signal D_Op0, D_Op1, D_Extra : std_logic_vector(15 downto 0);
  signal D_ALU_Control : std_logic_vector(2 downto 0);
  signal D_Op_Type : std_logic_vector(8 downto 0);
  
  signal pre_E_pipeline_D_Dest_Reg : std_logic_vector(3 downto 0);
  signal pre_E_pipeline_D_Op0, pre_E_pipeline_D_Op1, pre_E_pipeline_D_Extra : std_logic_vector(15 downto 0);
  signal pre_E_pipeline_D_ALU_Control : std_logic_vector(2 downto 0);
  signal pre_E_pipeline_D_Op_Type : std_logic_vector(8 downto 0);
  
  
  signal E_ALU_Out : std_logic_vector(15 downto 0);
  
  signal RF_RD0, RF_RD1 : std_logic_vector(15 downto 0);
  
  signal pre_M_pipeline_D_Dest_Reg : std_logic_vector(3 downto 0);
  signal pre_M_pipeline_D_Op_Type : std_logic_vector(8 downto 0);
  signal pre_M_pipeline_E_ALU_Out : std_logic_vector(15 downto 0);
  --addr => pre_M_pipeline_D_Dest_Reg, opType => pre_M_pipeline_D_Op_Type, aluData => pre_M_pipeline_E_ALU_Out
  --addr => D_Dest_Reg, opType => D_Op_Type, aluData => E_ALU_Out, rData => M_rData,
  
  signal M_rData : std_logic_vector(15 downto 0);
  signal M_wEnable, M_rEnable, M_WBackEnable : std_logic;
  signal M_wBackData: std_logic_vector (15 downto 0);
  signal M_wBackAddr : std_logic_vector(3 downto 0);
  
  signal Pre_WB_pipeline_M_WBackEnable : std_logic;
  signal Pre_WB_pipeline_M_wBackData : std_logic_vector (15 downto 0);
  signal Pre_WB_pipeline_M_wBackAddr : std_logic_vector(3 downto 0);
  
  
  signal IHandshake, IREnable : std_logic;
  signal IRAddress : std_logic_vector (15 DOWNTO 0);
  signal DHandshake, DREnable, DWEnable : std_logic;
  signal DAddress, DWData : std_logic_vector (15 DOWNTO 0);
  
  signal RAMREnable, RAMWEnable, RAMDelay : std_logic;
  signal RAMAddress, RAMWData : std_logic_vector (15 DOWNTO 0);
  signal RAMData : std_logic_vector (63 DOWNTO 0);
  
  signal DCacheDelay : std_logic;
  
  --RStation
  signal decode_stall_toUpstream, dirty : std_logic;
  
  signal mem_stall_toUpstream, exe_stall_toUpstream : std_logic;
  signal bubble_preWB_pipeline, bubble_pipeline_preExe, bubble_pipeline_preDec, bubble_pipeline_preMem : std_logic;
  signal exe_kill : std_logic;
  
  signal clock, reset : std_logic;
  
  constant zero16 : std_logic_vector(15 DOWNTO 0) := (others => '0');
  
BEGIN

ClockGenerator : entity work.ClockGen(behavior)
  PORT MAP( Clock => clock, Reset => reset);


--Instruction_Mem : ENTITY WORK.easy_RAM_simu(behavior)
--  PORT MAP( rst => reset, hDIn => (others => '0'), wr => '0', hAddr => IF_maddr,
--    hDOut => IF_mem_data);


--Data_Mem : ENTITY WORK.easy_RAM_simu(behavior)
--  PORT MAP( rst => reset, hDIn => D_Extra, wr => M_wEnable, hAddr => E_ALU_Out, hDOut => M_rData);  
  
IF_stage : Entity WORK.Instruction_Fetch_Stage(Structural)
  PORT MAP(mem_data => IF_mem_data, readAddress => IF_readAddress, jumpAddress => E_ALU_Out,
    jumpEnable => IF_jumpEnable, reset => reset, interrupt => '0', clock => clock, memdelay => IF_memDelay,
    d_cache_stall => DCacheDelay, downstream_stall => decode_stall_toUpstream, Instruction => IF_Instruction, PCValue_output => IF_PCValue_output, maddr => IF_maddr,
    bubble_pipeline_preDec => bubble_pipeline_preDec
    );

Pipeline_Reg_preDecode : ENTITY Work.Pipeline_Reg_PreDecode(Behavioral)
  PORT MAP( Instruction => IF_Instruction, PCValue => IF_PCValue_output,
    out_Instruction => pipeline_IF_Instruction, out_PCValue => pipeline_IF_PCValue_output,
    clock => clock, enable => ( not decode_stall_toUpstream),
    bubble => bubble_pipeline_preDec 
     );


DecodeStage : ENTITY WORK.DecodeStage(Structure)
  PORT MAP( Instruction => pipeline_IF_Instruction, PCValue => pipeline_IF_PCValue_output, RD0 => RF_RD0, RD1 => RF_RD1,
    RA0 => D_RA0, RA1 => D_RA1, Dest_Reg => D_Dest_Reg, Op0 => D_Op0, Op1 => D_Op1, Extra => D_Extra,
    ALU_Control => D_ALU_Control, Op_Type => D_Op_Type, downstream_stall => exe_stall_toUpstream, dirty => dirty, bubble_pipeline_preExe => bubble_pipeline_preExe,
     upstream_stall => decode_stall_toUpstream); 
  

Pipeline_Reg_preExecute : ENTITY Work.Pipeline_Reg_PreExecute(Behavioral)
  PORT MAP(
    ALU0 => D_Op0, ALU1 => D_Op1, Extra => D_Extra, ALU_Ctrl => D_ALU_Control,
    Op_Type => D_Op_Type, Branch_Inst => D_Dest_Reg,
    
    out_ALU0 => pre_E_pipeline_D_Op0, out_ALU1 => pre_E_pipeline_D_Op1, out_Extra => pre_E_pipeline_D_Extra, out_ALU_Ctrl => pre_E_pipeline_D_ALU_Control,
    out_Op_Type => pre_E_pipeline_D_Op_Type, out_Branch_Inst => pre_E_pipeline_D_Dest_Reg,
    
    clock => clock, enable => (not exe_stall_toUpstream), kill => IF_JumpEnable, --kill has precedence over enable
    bubble => bubble_pipeline_preExe
  
  );
 
  
ExecuteStage : ENTITY WORK.ExecuteStage(behavior)
  PORT MAP( ALU0 => pre_E_pipeline_D_Op0, ALU1 => pre_E_pipeline_D_Op1, Extra => pre_E_pipeline_D_Extra, ALU_Ctrl => pre_E_pipeline_D_ALU_Control,
    Op_Type => pre_E_pipeline_D_Op_Type, ALU_Out => E_ALU_Out, Branch_Inst => pre_E_pipeline_D_Dest_Reg, Branch_Ctrl => IF_JumpEnable,
    clock => clock, downstream_stall => mem_stall_toUpstream, upstream_stall => exe_stall_toUpstream, IF_memDelay => IF_memDelay,
    bubble_pipeline_preMem => bubble_pipeline_preMem);



Pipeline_Reg_preMem : ENTITY WORK.Pipeline_Reg_PreMem(Behavioral)
  PORT MAP(
    addr => pre_E_pipeline_D_Dest_Reg, opType => pre_E_pipeline_D_Op_Type, aluData => E_ALU_Out,
    
    out_addr => pre_M_pipeline_D_Dest_Reg, out_opType => pre_M_pipeline_D_Op_Type, out_aluData => pre_M_pipeline_E_ALU_Out,
    
    clock => clock, enable => (not mem_stall_toUpstream),
    bubble => '0' --EXE never causes a stall
  );


 --MUST BUBBLE THE PREMEM REGISTER
 MemStage : ENTITY WORK.MemStage(behavior)
  PORT MAP( addr => pre_M_pipeline_D_Dest_Reg, opType => pre_M_pipeline_D_Op_Type, aluData => pre_M_pipeline_E_ALU_Out, rData => M_rData,
    wEnable => M_wEnable, rEnable => M_rEnable, wBackEnable => M_WBackEnable, Dcache_stall =>DCacheDelay,  mem_stall_toUpstream => mem_stall_toUpstream, 
    wBackData => M_wBackData, wBackAddr => M_wBackAddr, bubble_preWB_pipeline => bubble_preWB_pipeline);
    

Pipeline_Reg_PreWB : ENTITY WORK.pipeline_Reg_PreWB(Behavioral)
  PORT MAP( M_WBackEnable => M_WBackEnable, wBackData => M_wBackData, wBackAddr => M_wBackAddr,
    
    out_M_WBackEnable => Pre_WB_pipeline_M_WBackEnable, out_wBackData => Pre_WB_pipeline_M_wBackData, out_wBackAddr => Pre_WB_pipeline_M_wBackAddr,
    
    clock => clock, enable => '1', --WB never stalls
    bubble => bubble_preWB_pipeline
  );

    
RegisterFile : ENTITY WORK.RegisterFile(structure)
  PORT MAP( wAddr => Pre_WB_pipeline_M_wBackAddr, wData => Pre_WB_pipeline_M_wBackData, wEnable => Pre_WB_pipeline_M_WBackEnable,
    rAddr0 => D_RA0, rAddr1 => D_RA1, clock =>clock, RD0 => RF_RD0, RD1 => RF_RD1);

Reservation_Station : ENTITY WORK.Full_Reservation_Station(Hybrid)
  PORT MAP( clock => clock, reset => reset, wb_enabled => Pre_WB_pipeline_M_WBackEnable, decode_stalled => decode_stall_toUpstream, Rselect0addr => D_RA0, Rselect1addr => D_RA1,
    Wselectaddr => D_Dest_Reg, WselectWriteBackaddr => Pre_WB_pipeline_M_wBackAddr , dirty => dirty, decode_opType => D_Op_Type
  );

    
ICache : ENTITY work.Cache(structure)
 PORT MAP(
 AddrIn => IF_maddr,
 DataIn => zero16,
 Read => '1',
 Write => '0',
 Handshake => IHandshake,
 clk => clock,
 reset => '0',
 RAMData => RAMData,
 AddrOut => IRAddress,
 DataReturn => IF_mem_data,
 ReadOut => IREnable,
 stall => IF_memDelay);
    
DCache : ENTITY work.Cache(structure)
PORT MAP(
 AddrIn => E_ALU_Out,
 DataIn => D_Extra,
 Read => M_rEnable and (not IF_memDelay),
 Write => M_wEnable and (not IF_memDelay),
 Handshake => DHandshake,
 clk => clock,
 reset => '0',
 RAMData => RAMData,
 AddrOut => DAddress,
 WriteDataOut => DWData,
 DataReturn => M_rData,
 WriteOut => DWEnable,
 ReadOut => DREnable,
 stall => DCacheDelay);
    
MemoryArbiter : ENTITY work.ArbiterStateMachine(behavior)
  PORT MAP(RAMDelay => NOT(RAMDelay),
		
		IRAddress => IRAddress,
		IREnable => IREnable,
		
		DWEnable => DWEnable,
		DREnable => DREnable,
		DAddress => DAddress,
		DWData => DWData,
		
		REnable => RAMREnable,
		WEnable => RAMWEnable,
		Address => RAMAddress,
		WData => RAMWData,
		
		IHandshake => IHandshake,
		
		DHandshake => DHandshake,
		
		clock => clock);
		
RAM : ENTITY work.ram_delay(behavior)
  PORT MAP(rst => reset,
	  hDIn => RAMWData,
	  wr => RAMWEnable,
	  rd => RAMREnable,
	  ack  => RAMDelay,
	  hAddr => RAMAddress,
	  hDOut => RAMData);
    

END ARCHITECTURE Structure;

