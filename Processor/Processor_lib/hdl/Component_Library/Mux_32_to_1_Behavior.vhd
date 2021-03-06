--
-- VHDL Architecture Advanced_Digital_Design_lib.Mux_4_to_1.Behavior
--
-- Created:
--          by - mew2ub.UNKNOWN (BCFRSJ1)
--          at - 00:44:14 02/ 5/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Mux_32_to_1 IS
  generic( width : integer );
    PORT ( In_vector : IN STD_LOGIC_VECTOR ( (width * 32) -1 downto 0);
        control : IN STD_LOGIC_VECTOR (4 downto 0);
      out_line: OUT STD_LOGIC_VECTOR ( width-1 downto 0));
      
    END ENTITY Mux_32_to_1;
    
    Architecture Behavior of Mux_32_to_1 IS

    Signal control_unsigned : unsigned(4 downto 0);
    SIGNAL control_integer : integer; 
      BEGIN
        
        control_unsigned <= unsigned(control);
        control_integer <= conv_integer(control_unsigned);
        
        out_line <= In_vector( control_integer * width + (width -1)  downto control_integer * width );
        
      end ARCHITECTURE Behavior;