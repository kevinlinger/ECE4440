--
-- VHDL Architecture Processor_lib.cacheFetchTopLevel.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 20:07:14 04/13/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY cacheFetchTopLevel IS
  port(clock, reset, handshake, jump : in std_logic;
       muxControl : in std_logic_vector(1 downto 0);
       muxOut : out std_logic_vector(15 downto 0));
END ENTITY cacheFetchTopLevel;

--
ARCHITECTURE Structure OF cacheFetchTopLevel IS
  
  signal stall : std_logic;
  signal IF_Instruction, IF_mem_data, IF_maddr, IF_PCValue_output, IF_readAddress, IRAddress : std_logic_vector(15 downto 0) := "0000000000000000";
  signal IREnable : std_logic;
  signal fetchStateOut : std_logic_vector(2 downto 0);
  signal cacheStateOut : std_logic_vector(3 downto 0);
 -- signal outSignals : std_logic_vector(15 downto 0);
  
BEGIN
  
  IF_stage : Entity WORK.Instruction_Fetch_Stage(Structural)
  PORT MAP(mem_data => IF_mem_data, readAddress => IF_readAddress, jumpAddress => "0000111100001111",
    jumpEnable => jump, reset => reset, interrupt => '0', clock => clock, memdelay => stall,
    stall => '0', Instruction => IF_Instruction, PCValue_output => IF_PCValue_output, maddr => IF_maddr, fetchStateOut => fetchStateOut);
    
   ICache : ENTITY work.Cache(structure)
 PORT MAP(
 AddrIn => IF_maddr,
 DataIn => "0000000000000000",
 Read => '1',
 Write => '0',
 Handshake => Handshake,
 clk => clock,
 reset => reset,
 RAMData => "0000000000000000000000000000000000000000000000000000000000000000",
 AddrOut => IRAddress,
 DataReturn => IF_mem_data,
 ReadOut => IREnable,
 stall => stall,
 cacheStateOut => cacheStateOut);
 
 debugMux : entity work.FourOneMux(Behavior)
 generic map( size => 16)
 port map(a0 =>IF_PCValue_output, a1=> IF_Instruction, a2 => IF_mem_data, a3(15 downto 12) => cacheStateOut, 
          a3(11 downto 9) => fetchStateOut, a3(0) => stall, a3(1) => reset, a3(2) => IREnable, a3(8 downto 3) => "000000",
          c => muxControl, z => muxOut);
 
  
END ARCHITECTURE Structure;

