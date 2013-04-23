LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


  ENTITY Mux_2_to_1 IS
    generic( width : integer );
    PORT (line_0, line_1 : IN STD_LOGIC_VECTOR ( width-1 downto 0);
        control : IN STD_LOGIC;
      out_line: OUT STD_LOGIC_VECTOR ( width-1 downto 0));
    END ENTITY Mux_2_to_1;
    
    Architecture Behavior of Mux_2_to_1 IS
      BEGIN
        PROCESS(control, line_0, line_1)
        BEGIN
          case control is
          when '0' =>
            out_line <= line_0;
          when others =>
            out_line <=  line_1;
          end case;
        end process;
      end ARCHITECTURE Behavior;   
      
      