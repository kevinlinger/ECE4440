--
-- VHDL Architecture lab4_lib.TriState.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVINLAPTOP)
--          at - 02:02:04 11/ 2/2012
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY TriState IS
  port(a, c : in std_logic;
        z : out std_logic);
END ENTITY TriState;

--
ARCHITECTURE Behavior OF TriState IS
BEGIN
  	process(a, c)
		--constant highZ : std_logic_vecotr(size-1 downto 0) := (others => 'z');
		begin
			if(c ='1') then
				z <= a;
			else
				z <= 'Z';
			end if;
		end process;
END ARCHITECTURE Behavior;

