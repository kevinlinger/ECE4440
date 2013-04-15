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

ENTITY TopLevelWithRAM IS
 -- PORT(interrupt : IN std_logic);
PORT(interrupt, clock, reset : in std_logic;
     control : in std_logic_vector(4 downto 0);
     Debug_mux_out : out std_logic_vector(15 downto 0));
--    Debug_mux_control : in std_logic_vector(4 downto 0);
--    Debug_mux_out : OUT std_logic_vector(15 downto 0);
--	 RAMAddress : out std_logic_vector(23 downto 0);
 --   RAMreadEn, RAMwriteEn : out std_logic;
--    RAMReadData : in std_logic_vector(63 downto 0);
--    RAMWriteData : out std_logic_vector(63 downto 0);
--    RAMbyteEnable : out std_logic_vector(7 downto 0);
--    RAMAcknowledge : in std_logic);
END ENTITY TopLevelWithRAM;



--
ARCHITECTURE Structure OF TopLevelWithRAM IS
  
  --Debug Signals
  Signal Debug_Register_Dump: std_logic_vector(255 downto 0);
  Signal Debug_PC, Debug_Inst, Debug_DRAM_address : std_logic_vector(15 downto 0);
  SIGNAL  Debug_DRAM_data_return : std_logic_vector(63 downto 0);
  Signal Pre_Debug_Mux: std_logic_vector( 511 downto 0);
  
  Signal temp_RAMAddress : std_logic_vector(15 downto 0);
  
  
  signal IF_mem_data, IF_readAddress : std_logic_vector(15 downto 0);
  signal IF_jumpEnable, IF_memDelay : std_logic;
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
  signal IRAddress : std_logic_vector (15 DOWNTO 0);
  signal DHandshake, DREnable, DWEnable : std_logic;
  signal DAddress, DWData : std_logic_vector (15 DOWNTO 0);
  
   signal RAMREnable, RAMWEnable, RAMDelay : std_logic;
   signal RAMAddress, RAMWData : std_logic_vector (15 DOWNTO 0);
   signal RAMData : std_logic_vector (63 DOWNTO 0);
   
   signal fetchStateOut : std_logic_vector(2 downto 0);
   signal cache1StateOut, cache2StateOut : std_logic_vector(3 downto 0);
  
  signal DCacheDelay : std_logic;
  
   --signal clock, reset : std_logic;
  
  constant zero16 : std_logic_vector(15 DOWNTO 0) := (others => '0');
  
BEGIN

 --ClockGenerator : entity work.ClockGen(behavior)
 --  PORT MAP( Clock => clock, Reset => reset);

--RAMWData <= "000000000000000000000000000000000000000000000000";

MemStage : ENTITY WORK.MemStage(behavior)
  PORT MAP( addr => D_Dest_Reg, opType => D_Op_Type, aluData => E_ALU_Out, rData => M_rData,
    wEnable => M_wEnable, rEnable => M_rEnable, wBackEnable => M_WBackEnable,
    wBackData => M_wBackData, wBackAddr => M_wBackAddr);
    

RegisterFile : ENTITY WORK.RegisterFile(structure)
  PORT MAP( wAddr => M_wBackAddr, wData => M_wBackData, wEnable => (M_WBackEnable and (not IF_memDelay)),
    rAddr0 => D_RA0, rAddr1 => D_RA1, clock =>clock, RD0 => RF_RD0, RD1 => RF_RD1, Debug_Register_Dump => Debug_Register_Dump);


--Instruction_Mem : ENTITY WORK.easy_RAM_simu(behavior)
--  PORT MAP( rst => reset, hDIn => (others => '0'), wr => '0', hAddr => IF_maddr,
--    hDOut => IF_mem_data);


--Data_Mem : ENTITY WORK.easy_RAM_simu(behavior)
--  PORT MAP( rst => reset, hDIn => D_Extra, wr => M_wEnable, hAddr => E_ALU_Out, hDOut => M_rData);  
  
