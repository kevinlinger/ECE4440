library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;

entity bitTest is
port(

	CLOCK_50 : in std_logic;
	CLOCK2_50 : in std_logic;
	CLOCK3_50 : in std_logic;


	LEDG : out std_logic_vector(8 downto 0);
	LEDR : out std_logic_vector(17 downto 0);


	KEY : in std_logic_vector(3 downto 0);

	SW : in std_logic_vector(17 downto 0);


	DRAM_ADDR : out std_LOGIC_VECTOR (12 downto 0);
	DRAM_BA : out std_LOGIC_VECTOR (1 downto 0);
	DRAM_CAS_N : out std_logic;
	DRAM_CKE : out std_logic;
	DRAM_CLK : out std_logic;
	DRAM_CS_N : out std_logic;
	DRAM_DQ : inout std_logic_vector(31 downto 0);
	DRAM_DQM : out std_logic_vector(3 downto 0);
	DRAM_RAS_N : out std_logic;
	DRAM_WE_N : out std_logic;

	GPIO : inout std_logic_vector(35 downto 0)
);

end entity bitTest;

architecture Structure of bitTest is

  
  --Debug Signals
  Signal Debug_Register_Dump: std_logic_vector(255 downto 0);
  Signal Debug_PC, Debug_Inst, Debug_DRAM_address : std_logic_vector(15 downto 0);
  SIGNAL  Debug_DRAM_data_return : std_logic_vector(63 downto 0);
  Signal Pre_Debug_Mux: std_logic_vector( 511 downto 0);
  
 
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
  
  signal IHandshake, IREnable : std_logic := '0';
  signal IRAddress : std_logic_vector (15 DOWNTO 0);
  signal DHandshake, DREnable, DWEnable : std_logic;
  signal DAddress, DWData : std_logic_vector (15 DOWNTO 0);
 
  signal ledgmuxin0, ledgmuxin1, ledgmuxin2, ledgmuxin3 : std_logic_vector(7 downto 0);
 
  signal DCacheDelay : std_logic;
  
  signal clock, reset : std_logic;
  
  constant zero16 : std_logic_vector(15 DOWNTO 0) := (others => '0');


--Arbiter only
signal bridgeAck : std_logic;
signal kthx : std_logic;
signal readData : std_logic_vector(63 downto 0);
signal latchRead : std_LOGIC_VECTOR(63 downto 0);
signal latchAck : std_logic;
signal arbRead, arbWrite : std_logic;
signal arbData : std_logic_vector(63 downto 0);
signal arbAddress : std_logic_vector(26 downto 0);
signal arbByteEnable : std_logic_Vector(7 downto 0);
signal arbReset, arbEnable : std_logic;

component qsysOut 
port(
		reset_reset_n : in std_logic;
		clk_clk : in std_logic;
		sdram_0_wire_addr : out std_logic_vector(11 downto 0);
		sdram_0_wire_ba : out std_logic_vector(1 downto 0);
		sdram_0_wire_cas_n : out std_logic;
		sdram_0_wire_cke : out std_logic;
		sdram_0_wire_cs_n : out std_logic;
		sdram_0_wire_dq : inout std_logic_vector(31 downto 0);
		sdram_0_wire_dqm : out std_logic_vector(3 downto 0);
		sdram_0_wire_ras_n : out std_logic;
		sdram_0_wire_we_n : out std_logic;
		bridge_0_external_interface_address : in std_logic_vector(26 downto 0);
		bridge_0_external_interface_byte_enable : in std_logic_vector(7 downto 0);
		bridge_0_external_interface_read : in std_logic;
		bridge_0_external_interface_write : in std_logic;
		bridge_0_external_interface_write_data : in std_logic_vector(63 downto 0);
		bridge_0_external_interface_acknowledge : out std_logic;
		bridge_0_external_interface_read_data : out std_logic_vector(63 downto 0);
		up_clocks_0_sdram_clk_clk : out std_logic
);
end component;

