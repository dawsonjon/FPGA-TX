library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity gps_pps is
  port(
    clk : in std_logic;
    pps : in std_logic;
    pps_count : out std_logic_vector(31 downto 0);
    pps_count_stb : out std_logic;
    pps_count_ack : in std_logic);
end entity gps_pps;

architecture rtl of gps_pps is

  signal count : std_logic_vector(31 downto 0) := (others => '0');
  signal pps_d, pps_d1, pps_d2 : std_logic;

begin

  process
  begin
    wait until rising_edge(clk);

    pps_d <= pps;
    pps_d1 <= pps_d;
    pps_d2 <= pps_d1;

    if pps_d1 = '1' and pps_d2 = '0' then
      count <= (others => '0');
      pps_count <= count;
    else
      count <= std_logic_vector(unsigned(count) + 1);
    end if;

  end process;

  pps_count_stb <= '1';

end rtl;
