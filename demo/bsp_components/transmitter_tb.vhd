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
      i_input : in std_logic_vector(7 downto 0);
      i_input_stb : in std_logic;
      i_input_ack : out std_logic;
      q_input : in std_logic_vector(7 downto 0);
      q_input_stb : in std_logic;
      q_input_ack : out std_logic;
      rf : out std_logic
    );
  end component transmitter;

  signal clk : std_logic;
  signal rst : std_logic;
  signal frequency : std_logic_vector(31 downto 0);
  signal i_input : std_logic_vector(7 downto 0);
  signal i_input_stb : std_logic;
  signal i_input_ack : std_logic;
  signal q_input : std_logic_vector(7 downto 0);
  signal q_input_stb : std_logic;
  signal q_input_ack : std_logic;
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
  end process;

  process
    file stimulus: TEXT open read_mode is "stim.txt";
    variable l : LINE;
    variable x : integer;
  begin
    while not endfile(stimulus) loop
      readline(stimulus, l);
      read(l, x);
      i_input <= std_logic_vector(to_signed(x, 8));
      q_input <= std_logic_vector(to_signed(x, 8));
      wait until rising_edge(clk) and i_input_ack = '1';
    end loop;
    wait;
  end process;

  frequency <= X"000FFFFF";
  i_input_stb <= '1';
  q_input_stb <= '1';

  uut : transmitter port map(
      clk => clk,
      rst => rst,
      frequency => frequency,
      i_input => i_input,
      i_input_stb => i_input_stb,
      i_input_ack => i_input_ack,
      q_input => q_input,
      q_input_stb => q_input_stb,
      q_input_ack => q_input_ack,
      rf => rf
  );

end rtl;
