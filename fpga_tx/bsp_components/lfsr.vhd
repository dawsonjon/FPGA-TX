library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
  generic(
    init : in std_logic_vector(63 downto 0) := X"0000000000000001"
  );
  port(
    clk : in std_logic;
    rand : out std_logic_vector(31 downto 0)
  );
end entity lfsr;

architecture rtl of lfsr is

  signal shifter : std_logic_vector(63 downto 0) := init;

begin

  process
  begin
    wait until rising_edge(clk);
    if shifter(0) = '1' then
      shifter <= ('0' & shifter(63 downto 1)) xor (X"d800000000000000");
    else
      shifter <= ('0' & shifter(63 downto 1));
    end if;
    rand <= shifter(63 downto 32) xor shifter(31 downto 0);
  end process;

end rtl;