begin

clock <= key(0);
reset <= sw(17);

MemStage : ENTITY WORK.MemStage(behavior)
  PORT MAP( addr => D_Dest_Reg, opType => D_Op_Type, aluData => E_ALU_Out, rData => M_rData,
    wEnable => M_wEnable, rEnable => M_rEnable, wBackEnable => M_WBackEnable,
    wBackData => M_wBackData, wBackAddr => M_wBackAddr);
    

RegisterFile : ENTITY WORK.RegisterFile(structure)
  PORT MAP( wAddr => M_wBackAddr, wData => M_wBackData, wEnable => (M_WBackEnable and (not IF_memDelay)),
    rAddr0 => D_RA0, rAddr1 => D_RA1, clock =>clock, RD0 => RF_RD0, RD1 => RF_RD1, Debug_Register_Dump => Debug_Register_Dump);

IF_stage : Entity WORK.Instruction_Fetch_Stage(Structural)
  PORT MAP(mem_data => IF_mem_data, readAddress => IF_readAddress, jumpAddress => E_ALU_Out,
    jumpEnable => IF_jumpEnable, reset => reset, interrupt => '0', clock => clock, memdelay => IF_memDelay,
    stall => DCacheDelay, Instruction => IF_Instruction, PCValue_output => IF_PCValue_output, maddr => IF_maddr, fetchStateOut => ledgmuxin3(2 downto 0));

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
 RAMData => latchRead,
 AddrOut => IRAddress,
 DataReturn => IF_mem_data,
 ReadOut => IREnable,
 stall => IF_memDelay,
 cacheStateOut => ledgmuxin1(7 downto 4));
    
DCache : ENTITY work.Cache(structure)
PORT MAP(
 AddrIn => E_ALU_Out,
 DataIn => D_Extra,
 Read => M_rEnable and (not IF_memDelay),
 Write => M_wEnable and (not IF_memDelay),
 Handshake => DHandshake,
 clk => clock,
 reset => reset,
 RAMData => latchRead,
 AddrOut => DAddress,
 WriteDataOut => DWData,
 DataReturn => M_rData,
 WriteOut => DWEnable,
 ReadOut => DREnable,
 stall => DCacheDelay,
 cacheStateOut => ledgmuxin1(3 downto 0));

 ledgmuxin2(0) <= DREnable;
 ledgmuxin2(1) <= DWEnable;
 ledgmuxin2(2) <= IREnable;
 ledgmuxin2(3) <= DCacheDelay;
 ledgmuxin2(4) <= IF_memDelay;
 ledgmuxin2(5) <= IHandshake;
 ledgmuxin2(6) <= DHandshake;
-- arb : entity work.ArbiterStateMachineNew(Behavior)
--port map(RAMAck => latchAck, IRAddress(15 downto 8) => "00000000", IRAddress(7 downto 0) => sw(7 downto 0), IRenable => not(key(3)), DWEnable =>(not(key(2))), 
--			DREnable => (not(key(1))), DAddress(15 downto 2) => "00000000000000", DAddress(1 downto 0) => sw(13 downto 12), DWData => "1111000011110000", 
--			REnable => arbRead, WEnable => arbWrite, Address => arbAddress, byteEnable => arbByteEnable,
--			WData => arbData, IHandshake => LEDG(7), DHAndshake => LEDG(6), clock => key(0), currentState => LEDG(5 downto 3), nextState => LEDG(2 downto 0), 
--			ackReset => arbReset, ackEnable => arbEnable);
			
arb : entity work.ArbiterStateMachineNew(Behavior)
port map(RAMAck => latchAck, IRAddress => IRAddress, IRenable => IREnable, DWEnable => DWEnable, 
			DREnable => DREnable, DAddress => DAddress, DWData => DWData, 
			REnable => arbRead, WEnable => arbWrite, Address => arbAddress, byteEnable => arbByteEnable,
			WData => arbData, IHandshake => IHandshake, DHAndshake => DHandshake, clock => clock, currentState => LEDGmuxin0(5 downto 3), nextState => LEDGmuxin0(2 downto 0), 
			ackReset => arbReset, ackEnable => arbEnable);

