--
-- VHDL Architecture lab4_lib.Decoder.Behavior
--
-- Created:
--          by - Kevin.UNKNOWN (KEVINLAPTOP)
--          at - 17:00:47 11/ 2/2012
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Decoder IS
 	generic(inputs : positive := 4);
	port(a : in std_logic_vector(inputs-1 downto 0);
	b : out std_logic_vector((2**inputs)-1 downto 0);
	enable : in std_logic);
END ENTITY Decoder;

--
ARCHITECTURE Behavior OF Decoder IS
BEGIN
  	process(a, enable)
		constant zeros : std_logic_vector((2**inputs)-1 downto 0) := (others=> '0');
		variable index : integer;
		variable alocal : unsigned(inputs-1 downto 0);
	begin
		b <= zeros;
		if(enable = '1') then
			alocal := unsigned(a);
			index := conv_integer(alocal);
			b(index) <= '1';
		
		end if;
		end process;
	
END ARCHITECTURE Behavior;

