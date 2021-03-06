--
-- VHDL Architecture Processor_lib.SimpleProcessorTest.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVIN-PC)
--          at - 00:39:10 04/ 7/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY SimpleProcessorTest IS
  port(clock, reset : in std_logic;
       control : in std_logic_vector(5 downto 0);
       dataReturn : in std_logic_vector(63 downto 0);
       address : out std_logic_vector(5 downto 0);
       byteEnable : out std_logic_vector(7 downto 0);
       writeData : out std_logic_vector(63 downto 0);
       readEn, writeEn : out std_logic;
       ledOut : out std_logic_vector(15 downto 0));
END ENTITY SimpleProcessorTest;

--
ARCHITECTURE Behavior OF SimpleProcessorTest IS

  
BEGIN

  ledOut <= dataReturn(15 downto 0);
  writeData <= "0000000000000000000000000000000000000000000000001010111100000101";
  readEn <= control(5);
  writeEn <= control(4);
  byteEnable <= "00000011";
  address(5 downto 2) <= control(3 downto 0);
  address(1 downto 0) <= "00";

END ARCHITECTURE Behavior;