IF_stage : Entity WORK.Instruction_Fetch_Stage(Structural)
  PORT MAP(mem_data => IF_mem_data, readAddress => IF_readAddress, jumpAddress => E_ALU_Out,
    jumpEnable => IF_jumpEnable, reset => reset, interrupt => '0', clock => clock, memdelay => IF_memDelay,
    stall => DCacheDelay, Instruction => IF_Instruction, PCValue_output => IF_PCValue_output, maddr => IF_maddr, fetchStateOut => fetchStateOut);

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
 AddrIn => IF_maddr,
 DataIn => zero16,
 Read => '1',
 Write => '0',
 Handshake => IHandshake,
 clk => clock,
 reset => reset,
 RAMData => RAMData,
 AddrOut => IRAddress,
 DataReturn => IF_mem_data,
 ReadOut => IREnable,
 stall => IF_memDelay,
 cacheStateOut => cache1StateOut);
    
DCache : ENTITY work.Cache(structure)
PORT MAP(
 AddrIn => E_ALU_Out,
 DataIn => D_Extra,
 Read => M_rEnable and (not IF_memDelay),
 Write => M_wEnable and (not IF_memDelay),
 Handshake => DHandshake,
 clk => clock,
 reset => reset,
 RAMData => RAMData,
 AddrOut => DAddress,
 WriteDataOut => DWData,
 DataReturn => M_rData,
 WriteOut => DWEnable,
 ReadOut => DREnable,
 stall => DCacheDelay,
 cacheStateOut => cache2StateOut);
    
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
		Address => temp_RAMAddress,
		WData => RAMWData(15 downto 0),
		
		IHandshake => IHandshake,
		
		DHandshake => DHandshake,
		
		clock => clock);
		
	--RAMbyteEnable <= "11111111";
	
--	RAMAddress(23 DOWNTO 16) <= (others => '0');
--	RAMAddress(15 DOWNTO 0) <= Temp_RAMAddress;	
--RAM : ENTITY work.ram_delay(behavior)
--  PORT MAP(rst => reset,
--	  hDIn => RAMWData,
--	  wr => RAMWEnable,
--	  rd => RAMREnable,
--	  ack  => RAMDelay,
--	  hAddr => temp_RAMAddress,
--	  hDOut => RAMData);
    
--
--Debug Stuff
  --Debug_PC <= IF_PCValue_output; --0
  --Debug_Inst <= IF_Instruction; --1
--  Debug_DRAM_data_return <= RAMData; --2
--  Debug_DRAM_address <= Temp_RAMAddress; --3
  
  --Debug_Register_Dump is directly port mapped from the register file
      --control 16 - 31

--  Pre_Debug_Mux(15 downto 0) <= IF_PCValue_output;
--  Pre_Debug_Mux(31 downto 16) <= IF_Instruction;
--  Pre_Debug_Mux(47 downto 32) <= Debug_DRAM_address;
--  Pre_Debug_Mux(111 downto 48) <= Debug_DRAM_data_return;
--  Pre_Debug_Mux(127 downto 112) <= E_ALU_Out;
--  Pre_Debug_Mux(255 downto 128) <= (others => '0');
--  Pre_Debug_Mux(511 downto 256) <= Debug_Register_Dump;
  

--Debug_Mux_32 : ENTITY work.Mux_32_to_1(Behavior)
--generic MAP( width => 16)
--  PORT MAP(In_vector => Pre_Debug_Mux, control => control, out_line => Debug_Mux_out);       


Debug_Mux : entity work.FourOneMux(Behavior)
generic map (size => 16)
port map(a0 => IF_PCvalue_output, a1 => IF_Instruction, a2 => Debug_Register_Dump(15 downto 0), a3 => E_ALU_Out, c => control(1 downto 0), z => Debug_mux_out);
  
END ARCHITECTURE Structure;

