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

bridgeLOL : qsysOUt
port map(clk_clk => CLOCK_50, reset_reset_n => not(SW(17)), bridge_0_external_interface_acknowledge => bridgeAck, 
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


arb : entity work.ArbiterStateMachineNew(Behavior)
port map(RAMAck => latchAck, IRAddress(15 downto 8) => "00000000", IRAddress(7 downto 0) => sw(7 downto 0), IRenable => not(key(3)), DWEnable =>(not(key(2))), 
			DREnable => (not(key(1))), DAddress(15 downto 2) => "00000000000000", DAddress(1 downto 0) => sw(13 downto 12), DWData => "1111000011110000", 
			REnable => arbRead, WEnable => arbWrite, Address => arbAddress, byteEnable => arbByteEnable,
			WData => arbData, IHandshake => LEDG(7), DHAndshake => LEDG(6), clock => key(0), currentState => LEDG(5 downto 3), nextState => LEDG(2 downto 0), 
			ackReset => arbReset, ackEnable => arbEnable);
			

--LOLlatch : entity work.FlipFlopNew(Behavior)
--port map(a => kthx, b => latchAck, clk => (bridgeAck or (not(kthx))), en => '1');

ackLatch : entity work.FlipFlopNew(Behavior)
port map(clk => bridgeAck, d => '1', en => arbEnable, rst => arbReset, q => latchAck);
		
dataLatch : entity work.VarRegister(Behavior)
generic map( size => 64)	
port map(a => readData, b => latchRead, clk => cloCK_50, en => bridgeAck );


ledmux : entity work.FourOneMux(Behavior)
generic map(size => 16)
port map(a0 => latchRead(15 downto 0), a1 => latchRead(31 downto 16), a2 => latchRead(47 downto 32), a3 => arbAddress(16 downto 1), c => sw(9 downto 8), z => LEDR(15 downto 0));

LEDG(8) <= latchAck;
LEDR(17) <= arbRead;
LEDR(16) <= arbWrite;

end Structure;