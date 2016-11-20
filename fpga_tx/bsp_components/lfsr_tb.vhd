library ieee; 
use ieee.std_logic_1164.all;

entity lfsr_tb is
end entity lfsr_tb;

architecture bhr of lfsr_tb is

  component lfsr is
    generic(
      init : in std_logic_vector(63 downto 0) := X"0000000000000001"
    );
    port(
      clk : in std_logic;
      rand : out std_logic_vector(31 downto 0)
    );
  end component lfsr;

  signal clk : std_logic;
  signal rand : std_logic_vector(31 downto 0);

begin

  process
  begin
    while True loop
      clk <= '1';
      wait for 5 ns;
      clk <= '0';
      wait for 5 ns;
    end loop;
    wait;
  end process;

  uut : lfsr port map(
      clk => clk,
      rand => rand
  );

end bhr;
