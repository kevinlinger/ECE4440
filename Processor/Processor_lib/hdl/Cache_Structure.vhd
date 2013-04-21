--
-- VHDL Architecture Processor_lib.Cache.Structure
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 18:06:50 02/27/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Cache IS
  Port(AddrIn, DataIn : in std_logic_vector(15 downto 0);
       Read, Write, Handshake, clk, reset : in std_logic;
       RAMData : in std_logic_vector(63 downto 0);
       AddrOut, WriteDataOut, DataReturn : out std_logic_vector(15 downto 0);
       cacheStateOut : out std_logic_vector(3 downto 0);
       WriteOut, ReadOut, stall : out std_logic);
END ENTITY Cache;

--
ARCHITECTURE Structure OF Cache IS
  
  signal TagLUTOut : std_logic_vector(11 downto 0);
  signal CacheBlock0Out : std_logic_vector(15 downto 0);
  signal CacheBlock1Out : std_logic_vector(15 downto 0);
  signal CacheBlock2Out : std_logic_vector(15 downto 0);
  signal CacheBlock3Out : std_logic_vector(15 downto 0);
  signal CacheBlock0In : std_logic_vector(15 downto 0);
  signal CacheBlock1In : std_logic_vector(15 downto 0);
  signal CacheBlock2In : std_logic_vector(15 downto 0);
  signal CacheBlock3In : std_logic_vector(15 downto 0);
  signal CompareMatch : std_logic;
  signal SRAMcontrol : std_logic;
  signal TagControl : std_logic;
  signal hit : std_logic;
  signal addressMuxControl : std_logic;
  
BEGIN
  
<<<<<<< HEAD
<<<<<<< HEAD
    TagBlock : entity work.TagLUTInit(Behavior)
      port map (clk => clk, we => TagControl , din(11) => '1', din(10 downto 0) => AddrIn(15 downto 5), addr => AddrIn(4 downto 2), dout => TagLUTOut);
 
=======
=======
>>>>>>> parent of d99609e... Changed TAG block write controls
    TagBlock : entity work.TagLUT(Structure)
      port map (clk => clk, we => TagControl or (Write and hit), din(11) => (Read or (not Write)), din(10 downto 0) => AddrIn(15 downto 5), addr => AddrIn(4 downto 2), dout => TagLUTOut);
      
>>>>>>> parent of d99609e... Changed TAG block write controls
    TagComparer : entity work.CacheComparer(Behavior)
    Generic Map(size => 11)
    Port map(InA => TagLUTOut(10 downto 0), InB => AddrIn(15 downto 5), match => CompareMatch);
   
    hit <= CompareMatch and TagLUTOut(11);
   
    CacheBlock0 : entity work.InstructionCacheInit1(Behavior)
    port map (clk => clk, we => SRAMcontrol or (Write and (not AddrIn(1)) and (not AddrIn(0)) and hit), din => CacheBlock0In, addr => AddrIn(4 downto 2), dout => CacheBlock0Out);     
    
    CacheBlock1 : entity work.InstructionCacheInit2(Behavior)
     port map (clk => clk, we => SRAMcontrol or (Write and (not AddrIn(1)) and AddrIn(0) and hit), din => CacheBlock1In, addr => AddrIn(4 downto 2), dout => CacheBlock1Out);
    
    CacheBlock2 : entity work.InstructionCacheInit3(Behavior)
     port map (clk => clk, we => SRAMcontrol or (Write and AddrIn(1) and (not AddrIn(0)) and hit), din => CacheBlock2In, addr => AddrIn(4 downto 2), dout => CacheBlock2Out);
    
    CacheBlock3 : entity work.InstructionCacheInit4(Behavior)
     port map (clk => clk, we => SRAMcontrol or (Write and AddrIn(1) and AddrIn(0) and hit), din => CacheBlock3In, addr => AddrIn(4 downto 2), dout => CacheBlock3Out);

--    CacheBlock0 : entity work.CacheMemory(Structure)
--    port map (clk => clk, we => SRAMcontrol or (Write and (not AddrIn(1)) and (not AddrIn(0)) and hit), din => CacheBlock0In, addr => AddrIn(4 downto 2), dout => CacheBlock0Out);     
--    
--    CacheBlock1 : entity work.CacheMemory(Structure)
--     port map (clk => clk, we => SRAMcontrol or (Write and (not AddrIn(1)) and AddrIn(0) and hit), din => CacheBlock1In, addr => AddrIn(4 downto 2), dout => CacheBlock1Out);
--    
--    CacheBlock2 : entity work.CacheMemory(Structure)
--     port map (clk => clk, we => SRAMcontrol or (Write and AddrIn(1) and (not AddrIn(0)) and hit), din => CacheBlock2In, addr => AddrIn(4 downto 2), dout => CacheBlock2Out);
--    
--    CacheBlock3 : entity work.CacheMemory(Structure)
--     port map (clk => clk, we => SRAMcontrol or (Write and AddrIn(1) and AddrIn(0) and hit), din => CacheBlock3In, addr => AddrIn(4 downto 2), dout => CacheBlock3Out);
--       
    CacheBlockOutMux : entity work.FourOneMux(Behavior)
    Generic Map (size => 16)
    Port Map ( a0 => CacheBlock0Out, a1 => CacheBlock1Out, a2 => CacheBlock2Out, a3 => CacheBlock3Out, c => AddrIn(1 downto 0), z => DataReturn);

    CacheBlockInMux0 : entity work.TwoOneMux(Behavior)
    Generic Map (size => 16)
    Port Map(a0 => DataIn, a1 => RamData(63 downto 48), c => SRAMcontrol, z => CacheBlock0In);

    CacheBlockInMux1 : entity work.TwoOneMux(Behavior)
    Generic Map (size => 16)
    Port Map(a0 => DataIn, a1 => RamData(47 downto 32), c => SRAMcontrol, z => CacheBlock1In);
      
    CacheBlockInMux2 : entity work.TwoOneMux(Behavior)
    Generic Map (size => 16)
    Port Map(a0 => DataIn, a1 => RamData(31 downto 16), c => SRAMcontrol, z => CacheBlock2In);
      
    CacheBlockInMux3 : entity work.TwoOneMux(Behavior)
    Generic Map (size => 16)
    Port Map(a0 => DataIn, a1 => RamData(15 downto 0), c => SRAMcontrol, z => CacheBlock3In);

    AddrOutMux : entity work.TwoOneMux(Behavior)
    Generic Map (size => 16)
    Port Map (a0(15 downto 2) => AddrIn(15 downto 2), a0(1 downto 0) => "00", a1 => AddrIn, c => Write, z => AddrOut);

  
    CacheSM : entity work.Cache_State_Machine(Behavioral)
    Port Map(read_from_proc => Read, write_from_proc => Write, hit => hit, arbiter_handshake => handshake, SRAM_control => SRAMcontrol, Tag_LUT_control => TagControl, stall => stall, 
             pre_address_mux_ctrl => addressMuxControl, read_to_arbiter => ReadOut, write_to_arbiter => WriteOut, clock => clk, reset => reset, AddrIn => AddrIn, cacheStateOut => cacheStateOut);
  
  
    WriteDataOut <= DataIn;

END ARCHITECTURE Structure;

