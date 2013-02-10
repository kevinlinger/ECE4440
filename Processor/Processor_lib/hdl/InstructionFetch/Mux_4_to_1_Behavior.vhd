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

ENTITY Mux_4_to_1 IS
  generic( width : integer );
    PORT ( line_0, line_1, line_2, line_3 : IN STD_LOGIC_VECTOR ( width-1 downto 0);
        control : IN STD_LOGIC_VECTOR (1 downto 0);
      out_line: OUT STD_LOGIC_VECTOR ( width-1 downto 0));
      
    END ENTITY Mux_4_to_1;
    
    Architecture Behavior of Mux_4_to_1 IS
      BEGIN
        PROCESS(line_0, line_1, line_2, line_3, control)
        BEGIN
          case control is
          when "00" =>
            out_line <= line_0;
          when "01" =>
            out_line <= line_1;
          when "10" =>
            out_line <= line_2;
          when others =>
            out_line <= line_3;
          end case;
        end process;
      end ARCHITECTURE Behavior;