bridgeLOL : qsysOUt
port map(clk_clk => CLOCK_50, reset_reset_n => '1', bridge_0_external_interface_acknowledge => bridgeAck, 
			--bridge_0_external_interface_address(26 downto 16) => "00000000000",
			--bridge_0_external_interface_address(15 downto 0) => arbAddress,
			bridge_0_external_interface_address => arbAddress,
			--bridge_0_external_interface_byte_enable(7 downto 2) => "111111", bridge_0_external_interface_byte_enable(1 downto 0) => sw(11 downto 10),
			bridge_0_external_interface_byte_enable => arbByteEnable,
			--bridge_0_external_interface_byte_enable => "11111111",
			bridge_0_external_interface_read_data => readData, bridge_0_external_interface_read => arbRead,
			--bridge_0_external_interface_write_data(63 downto 16) => "111100001111111001010101101010100000111100110011", bridge_0_external_interface_write_data(15 downto 0) => arbData(15 downto 0),
			bridge_0_external_interface_write_data => arbData,
			bridge_0_external_interface_write=> arbWrite, 
			sdram_0_wire_addr => DRAM_ADDR(11 downto 0), 
			sdram_0_wire_ba => DRAM_BA, sdram_0_wire_cas_n => DRAM_CAS_N, sdram_0_wire_cke => DRAM_CKE, 
			sdram_0_wire_cs_n => DRAM_CS_N, sdram_0_wire_dq => DRAM_DQ, sdram_0_wire_dqm => DRAM_DQM,
			sdram_0_wire_ras_n => DRAM_RAS_N, sdram_0_wire_we_n => DRAM_WE_N, up_clocks_0_sdram_clk_clk => DRAM_CLK);

DRAM_ADDR(12) <= '0';
--LEDG(7) <= bridgeAck;
--kthx <= arbRead or arbWrite;
--kthx <= ((not(key(3))) or (not(key(2))) or (not(key(1))));



			

--LOLlatch : entity work.FlipFlopNew(Behavior)
--port map(a => kthx, b => latchAck, clk => (bridgeAck or (not(kthx))), en => '1');

ackLatch : entity work.FlipFlopNew(Behavior)
port map(clk => bridgeAck, d => '1', en => arbEnable, rst => arbReset, q => latchAck);
		
dataLatch : entity work.VarRegister(Behavior)
generic map( size => 64)	
port map(a => readData, b => latchRead, clk => cloCK_50, en => bridgeAck );


--ledmux : entity work.FourOneMux(Behavior)
--generic map(size => 16)
--port map(a0 => latchRead(15 downto 0), a1 => latchRead(31 downto 16), a2 => latchRead(47 downto 32), a3 => arbAddress(16 downto 1), c => sw(9 downto 8), z => LEDR(15 downto 0));

ledmux : entity work.Mux_16_to_1(Behavior)
generic map(size => 16)
port map(a => IF_PCValue_output, b => IF_Instruction, c => Debug_Register_Dump(15 downto 0), d => latchRead(15 downto 0), 
			e => latchRead(31 downto 16), f => latchRead(47 downto 32), g => latchRead(63 downto 48), 
			h => IF_mem_data, i => E_ALU_Out, j => IRAddress, k => arbAddress(16 downto 1), sel => sw(3 downto 0), z => LEDR(15 downto 0));

gledmux : entity work.FourOneMux(Behavior)
generic map(size => 8)
port map(a0 => ledgmuxin0, a1 => ledgmuxin1, a2 => ledgmuxin2, a3 => ledgmuxin3 , c => sw(13 downto 12), z => LEDG(7 downto 0));

LEDG(8) <= latchAck;
LEDR(17) <= arbRead;
LEDR(16) <= arbWrite;

end Structure;