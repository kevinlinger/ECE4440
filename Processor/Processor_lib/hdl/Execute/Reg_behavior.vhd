library ieee;
use ieee.std_logic_1164.all;

ENTITY reg IS
  GENERIC (size : POSITIVE := 16);
  PORT (a : IN std_logic_vector(size - 1 DOWNTO 0) := (others => '0');
    b : OUT std_logic_vector(size - 1 DOWNTO 0) := (others => '0');
    c, e : IN std_logic);
END ENTITY Reg;
  
ARCHITECTURE behavior OF reg IS
BEGIN
  PROCESS(c)
  BEGIN
    IF (rising_edge(c) AND (e = '1')) THEN
      b <= a;
    END IF;
  END PROCESS;
END ARCHITECTURE;