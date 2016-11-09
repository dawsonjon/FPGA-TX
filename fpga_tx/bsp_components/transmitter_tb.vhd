library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity transmitter_tb is
end entity transmitter_tb;

architecture rtl of transmitter_tb is

  component transmitter is
    port(
      clk : in std_logic;
      rst : in std_logic;
      frequency : in std_logic_vector(31 downto 0);
      frequency_stb : in std_logic;
      frequency_ack : out std_logic;
      control : in std_logic_vector(31 downto 0);
      control_stb : in std_logic;
      control_ack : out std_logic;
      amplitude : in std_logic_vector(31 downto 0);
      amplitude_stb : in std_logic;
      amplitude_ack : out std_logic;
      rf : out std_logic
    );
  end component transmitter;

  signal clk : std_logic;
  signal rst : std_logic;
  signal frequency : std_logic_vector(31 downto 0);
  signal frequency_stb : std_logic;
  signal frequency_ack : std_logic;
  signal control : std_logic_vector(31 downto 0);
  signal control_stb : std_logic;
  signal control_ack : std_logic;
  signal amplitude : std_logic_vector(31 downto 0);
  signal amplitude_stb : std_logic;
  signal amplitude_ack : std_logic;
  signal rf : std_logic;

begin

  process
  begin
    clk <= '0';
    while True loop
      wait for 5 ns;
      clk <= not clk;
    end loop;
    wait;
  end process;

  process
  begin
    rst <= '0';
    wait for 20 ns;
    rst <= '1';
   wait;
  end process;

  process
    file stimulus: TEXT open read_mode is "stim.txt";
    variable l : LINE;
    variable x : integer;
  begin
    while not endfile(stimulus) loop
      readline(stimulus, l);
      read(l, x);
      amplitude <= (others => '0');
      amplitude(7 downto 0) <= std_logic_vector(to_signed(x, 8));
      amplitude(23 downto 16) <= std_logic_vector(to_signed(x, 8));
      wait until rising_edge(clk) and amplitude_ack = '1';
    end loop;
    wait;
  end process;

  frequency <= X"000FFFFF";
  control <= X"00000000";
  amplitude_stb <= '1';
  frequency_stb <= '1';
  control_stb <= '1';

  uut : transmitter port map(
      clk => clk,
      rst => rst,
      frequency => frequency,
      frequency_stb => frequency_stb,
      frequency_ack => frequency_ack,
      control => control,
      control_stb => control_stb,
      control_ack => control_ack,
      amplitude => amplitude,
      amplitude_stb => amplitude_stb,
      amplitude_ack => amplitude_ack,
      rf => rf
  );

end rtl;
