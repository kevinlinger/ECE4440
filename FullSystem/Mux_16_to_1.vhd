LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Mux_16_to_1 IS
	GENERIC (size : POSITIVE := 16);
	PORT (
		a, b, c, d, e, f, g, h, i , j, k, l, m, n, o, p : IN std_logic_vector (size - 1 DOWNTO 0) := (others => '0');
		z : OUT std_logic_vector (size - 1 DOWNTO 0) := (others => '0');
		sel : IN std_logic_vector(3 DOWNTO 0));
END ENTITY Mux_16_to_1;

ARCHITECTURE behavior OF Mux_16_to_1 IS
BEGIN
--	PROCESS(a, b, c, d, e, f, g, h, i , j, k, l, m, n, o, p, sel)
--	BEGIN
		WITH sel SELECT
		z <=	a WHEN "0000",
				b WHEN "0001",
				c WHEN "0011",
				d WHEN "0010",
				e WHEN "0110",
				f WHEN "0111",
				g WHEN "0101",
				h WHEN "0100",
				i WHEN "1100",
				j WHEN "1101",
				k WHEN "1111",
				l WHEN "1110",
				m WHEN "1010",
				n WHEN "1011",
				o WHEN "1001",
				p WHEN "1000",
				"XXXXXXXXXXXXXXXX" WHEN OTHERS;
--	END PROCESS;
END ARCHITECTURE behavior;